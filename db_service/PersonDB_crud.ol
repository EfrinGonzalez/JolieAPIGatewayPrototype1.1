include "console.iol"
include "database.iol"
include "string_utils.iol"

execution { concurrent }

interface Persons {
RequestResponse:
	retrieveAll(void)(undefined),
	create(undefined)(undefined),
	retrieve(undefined)(undefined),
	update(undefined)(undefined),
	delete(undefined)(undefined)
}

inputPort Server {
	Location: "socket://localhost:8001/"
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
	//connect@Database(connectionInfo)();
	
	
	// create table if it does not exist
	//scope (createTable) {
	//	install (SQLException => println@Console("TodoItem table already there")());
	//	update@Database(
	//	    "insert into persons values(4, 'Josue');"
	//	)(ret)
	//}
}

main
{
	//println@Console("connected")()
	
	//Example: http://localhost:8001/retrieveAll
	[ retrieveAll()(response) {
		query@Database(
			"select * from persons"
		)(sqlResponse);
		response.values -> sqlResponse.row
	} ]
	
	//Example: http://localhost:8001/create?id=1&name=Magda
	[ create(request)(response) {
		update@Database(
			"insert into persons(personid, name) values (:id, :name)" {
				.id = request.id,
				.name = request.name
			}
		)(response.status)
	} ]
	
	//Example: http://localhost:8001/retrieve?id=1
	[ retrieve(request)(response) {
		query@Database(
			"select * from persons where personid=:id" {
				.id = request.id
			}
		)(sqlResponse);
		if (#sqlResponse.row == 1) {
			response -> sqlResponse.row[0]
		}
	} ]	
	
	//Example: http://localhost:8001/update?id=5&name=Magda2
	[ update(request)(response) {
		update@Database(
			"update persons set name=:name where personid=:id" {
				.id = request.id,
				.name = request.name
				
			}
		)(response.status)
	} ]
	
	//Example: http://localhost:8001/delete?id=5
	[ delete(request)(response) {
		update@Database(
			"delete from persons where personid=:id" {
				.id = request.id
			}
		)(response.status)
	} ]
}
