type Person:void {
	.email:string
	.name:string
}

interface Persons {
RequestResponse:
	retrieveAll(void)(undefined),
	create(undefined)(undefined),
	retrieve(undefined)(undefined),
	update(undefined)(undefined),
	delete(undefined)(undefined),
	twice( int )( int ) 
}

//Just in case
/*interface MyInterface {
RequestResponse:
	sayHello( Person )( string )
}*/
