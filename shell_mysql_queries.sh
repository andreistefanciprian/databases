#!/bin/bash

# Send command to mysql server
mysql -u root -e 'select * from StudentsDB.StudentsDetail where email='andreic@gmail.com''

# Send multiple commands to mysql server
mysql StudentsDB -u root <<EOF
show tables;
select * from StudentsDetail where email like 'andrei%';
EOF
