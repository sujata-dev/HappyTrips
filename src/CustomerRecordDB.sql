create database CustomerRecord;

use CustomerRecord;

create table Registration
(
    firstname       varchar(255),
    lastname        varchar(255),
    gender          varchar(255),
    age             int,
    email           varchar(255),
    mobile          varchar(255),

    primary key(email)
);

insert into Registration
values('sujata', 'dev', 'female', 20, 'sujatadev97@gmail.com', 'cleverbot5',
'cleverbot5', '8600657942');


create table Airticket
(
    eticketno       mediumint auto_increment not null,
    travelclass     varchar(255),
    adults          int,
    children        int,
    infants         int,
    date            date,
    cityfrom        varchar(255),
    cityto          varchar(255),

    primary key(eticketno)
);

insert into Airticket
values(1000001, 'economy', 1, 0, 0, '1997-4-17', 'Varanasi', 'Pune');
