package mx.random.events{
	import flash.events.Event;

	public class WebApplicationEvent extends Event{
		
		public static var WEB_APPLICATION_READY:String = "web_application_ready";
		public static var MOBILE_WEB_APPLICATION_READY:String = "mobile_web_application_ready";
		
		public function WebApplicationEvent(type:String){
			super(type,true,true)
		}
	}
}