package mx.random.events  {
	import flash.events.Event;
	
	public class ProxyServerEvent extends Event{
		
		public static var SOCKET_SENT_COMPLETE:String 			= "socket_sent_complete";	
		public static var SOCKET_RECEIVE_COMPLETE:String 		= "socket_receive_sent";
		public static var SERVER_CONNECTED:String 				= "server_connected";
		public static var SERVER_DISCONNECTED:String 			= "server_disconnected";
		
		public var _socketData:Object;

		public function ProxyServerEvent(type:String,data:Object = null){
			_socketData = data;
			super(type,true,true);
		} 

	}
	
}
