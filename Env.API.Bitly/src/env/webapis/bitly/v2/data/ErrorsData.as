package env.webapis.bitly.v2.data
{
	import env.webapis.bitly.v2.BitlyData;
	import env.webapis.bitly.v2.BitlyFault;
	
	public class ErrorsData
	extends BitlyData
	{
		public var faults:Array;
		
		// ----------------------------------------------------
		//	interface : methods
		// ----------------------------------------------------
		
		public function ErrorsData()
		{
		}
		
		override public function toString():String
		{
			return '[ErrorsData count="' + (faults ? faults.length : 0) + '"]';
		}
		
		// ----------------------------------------------------
		//	interface : properties
		// ----------------------------------------------------

	}
}