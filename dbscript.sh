#!/bin/bash
export PGPASSWORD=12345;
user='postgres';
dbname='postgres';
dumpPath='';
tables=$(psql -b -L 'log.txt' -U "$user" -h 'localhost' -d "$dbname" -c 'SELECT table_name FROM information_schema.tables WHERE table_schema = '\'public\''');
table_arr=($(echo $tables | tr " " "\n"));
table_arr=("${table_arr[@]:2}");
unset 'table_arr[-1]';
unset 'table_arr[-1]';
for table in "${table_arr[@]}"
do psql -b -L 'log.txt' -U "$user" -h 'localhost' -d "$dbname" -c 'VACUUM '"$table"';';
psql -b -L 'log.txt' -U "$user" -h 'localhost' -d "$dbname" -c 'REINDEX TABLE '"$table"';';
done
pg_dump -d "$dbname" -U "$user" -h 'localhost' > pgsql_$(date "+%Y-%m-%d").dump
unset PGPASSWORD