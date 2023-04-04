create database manohar; #here i am creating our own database
use manohar;

#users table
create table users (
  name varchar(255) NOT NULL,
  email varchar(255) primary key,
  password varchar(255) not null,
  type ENUM('agent', 'perspective_renter') NOT NULL
);
#agents table
create table agents(
emailID varchar(255) primary key,
name char(25),
job_title varchar(25) not null,
agency varchar(25) not null,
contact_info varchar(15) not null,
foreign key (emailID) references users(email));

#renters table
CREATE TABLE perspective_renters (
  emailID varchar(255) PRIMARY KEY,
  name char(255),
  move_in_date DATE NOT NULL,
  location VARCHAR(255) NOT NULL,
  budget INT NOT NULL,
  FOREIGN KEY (emailID) REFERENCES users(email)
);

#renters address
create table renterAddress(emailID varchar(255) primary key,addressID INT AUTO_INCREMENT UNIQUE, line_1 varchar(25), line_2 varchar(25), postal_code numeric(5),
city char(25), state char(25), country char(25),FOREIGN KEY (emailID) REFERENCES perspective_renters(emailID));

#creditcard_information
create table creditCard_information(emailID varchar(255),Card_Number numeric(16) primary key not null, cardExpiry date not null,Name char(25) not null, 
cvv numeric(3) not null ,FOREIGN KEY (emailID) REFERENCES perspective_renters(emailID));

#property
create table property(emailID varchar(255),propertyID INT AUTO_INCREMENT UNIQUE,property_type ENUM('house', 'apartment','commercial_building') NOT NULL, location char(35),
city char(35),address varchar(100),price int,description varchar(255),availability date,images varchar(25),FOREIGN KEY (emailID) REFERENCES agents(emailID));

#houses
create table houses(houseID INT unique, rooms int,sft int, foreign key(houseID) references property(propertyID));

#apartments
create table apartments(apartmentID INT unique, rooms int, sft int, building_type varchar(25), foreign key(apartmentID) references property(propertyID));

#commercial building
create table commercial_building(buildingID int unique,sft int, type varchar(25), foreign key(buildingID) references property(propertyID));

#booking
create table bookingRecords(BookingID int primary key AUTO_INCREMENT,emailID varchar(255) not null, propertyID int unique not null,creditCard numeric(16), 
foreign key(emailID) references perspective_renters(emailID), foreign key(propertyID) references property(propertyID),foreign key(creditCard)
references creditCard_information(Card_Number)
);

##END--SCHEMA DESIGN

#Insert into table(This is done to check the relations)
# Users
-- insert into users(name,email,password,type) values('manohar', 'mvemuri02@gmail.com','sai','agent');
-- INSERT INTO users(name,email,password,type) VALUES('madhu','madhu@gmail.com', 'madhu','agent');
-- select * from users;

#agents
-- INSERT INTO agents(emailID,name,job_title,agency,contact_info) VALUES ('madhu@gmail.com','madhu','manager','Madhu Realty', '312-721-6465');
-- select * from agents;

#perspective_renters
-- insert into perspective_renters values('mvemuri02@gmail.com','manohar','2022-01-01','Chicago',2000);
-- select * from perspective_renters;


#renters_address
-- insert into renterAddress (emailID,line_1,line_2,postal_code,city,state,country)values('mvemuri02@gmail.com','3001 S King Drive','000','60616','Chicago','IL','US');
-- select * from renterAddress;


#credit card information
-- insert into creditCard_information values('mvemuri02@gmail.com',1234123412341234,'2022-02-02','manohar','001');
-- select * from creditCard_information;


#property
-- insert into property(emailID,property_type,location,city,address,price,description,availability,images) values('madhu@gmail.com','house','South Chicago','Chicago','3001 S King Drive',2400,'good','2022-02-02','yet to be developed');
-- insert into property(emailID,property_type,location,city,address,price,description,availability,images) values('madhu@gmail.com','apartment','Downtown','New York','Chambers ST',22000,'furnished & in good condition','2023-09-06','yet to be developed');
-- insert into property(emailID,property_type,location,city,address,price,description,availability,images) values('madhu@gmail.com','commercial_building','Downtown','San Fransisco','Bay Area',45000,'good','2023-04-09','yet to be developed');
-- select * from property;

#houses
-- insert into houses(houseID,rooms,sft) values(1,2,800);
-- select * from houses;

#apartments
-- insert into apartments values(2,5,1150,'apartment_type');
-- select * from apartments;

#commercial_building
-- insert into commercial_building values(3,25000,'shopping complex');
-- select * from commercial_building;

#bookingRecords
-- insert into bookingRecords(emailID,propertyID,creditCard) values('mvemuri02@gmail.com',1,1234123412341234);
-- insert into bookingRecords(emailID,propertyID,creditCard) values('mvemuri02@gmail.com',2,1234123412341234);
-- select * from bookingRecords;




