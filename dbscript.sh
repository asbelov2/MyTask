#!/bin/bash
export PGPASSWORD=12345
tables=$(psql -b -L 'log.txt' -U 'postgres' -h 'localhost' -d 'postgres' -c 'SELECT table_name FROM information_schema.tables WHERE table_schema = '\'public\''')
table_arr=($(echo $tables | tr " " "\n"))
table_arr=("${table_arr[@]:2}")
unset 'table_arr[-1]'
unset 'table_arr[-1]'
for i in "${table_arr[@]}"
do
   echo "$i"
done

for table in "${table_arr[@]}"
do psql -b -L 'log.txt' -h 'localhost' -U 'postgres' -d 'postgres' -c 'VACUUM '"$table"';'
psql -b -L 'log.txt' -h 'localhost' -U 'postgres' -d 'postgres' -c 'REINDEX TABLE '"$table"';'
done