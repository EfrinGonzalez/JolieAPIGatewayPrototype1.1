type User:void {
	.email:string
	.name:string
	.profile:string
}

interface Users {
RequestResponse:
	retrieveAll(void)(undefined),
	create(undefined)(undefined),
	retrieve(undefined)(undefined),
	update(undefined)(undefined),
	delete(undefined)(undefined),
	twice( int )( int ),
	auth(User)(bool)
	
OneWay: 
	login(User)	
}


