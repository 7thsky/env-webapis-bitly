package env.webapis.bitly.v2
{
	public class BitlyFault
	{
		
		public var code:String;
		public var message:String;
		
		// ---------------------------------------------
		//	interface : methods
		// ---------------------------------------------
		
		public function BitlyFault()
		{
		}
		
		public function toString():String
		{
			return '[BitlyFault' +
				' code="' + code + '"' +
				' message="' + message + '"]';
		}
		
		// ---------------------------------------------
		//	interface : properties
		// ---------------------------------------------
		
	}
}