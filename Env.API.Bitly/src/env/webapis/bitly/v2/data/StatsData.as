package env.webapis.bitly.v2.data
{
	import env.webapis.bitly.v2.BitlyData;
	
	public class StatsData
	extends BitlyData
	{
		public static const DIRECT:String = 'direct';
		
		public var totalClicks:int;
		public var hash:String;
		public var referrers:Array;
				
		// -------------------------------------------------------
		//	interface : methods
		// -------------------------------------------------------
				
		public function StatsData()
		{
		}
		
		override public function toString():String 
		{
			return '[StatsData' +
				' totalClicks="' + totalClicks + '"' +
				' hasReferrers="' + (referrers && referrers.length > 0) + '"]';
		}
		
		// -------------------------------------------------------
		//	interface : properties
		// -------------------------------------------------------
				

	}
}