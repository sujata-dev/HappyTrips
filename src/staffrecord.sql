create database staffrecord;

use staffrecord;

create table Login
(
    fullname        varchar(255),
    username        varchar(255),
    password        varchar(255),

    primary key(username)
);

insert into Login
values('Riya Sharma', 'riya23', 'rs23');
