
-- drop tables
drop table if exists user_address;
drop table if exists card;
drop table if exists rating;
drop table if exists book;
drop table if exists user_info;
drop table if exists test_cart;


create table book
(
	bookid	int primary key	auto_increment,
    title	varchar(100) not null,
    genre	varchar (100) not null,
    publisherName	varchar(100) not null,
    releaseDate	date	default '9999-12-31',
    price	decimal (6, 2),
	author	varchar(100) not null,
    stock	int	default '0',
    check (stock >= 0),
    description	text
);

-- book rating


create table rating
(
	bookid	int not null,
    score	decimal	(2, 1)	default '0.0',
    comments	text,
	foreign key (bookid) references book(bookid)
);

-- user


create table user_info
(
	userName	varchar(30)	primary key,
    nameF	varchar(30)	not null,
    nameL	varchar(20)	not null,
    email	varchar(50)	unique
);

-- address


create table user_address
(
	userName	varchar(30) not null,
    street	varchar (100) not null,
    apt		varchar (10),
    city	varchar	(20) not null,
    state	char(2)	not null, -- na if not a state
    country	varchar(20) not null	default 'United States',
    foreign key (userName) references user_info(userName)
);

-- credit card


create table card
(
	userName	varchar(30)	not null,
	cardNr	char(16)	primary key,
    name	varchar(30)	not null,
    expMonth	char(2)	not null,
    expYear		char(2)	not null,
    securityCode	char(4),
    foreign key (userName) references user_info(userName)
);

-- test cart for the website
create table test_cart
 (
	bookid	int	primary key,
    title	varchar(100),
    price	decimal (6, 2),
    count	int,
    check(count > -1),
    foreign key (bookid) references book(bookid)
 );

