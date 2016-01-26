include "console.iol"
include "/db_service/user_iface.iol"

inputPort Auth_Service{
	Location: "socket://localhost:9000"
	Protocol: sodep
	Interfaces: Users
}

main
{

	auth(user)(response){
		if(user.email=="test"){
			response = true
		}else{
			response = false
		}
		
			
	}
	
	
}