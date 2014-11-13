package mx.random.events  {
	import flash.events.Event;
	
	public class PaymentEvent extends Event{
		
		public static var PAYMETN_COMPLETE:String 	= "payment_complete";	
		public static var PAYMETN_ERROR:String 		= "payment_error";	
		public static var PAYMETN_REFERRED:String 	= "payment_referred";		
		
		public function PaymentEvent(type:String){
			super(type,true,true)
		}
		
	}
	
}
