package mx.random.cms.events{
	
	import flash.events.Event;
	
	import mx.random.cms.web.WebApplication;
	
	public class ConfigEvent extends Event{

		public static const CONFIG_COMPLETE:String = "configComplete";
		
		public var webApplication:WebApplication;
		
		function ConfigEvent(type:String, webApplication:WebApplication, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.webApplication = webApplication;
		}
		
		override public function clone():Event {
			return new ConfigEvent(type, webApplication, bubbles, cancelable);
		}
		
	}
}

