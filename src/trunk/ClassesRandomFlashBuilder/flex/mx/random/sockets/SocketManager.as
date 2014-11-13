package mx.random.sockets{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.random.converters.Converter;
	import mx.random.constants.SystemGlobals;
	import mx.random.events.SocketMessageEvent;
	import mx.rpc.xml.SimpleXMLDecoder;
	
	
	[Bindable]
	public class SocketManager	extends EventDispatcher{
		
		public var connected:Boolean = false;
		public var connectedUsers:ArrayCollection = new ArrayCollection();
		private var socket:Socket;
		public var clientIP:String = "0.0.0.0";
				
		public function SocketManager(){				
							
		}
		
		public function connect():void{
			socket = new Socket();	
			socket.addEventListener(IOErrorEvent.IO_ERROR,connectionError)		
			socket.addEventListener(Event.CONNECT,socketConnected);
			socket.addEventListener(Event.CLOSE,socketDisconnected);
			socket.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
			socket.connect(SystemGlobals.SOCKET_SERVER_IP,SystemGlobals.SOCKET_SERVER_PORT);
			addEventListener(SocketMessageEvent.SOCKET_USER_CONNECTED,updateUsers);	
			addEventListener(SocketMessageEvent.SOCKET_USER_DISCONNECTED,updateUsers);	
		}
		
		private function connectionError(e:IOErrorEvent):void{
			SystemGlobals.serverStatus = "Not Connected";
		}
		
		private function updateUsers(e:SocketMessageEvent):void{
			switch(e.type){
				case SocketMessageEvent.SOCKET_USER_DISCONNECTED:
					requestUserList();
					break;
				case SocketMessageEvent.SOCKET_USER_CONNECTED:
					requestUserList();
					break;
			}
		}
		
		private function findUserIndex(clientIP:String):Number{
			var res:Number = -1;
			for(var n:Number = 0;n<connectedUsers.length;n++){
				if(connectedUsers[n].clientIP==clientIP) break;
			}
			return res;
		}
		
		private function socketDisconnected(e:Event):void{			
			socket.removeEventListener(Event.CONNECT,socketConnected);
			socket.removeEventListener(Event.CLOSE,socketDisconnected);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA,socketData);
			dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_CONNECTED));
			connected = false;
		}
		
		private function socketConnected(e:Event):void{
			dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_DISCONNECTED));
			writeMessageToSockets(getUserInfo(),"0.0.0.0",SocketMessage.REQUEST_REMOTE_IP);			
			connected = true;
			SystemGlobals.serverStatus = "Getting IP Address...";			
		}
		
		private function getUserInfo():String{
			return "<user>" + 
						"<userName>" +SystemGlobals.userName+ "</userName>"+
						"<userId>" +SystemGlobals.userId+ "</userId>"+
						"<userLevel>" +SystemGlobals.userLevel+ "</userLevel>"+
					"</user>";
		}
		
		public function disconnect():void{
			socket.close();
		}
		
		private function socketData(e:ProgressEvent):void{													
			var sckMsg:String = socket.readUTFBytes(socket.bytesAvailable);	
			sckMsg = Converter.tagExtract("socket",sckMsg); 			
			var socketMessage:SocketMessage = new SocketMessage(new XML(sckMsg));
			switch(socketMessage.subject){
				case SocketMessage.REGULAR_MESSAGE:
					dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_USER_MESSAGE,socketMessage));	
					break;
				case SocketMessage.SERVER_RESPONSE:
					dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_DATA_SYNC,socketMessage));	
					break;
				case SocketMessage.USER_CONNECTED:
					dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_USER_CONNECTED,socketMessage));	
					break;
				case SocketMessage.USER_DISCONNECTED:
					dispatchEvent(new SocketMessageEvent(SocketMessageEvent.SOCKET_USER_DISCONNECTED,socketMessage));	
					break;
				case SocketMessage.REQUEST_REMOTE_IP_RESPONSE:
					clientIP = socketMessage.getData();
					SystemGlobals.serverStatus = clientIP;
					break;
				case SocketMessage.REQUEST_CONNECTED_USERS_RESPONSE:
					connectedUsers = updateUserList(socketMessage.getData());
					break;
			}
											
		}
		
		
		public function requestUserList():void{
			writeMessageToSockets(getUserInfo(),"0.0.0.0",SocketMessage.REQUEST_CONNECTED_USERS);	
		}
		
			
		private function updateUserList(data:String):ArrayCollection{			
            var xmlDoc:XMLDocument = new XMLDocument(Converter.tagExtract("users",data));
            var decoder:SimpleXMLDecoder = new SimpleXMLDecoder(true);
            var resultObj:Object = decoder.decodeXML(xmlDoc);
            var res:ArrayCollection = new ArrayCollection();
            if(resultObj){
	            if(resultObj.users.user.length){
	            	res = Converter.arrayConverter(resultObj.users.user);
	            }else{            	
	            	var userData:Object = {	userId:resultObj.users.user.userId,
											userName:resultObj.users.user.userName,
											userLevel:resultObj.users.user.userLevel} ;
	            	res.addItem(userData);
	            }
	        }
            
            return res;

		}
		
		private function writeMessageToSockets(data:String,destination:String,subject:String=""):void{			
			var xmlData:String;
			xmlData = SocketMessage.encodeMessage(data,destination,clientIP,subject);
			socket.writeUTF(xmlData);
			socket.flush();
		}
		
		public static function get localAddresses():Array
        {
        	
            var addresses:Array = [];
            return addresses;
        }

	}
}