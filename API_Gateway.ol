include "console.iol"
include "database.iol"
include "time.iol"
include "/Dynamic_Embedding_Counter/counterInterface.iol"
include "/Dynamic_Embedding_Counter/embedderInterface.iol"
include "/Dynamic_Embedding_Counter/clientInterface.iol"
include "/profileC_service/twiceInterface.iol"
include "runtime.iol"
include "authenticator.iol"

execution{ single }

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
	println@Console( "Database connection successful!!!")();
	
	q = "select * from service_registry where service_id=:1" ;
	query@Database(q)(result);
	
	println@Console( "Service name: "+ result)()
}

main
{


		embedInfo.type = "Jolie";
		keepRunning = true;
		login(request)(response){
		//login(UserProfile)(response)	
		//if(request == 1){
		
		
		service_id = q.service_id;
		
		 //println@Console( "Testing DB" )();
		 //println@Console( "Value from jolie: "+ service_id)();
		
		
			//Loading profileA services
			
			
			
			embedInfo.filepath = "/profileA_service/ProfileA_Adapter.ol";
			loadEmbeddedService@Runtime( embedInfo )( ProfileA_Adapter.location );
			response = "Profile A services Loaded...";
			while( keepRunning ){	
				keepRunning = true
			}
	
	
	
	
	
	
	
	
		//}   else{
		//	keepRunning = false
		//}
		
		
	
	}
	
	
	
}






