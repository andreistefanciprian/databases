#!/bin/bash

# Purge old Percona MySQL records from Monday to Thursday from 10 to 12 AM and from 00 to 04 AM
# 01 00 * * 1-4 /root/purge_sessions.sh 225m
# 01 10 * * 1-4 /root/purge_sessions.sh 105m

# Log time
touch purge_radius_sessions.log
{ echo;echo;echo; } | tee -a purge_radius_sessions.log
echo " $(date +%Y%b%d-%Hh%Mm) -- SCRIPT STARTED" | tee -a purge_radius_sessions.log

# Define variables
scriptstarttime=`date +%s`
duration=$1

# Capture standard out and standard error in this file
exec &> capture_purge_radius_sessions.log

# Display DB stats
echo  | tee -a purge_radius_sessions.log
mysql -u root -h localhost -te "
tee purge_radius_sessions.log;
SELECT CONCAT(table_schema, '.', table_name)                                          TABLE_NAME,
       table_rows                                                                     ROWS,
       CONCAT(ROUND(data_length / ( 1024 * 1024 * 1024 ), 3), 'G')                    DATA,
       CONCAT(ROUND(index_length / ( 1024 * 1024 * 1024 ), 3), 'G')                   IDX,
       CONCAT(ROUND(( data_length + index_length ) / ( 1024 * 1024 * 1024 ), 3), 'G') TOTAL_SIZE
FROM   information_schema.TABLES
WHERE table_name = 'sessions' AND table_schema = 'radius_production';"

# Purge table
echo | tee -a purge_radius_sessions.log
sudo timeout ${duration} pt-archiver --user root --source h=localhost,D=radius_production,t=sessions --where "id<3583423191" --limit 10 --txn-size 10 --primary-key-only --bulk-delete --purge --statistics --sleep 2 | tee -a purge_radius_sessions.log

# Display DB sizes
echo | tee -a purge_radius_sessions.log
mysql -u root -h localhost -te "
tee purge_radius_sessions.log;
SELECT CONCAT(table_schema, '.', table_name)                                          TABLE_NAME,
       table_rows                                                                     ROWS,
       CONCAT(ROUND(data_length / ( 1024 * 1024 * 1024 ), 3), 'G')                    DATA,
       CONCAT(ROUND(index_length / ( 1024 * 1024 * 1024 ), 3), 'G')                   IDX,
       CONCAT(ROUND(( data_length + index_length ) / ( 1024 * 1024 * 1024 ), 3), 'G') TOTAL_SIZE
FROM   information_schema.TABLES
WHERE table_name = 'sessions' AND table_schema = 'radius_production';"

# Log time
scriptendtime=`date +%s`
scripttime=$((($scriptendtime) - ($scriptstarttime)))
echo | tee -a purge_radius_sessions.log
echo " $(date +%Y%b%d-%Hh%Mm) -- SCRIPT ENDED AND RUN FOR $scripttime seconds" | tee -a purge_radius_sessions.log
