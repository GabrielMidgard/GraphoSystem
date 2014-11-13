package mx.random.config{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.random.web.WebApplication;
	import mx.random.events.ConfigEvent;

	public class ConfigLoader extends EventDispatcher{
		
		protected var loader:URLLoader;
		
		
		public function ConfigLoader(xmlPath:String)	{
			super();
			
			var configPath:String = xmlPath + "?noCache="+new Date().getTime().toString();
			
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener( Event.COMPLETE, xmlLoadComplete );
			loader.load( new URLRequest( configPath ) );
			
		}
		
		protected function xmlLoadComplete(event:Event):void {
			loader.removeEventListener( Event.COMPLETE, xmlLoadComplete );
			var configXML:XML = new XML( loader.data );
			if (!configXML) {
				trace("No se pudo cargar la configuracion");
				return;
			}
			
			var webApplication:WebApplication = new WebApplication(configXML.webApplication);
			
			dispatchEvent(new ConfigEvent(ConfigEvent.CONFIG_COMPLETE, webApplication));
			
		}		
		
		
		
	}
}