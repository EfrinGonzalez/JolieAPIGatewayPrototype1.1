include "console.iol"
include "database.iol"
include "string_utils.iol"
include "../db_service/person_iface.iol"
include "/db_service/DBConnector_iface.iol"

execution { concurrent }

outputPort DB_Connector {
	Location: "socket://localhost:1000/"
	Protocol: sodep
	Interfaces: ConnectionPool
}

inputPort Monitor {
	Location: "socket://localhost:8005/"
	Protocol: http { .format = "json" }
	Interfaces: Persons, ConnectionPool
}

/*embedded {
		Jolie:  "/db_service/DBConnector.ol"
		}
*/
init
{
	connectionConfigInfo@DB_Connector()(connectionInfo);
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
