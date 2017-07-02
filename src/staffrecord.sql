create database staffrecord;

use staffrecord;

create table Login
(
    staffID         varchar(255),
    fullname        varchar(255),
    username        varchar(255),
    password        varchar(255),

    primary key(staffID)
);

insert into Login
values('R17003', 'Riya Sharma', 'riya23', 'rs23');
