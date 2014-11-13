package mx.random.web
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import mx.random.events.WebApplicationEvent;

	public class MobileWebApplication extends EventDispatcher{
		
		public static var webApplication:WebApplication;
		public static var WAReady:Boolean = false;
		private var _loader:URLLoader = new URLLoader();
		
		public function MobileWebApplication(){
			_loader.dataFormat = URLLoaderDataFormat.TEXT;
			_loader.addEventListener(Event.COMPLETE, handleComplete );
			_loader.load( new URLRequest( "config/config.xml" ) );
		}
		
		private function handleComplete(e:Event):void{
			var configData:XML = new XML( e.target.data );			
			webApplication = new WebApplication(configData.webApplication);	
			dispatchEvent(new WebApplicationEvent(WebApplicationEvent.MOBILE_WEB_APPLICATION_READY));
			WAReady = true
		}

	}
}