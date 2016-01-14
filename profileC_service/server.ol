include "twiceInterface.iol"

execution{ concurrent }

inputPort TwiceService {
	Location: "socket://localhost:2004"
	Protocol: sodep
	Interfaces: TwiceInterface
}

main
{
	twiceJolie( number )( result )
	{
		result = number * 2
	}
}