// Client.ol works with only one instance because of the hardcoded callback port (4002)

include "console.iol"
include "/Dynamic_Embedding_Counter/embedderInterface.iol"
include "/Dynamic_Embedding_Counter/clientInterface.iol"
include "/profileC_service/twiceInterface.iol"
include "authenticator.iol"
include "/db_service/user_iface.iol"

outputPort Gateway{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: Users
}

outputPort ProfileB {
	Location: "socket://localhost:2002/"
	Protocol: sodep
	Interfaces: AuthenticatorInterface	
}
inputPort ClientB{
	Location: "socket://localhost:4003"
	Protocol: sodep
	Interfaces: CounterClientInterface
}

main
{

	user.email = args[0];
	println@Console(user.mail)();
	user.name = args[1];
	user.profile = args[2];
	
	 //Saying wich profile is loaded
	 login@Gateway(user)|
	 loadingMessage@ProfileB("ProfileB")
	
	
}