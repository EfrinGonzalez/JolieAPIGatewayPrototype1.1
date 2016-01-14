include "console.iol"
include "twiceInterface.iol"

interface MyConsoleInterface {
	OneWay:	println( string )
}

interface TwiceInterfaceJava {
	RequestResponse: 	twiceInt( int )( int ),
						twiceDoub( double )( double )
}

outputPort MyConsole {
	Interfaces: MyConsoleInterface
}

outputPort TwiceJava {
	Interfaces: TwiceInterfaceJava
}

embedded {
	Java: 	"example.Twice" in TwiceJava,
			"example.MyConsole" in MyConsole
}

outputPort ProfileC {
	Location: "socket://localhost:2004/"
	Protocol: sodep
	Interfaces: TwiceInterface
}

main
{
	//calling the java methods through the java embedded classes.
	intExample = 3;
	doubleExample = 3.14;
	twiceInt@TwiceJava( intExample )( intExample );
	twiceDoub@TwiceJava( doubleExample )( doubleExample );
	println@MyConsole("intExample twice from java: " + intExample );
	println@MyConsole("doubleExample twice from java: " + doubleExample );
	
	
	//Calling the jolie methods through the jolie embedded jolie files. 
	twiceJolie@ProfileC( 15 )( response );
	println@Console( "Value from jolie: "+response )()
	
	
	
}