package mx.random.events{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class StaticEvent{	
		protected static var dispatcher:EventDispatcher;

		public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
			if (dispatcher == null) { dispatcher = new EventDispatcher(); }
			dispatcher.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
		}
		public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
			if (dispatcher == null) { return; }
			dispatcher.removeEventListener(p_type, p_listener, p_useCapture);
		}
		public static function dispatchEvent(p_event:Event):void {
			if (dispatcher == null) { return; }
			dispatcher.dispatchEvent(p_event);
		}

	}
	
}