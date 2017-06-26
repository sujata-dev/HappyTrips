create database flightrecord;

use flightrecord;

create table AirbusRecord
(
    airbusno        int not null,
    departure       int not null,
    arrival         int not null,
    businessfare    int not null,
    economicalfare  int not null,

    primary key(airbusno)
);


create table aircodes
(
    code varchar(255) not null,
    city varchar(255),
    state varchar(255),

    primary key(code)
);

insert into aircodes
values('0003', 'Hyderabad', 'Telangana', 'Rajiv Gandhi International Airport');
