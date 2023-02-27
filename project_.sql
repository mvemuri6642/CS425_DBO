use manohar;



create table users (
  name varchar(255) NOT NULL,
  email varchar(255) primary key,
  password varchar(255) not null,
  type ENUM('agent', 'perspective_renter') NOT NULL
);
insert into users(name,email,password,type) values('manohar', 'mvemuri02@gmail.com','sai','agent');
INSERT INTO users VALUES('madhu','madhu@gmail.com', 'madhu','agent');
select * from users;


create table agents(
emailID varchar(25) primary key,
name char(25),
job_title varchar(25) not null,
agency varchar(25) not null,
contact_info varchar(15) not null,
foreign key (emailID) references users(email));
INSERT INTO agents VALUES ('madhu@gmail.com','madhu','manager','Madhu Realty', '312-721-6465');
select * from agents;


CREATE TABLE perspective_renters (
  emailID varchar(255) PRIMARY KEY,
  name char(255),
  move_in_date DATE NOT NULL,
  location VARCHAR(255) NOT NULL,
  budget INT NOT NULL,
  FOREIGN KEY (emailID) REFERENCES users(email)
);
insert into perspective_renters values('mvemuri02@gmail.com','manohar','2022-01-01','Chicago',2000);
select * from perspective_renters;


create table creditCard_information(emailID varchar(255),Card_Number INT primary key not null, cardExpiry date not null,Name char(25) not null, 
cvv numeric(3) not null, FOREIGN KEY (emailID) REFERENCES users(email));
select * from creditCard_information;

create table customerAddress(addressID INT AUTO_INCREMENT PRIMARY KEY, line_1 varchar(25), line_2 varchar(25), postal_code numeric(5),
city char(25), state char(25), country char(25));
select * from customerAddress;

create table property(propertyID varchar(25),property_type ENUM('house', 'apartment','commercial_building') NOT NULL, location char(35),
city char(35),address varchar(100),price int,description varchar(255),availability date);
select * from property;