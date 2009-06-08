package env.webapis.bitly
{
	public class BitlyAPI
	{
		public static const VERSION:String			= '2.0.1';
		public static const DEFAULT_BASE_URL:String	= 'http://api.bit.ly/';
		
		private var _apiKey:String;
		private var _login:String;
		private var _format:String;
		private var _baseURL:String;
		
		// ---------------------------------------------------------
		//	interface : methods
		// ---------------------------------------------------------
		
		public function BitlyAPI(login:String, apiKey:String, baseURL:String = null)
		{
			_apiKey 	= apiKey;
			_login 		= login;
			_format		= BitlyFormat.XML;
			_baseURL	= baseURL ? baseURL : DEFAULT_BASE_URL;			
		}
		
		/**
		 * Given a long url, returns a shorter one
		 * 
		 * @param longURL		:	String
		 * @param keyword		:	String
		 * 
		 * @return <code>BitlyCall</code>
		 */		
		public function shorten(longURL:String, keyword:String = null):BitlyCall
		{
			var call:BitlyCall;
			
			if (longURL) 
			{
				call = new BitlyCall(this, BitlyMethod.SHORTEN);
				call.setParameter(BitlyParameter.LONG_URL, longURL);
				
				if (keyword) 
				{
					call.setParameter(BitlyParameter.KEYWORD, keyword);
				}
				
				call.execute();
			}			
			
			return call;
		}
		
		/**
		 * Given a bit.ly url or hash, return long source url
		 * 
		 * @param shortURL		:	String
		 * 
		 * @return <code>BitlyCall</code>
		 */		
		public function expand(shortURL:String):BitlyCall 
		{
			var call:BitlyCall;
			
			if (shortURL) 
			{
				call = new BitlyCall(this, BitlyMethod.EXPAND);
				call.setParameter(BitlyParameter.SHORT_URL, shortURL);
				call.execute();
			}			
			
			return call;
		}
		
		/**
		 * Given a bit.ly url or hash, return traffic and referrer data
		 * 
		 * @param longURLOrHash		:	String
		 * 
		 * @return <code>BitlyCall</code> 
		 */		
		public function stats(longURLOrHash:String):BitlyCall 
		{
			var call:BitlyCall;
			
			if (longURLOrHash) 
			{
				call = new BitlyCall(this, BitlyMethod.STATS);
				call.setParameter(
					longURLOrHash.indexOf('http://') == 0 ? 
						BitlyParameter.LONG_URL : BitlyParameter.HASH, 
					longURLOrHash);
				call.execute();
			}			
			
			return call;
		}
		
		/**
		 * Given a bit.ly url or hash, return information about that page, such as the long source url
		 * 
		 * @param longURLOrHash		:	String
		 * 
		 * @return <code>BitlyCall</code> 
		 */		
		public function info(longURLOrHash:String):BitlyCall
		{
			var call:BitlyCall;
			
			if (longURLOrHash) 
			{
				call = new BitlyCall(this, BitlyMethod.INFO);
				call.setParameter(
					longURLOrHash.indexOf('http://') == 0 ? 
						BitlyParameter.LONG_URL : BitlyParameter.HASH, 
					longURLOrHash);
				call.execute();
			}			
			
			return call;
		}
		
		/**
		 * Get a list of bit.ly API error codes.
		 * 
		 * @return <code>BitlyCall</code> 
		 */		
		public function errors():BitlyCall 
		{
			var call:BitlyCall;
			
			call = new BitlyCall(this, BitlyMethod.ERRORS);
			call.execute();

			return call;
		}
		
		public function dispose():void 
		{
		}
		
		// ---------------------------------------------------------
		//	interface : properties
		// ---------------------------------------------------------
		
		public function get apiKey():String
		{
			return _apiKey;
		}
		
		public function get login():String 
		{
			return _login;
		}
		
		public function get version():String
		{
			return VERSION;
		}
		
		public function get format():String 
		{
			return _format; 
		}
		
		public function get baseURL():String 
		{
			return _baseURL;
		}
		
		
	}
}