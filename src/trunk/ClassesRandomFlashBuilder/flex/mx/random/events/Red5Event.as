package mx.random.events  {
	import flash.events.Event;
	
	import mx.random.red5.Red5Message;
	
	public class Red5Event extends Event{
		
		public static var RED5_CONNECTED:String 			= "red5_connected";	
		public static var RED5_USER_LOGIN:String 			= "red5_user_login";
		public static var RED5_USER_LOGOUT:String 			= "red5_user_logout";
		public static var RED5_USER_MESSAGE:String 			= "red5_user_message";	
		public static var RED5_USER_RECORD_UPDATE:String 	= "red5_user_record_update";
		public static var RED5_USER_RECORD_DELETE:String 	= "red5_user_record_delete";
		public static var RED5_USER_CATALOG_UPDATE:String 	= "red5_user_catalog_update";
		public static var RED5_USER_CATALOG_DELETE:String 	= "red5_user_catalog_delete";
		public static var RED5_DISCONNECTED:String 			= "red5_disconnected";
		public static var RED5_DATA_SYNC:String 			= "red5_data_sync";
		public static var RED5_USER_DATA_SYNC:String 		= "red5_user_data_sync";

		public var red5Message:Red5Message;	

		public function Red5Event(type:String,message:Red5Message = null){
			red5Message 	= message;
			super(type,true,true)
		}

	}
	
}
