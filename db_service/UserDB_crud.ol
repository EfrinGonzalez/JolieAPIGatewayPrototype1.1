include "console.iol"
include "database.iol"
include "string_utils.iol"
include "person_iface.iol"


execution { concurrent }


inputPort Server {
	Location: "socket://localhost:8002/"
	Protocol: http { .format = "json" }
	Interfaces: Persons
}



init
{
	with (connectionInfo) {
		.username = "";
		.password = "";
		.host = "127.0.0.1";
		.port = 3306;
		.database = "test"; 		
		.driver = "mysql"
	};
	connect@Database(connectionInfo)()
	
}

main
{
	//Example: http://localhost:8002/retrieveAll
	[ retrieveAll()(response) {
		query@Database(
			"select * from users"
		)(sqlResponse);
		response.values -> sqlResponse.row
	} ]
	
	//Example: http://localhost:8002/create?email=test@test.com&name=test&password=test
	[ create(request)(response) {
		update@Database(
			"insert into users(email, name, password) values (:email, :name, :password)" {
				.email = request.email,
				.name = request.name,
				.password = request.password
			}
		)(response.status)
	} ]
	
	//Example: http://localhost:8002/retrieve?id=1
	[ retrieve(request)(response) {
		query@Database(
			"select * from users where user_id=:id" {
				.id = request.id
			}
		)(sqlResponse);
		
		println@Console( "You have requested the user_id: " + request.id)();
		
		if (#sqlResponse.row == 1) {
			response -> sqlResponse.row[0]			
		}
		
	} ]	
	
	//Example: http://localhost:8002/update?id=5&name=Magda2
	[ update(request)(response) {
		update@Database(
			"update users set name=:name where user_id=:id" {
				.id = request.id,
				.name = request.name
				
			}
		)(response.status)
	} ]
	
	//Example: http://localhost:8002/delete?id=3
	[ delete(request)(response) {
		update@Database(
			"delete from users where user_id=:id" {
				.id = request.id
			}
		)(response.status)
	} ]
	
}
