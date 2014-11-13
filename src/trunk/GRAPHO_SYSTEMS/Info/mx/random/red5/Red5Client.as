package mx.random.red5
{

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.SyncEvent;
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import flash.net.SharedObject;
    
    import mx.controls.Alert;

	[Bindable]
    public class Red5Client extends EventDispatcher
    {

        public var connected:Boolean = false;
        private var nc:NetConnection = null;
        public var so:SharedObject = null;
        public var appName:String = "defApp";
		
		
        public function Red5Client(){
            
        }
        
        public function connect(connUrl:String = "rtmp://random.mx/oflaDemo"):void{
        	if(!nc){
                nc = new NetConnection();
				nc.objectEncoding = ObjectEncoding.AMF0;
                nc.addEventListener(NetStatusEvent.NET_STATUS,onConnectHandler);
                nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onConnectErrorHandler);
                nc.client = this;
                nc.connect(connUrl);               
            }
        }
        
        private function onConnectErrorHandler(event:SecurityErrorEvent):void {
            Alert.show(event.text,"Error on Connect");
        }
        
        private function onDataUpdate(event:SyncEvent):void {
        	dispatchEvent(new Event("DataSync",true,true));
        }
        
        public function sendData(data:*):void{
        	so.setProperty(appName,data);
        }
        
        private function onConnectHandler(event:Event):void {
            connected = nc.connected;            
            so = SharedObject.getRemote(appName,nc.uri, false);
            so.addEventListener(SyncEvent.SYNC,onDataUpdate);
            so.connect(nc);
            dispatchEvent(new Event("Connected",true,true));
        }
        
        public function onBWDone():void{
			// have to have this for an RTMP connection
		}

        
    }

}