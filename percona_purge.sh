# verify disk usage
df -h

#  list total size of all directories within the current one, and sort them by size
cd /data/mysql
du -ch -d 1 | sort -hr

# identify biggest mysql tables
SELECT CONCAT(table_schema, '.', table_name),
       CONCAT(ROUND(table_rows / 1000000, 2), 'M')                                    rows,
       CONCAT(ROUND(data_length / ( 1024 * 1024 * 1024 ), 2), 'G')                    DATA,
       CONCAT(ROUND(index_length / ( 1024 * 1024 * 1024 ), 2), 'G')                   idx,
       CONCAT(ROUND(( data_length + index_length ) / ( 1024 * 1024 * 1024 ), 2), 'G') total_size,
       ROUND(index_length / data_length, 2)                                           idxfrac
FROM   information_schema.TABLES
ORDER  BY data_length + index_length DESC
LIMIT  10;

# identify id by date
select id FROM radius_production.wlc_sessions where id>858310431 AND created_at<'2018-06-28' order by id desc LIMIT 2;
+------------+
| id         |
+------------+
| 1548106960 |
| 1548106957 |
+------------+
# table purge
sudo pt-archiver --user root --ask-pass --source h=localhost,D=radius_production,t=wlc_sessions --where "id<1548106960 AND created_at < '2018-06-28'" --limit 1000 --commit-each --purge

# table resize
sudo pt-online-schema-change --user root --ask-pass --alter "ENGINE=InnoDB" D=radius_production,t=wlc_sessions --execute --preserve-triggers

