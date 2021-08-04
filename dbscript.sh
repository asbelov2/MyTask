#!/bin/bash
dbname=postgres
dbuser=postgres
tables=$(psql -U $dbuser -d $dbname -c "SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');")
for table in $("cat $tables")
do
psql -c "VACUUM $table; REINDEX TABLE $table"
done