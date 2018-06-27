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
"""Common downloader interface."""

from abc import ABC, abstractmethod
from tempfile import mkdtemp


# pylint: disable=too-few-public-methods
class ReportDownloaderInterface(ABC):
    """
    Download cost reports from a cloud provider.

    Base object class to be inherited by provider-specific classes.
    """

    def __init__(self, download_path=None):
        """
        Create a downloader.

        Args:
            download_path (String) filesystem path to store downloaded files
        """
        if download_path:
            self.download_path = download_path
        else:
            self.download_path = mkdtemp(prefix='masu')

    @abstractmethod
    def download_report(self, datetime):
        """
        Download cost report for a given date.

        Implemented by a downloader class.  Must return a list of
        file paths that are part of the cost report.

        Args:
            None

        Returns:
            (List) List of local file paths to report files.

        """
        pass

    @abstractmethod
    def download_current_report(self):
        """
        Download the current cost report.

        Implemented by a downloader class.  Must return a list of
        file paths that are part of the cost report.

        Args:
            None

        Returns:
            (List) List of local file paths to report files.

        """
        pass
