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

"""Test the CostUsageReportAccount object."""

from unittest.mock import patch
from masu.exceptions import CURAccountsInterfaceError
from masu.external import (AMAZON_WEB_SERVICES, OPENSHIFT_CONTAINER_PLATFORM)
from masu.external.accounts_accessor import AccountsAccessor, AccountsAccessorError
from masu.external.accounts.network.cur_accounts_network import CURAccountsNetwork
from tests import MasuTestCase


class AccountsAccessorTest(MasuTestCase):
    """Test Cases for the AccountsAccessor object."""

    def test_get_accounts(self):
        """Test to get_access_credential"""
        account_objects = AccountsAccessor().get_accounts()

        if len(account_objects) != 2:
            self.fail('unexpected number of accounts')

        for account in account_objects:
            if account.get('provider_type') == AMAZON_WEB_SERVICES:
                self.assertEqual(account.get('authentication'), 'arn:aws:iam::111111111111:role/CostManagement')
                self.assertEqual(account.get('billing_source'), 'test-bucket')
                self.assertEqual(account.get('customer_name'), 'acct10001')
            elif account.get('provider_type') == OPENSHIFT_CONTAINER_PLATFORM:
                self.assertEqual(account.get('authentication'), 'my-ocp-cluster-1')
                self.assertEqual(account.get('billing_source'), None)
                self.assertEqual(account.get('customer_name'), 'acct10001')
            else:
                self.fail('Unexpected provider')

    def test_invalid_source_specification(self):
        """Test that error is thrown with invalid account source."""

        with self.assertRaises(AccountsAccessorError):
            AccountsAccessor('bad')

    def test_get_accounts_exception(self):
        """Test to get accounts with an exception."""
        with patch.object(CURAccountsNetwork, 'get_accounts_from_source', side_effect=CURAccountsInterfaceError('test')):
            with self.assertRaises(AccountsAccessorError):
                AccountsAccessor('network').get_accounts()
