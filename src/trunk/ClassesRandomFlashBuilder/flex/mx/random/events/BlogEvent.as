package mx.random.events  {
	import flash.events.Event;
	
	public class BlogEvent extends Event{
		
		public static var SEND_MESSAGE_COMPLETE:String = "send_message_complete";
		public static var SEND_MESSAGE_CANCELED:String = "send_message_canceled";	

		public function BlogEvent(type:String){
			super(type,true,true)
		}

	}
	
}
