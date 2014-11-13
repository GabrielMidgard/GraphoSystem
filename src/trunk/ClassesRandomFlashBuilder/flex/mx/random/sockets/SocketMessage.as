package mx.random.sockets{
	import flash.utils.ByteArray;
	
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;

	public class SocketMessage	{
				
		public var clientIP:String 			= new String();
		public var serverIP:String 			= new String();
		public var messageData:String		= new String();
		public var destination:String		= new String();
		public var subject:String			= new String();
		public var dateTime:String			= new String();
		
		public static var FOR_ALL_USERS:String 		= "for_all_users";
		public static var FOR_SINGLE_USER:String 	= "for_single_user";
		public static var PRIORITY_HIGH:String 		= "proirity_high";
		public static var PRIORITY_MEDIUM:String 	= "proirity_medium";
		public static var PRIORITY_LOW:String 		= "proirity_low";
		
		public static var USER_CONNECTED:String 						= "user_connected";
		public static var USER_DISCONNECTED:String 						= "user_disconnected";
		public static var REQUEST_CONNECTED_USERS:String 				= "request_connected_users";
		public static var REQUEST_CONNECTED_USERS_RESPONSE:String 		= "request_connected_users_response";
		public static var REQUEST_SERVER_STATUS:String 					= "request_server_status";
		public static var REGULAR_MESSAGE:String 						= "regular_message";
		public static var REQUEST_REMOTE_IP:String 						= "request_remote_ip";
		public static var REQUEST_REMOTE_IP_RESPONSE:String 			= "request_remote_ip_response";
		public static var SERVER_RESPONSE:String 						= "server_response";
		
		public function SocketMessage(data:XML)	{			
			clientIP 	= data[0].clientIP;
			serverIP 	= data[0].serverIP;
			messageData = data[0].data;
			destination = data[0].destination;
			subject 	= data[0].subject;
			dateTime	= data[0].dateTime;
		}
		
		
		public static function encodeMessage(data:String,destination:String,client:String,subject:String=""):String{
			var message:String = new String();
			var encoder:Base64Encoder = new Base64Encoder(); 
			encoder.encode(data);
			var encodedData:String = encoder.toString();
			if(subject=="") subject = SocketMessage.REGULAR_MESSAGE;			
			message = "<socket>" +
							"<dateTime>"+new Date().toString()+"</dateTime>" +
							"<serverIP>"+destination+"</serverIP>" +
							"<clientIP>"+client+"</clientIP>" +
							"<userName>"+client+"</userName>" +
							"<priority>"+SocketMessage.PRIORITY_HIGH+"</priority>" +
							"<subject>"+subject+"</subject>" +
							"<destination>"+destination+"</destination>" +
							"<data>"+encodedData+"</data>" +
					  "</socket>";
			
			var xml:XML = new XML(message);
			return xml.toString();
		}
		
		public static function decodeMessage(data:String):String{
			var decoder:Base64Decoder = new Base64Decoder();
			decoder.decode(data[0].data);
			var result:ByteArray = decoder.toByteArray();			
			return result.toString();			
		}
		
		public function getData():String{
			return decodeData(messageData);
		}
		
		private function decodeData(data:String):String{
			var decoder:Base64Decoder = new Base64Decoder();
			decoder.decode(data);
			var result:ByteArray = decoder.toByteArray();			
			return result.toString();			
		}
		
		
	}
}