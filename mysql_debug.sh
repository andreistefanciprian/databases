
# Show mysqld running threads
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST\G;

# Kill mysql thread
KILL processlist_id;

# Show locked tables;
SHOW OPEN TABLES WHERE In_use > 0;
