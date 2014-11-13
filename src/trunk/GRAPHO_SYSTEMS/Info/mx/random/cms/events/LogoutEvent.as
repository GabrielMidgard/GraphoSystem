package  mx.random.cms.events{
	
	import flash.events.Event;
	
	public class LogoutEvent extends Event{

		public static const LOGOUT_COMPLETE:String = "logoutComplete";
		
		function LogoutEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new LogoutEvent(type, bubbles, cancelable);
		}
		
	}
}

