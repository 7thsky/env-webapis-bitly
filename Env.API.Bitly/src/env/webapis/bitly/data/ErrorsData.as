package env.webapis.bitly.data
{
	import env.webapis.bitly.BitlyData;
	import env.webapis.bitly.BitlyFault;
	
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
			var s:String;
			var fault:BitlyFault;
			
			s = '[ErrorsData count="' + (faults ? faults.length : 0) + '"]';
			
			if (faults) 
			{
				for each (fault in faults) 
				{
					s += "\n\t" + fault;
				}
			} 
			
			return s;
		}
		
		// ----------------------------------------------------
		//	interface : properties
		// ----------------------------------------------------

	}
}