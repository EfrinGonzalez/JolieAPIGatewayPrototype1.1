include "console.iol"
include "runtime.iol"
include "../authenticator.iol"
include "../db_service/user_iface.iol"

execution{ concurrent }
outputPort UserDB_Service {
	Location: "socket://localhost:8002/"
	Protocol: http
	Interfaces: Users
}

inputPort ProfileA {
	Location: "socket://localhost:2001/"
	Protocol: sodep
	Interfaces: AuthenticatorInterface
	Redirects: DB => UserDB_Service 
}

	
	
embedded {
		Jolie:  "/db_service/UserDB_crud.ol" in UserDB_Service
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