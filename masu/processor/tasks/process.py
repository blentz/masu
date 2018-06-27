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
"""Processing asynchronous tasks."""

import logging

from masu.processor.report_processor import ReportProcessor
from masu.providers.database.accessors import ReportStatsDB

LOG = logging.getLogger(__name__)


def process_report_file(process_request):
    """
    Task to process a Cost Usage Report.

    Args:
        process_request (dict): Attributes for report processing.

    Returns:
        None

    """
    stmt = ('Processing Report:'
            ' schema_name: {},'
            ' report_path: {},'
            ' compression: {}')
    log_statement = stmt.format(schema_name,
                                report_path,
                                compression)
    LOG.info(log_statement)

    file_name = process_request['report_path'].split('/')[-1]
    stats_recorder = ReportStatsDB(file_name)
    cursor_position = stats_recorder.get_cursor_position()

    processor = ReportProcessor(schema_name=schema_name,
                                report_path=report_path,
                                compression=compression,
                                cursor_pos=cursor_position)

    stats_recorder.log_last_started_datetime()
    last_cursor_position = processor.process()
    stats_recorder.log_last_completed_datetime()
    stats_recorder.set_cursor_position(last_cursor_position)
    stats_recorder.commit()
