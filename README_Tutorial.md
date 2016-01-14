# JolieAPIGatewayPrototype1.0
Master Thesis project on Microservices and Jolie Programming Language.

Before you start the services, you should have a MySql database as follows:
name: test
tables: persons, users

SQL
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

To start the software go to the command line and look for main root of the project, and write: jolie API_Gateway.ol

The Gateway will be waiting for you to run the client that sends the parameter for the user profile. In this case it will be 1, 2 or 3. 

So, now run the next: jolie client.ol 1 
the number 1 (2 or 3 as well) is the parameter to decide which set of services to start. 
If you choose 1, please go to http://localhost:8001/retrieveAll 
If you choose 2, please go to http://localhost:8002/retrieveAll

Those links will provide the information on the browser for the time being. It is not how it will work, but it just for demonstration. That would be enough for the time being. 

If you choose 3, you just need to run the next: 
jolie client.ol 3
And this will show you a text as follows: 
Value from Jolie: 30.
This is a demonstration of how to use an embedded Jolie service, calling it in parallel from the client. 