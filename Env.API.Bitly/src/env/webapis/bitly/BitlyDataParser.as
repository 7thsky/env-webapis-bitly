package env.webapis.bitly
{
	import env.webapis.bitly.data.ExpandData;
	import env.webapis.bitly.data.InfoData;
	import env.webapis.bitly.data.ShortenData;
	import env.webapis.bitly.data.StatsData;
	
	public class BitlyDataParser
	{
		public static function parseFault(response:XML):BitlyFault
		{
			var fault:BitlyFault;
			
			if (response) 
			{
				if (response.child('statusCode').text().toString().toLowerCase() == 'error')
				{ 
					fault 			= new BitlyFault();
					fault.code 		= response.child('errorCode').text()[0];
					fault.message	= response.child('errorMessage').text()[0];
				}
			} 
			else 
			{
				
			}
			
			return fault;
		}
		
		public static function parseData(response:XML, method:String):BitlyData
		{
			var data:BitlyData;
			var result:XML;
			
			
			result = response.child('results')[0];
			
			if (!result) 
			{
				return null
			} 
			
			switch (method)
			{
				case BitlyMethod.SHORTEN:
					data = parseShortenData(result);
					break;
					
				case BitlyMethod.EXPAND:
					data = parseExpandData(result);
					break;
					
				case BitlyMethod.INFO:
					data = parseInfoData(result);
					break;
					
				case BitlyMethod.STATS:
					data = parseStatsData(result);
					break;
					
				case BitlyMethod.ERRORS:
					data = parseErrorsData(result);
					break;
			}
			
			// save result xml node
			data.result = result;
			
			return data;
		}
		
		private static function parseShortenData(results:XML):BitlyData
		{
			var data:ShortenData;
			
			results					= results.child('nodeKeyVal')[0];
			data 					= new ShortenData();
			data.hash				= results.child('hash').text()[0];
			data.longURL			= results.child('nodeKey').text()[0];
			data.shortURL			= results.child('shortUrl').text()[0];
			data.userHash			= results.child('userHash').text()[0];
			data.shortKeywordURL	= results.child('shortKeywordUrl').text()[0];	
			
			return data;
		}
		
		private static function parseExpandData(results:XML):BitlyData
		{
			var data:ExpandData;
			var x:XML;
			
			data			= new ExpandData();	
			data.hash		= results.children()[0].name();
			data.longURL	= results.children().child('longUrl')[0].text();
			
			return data;
		}
		
		private static function parseStatsData(results:XML):BitlyData
		{
			var data:StatsData;
			var referrers:XMLList;
			var referrer:XML;
			
			data 				= new StatsData();
			data.hash			= results.child('hash').text()[0];
			data.totalClicks	= results.child('clicks').text()[0];
			data.referrers		= [];
			
			//
			// parse referrers
			//
			referrers = results.child('referrers').child('nodeKeyVal');
			
			for each (referrer in referrers) 
			{
				if (referrer.child('direct').length() == 1) 
				{
					data.referrers.push(
						{
							type:		'direct',
							domain:		null,
							path: 		null,
							clicks:		parseInt(referrer.child('direct').text()[0])
						});
				} 
				else 
				{
					data.referrers.push(
						{
							type: 		'embed',	
							domain: 	referrer.child('nodeKey').text().toString(),
							path:		referrer.child('nodeKeyVal').child('nodeKey').text().toString(),
							clicks:		parseInt(referrer.child('nodeKeyVal').child('nodeValue').text()[0])
						});
				}
			}
			
			return data;
		}
		
		private static function parseInfoData(results:XML):BitlyData
		{
			var data:InfoData;
			var users:XMLList;
			var user:XML;
			var userName:String;
			
			results 				= results.child('doc')[0];
			data					= new InfoData();
			data.hash				= results.child('hash').text()[0];
			data.userHash			= results.child('userHash').text()[0];
			data.globalHash			= results.child('globalHash').text()[0];
			data.keyword			= results.child('keyword').text()[0];
			data.longURL			= results.child('longUrl').text()[0];
			data.shortenedByUser	= results.child('shortenedByUser').text()[0];
			data.version			= results.child('version').text()[0];
			data.users				= [];
			
			//
			// parse users
			//			
			users = results.child('users').child('item');
			for each (user in users) 
			{
				userName = user.text()[0];
				data.users.push(userName);
			}
			
			//
			// TODO complete data parsing
			//
			
			return data;
		}

		private static function parseErrorsData(results:XML):BitlyData
		{
			return null;
		}

	}
}