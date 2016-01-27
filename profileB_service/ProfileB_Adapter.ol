include "console.iol"
include "../db_service/person_iface.iol"
include "../authenticator.iol"
include "../db_service/user_iface.iol"


execution{ concurrent }

outputPort Server {
	Location: "socket://localhost:8001/"
	Protocol: http
	Interfaces: Users
}

inputPort ProfileB {
	Location: "socket://localhost:2002/"
	Protocol: sodep	
	Interfaces: AuthenticatorInterface
	Redirects: DB => Server 
	
}

embedded {
		Jolie:  "/db_service/PersonDB_crud.ol" in Server
		}

main 
{
	loadingMessage( profileName );
	println@Console("Loading "+ profileName +" Services!")();

	keepRunning = true;
	while( keepRunning ){	
				keepRunning = true
			}
}