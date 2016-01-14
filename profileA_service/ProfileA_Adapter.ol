include "console.iol"
include "authenticator.iol"
include "../db_service/user_iface.iol"

//execution{ concurrent }
outputPort Server {
	Location: "socket://localhost:8002/"
	Protocol: http
	Interfaces: Users
}

inputPort ProfileA {
	Location: "socket://localhost:2001/"
	Protocol: sodep
	Redirects: DB => Server 
}

	
	
embedded {
Jolie:  "/db_service/UserDB_crud.ol" in Server}

main 
{
println@Console( "Loading ProfileA Services!" )()

	
	
	
}