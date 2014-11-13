package mx.random.events  {
	import flash.events.Event;
	
	public class ClientEvent extends Event{		
		public static var CLIENT_PAYMENTS_COMPLETE:String = "client_payments_complete";
		public static var CLIENT_CREATION_COMPLETE:String = "client_creation_complete";	

		public function ClientEvent(type:String){
			super(type,true,true)
		}

	}
	
}