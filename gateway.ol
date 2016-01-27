include "console.iol"
include "database.iol"
include "time.iol"
include "../db_service/person_iface.iol"
include "/db_service/user_iface.iol"
include "/db_service/DBConnector_iface.iol"
include "runtime.iol"
//include "authenticator.iol"
include "protocols/http.iol"
include "MonitoringTool/LeonardoWebServer/config.iol"

execution{ concurrent }

outputPort DB_Connector {
	Location: "socket://localhost:1000/"
	Protocol: sodep
	Interfaces: ConnectionPool
}

outputPort Auth_Service{
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: Users
}

//Note: The gateway runs the monitoring service
outputPort Monitor {
	Location: "socket://localhost:8005/"
	//Protocol: http { .format = "json" }
	Interfaces: Persons
}

//Note: the gateway runs the leonardo server to show what it is 
//in the monitoring service.
outputPort HTTPInput {
	Location: Location_Leonardo
	//Protocol: http { .format = "json" }
	//Interfaces: HTTPInterface
}

inputPort Gateway{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: Users, ConnectionPool
	Redirects: MonitoringTool => Monitor,	
			   LeonardoWebServer => HTTPInput
}

embedded 
{
		Jolie:  "/MonitoringTool/Monitor.ol" in Monitor,
		        "/MonitoringTool/LeonardoWebServer/leonardo.ol" in HTTPInput,
				"/auth_service/Auth.ol",
				"/db_service/DBConnector.ol"
}
	
init
{
	connectionConfigInfo@DB_Connector()(connectionInfo);
	connect@Database(connectionInfo)()
		
}			

main
{
	login(user);
	profile = user.profile;
	println@Console("Email: "+user.email)();
	println@Console("Name: "+user.name)();
	println@Console("Profile "+user.profile)();
	
	
	
	
	auth@Auth_Service(user)(response);
	println@Console("Authentication response is: " + response)();
	if(response = true){				
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

			embedInfo.type = "Jolie";
			keepRunning = true;
			embedInfo.filepath = result.row[0].filepath;
			loadEmbeddedService@Runtime( embedInfo )( result.row[0].context.location );
			
			while( keepRunning ){	
				keepRunning = true
			}
				
	}			
		
		
		
	
	
	
	
	
}






