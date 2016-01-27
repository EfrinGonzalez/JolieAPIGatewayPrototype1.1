include "console.iol"
include "runtime.iol"
include "../authenticator.iol"
include "../db_service/user_iface.iol"
include "/db_service/DBConnector_iface.iol"
include "database.iol"


execution{ concurrent }


inputPort DB_Connector {
	Location: "socket://localhost:1000/"
	Protocol: sodep
	Interfaces: ConnectionPool
}

	
	


main 
{
	connectionConfigInfo()(connectionInfo){
		with (connectionInfo) {
			.username = "";
			.password = "";
			.host = "127.0.0.1";
			.port = 3306;
			.database = "test"; 		
			.driver = "mysql"
		}
	
	}
}