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
"""Standardized namespacing entry-point for DB accessors."""

# pylint: disable=unused-import
from .auth import AuthDB
from .customer import CustomerDB
from .koku import KokuDB
from .provider import ProviderDB
from .provider_auth import ProviderAuthDB
from .provider_billing_source import ProviderBillingSourceDB
from .report import ReportDB
from .report_stats import ReportStatsDB
from .reporting_common import ReportingCommonDB