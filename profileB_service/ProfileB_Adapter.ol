include "console.iol"
include "../db_service/person_iface.iol"


//execution{ concurrent }

outputPort Server {
	Location: "socket://localhost:8001/"
	Protocol: http
	Interfaces: Persons
}

inputPort ProfileB {
	Location: "socket://localhost:2002/"
	Protocol: http	
	Redirects: DB => Server 
	
}

embedded {
Jolie:  "/db_service/PersonDB_crud.ol" in Server}

main 
{
println@Console( "Loading ProfileB Services!" )()
}