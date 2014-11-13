package mx.random.cms.events {
	
	import flash.events.Event;
	
	public class LoginEvent extends Event{

		public static const LOGIN_COMPLETE:String = "loginComplete";
		
		public var state:String;
		public var stateParams:Object
		
		function LoginEvent(type:String, state:String, stateParams:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.state = state;
			this.stateParams = stateParams;
		}
		
		override public function clone():Event {
			return new LoginEvent(type, state, stateParams, bubbles, cancelable);
		}
		
	}
}

