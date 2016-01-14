include "console.iol"
include "twiceInterface.iol"

//execution{ concurrent }

outputPort TwiceServer {
	Location: "socket://localhost:2004/"
	Protocol: sodep
	Interfaces: TwiceInterface
}



inputPort ProfileC {
	Location: "socket://localhost:2003/"
	Protocol: sodep	
	//Interfaces: TwiceInterface	
	Redirects: Twice => TwiceServer 
}

embedded {
Jolie:  "server.ol" in TwiceServer}

main 
{

	println@Console( "Loading ProfileC Services!" )()
	
}