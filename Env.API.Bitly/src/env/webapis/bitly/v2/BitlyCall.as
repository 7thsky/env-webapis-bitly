package env.webapis.bitly.v2
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	[Event(type="env.webapis.bitly.v2.BitlyEvent", name="complete")]
	[Event(type="env.webapis.bitly.v2.BitlyEvent", name="error")]
	
	public class BitlyCall
	extends EventDispatcher
	{
		private var _api:BitlyAPI;
		private var _parameters:URLVariables;
		private var _method:String;
		private var _result:BitlyData;
		private var _fault:BitlyFault;
		private var _success:Boolean;
		
		private var started:Boolean;
		private var completed:Boolean;
		private var loader:URLLoader;
		
		// -------------------------------------------------------
		//	interface : methods
		// -------------------------------------------------------
		
		public function BitlyCall(api:BitlyAPI, method:String)
		{
			_api 		= api;
			_method 	= method;
			_parameters = new URLVariables();
		}
		
		public function execute(params:Object = null):void 
		{
			var pName:String;
			var request:URLRequest;
			var e:Error;
			
			// parse additional params
			if (params) 
			{
				for (pName in params)
				{
					setParameter(pName, params[pName]);
				}
			}
			
			// build request
			request = buildBaseRequest();
			
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
			
			try 
			{
				loader.load(request);
			}
			catch(e:Error)
			{
				// TODO
				processResult(null, null, new BitlyFault());
			}
		}
		
		public function cancel():void 
		{
		}
		
		public function setParameter(key:String, value:*):void 
		{
			if (key) 
			{
				_parameters[key] = value;
			}
		}
		
		public function getParameter(key:String):*
		{
			return _parameters[key];
		}
				
		// -------------------------------------------------------
		//	interface : properties
		// -------------------------------------------------------
		
		public function get api():BitlyAPI
		{
			return _api;
		}
		
		public function get parameters():Object 
		{
			return _parameters;
		}
		
		public function get method():String
		{
			return _method;
		}
		
		[Bindable(event="result")]
		public function get result():BitlyData
		{
			return _result;
		}
		
		[Bindable(event="fault")]		
		public function get fault():BitlyFault
		{
			return _fault;
		}
		
		[Bindable(event="error")]
		[Bindable(event="complete")]
		public function get success():Boolean
		{
			return _success;
		}
		
		// -------------------------------------------------------
		//	private methods
		// -------------------------------------------------------
		
		private function buildBaseRequest():URLRequest 
		{
			var request:URLRequest;
			var vars:URLVariables;
			
			vars 							= _parameters;
			vars[BitlyParameter.API_KEY] 	= api.apiKey;
			vars[BitlyParameter.LOGIN]		= api.login;
			vars[BitlyParameter.VERSION]	= api.version;
			vars[BitlyParameter.FORMAT]		= api.format;
						
			request 		= new URLRequest();
			request.url		= api.baseURL + method;
			request.data	= vars;
			request.method	= URLRequestMethod.POST;
			
			return request;
		}
		
		private function processResult(response:String, data:BitlyData, fault:BitlyFault):void
		{
			
			completed = true;
			
			if (fault) 
			{
				_success = false;
				_fault = fault;
				_result = null;
				
				dispatchEvent(
					new BitlyEvent(
						BitlyEvent.ERROR, 
						false, 
						response,
						null, 
						fault));
			} 
			else 
			{
				_success = true;
				_fault = null;
				_result = data;

				dispatchEvent(
					new BitlyEvent(
						BitlyEvent.COMPLETE,
						true,
						response,
						data,
						null));
			}
		}
		
		private function uninstallListeners():void 
		{
			loader.removeEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderSecurityErrorHandler);
		}
		
		// -------------------------------------------------------
		//	event handler
		// -------------------------------------------------------
		
		private function loaderCompleteHandler(evt:Event):void 
		{
			var response:XML;
			var e:Error;
			var fault:BitlyFault;
			var data:BitlyData;
			var rawResponse:String;
			
			uninstallListeners();
			rawResponse = loader.data;
			
			try 
			{
				response = new XML(rawResponse);
			}
			catch(e:Error)
			{
				// TODO
				// fake fault message
			}
			
			try
			{
				fault 	= BitlyDataParser.parseFault(response);
				data 	= BitlyDataParser.parseData(response, method);
			}
			catch(e:Error)
			{
				// TODO
				// fake fault message
			}
			
			processResult(rawResponse, data, fault);
		}
		
		private function loaderIOErrorHandler(evt:IOErrorEvent):void 
		{
			uninstallListeners();
			processResult(null, null, new BitlyFault());
		}
		
		private function loaderSecurityErrorHandler(evt:SecurityErrorEvent):void 
		{
			uninstallListeners();
			processResult(null, null, new BitlyFault());
		}

	}
}