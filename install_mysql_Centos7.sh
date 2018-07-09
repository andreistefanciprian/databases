#!/bin/bash

# Install MySQL on Centos 7 https://www.linode.com/docs/databases/mysql/how-to-install-mysql-on-centos-7/

# Install tools
sudo yum install -y wget


# Download and add the repository, then update
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
sudo rpm -ivh mysql80-community-release-el7-1.noarch.rpm
sudo yum update -y


# Install and start MySQL service
sudo yum install mysql-server -y
sudo systemctl start mysqld

# Get the temporary password created at install
sudo grep 'temporary password' /var/log/mysqld.log
# Virgin!234
# mysql -u root -p'Virgin!234'

# Harden MySQL Server
# Run the mysql_secure_installation script to address several security concerns in a default MySQL installation
sudo mysql_secure_installation

### https://www.ntu.edu.sg/home/ehchua/programming/sql/MySQL_Beginner.html
# Log in
mysql -u root -p

# Debug MySQL
mysqladmin status
sudo tail -f /var/log/mysqld.log




