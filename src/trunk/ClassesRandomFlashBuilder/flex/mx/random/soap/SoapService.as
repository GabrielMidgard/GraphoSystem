package mx.random.soap
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.random.constants.SystemGlobals;
	import mx.random.converters.Converter;
	import mx.random.web.WebApplication;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public dynamic class SoapService extends EventDispatcher{
		
		public var _methodName:String;
		private var _service:HTTPService;
		
		public function SoapService(url:String,method:String,methodName:String){
			_methodName 				= methodName;
			
			_service					= new HTTPService();
			_service.url 				= url;
			_service.method 			= method;
			_service.addEventListener(ResultEvent.RESULT,onResult);
			_service.addEventListener(FaultEvent.FAULT,onFault);
			SoapService.prototype[_methodName] = function(JSONParams:Object='',returnType:Number=0):void{
				var params:Object = new Object();
				params.method		= _methodName;
				if(JSONParams!=''){
					params.JSONParams 	= JSON.stringify(JSONParams);		
				}
				params.returnType 	= returnType;
				_service.send(params);
			}
		}
		
		public function call(JSONParams:Object='',returnType:Number=0):void{
			var params:Object = new Object();
			params.method		= _methodName;
			params.token 		= SystemGlobals.token;
			if(JSONParams!=''){
				params.JSONParams 	= JSON.stringify(JSONParams);		
			}
			params.returnType 	= returnType;
			_service.send(params);
		}
		
		private function onResult(e:ResultEvent):void{
			var resultObject:Object = JSON.parse(e.result.toString());
			//var result:ArrayCollection = Converter.arrayConverter(resultObject.result);
			if(resultObject){
				if(!resultObject.faultcode){
					dispatchEvent(new ResultEvent(ResultEvent.RESULT,false,true,resultObject.result));
				}else{
					var fault:Fault = new Fault('0001',resultObject.faultcode)
					dispatchEvent(new FaultEvent(FaultEvent.FAULT,false,true,fault));
				}
			}else{
				dispatchEvent(new ResultEvent(ResultEvent.RESULT,false,true,false));
			}
		}
		
		private function onFault(e:FaultEvent):void{
			dispatchEvent(e);
		}
		
		
	}
}