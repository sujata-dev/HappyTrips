create database flightrecord;

use flightrecord;

create table AirbusRecord
(
    airbusno        int,
    flightname      varchar(255),
    journeydate     date,
    departure       varchar(255),
    departuretime   varchar(255),
    arrival         varchar(255),
    arrivaltime     varchar(255),
    businessfare    int,
    economicalfare  int,

    primary key(airbusno)
);

insert into AirbusRecord
values(1001, 'SpiceJet', '2017-02-27', 'Hyderabad', '20:55', 'Raipur', '23:05', 5000, 2000);


create table aircodes
(
    code varchar(255) not null,
    city varchar(255),
    state varchar(255),

    primary key(code)
);

insert into aircodes
values('0001', 'Port Blair', 'Andaman & Nicobar Islands',
                                    'Veer Savarkar International Airport');
insert into aircodes
values('0003', 'Hyderabad', 'Telangana',
                                    'Rajiv Gandhi International Airport');
insert into aircodes
values('0004', 'Tirupati', 'Andhra Pradesh',
                                    'Tirupati Airport');
insert into aircodes
values('0005', 'Vijayawada', 'Andhra Pradesh',
                                    'Vijayawada International Airport');
insert into aircodes
values('0006', 'Visakhapatnam', 'Andhra Pradesh',
                                    'Visakhapatnam Airport');
insert into aircodes
values('0008', 'Itanagar', 'Arunachal Pradesh',
                                    'Itanagar Airport');
insert into aircodes
values('0014', 'Silchar', 'Assam',
                                    'Silchar Airport');
insert into aircodes
values('0016', 'Gaya', 'Bihar',
                                    'Gaya International Airport');
insert into aircodes
values('0022', 'Raipur', 'Chhattisgarh',
                                    'Swami Vivekananda Airport');
insert into aircodes
values('0025', 'New Delhi', 'New Delhi',
                                    'Indira Gandhi International Airport');


