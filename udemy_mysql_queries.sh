
# Create user
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'Virgin!234';
GRANT ALL PRIVILEGES ON * . * TO newuser@localhost;
FLUSH PRIVILEGES;

# Create database
CREATE DATABASE StudentsDB;

# Create table
CREATE TABLE IF NOT EXISTS StudentsDetail (
         id           INT(11)       NOT NULL AUTO_INCREMENT PRIMARY KEY,
         firstname    VARCHAR(30)   NOT NULL,
         lastname     VARCHAR(30)   NOT NULL,
         email        VARCHAR(100),
         mobile       VARCHAR(100),
         enrolled_date TIMESTAMP
       );

# Insert data into table
INSERT INTO StudentsDetail (firstname, lastname, mobile, email, enrolled_date)
VALUES ('Stefan', 'Ciprian', '0749832222', 'andreic@gmail.com', NOW());

INSERT INTO StudentsDetail (firstname, lastname, mobile, email, enrolled_date)
VALUES ('Student1', 'LastName', '0749833333', 'email@gmail.com', NOW());

# Select columns
select * from StudentsDetail;
select lastname,firstname from StudentsDetail;

# Display distinct values for particular column(s)
select distinct lastname from StudentsDetail;
select distinct lastname,firstname from StudentsDetail;

# Selecting specific data with multiple identifiers using WHERE, AND and OR
select id,mobile,firstname from StudentsDetail where mobile like "%33";
select * from StudentsDetail where mobile='0749832222';
select * from StudentsDetail where email='email@gmail.com' and firstname = 'Student1';
select * from StudentsDetail where email='email@gmail.com' or firstname = 'Student1';
select * from StudentsDetail where email='email@gmail.com' or mobile = '0749833333';
select * from StudentsDetail where email='email@gmail.com' and mobile='0749833333' or firstname = 'Student1';

# Limit the retrieved data using LIMIT
select * from StudentsDetail limit 5;
select * from StudentsDetail limit 5,2;

# Update values
select * from StudentsDetail where firstname='Student1';
update StudentsDetail set email='student1@gmail.com', mobile='123456789' where firstname='Student1';

# Delete values
delete from StudentsDetail where firstname='Student1';
