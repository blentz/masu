#
# Copyright 2018 Red Hat, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

"""Test the ReportProcessor."""
from collections import defaultdict
import csv
import copy
import datetime
import gzip
from itertools import islice
import json
import random

from sqlalchemy.sql.expression import delete

from masu.config import Config
from masu.providers.database import AWS_CUR_TABLE_MAP
from masu.providers.database.report import ReportDB
from masu.providers.database.reporting_common import ReportingCommonDB
from masu.exceptions import MasuProcessingError
from masu.processor.report_processor import ProcessedReport, ReportProcessor
from tests import MasuTestCase


class ProcessedReportTest(MasuTestCase):
    @classmethod
    def setUpClass(cls):
        """Set up the test class with required objects."""
        cls.report = ProcessedReport()

    def test_remove_processed_rows(self):
        test_entry = {'test': 'entry'}
        self.report.cost_entries.update(test_entry)
        self.report.line_items.append(test_entry)
        self.report.products.update(test_entry)
        self.report.pricing.update(test_entry)
        self.report.reservations.update(test_entry)

        self.report.remove_processed_rows()

        self.assertEqual(self.report.cost_entries, {})
        self.assertEqual(self.report.line_items, [])
        self.assertEqual(self.report.products, {})
        self.assertEqual(self.report.pricing, {})
        self.assertEqual(self.report.reservations, {})


class ReportProcessorTest(MasuTestCase):
    """Test Cases for the ReportingCommonDB object."""

    @classmethod
    def setUpClass(cls):
        """Set up the test class with required objects."""
        cls.test_report = './tests/data/test_cur.csv'
        cls.test_report_gzip = './tests/data/test_cur.csv.gz'

        cls.processor = ReportProcessor(
            schema_name='testcustomer',
            report_path=cls.test_report,
            compression=Config.UNCOMPRESSED
        )

        cls.accessor = cls.processor.report_db
        cls.report_schema = cls.accessor.report_schema
        cls.session = cls.accessor._session

        cls.report_tables = list(AWS_CUR_TABLE_MAP.values())
        # Grab a single row of test data to work with
        with open(cls.test_report, 'r') as f:
            reader = csv.DictReader(f)
            cls.row = next(reader)

    def tearDown(self):
        """Return the database to a pre-test state."""
        self.session.rollback()

        for table_name in self.report_tables:
            self.accessor._cursor.execute(f'DELETE FROM {table_name}')
        self.accessor._conn.commit()

        self.processor.processed_report.remove_processed_rows()


    def test_initializer(self):
        """Test initializer."""
        self.assertIsNotNone(self.processor._schema_name)
        self.assertIsNotNone(self.processor._report_path)
        self.assertIsNotNone(self.processor._report_name)
        self.assertIsNotNone(self.processor._cursor_pos)
        self.assertIsNotNone(self.processor._compression)
        self.assertEqual(
            self.processor._datetime_format,
            Config.AWS_DATETIME_STR_FORMAT
        )
        self.assertEqual(
            self.processor._batch_size,
            Config.REPORT_PROCESSING_BATCH_SIZE
        )

    def test_initializer_unsupported_compression(self):
        """Assert that an error is raised for an invalid compression."""
        with self.assertRaises(MasuProcessingError):
            processor = ReportProcessor(
                schema_name='testcustomer',
                report_path=self.test_report,
                compression='unsupported'
            )

    def test_process_default(self):
        """Test the processing of an uncompressed file."""
        counts = {}
        processor = ReportProcessor(
            schema_name='testcustomer',
            report_path=self.test_report,
            compression=Config.UNCOMPRESSED
        )
        report_db = processor.report_db
        report_schema = report_db.report_schema
        for table_name in self.report_tables:
            table = getattr(report_schema, table_name)
            count = report_db.session.query(table).count()
            counts[table_name] = count

        lines = 0
        with open(self.test_report, 'r') as f:
            # Bump the header
            f.readline()
            for line in f:
                lines += 1
        old_cursor = processor._cursor_pos
        expected = old_cursor + lines
        new_cursor = processor.process()

        self.assertEqual(new_cursor, expected)

        for table_name in self.report_tables:
            table = getattr(report_schema, table_name)
            count = report_db.session.query(table).count()

            if table_name == 'reporting_awscostentryreservation':
                self.assertTrue(count >= counts[table_name])
            else:
                self.assertTrue(count > counts[table_name])

        self.assertTrue(processor.report_db._conn.closed)

    def test_process_gzip(self):
        """Test the processing of a gzip compressed file."""
        counts = {}
        processor = ReportProcessor(
            schema_name='testcustomer',
            report_path=self.test_report_gzip,
            compression=Config.GZIP_COMPRESSED
        )
        report_db = processor.report_db
        report_schema = report_db.report_schema
        for table_name in self.report_tables:
            table = getattr(report_schema, table_name)
            count = report_db.session.query(table).count()
            counts[table_name] = count

        lines = 0
        with gzip.open(self.test_report_gzip, 'rt') as f:
            # Bump the header
            f.readline()
            for line in f:
                lines += 1
        old_cursor = processor._cursor_pos
        expected = old_cursor + lines
        new_cursor = processor.process()

        self.assertEqual(new_cursor, expected)

        for table_name in self.report_tables:
            table = getattr(report_schema, table_name)
            count = report_db.session.query(table).count()

            if table_name == 'reporting_awscostentryreservation':
                self.assertTrue(count >= counts[table_name])
            else:
                self.assertTrue(count > counts[table_name])

        self.assertTrue(processor.report_db._conn.closed)

    def test_process_non_zero_cursor(self):
        """Test that cursor position is calculated properly."""
        counts = {}
        cursor_pos = random.randint(1,100)
        processor = ReportProcessor(
            schema_name='testcustomer',
            report_path=self.test_report,
            compression=Config.UNCOMPRESSED,
            cursor_pos=cursor_pos
        )

        lines = 0
        with open(self.test_report, 'r') as f:
            # Bump the header
            f.readline()
            for row in islice(f, cursor_pos, None):
                lines += 1
        old_cursor = processor._cursor_pos
        expected = old_cursor + lines
        new_cursor = processor.process()

        self.assertEqual(new_cursor, expected)


    def test_get_file_opener_default(self):
        """Test that the default file opener is returned."""
        opener, mode = self.processor._get_file_opener(Config.UNCOMPRESSED)

        self.assertEqual(opener, open)
        self.assertEqual(mode, 'r')

    def test_get_file_opener_gzip(self):
        """Test that the gzip file opener is returned."""
        opener, mode = self.processor._get_file_opener(Config.GZIP_COMPRESSED)

        self.assertEqual(opener, gzip.open)
        self.assertEqual(mode, 'rt')

    def test_update_mappings(self):
        """Test that mappings are updated."""
        test_entry = {'key': 'value'}
        counts = {}
        ce_maps = {
            'cost_entry': self.processor.existing_cost_entry_map,
            'product': self.processor.existing_product_map,
            'pricing': self.processor.existing_pricing_map,
            'reservation': self.processor.existing_reservation_map
        }

        for name, ce_map in ce_maps.items():
            counts[name] =  len(ce_map.values())
            ce_map.update(test_entry)

        self.processor._update_mappings()

        for name, ce_map in ce_maps.items():
            self.assertTrue(len(ce_map.values()) > counts[name])
            for key in test_entry:
                self.assertIn(key, ce_map)

    def test_write_processed_rows_to_csv(self):
        """Test that the CSV bulk upload file contains proper data."""
        bill_id = self.processor._create_cost_entry_bill(self.row)
        cost_entry_id = self.processor._create_cost_entry(self.row, bill_id)
        product_id = self.processor._create_cost_entry_product(self.row)
        pricing_id = self.processor._create_cost_entry_pricing(self.row)
        reservation_id = self.processor._create_cost_entry_reservation(self.row)
        self.processor._create_cost_entry_line_item(
            self.row,
            cost_entry_id,
            bill_id,
            product_id,
            pricing_id,
            reservation_id
        )

        file_obj = self.processor._write_processed_rows_to_csv()

        line_item_data = self.processor.processed_report.line_items.pop()
        # Convert data to CSV format
        expected_values = [str(value) if value else None
                           for value in line_item_data.values()]

        reader = csv.reader(file_obj)
        new_row = next(reader)
        new_row = new_row[0].split('\t')
        actual = {}

        for i, key in enumerate(line_item_data.keys()):
            actual[key] = new_row[i] if new_row[i] else None

        self.assertEqual(actual.keys(), line_item_data.keys())
        self.assertEqual(list(actual.values()), expected_values)

    def test_get_data_for_table(self):
        """Test that a row is disected into appropriate data structures."""
        column_map = self.processor.report_common_db.column_map

        for table_name in self.report_tables:
            expected_columns = sorted(column_map[table_name].values())
            data = self.processor._get_data_for_table(self.row, table_name)

            for key in data:
                self.assertIn(key, expected_columns)

    def test_process_tags(self):
        """Test that tags are properly packaged in a JSON string."""
        row = {
            'resourceTags\\User': 'value',
            'notATag': 'value',
            'resourceTags\\System': 'value'
        }

        expected = {key: value for key, value in row.items()
                    if 'resourceTags' in key}
        actual = json.loads(self.processor._process_tags(row))

        self.assertNotIn(row['notATag'], actual)
        self.assertEqual(expected, actual)

    def test_get_cost_entry_time_interval(self):
        """Test that an interval string is properly split."""
        fmt = Config.AWS_DATETIME_STR_FORMAT
        end = datetime.datetime.utcnow()
        expected_start = (end - datetime.timedelta(days=1)).strftime(fmt)
        expected_end = end.strftime(fmt)
        interval = expected_start + '/' + expected_end

        actual_start, actual_end = \
            self.processor._get_cost_entry_time_interval(interval)

        self.assertEqual(expected_start, actual_start)
        self.assertEqual(expected_end, actual_end)

    def test_create_cost_entry_bill(self):
        """Test that a cost entry bill id is returned."""
        table_name = AWS_CUR_TABLE_MAP['bill']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')
        bill_id = self.processor._create_cost_entry_bill(self.row)

        self.assertIsNotNone(bill_id)

        query = self.accessor._get_db_obj_query(table_name)
        id_in_db = query.order_by(id_column.desc()).first().id

        self.assertEqual(bill_id, id_in_db)

    def test_create_cost_entry_bill_existing(self):
        """Test that a cost entry bill id is returned from an existing bill."""
        table_name = AWS_CUR_TABLE_MAP['bill']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')
        bill_id = self.processor._create_cost_entry_bill(self.row)

        query = self.accessor._get_db_obj_query(table_name)
        bill = query.first()

        self.processor.current_bill = bill

        new_bill_id = self.processor._create_cost_entry_bill(self.row)

        self.assertEqual(bill_id, new_bill_id)

        self.processor.current_bill = None

    def test_create_cost_entry(self):
        """Test that a cost entry id is returned."""
        table_name = AWS_CUR_TABLE_MAP['cost_entry']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')

        bill_id = self.processor._create_cost_entry_bill(self.row)

        cost_entry_id = self.processor._create_cost_entry(self.row,
                                                          bill_id)
        self.accessor.commit()

        self.assertIsNotNone(cost_entry_id)

        query = self.accessor._get_db_obj_query(table_name)
        id_in_db = query.order_by(id_column.desc()).first().id

        self.assertEqual(cost_entry_id, id_in_db)

    def test_create_cost_entry_existing(self):
        """Test that a cost entry id is returned from an existing entry."""
        table_name = AWS_CUR_TABLE_MAP['cost_entry']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')

        bill_id = self.processor._create_cost_entry_bill(self.row)
        self.accessor.commit()

        interval = self.row.get('identity/TimeInterval')
        start, end = self.processor._get_cost_entry_time_interval(interval)
        expected_id = random.randint(1,9)
        self.processor.existing_cost_entry_map[start] = expected_id

        cost_entry_id = self.processor._create_cost_entry(self.row,
                                                          bill_id)

        self.assertEqual(cost_entry_id, expected_id)

    def test_create_cost_entry_line_item(self):
        """Test that line item data is returned properly."""
        bill_id = self.processor._create_cost_entry_bill(self.row)
        cost_entry_id = self.processor._create_cost_entry(self.row, bill_id)
        product_id = self.processor._create_cost_entry_product(self.row)
        pricing_id = self.processor._create_cost_entry_pricing(self.row)
        reservation_id = self.processor._create_cost_entry_reservation(self.row)

        self.accessor.commit()

        self.processor._create_cost_entry_line_item(
            self.row,
            cost_entry_id,
            bill_id,
            product_id,
            pricing_id,
            reservation_id
        )

        line_item = None
        if self.processor.processed_report.line_items:
            line_item = self.processor.processed_report.line_items[-1]

        self.assertIsNotNone(line_item)
        self.assertIn('tags', line_item)
        self.assertEqual(line_item.get('cost_entry_id'), cost_entry_id)
        self.assertEqual(line_item.get('cost_entry_bill_id'), bill_id)
        self.assertEqual(line_item.get('cost_entry_product_id'), product_id)
        self.assertEqual(line_item.get('cost_entry_pricing_id'), pricing_id)
        self.assertEqual(
            line_item.get('cost_entry_reservation_id'),
            reservation_id
        )

    def test_create_cost_entry_product(self):
        """Test that a cost entry product id is returned."""
        table_name = AWS_CUR_TABLE_MAP['product']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')

        product_id = self.processor._create_cost_entry_product(self.row)

        self.accessor.commit()

        self.assertIsNotNone(product_id)

        query = self.accessor._get_db_obj_query(table_name)
        id_in_db = query.order_by(id_column.desc()).first().id

        self.assertEqual(product_id, id_in_db)

    def test_create_cost_entry_product_already_processed(self):
        """Test that an already processed product id is returned."""
        expected_id = random.randint(1,9)
        sku = self.row.get('product/sku')
        self.processor.processed_report.products.update({sku: expected_id})

        product_id = self.processor._create_cost_entry_product(self.row)

        self.assertEqual(product_id, expected_id)

    def test_create_cost_entry_product_existing(self):
        """Test that a previously existing product id is returned."""
        expected_id = random.randint(1,9)
        sku = self.row.get('product/sku')
        self.processor.existing_product_map.update({sku: expected_id})

        product_id = self.processor._create_cost_entry_product(self.row)

        self.assertEqual(product_id, expected_id)

    def test_create_cost_entry_pricing(self):
        """Test that a cost entry pricing id is returned."""
        table_name = AWS_CUR_TABLE_MAP['pricing']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')

        pricing_id = self.processor._create_cost_entry_pricing(self.row)

        self.accessor.commit()

        self.assertIsNotNone(pricing_id)

        query = self.accessor._get_db_obj_query(table_name)
        id_in_db = query.order_by(id_column.desc()).first().id

        self.assertEqual(pricing_id, id_in_db)

    def test_create_cost_entry_pricing_already_processed(self):
        """Test that an already processed pricing id is returned."""
        expected_id = random.randint(1,9)
        key = '{cost}-{rate}-{term}-{unit}'.format(
            cost=self.row['pricing/publicOnDemandCost'],
            rate=self.row['pricing/publicOnDemandRate'],
            term=self.row['pricing/term'],
            unit=self.row['pricing/unit']
        )
        self.processor.processed_report.pricing.update({key: expected_id})

        pricing_id = self.processor._create_cost_entry_pricing(self.row)

        self.assertEqual(pricing_id, expected_id)

    def test_create_cost_entry_pricing_existing(self):
        """Test that a previously existing pricing id is returned."""
        expected_id = random.randint(1,9)
        key = '{cost}-{rate}-{term}-{unit}'.format(
            cost=self.row['pricing/publicOnDemandCost'],
            rate=self.row['pricing/publicOnDemandRate'],
            term=self.row['pricing/term'],
            unit=self.row['pricing/unit']
        )
        self.processor.existing_pricing_map.update({key: expected_id})

        pricing_id = self.processor._create_cost_entry_pricing(self.row)

        self.assertEqual(pricing_id, expected_id)

    def test_create_cost_entry_reservation(self):
        """Test that a cost entry reservation id is returned."""
        # Ensure a reservation exists on the row
        arn = 'TestARN'
        row = copy.deepcopy(self.row)
        row['reservation/ReservationARN'] = arn

        table_name = AWS_CUR_TABLE_MAP['reservation']
        table = getattr(self.report_schema, table_name)
        id_column = getattr(table, 'id')

        reservation_id = self.processor._create_cost_entry_reservation(row)

        self.accessor.commit()

        self.assertIsNotNone(reservation_id)

        query = self.accessor._get_db_obj_query(table_name)
        id_in_db = query.order_by(id_column.desc()).first().id

        self.assertEqual(reservation_id, id_in_db)

    def test_create_cost_entry_reservation_already_processed(self):
        """Test that an already processed reservation id is returned."""
        expected_id = random.randint(1,9)
        arn = self.row.get('reservation/ReservationARN')
        self.processor.processed_report.reservations.update({arn: expected_id})

        reservation_id = self.processor._create_cost_entry_reservation(self.row)

        self.assertEqual(reservation_id, expected_id)

    def test_create_cost_entry_reservation_existing(self):
        """Test that a previously existing reservation id is returned."""
        expected_id = random.randint(1,9)
        arn = self.row.get('reservation/ReservationARN')
        self.processor.existing_reservation_map.update({arn: expected_id})

        product_id = self.processor._create_cost_entry_reservation(self.row)

        self.assertEqual(product_id, expected_id)
