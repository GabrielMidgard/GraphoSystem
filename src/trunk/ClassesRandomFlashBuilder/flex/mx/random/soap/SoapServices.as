package mx.random.soap
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.random.converters.Converter;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	public dynamic class SoapServices {
		
		private var _url:String;
		private var _method:String;
		private var _className:String;
		
		public function SoapServices(url:String,method:String,className:String,methods:Array){
			_url 		= url;
			_method		= method;
			_className 	= className;
			for(var n:Number = 0;n<methods.length;n++){
				createMethod(methods[n]);
			}
		}
		
		
		private function createMethod(methodName:String):void{
			SoapService[methodName] =  new SoapService(_url,_method,_className+'.'+methodName);
			
		}
		
		
		
		
	}
}