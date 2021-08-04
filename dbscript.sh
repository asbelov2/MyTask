#!/bin/bash
dbname="postgres"
dbuser="postgres"
PGPASSWORD=12345
tables=$(psql -U $dbuser -h "localhost" -d $dbname -c "SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');")
echo $tables
for table in $tables
do psql -U $dbuser -h "localhost" -d $dbname -c "VACUUM VERBOSE $table; REINDEX TABLE $table"
done