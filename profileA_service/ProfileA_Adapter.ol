include "console.iol"
include "../authenticator.iol"
include "../db_service/user_iface.iol"

execution{ concurrent }
outputPort Server {
	Location: "socket://localhost:8002/"
	Protocol: http
	Interfaces: Users
}

inputPort ProfileA {
	Location: "socket://localhost:2001/"
	Protocol: sodep
	Interfaces: AuthenticatorInterface
	Redirects: DB => Server 
}

	
	
embedded {
		Jolie:  "/db_service/UserDB_crud.ol" in Server
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