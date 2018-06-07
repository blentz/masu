#!/bin/sh
CWD=$(pwd)
TEST_DATABASE='test'

psql ${DATABASE_NAME} -p ${DATABASE_PORT} -h ${DATABASE_HOST} -U postgres -c "CREATE DATABASE $TEST_DATABASE;"

psql $TEST_DATABASE -p ${DATABASE_PORT} -h ${DATABASE_HOST} -U postgres -c "ALTER DATABASE $TEST_DATABASE OWNER TO ${DATABASE_USER};"

psql $TEST_DATABASE -p ${DATABASE_PORT} -h ${DATABASE_HOST} -U postgres -c 'DROP SCHEMA IF EXISTS testcustomer CASCADE; DROP SCHEMA IF EXISTS public CASCADE;'

psql $TEST_DATABASE -p ${DATABASE_PORT} -h ${DATABASE_HOST} -U ${DATABASE_USER} -c 'CREATE SCHEMA public;'

psql $TEST_DATABASE  -p ${DATABASE_PORT} -h ${DATABASE_HOST} -U ${DATABASE_USER} < "$CWD/tests/sql/test.sql"