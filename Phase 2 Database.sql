-- Drone Delivery Service Database

drop database if exists drone_delivery;
create database if not exists drone_delivery;
use drone_delivery;

-- ingredient
drop table if exists ingredient;
create table ingredient (
	barcode varchar(40) PRIMARY KEY NOT NULL,
    iname char(100),
    weight int
);

insert into ingredient (barcode, iname, weight) values ('bv_4U5L7M', 'balsamic vinegar', 4);
insert into ingredient (barcode, iname, weight) values ('clc_4T9U25X', 'caviar', 5);
insert into ingredient (barcode, iname, weight) values ('ap_9T25E36L', 'foie gras', 4);
insert into ingredient (barcode, iname, weight) values ('pr_3C6A9R', 'prosciutto', 6);
insert into ingredient (barcode, iname, weight) values ('ss_2D4E6L', 'saffron', 3);
insert into ingredient (barcode, iname, weight) values ('hs_5E7L23M', 'truffles', 3);

-- user
drop table if exists users;
create table users (
	username varchar(40) PRIMARY KEY NOT NULL,
    first_name varchar(100),
    last_name varchar(100),
    address varchar(500),
    birthdate date 
    );

insert into users (username, first_name, last_name, address, birthdate) values
('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
('ckann5', 'Carrot', 'Kann', '64 Knights Square Trail', '1972-09-01'),
('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28'),
('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
('mrobot1', 'Mister', 'Robot', '10 Autonomy Trace', '1988-11-02'),
('mrobot2', 'Mister', 'Robot', '10 Clone Me Circle', '1988-11-02'),
('rlopez6', 'Radish', 'Lopez', '8 Queens Route', '1999-09-03'),
('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19');

-- employee
drop table if exists employee;
create table employee (
	usernameID varchar(40) PRIMARY KEY NOT NULL,
	FOREIGN KEY (usernameID) 
		REFERENCES users(username),
	taxID varchar(40) NOT NULL UNIQUE,
    hired date,
    salary int,
    experience int,
    CHECK (taxID regexp '[0-9]{3}[-][0-9]{2}[-][0-9]{4}')
);

insert into employee (usernameID, taxID, hired, salary, experience) values
('agarcia7', '999-99-9999', '2019-03-17', 41000, 24),
('awilson5', '111-11-1111', '2020-03-15', 46000, 9),
('bsummers4', '000-00-0000', '2018-12-06', 35000, 17),
('ckann5', '640-81-2357', '2019-08-03', 46000, 27),
('csoares8', '888-88-8888', '2019-02-25', 57000, 26),
('echarles19', '777-77-7777', '2021-01-02', 27000, 3),
('eross10', '444-44-4444', '2020-04-17', 61000, 10),
('fprefontaine6', '121-21-2121', '2020-04-19', 20000, 5),
('hstark16', '555-55-5555', '2018-07-23', 59000, 20),
('lrodriguez5', '222-22-2222', '2019-04-15', 58000, 20),
('mrobot1', '101-01-0101', '2015-05-27', 38000, 8),
('mrobot2', '010-10-1010', '2015-05-27', 38000, 8),
('rlopez6', '123-58-1321', '2017-02-05', 64000, 51),
('tmccall5', '333-33-3333', '2018-10-17', 33000, 29);

-- pilot
drop table if exists pilot;
create table pilot (
	licenseID varchar(40) UNIQUE NOT NULL,
    experience INT,
    employeeID varchar(40) PRIMARY KEY NOT NULL,
	FOREIGN KEY (employeeID) 
		REFERENCES employee(usernameID)
);

insert into pilot (employeeID, licenseID, experience) values
('agarcia7', 610623, 38),
('awilson5', 314159, 41),
('bsummers4', 411911, 35),
('csoares8', 343563, 7),
('echarles19', 236001, 10),
('fprefontaine6', 657483, 2),
('lrodriguez5', 287182, 67),
('mrobot1', 101010, 18),
('rlopez6', 235711, 58),
('tmccall5', 181633, 10);

-- worker
drop table if exists worker;
create table worker (
	employeeID varchar(40) PRIMARY KEY NOT NULL,
    FOREIGN KEY (employeeID)
		REFERENCES employee(usernameID)
);

insert into worker (employeeID) values
('ckann5'),
('csoares8'),
('echarles19'),
('eross10'),
('hstark16'),
('mrobot2'),
('tmccall5');

-- owner
drop table if exists owners;
create table owners (
	usernameID varchar(40) PRIMARY KEY NOT NULL,
    FOREIGN KEY (usernameID)
		REFERENCES users(username)
);

insert into owners (usernameID) values
('cjordan5'),
('jstone5'),
('sprince6');

-- restaurant
drop table if exists restaurant;
create table restaurant (
	rating INT,
	spent INT,
    rname varchar(40) PRIMARY KEY NOT NULL,
    fund varchar(40),
    FOREIGN KEY (fund)
		REFERENCES owners(usernameID),
	CHECK (rating <= 5), 
    CHECK (rating > 0)
);

insert into restaurant (rname, spent, rating, fund) values
('Bishoku', 10, 5, NULL),
('Casi Cielo', 30, 5, NULL),
('Ecco', 0, 3, 'jstone5'),
('Fogo de Chao', 30, 4, NULL),
('Hearth', 0, 4, NULL),
('Il Giallo', 10, 4, 'sprince6'),
('Lure', 20, 5, 'jstone5'),
('Micks', 0, 2, NULL),
('South City Kitchen', 30, 5, 'jstone5'),
('Tre Vele', 10, 4, NULL);

-- service 
drop table if exists service;
create table service (
	id varchar(40) PRIMARY KEY NOT NULL,
    sname varchar(100),
    manage varchar(40) NOT NULL,
    FOREIGN KEY (manage)
		REFERENCES worker(employeeID)
);

insert into service(id, sname, manage) values
('hf', 'Herban Feast', 'hstark16'),
('osf', 'On Safari Foods', 'eross10'),
('rr', 'Ravishing Radish', 'echarles19');

-- location
drop table if exists location;
create table location (
	label varchar(40) PRIMARY KEY NOT NULL,
    x_coord INT,
    y_coord INT, 
    space INT
);

insert into location(label, x_coord, y_coord, space) values
('airport', -2, -9, 4),
('avalon', 2, 16, 5),
('buckhead', 3, 8, 4),
('highpoint', 7, 0, 2),
('mercedes', 1, 1, 2),
('midtown', 1, 4, 3),
('plaza', 5, 12, 20),
('southside', 3, -6, 3);

-- drone
drop table if exists drone;
create table drone (
	serviceID varchar(40) NOT NULL,
	tag INT NOT NULL,
    fuel INT,
    capacity INT,
    sales INT,
	hover varchar(40) NOT NULL,
    FOREIGN KEY (serviceID)
		REFERENCES service (id),
	FOREIGN KEY (hover)
		REFERENCES location(label),
    control varchar(40),
	FOREIGN KEY (control) 
		REFERENCES pilot(employeeID),
    PRIMARY KEY (serviceID, tag)
);

insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('hf', 1, 100, 6, 0, 'southside', 'fprefontaine6');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('hf', 5, 27, 7, 100, 'buckhead', 'fprefontaine6');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('hf', 8, 100, 8, 0, 'southside', 'bsummers4');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('hf', 11, 25, 10, 0, 'buckhead', NULL);
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('hf', 16, 17, 5, 40, 'buckhead', 'fprefontaine6');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('osf', 1, 100, 9, 0, 'airport', 'awilson5');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('osf', 2, 75, 7, 0, 'airport', NULL);
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('rr', 3, 100, 5, 50, 'avalon', 'agarcia7');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('rr', 7, 53, 5, 100, 'avalon', 'agarcia7');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('rr', 8, 100, 6, 0, 'highpoint', 'agarcia7');
insert into drone (serviceID, tag, fuel, capacity, sales, hover, control) values ('rr', 11, 90, 6, 0, 'highpoint', NULL);

-- work_for
drop table if exists work_for;
create table work_for (
	empID varchar(40) NOT NULL,
    FOREIGN KEY (empID) 
		REFERENCES employee(usernameID),
    serviceID varchar(40) NOT NULL,
    FOREIGN KEY(serviceID) 
		REFERENCES service(id),
    PRIMARY KEY (empID, serviceID)
);

insert into work_for (empID, serviceID) values
('agarcia7', 'rr'),
('awilson5', 'osf'),
('bsummers4', 'hf'),
('ckann5', 'osf'),
('echarles19', 'rr'),
('eross10', 'osf'),
('fprefontaine6', 'hf'),
('hstark16', 'hf'),
('mrobot1', 'osf'),
('rlopez6', 'rr'),
('tmccall5', 'hf'),
('mrobot1', 'rr');

-- contain
drop table if exists contain;
create table contain (
	ingredientID varchar(40) NOT NULL,
    FOREIGN KEY (ingredientID)
		REFERENCES ingredient(barcode),
	droneID varchar(40) NOT NULL, 
    droneTag INT NOT NULL,
    FOREIGN KEY (droneID, droneTag)
		REFERENCES drone(serviceID, tag),
    price INT,
    quantity INT,
    PRIMARY KEY (ingredientID, droneID, droneTag)
);

insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('clc_4T9U25X', 'rr', 3, 28, 2);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('clc_4T9U25X', 'hf', 5, 30, 1);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('pr_3C6A9R', 'osf', 1, 20, 5);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('pr_3C6A9R', 'hf', 8, 18, 4);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('ss_2D4E6L', 'osf', 1, 23, 3);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('ss_2D4E6L', 'hf', 11, 19, 3);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('ss_2D4E6L', 'hf', 1, 27, 6);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('hs_5E7L23M', 'osf', 2, 14, 7);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('hs_5E7L23M', 'rr', 3, 15, 2);
insert into contain (ingredientID, droneID, droneTag, price, quantity) values ('hs_5E7L23M', 'hf', 5, 17, 4);

-- swarm
drop table if exists swarm;
create table swarm (
	leadDroneID varchar(40) NOT NULL,
	leadDroneTag INT NOT NULL,
	FOREIGN KEY (leadDroneID, leadDroneTag)
		REFERENCES drone(serviceID, tag),
    followDroneID varchar(40) NOT NULL,
    followDroneTag INT NOT NULL,
	FOREIGN KEY (followDroneID, followDroneTag)
		REFERENCES drone(serviceID, tag),
    
	PRIMARY KEY (leadDroneID, leadDroneTag, followDroneID, followDroneTag)
);

insert into swarm (leadDroneID, leadDroneTag, followDroneID, followDroneTag) values ('hf', 5, 'hf', 11);
insert into swarm (leadDroneID, leadDroneTag, followDroneID, followDroneTag) values ('osf', 1, 'osf', 2);
insert into swarm (leadDroneID, leadDroneTag, followDroneID, followDroneTag) values ('rr', 8, 'rr', 11);
