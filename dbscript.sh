#!/bin/bash
dbname="postgres"
dbuser="postgres"
tables=$(psql -U $dbuser -W -h "localhost" -d $dbname -c "SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');")
echo "$tables"
for table in $("cat $tables")
do psql -U $dbuser -W -h "localhost" -d $dbname -c "VACUUM VERBOSE $table; REINDEX TABLE $table"
done
read -p -r "Press any key to resume ..."; 