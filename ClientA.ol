// Client.ol works with only one instance because of the hardcoded callback port (4002)

include "console.iol"
include "/Dynamic_Embedding_Counter/embedderInterface.iol"
include "/Dynamic_Embedding_Counter/clientInterface.iol"
include "/profileC_service/twiceInterface.iol"
include "authenticator.iol"

inputPort ClientA{
	Location: "socket://localhost:4002"
	Protocol: sodep
	Interfaces: CounterClientInterface
}

outputPort Gateway{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: CounterEmbedderInterface, AuthenticatorInterface
}

outputPort TwiceService {
	Location: "socket://localhost:2004/"
	Protocol: sodep
	Interfaces: TwiceInterface
}

outputPort ProfileA {
	Location: "socket://localhost:2001/"
	Protocol: sodep
	Interfaces: AuthenticatorInterface	
}

main
{

	request = args[0];
	 //Saying wich profile is loaded
	 login@Gateway(request)|
	 loadingMessage@ProfileA("ProfileA")
	 
	 
	 
	/* request = args[0];
	 //Saying wich profile is loaded
	 login@Gateway(request)(response)|
	 println@Console(response)()|
	 twiceJolie@TwiceService( 15 )( response );	
	 //in the case profile three loads the java and jolie services
	 println@Console( "Value from jolie: "+response )()
	 */
	 /*
	 //calling the java methods through the java embedded classes.
	intExample = 3;
	doubleExample = 3.14;
	twiceInt@TwiceJava( intExample )( intExample );
	twiceDoub@TwiceJava( doubleExample )( doubleExample );
	println@MyConsole("intExample twice from java: " + intExample );
	println@MyConsole("doubleExample twice from java: " + doubleExample );
	
	
	 */
	
	
}