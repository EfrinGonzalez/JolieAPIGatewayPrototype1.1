include "console.iol"
include "database.iol"
include "string_utils.iol"
include "../db_service/person_iface.iol"


execution { concurrent }

inputPort Monitor {
	Location: "socket://localhost:8005/"
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
	//Example: http://localhost:8005/retrieveAll
	[ retrieveAll()(response) {
		query@Database(
			"select * from service_registry"
		)(sqlResponse);
		response.values -> sqlResponse.row
	} ]
	
	
}
