package env.webapis.bitly.v2.data
{
	import env.webapis.bitly.v2.BitlyData;

	public class ExpandData 
	extends BitlyData
	{
		
		public var hash:String;
		public var longURL:String;
		
		// ------------------------------------------------
		//	interface : methods
		// ------------------------------------------------
		
		public function ExpandData()
		{
		}
		
		override public function toString():String
		{
			return '[ExpandData' +
				' hash="' + hash + '"' +
				' longURL="' + longURL + '"]';
		}
		
		// ------------------------------------------------
		//	interface : properties
		// ------------------------------------------------
		
		
	}
}