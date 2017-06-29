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
    airbusno        int,
    flightname      varchar(255),
    travelclass     varchar(255),
    date            date,
    departuretime   varchar(255),
    arrivaltime     varchar(255),
    adults          int,
    children        int,
    infants         int,
    cityfrom        varchar(255),
    cityto          varchar(255),
    fare            float,

    primary key(eticketno)
);

insert into Airticket
values(1000001, 1001, 'SpiceJet', 'Economy', '2007-4-17', '20:15', '22:30', 1, 0, 0, 'Raipur', 'Pune', 2400);
