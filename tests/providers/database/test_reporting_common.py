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

"""Test the ReportingCommonDB utility object."""
import copy

from sqlalchemy.orm.session import Session

from masu.providers.database import AWS_CUR_TABLE_MAP
from masu.providers.database.reporting_common import ReportingCommonDB
from tests import MasuTestCase


class ReportingCommonDBTest(MasuTestCase):
    """Test Cases for the ReportingCommonDB object."""

    @classmethod
    def setUpClass(cls):
        """Set up the test class with required objects."""
        cls.accessor = ReportingCommonDB()
        cls.report_tables = list(AWS_CUR_TABLE_MAP.values())

    def test_initializer(self):
        """Test initializer."""
        report_common_schema = self.accessor.report_common_schema
        self.assertIsNotNone(self.accessor._session)
        self.assertIsInstance(self.accessor.column_map, dict)
        self.assertTrue(
            hasattr(report_common_schema, 'reporting_common_reportcolumnmap')
        )

    def test_generate_column_map(self):
        """Assert all tables are in the column map."""
        column_map = self.accessor.generate_column_map()
        keys = column_map.keys()

        tables = copy.deepcopy(self.report_tables)
        tables.remove(AWS_CUR_TABLE_MAP['cost_entry'])
        for table in tables:
            self.assertIn(table, keys)

    def test_create_session(self):
        """Test the session factory and scoped session."""
        session = self.accessor._session
        new_session = self.accessor._create_session()

        self.assertIsInstance(session, Session)
        self.assertIs(session, new_session)