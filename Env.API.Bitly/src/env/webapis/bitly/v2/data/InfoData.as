package env.webapis.bitly.v2.data
{
	import env.webapis.bitly.v2.BitlyData;
	
	public class InfoData
	extends BitlyData
	{
		public var shortenedByUser:String;
		public var keywords:Array;
		public var hash:String;
		public var longURL:String;
		public var globalHash:String;
		public var userHash:String;
		public var keyword:String;
		
		public var exif:String;
		public var surbl:String;
		public var contentLength:String;
		public var id3:String;
		public var version:String;

		public var htmlMetaDescription:String;
		public var htmlMetaKeywords:Array;
		
		public var calais:String;
		public var calaisId:String;
		public var calaisResolutions:Array;
		
		public var thumbnail:String;
		public var contentType:String;
		public var htmlTitle:String;
		
		public var mirrorURL:String;
		public var metacarta:String;
				
		public var users:Array;
		 
		// -------------------------------------------------------------
		//	interface : methods
		// -------------------------------------------------------------
			
		public function InfoData()
		{
		}

		override public function toString():String
		{
			return '[InfoData' +
				' hash="' + hash + '"' +
				' userHash="' + userHash + '"' +
				' globalHash="' + globalHash + '"' +
				' keyword="' + keyword + '"' +
				' longURL="' + longURL + '"' +
				' shortenByUser="' + shortenedByUser + '"]';
		}
		// -------------------------------------------------------------
		//	interface : properties
		// -------------------------------------------------------------
			

	}
}