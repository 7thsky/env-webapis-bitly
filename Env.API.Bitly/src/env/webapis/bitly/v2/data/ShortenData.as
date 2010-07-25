package env.webapis.bitly.v2.data
{
	import env.webapis.bitly.v2.BitlyData;
	
	public class ShortenData 
	extends BitlyData
	{
		public var shortURL:String;
		public var shortKeywordURL:String;
		public var longURL:String;
		public var hash:String;
		public var userHash:String;
		
		// ----------------------------------------------------------
		//	interface : methods
		// ----------------------------------------------------------
				
		public function ShortenData()
		{
			super();
		}
		
		override public function toString():String
		{
			return '[ShortenData' + 
				' shortURL="' + shortURL + '"' +
				' shortKeywordURL="' + shortKeywordURL + '"' +
				' longURL="' + longURL + '"' +
				' hash="' + hash + '"' +
				' userHash="' + userHash + '"]';
		}
		
		// ----------------------------------------------------------
		//	interface : properties
		// ----------------------------------------------------------
		
	}
}