package mx.random.arduino{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	
	import mx.random.events.ProxyServerEvent;

[Bindable] public class ProxyServer extends EventDispatcher{
		
		private var socket:Socket;
		public  var _connected:Boolean = false;
		public  var output:String = "";
		private var _buffer:String = "";
		private var EOF:String = "@";
		private var _host:String = "127.0.0.1";
		private var _port:Number = 5331;
		
			
		public function ProxyServer(){
			
		}

		private function connect():void{
			if(!_connected){
				socket = new Socket();
				socket.addEventListener(Event.CONNECT,socketConnected);
				socket.addEventListener(Event.CLOSE,socketDisconnected);
				socket.addEventListener(ProgressEvent.SOCKET_DATA,socketData);
				socket.connect(_host,_port);
				dispatchEvent(new ProxyServerEvent(ProxyServerEvent.SERVER_CONNECTED));
			}else{
				socket.close();
				socket.removeEventListener(Event.CONNECT,socketConnected);
				socket.removeEventListener(Event.CLOSE,socketDisconnected);
				socket.removeEventListener(ProgressEvent.SOCKET_DATA,socketData);
				_connected = false;
				dispatchEvent(new ProxyServerEvent(ProxyServerEvent.SERVER_DISCONNECTED));
			}
		}
		
		
		private function socketData(e:ProgressEvent):void{						
			var data:String = socket.readUTFBytes(socket.bytesAvailable);	
			_buffer += data;				
			if(_buffer.indexOf(EOF) != -1){	
				output = ""
				output += _buffer.slice(0,_buffer.length-1);
				_buffer = "";
				dispatchEvent(new ProxyServerEvent(ProxyServerEvent.SOCKET_RECEIVE_COMPLETE,output));
			}				
		}
		
		private function socketDisconnected(e:Event):void{
			socket.removeEventListener(Event.CONNECT,socketConnected);
			socket.removeEventListener(Event.CLOSE,socketDisconnected);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA,socketData);
			_connected = false;
			dispatchEvent(new ProxyServerEvent(ProxyServerEvent.SERVER_DISCONNECTED));
		}
		
		private function socketConnected(e:Event):void{
			_connected = true;	 			
		}
		
		public function sendByteData(data:Array):void{				
			for(var n:Number = 0;n<data.length;n++){
				socket.writeByte(data[n]);
			}
			socket.writeUTFBytes(EOF);
			socket.flush();			
		}
		
		public function sendStringData(data:String):void{							
			socket.writeUTFBytes(data+EOF);
			socket.flush();			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
}