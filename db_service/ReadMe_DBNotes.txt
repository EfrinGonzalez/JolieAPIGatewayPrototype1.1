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

