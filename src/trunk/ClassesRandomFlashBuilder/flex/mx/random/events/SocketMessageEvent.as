package mx.random.events  {
	import flash.events.Event;
	
	import mx.random.sockets.SocketMessage;
	
	public class SocketMessageEvent extends Event{
		
		public static var SOCKET_CONNECTED:String 			= "socket_connected";	
		public static var SOCKET_USER_CONNECTED:String 		= "socket_user_connected";
		public static var SOCKET_USER_DISCONNECTED:String 	= "socket_user_disconnected";
		public static var SOCKET_USER_MESSAGE:String 		= "socket_user_message";	
		public static var SOCKET_DISCONNECTED:String 		= "socket_disconnected";
		public static var SOCKET_DATA_SYNC:String 			= "socket_data_sync";


		public var socketMessage:SocketMessage;	
		public var socketString:String;

		public function SocketMessageEvent(type:String,message:SocketMessage = null,msgString:String=""){
			socketMessage 	= message;
			socketString	= msgString;
			super(type,true,true)
		}

	}
	
}
