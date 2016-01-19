include "console.iol"
include "database.iol"
include "time.iol"
include "/Dynamic_Embedding_Counter/counterInterface.iol"
include "/Dynamic_Embedding_Counter/embedderInterface.iol"
include "/Dynamic_Embedding_Counter/clientInterface.iol"
include "/profileC_service/twiceInterface.iol"
include "runtime.iol"
include "authenticator.iol"

execution{ concurrent }

outputPort CounterService{
	Interfaces: CounterInterface
}



inputPort Gateway{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: CounterEmbedderInterface, AuthenticatorInterface
}
	
init
{
	with (connectionInfo) {
		.username = "";
		.password = "";
		.host = "127.0.0.1";
		.port = 3306;
		.database = "test"; 		
		.driver = "mysql"
	};
	connect@Database(connectionInfo)();
	println@Console( "Database connection successful!!!")()
	
	/*q = "select * from service_registry where service_id=:service_id" ;
		 //q.service_id=1;
		 q.service_id=args[0];				
	query@Database(q)(result);	
	println@Console( "Service context: "+ result.row[0].context +
					 "--"+	
					 "Service protocol: "+ result.row[0].protocol +
					 "--"+	
					 "Service Input port: "+ result.row[0].input_port +
					 "--"+
					 "Service Filepath: "+ result.row[0].filepath +
					 "--"+
					 "Service Location: "+ result.row[0].location)()*/
}			

main
{
	login(profile);
		println@Console("Welcome!")();
		q = "select * from adapter_registry where service_id=:service_id" ;		 
		q.service_id=profile;
		//q.service_id=args[0];
		query@Database(q)(result);
		
		println@Console( "The requested service contains the following configuration;")();
		println@Console( "Service id: "+ result.row[0].service_id +
						 "\n"+	
						 "Service context: "+ result.row[0].context +
						 "\n"+	
						 "Service protocol: "+ result.row[0].protocol +
						 "\n"+	
						 "Service Input port: "+ result.row[0].input_port +
						 "\n"+
						 "Service Filepath: "+ result.row[0].filepath +
						 "\n"+
						 "Service Location: "+ result.row[0].location)();

	
			//answer = "Everything seems to be ok...!";
			embedInfo.type = "Jolie";
			keepRunning = true;
			embedInfo.filepath = result.row[0].filepath;
			loadEmbeddedService@Runtime( embedInfo )( result.row[0].context.location );
			
			
			
			
			
			while( keepRunning ){	
				keepRunning = true
			}
			
			
	
		
		
	
	
	
	
	
}






