include "console.iol"
include "database.iol"
include "time.iol"
include "../db_service/person_iface.iol"
include "/db_service/user_iface.iol"
include "runtime.iol"
//include "authenticator.iol"
include "protocols/http.iol"
include "MonitoringTool/LeonardoWebServer/config.iol"

execution{ concurrent }

outputPort Auth_Service{
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: Users
}

//Important: The gateway runs the monitoring service
outputPort Monitor {
	Location: "socket://localhost:8005/"
	//Protocol: http { .format = "json" }
	Interfaces: Persons
}

//Important: the gateway runs the leonardo server to show what it is in the monitoring service
outputPort HTTPInput {
	Location: Location_Leonardo
	//Protocol: http { .format = "json" }
	//Interfaces: HTTPInterface
}

inputPort Gateway{
	Location: "socket://localhost:2000"
	Protocol: sodep
	Interfaces: Users
	Redirects: MonitoringTool => Monitor,	
			   LeonardoWebServer => HTTPInput
}

embedded {
		Jolie:  "/MonitoringTool/Monitor.ol" in Monitor,
		        "/MonitoringTool/LeonardoWebServer/leonardo.ol",
				"/auth_service/Auth.ol"
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
	
	//login(profile);
	/*Important: Here, is is needed to use the comming profile data. Therefore, it is better
	to have this connection logic here, instead of having it on the init procedure.*/
	
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






