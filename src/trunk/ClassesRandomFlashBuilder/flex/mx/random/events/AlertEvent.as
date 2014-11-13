package mx.random.events  {
	import flash.events.Event;
	
	public class AlertEvent extends Event{
		
		public static var ALERT_YES:String 		= "alert_yes";
		public static var ALERT_NO:String 		= "alert_no";	
		public static var ALERT_CANCEL:String 	= "alert_cancel";
		

		public function AlertEvent(type:String){
			super(type,true,true)
		}

	}
	
}
