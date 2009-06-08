package env.webapis.bitly
{
	import flash.events.Event;

	public class BitlyEvent 
	extends Event
	{
		public static const COMPLETE:String		= 'complete';
		public static const ERROR:String		= 'error';
		
		private var _data:BitlyData;
		private var _success:Boolean;
		private var _fault:BitlyFault;
		private var _response:String;
		
		// ---------------------------------------------------------
		//	interface : methods
		// ---------------------------------------------------------
		
		public function BitlyEvent(type:String, success:Boolean, response:String, data:BitlyData, fault:BitlyFault = null)
		{
			super(type);
			
			_success 	= success;
			_data		= data;
			_fault		= fault;
		}
		
		override public function toString():String 
		{
			return '[BitlyEvent' +
				' success="' + success + '"' +
				' data="' + data + '"' +
				' fault="' + fault + '"]';
		}
		
		override public function clone():Event
		{
			return new BitlyEvent(type, success, response, data, fault);
		}
		
		// ---------------------------------------------------------
		//	interface : properties
		// ---------------------------------------------------------
		
		public function get success():Boolean
		{
			return _success;
		}
		
		public function get data():BitlyData
		{
			return _data;
		}
		
		public function get fault():BitlyFault
		{
			return _fault;
		}
		
		public function get response():String 
		{
			return _response;
		}
	}
}