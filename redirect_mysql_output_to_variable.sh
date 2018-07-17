#!/bin/bash

# Redirecting SQL output to variable
dbs=$(mysql -u root -e 'show databases')
for db in $dbs
do
    echo $db
done
