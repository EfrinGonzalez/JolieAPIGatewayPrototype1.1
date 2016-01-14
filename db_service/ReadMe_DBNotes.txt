The lib folder must be where the DB functionallity is called. In this case, the the whole process starts at API_Gateway, once the services are redirected to other services and loaded at the same time the API_Gateway is loaded. So, it is necessary for that library to live at root level for this case. 

DB

CREATE TABLE persons
(
person_id int NOT NULL,
name varchar(255)
)


CREATE TABLE users
(
user_id int NOT NULL AUTO_INCREMENT,
email varchar(255) NOT NULL,
name varchar(255),
password varchar(255),
PRIMARY KEY (user_id)
)

CREATE TABLE service_registry
(
service_id int NOT NULL AUTO_INCREMENT,
context varchar(255) NOT NULL,
protocol varchar(255) NOT NULL,
input_port varchar(255),
filepath varchar(255),
location varchar(255),
PRIMARY KEY (service_id)
)

INSERT INTO service_registry (context, protocol, input_port, filepath, location)
VALUES ('A','sodep', 'ProfileA','/profileA_service/ProfileA_Adapter.ol','socket://localhost:2001/');