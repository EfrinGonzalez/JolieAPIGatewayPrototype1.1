include "console.iol"
include "runtime.iol"
include "database.iol"
include "string_utils.iol"
include "person_iface.iol"
include "math.iol"
include "/db_service/DBConnector_iface.iol"

execution { concurrent }


interface ShutdownInterface {
OneWay: off(void)
}
outputPort DB_Connector {
	Location: "socket://localhost:1000/"
	Protocol: sodep
	Interfaces: ConnectionPool
}

inputPort UserDB_Service {
	Location: "socket://localhost:8002/"
	Protocol: http { .format = "json" }
	Interfaces: Persons, ShutdownInterface, ConnectionPool
}

init
{
	connectionConfigInfo@DB_Connector()(connectionInfo);
	connect@Database(connectionInfo)();
	
	//generating and random service_id	
	random@Math( )( random_service_id );
	println@Console( "response.random: " + random_service_id)();
	service_id = random_service_id;
	
	
	/*Important: The service registers itself in service registry. It unregisters by 
	using the shutdown() procedure like: http://localhost:8002/shutdown*/
	scope(update){
		install ( SQLException => println@Console("Inserting data to service registry")() );
					q = "insert into service_registry(service_id, context, input_port, location) values("+ service_id + ",'ProfileA', 'UserDB_Service','socket://localhost:8002/')";
					update@Database(q)(response);
				
		println@Console( "Registering status: " + response)()

	}
}

main
{
	/*off();
	keepRunning = true;
	while(keepRunning){*/
	
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
	
	// shutdown DB: http://localhost:8002/shutdown
	[shutdown(request)(response){
		update@Database( "delete from service_registry where service_id=:id"{
			.id = service_id
		}
		
		)( sqlResponse);
		response.values -> sqlResponse.row;
		callExit@Runtime(service.this)()
		
		
	}]
	
 
    
}
