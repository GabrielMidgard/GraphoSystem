package mx.random.red5
{

    import com.adobe.crypto.MD5;    
    import flash.events.NetStatusEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.SyncEvent;
    import flash.net.NetConnection;
    import flash.net.ObjectEncoding;
    import flash.net.SharedObject;
    
    import mx.controls.Alert;
    import mx.random.web.WebApplication;
    import mx.random.events.Red5Event;
    import mx.random.events.StaticEvent;

	[Bindable]
    public class Red5Client
    {

       

        public var connected:Boolean 		= false;
        private var nc:NetConnection 		= null;
        private var so_data:SharedObject 	= null;
        private var so_user:SharedObject 	= null;
        private var appName:String 			= "";
		public var  output:String 			= "";
		public var  userList:Array 			= new Array();
		public var  user:String 			= new String();
		public var  userId:Number 			= 0;
		public var  userToken:String 		= "";
		public var 	red5Status:String		= "";
		private var logged:Boolean 			= false;
		private var logOutUser:Boolean 		= false;		
		private var _connUrl:String			= "";
		
        public function Red5Client(AppName:String,rtmp:String,WebApp:WebApplication){
            appName 	= AppName;
            _connUrl 	= rtmp;
            user 		= WebApp.user.firstName+" "+WebApp.user.lastName_1; 
            userId 		= WebApp.user.userId;
            StaticEvent.addEventListener(Red5Event.RED5_USER_RECORD_UPDATE,userDataChange);  
            StaticEvent.addEventListener(Red5Event.RED5_USER_RECORD_DELETE,userDataChange);
            StaticEvent.addEventListener(Red5Event.RED5_USER_CATALOG_DELETE,userDataChange);  
            StaticEvent.addEventListener(Red5Event.RED5_USER_CATALOG_UPDATE,userDataChange);
            StaticEvent.addEventListener(Red5Event.RED5_USER_DATA_SYNC,userDataChange);           
        }
        
       public function connect():void{        	
        	so_data 	= null;
        	so_user 	= null;
    		userToken 	= MD5.hash(Math.random().toString());        		
    		red5Status = "Connecting...";
            nc = new NetConnection();
			nc.objectEncoding = ObjectEncoding.AMF0;
            nc.addEventListener(NetStatusEvent.NET_STATUS,onConnectHandler);
            nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onConnectErrorHandler);
            nc.client = this;
            nc.connect(_connUrl);                                     				
           
            logOutUser = false;
        }
        
        public function disconnect():void{        	
        	logOut();  	
        }
        
        private function onConnectHandler(event:Event):void {
        	connected = nc.connected;         	
        	if(nc.connected){	                       
	            so_data = SharedObject.getRemote(appName,nc.uri, false);
	            so_user = SharedObject.getRemote("Users",nc.uri, false);            
	            so_data.addEventListener(SyncEvent.SYNC,onDataUpdate);                        
	            so_user.addEventListener(SyncEvent.SYNC,onUsersUpdate);	            
	            so_data.connect(nc);
	            so_user.connect(nc);
	            red5Status = "On Line";
        	}else{
	        	so_data.removeEventListener(SyncEvent.SYNC,onDataUpdate);                        
	            so_user.removeEventListener(SyncEvent.SYNC,onUsersUpdate);
	            red5Status = "Disconnected";
        	}
        }
        
       
        public function onBWDone():void{
			
		}
		
		
		
		public function userDataChange(e:Red5Event):void{			
            so_data.setProperty(appName,e.red5Message);                  
		}
		
		
		public function sendRed5Message(msj:Red5Message):void {
            so_data.setProperty(appName,msj);
        }
        
        public function sendTextMessage(msj:String,destinationUsers:Array):void {
        	var destinationUsersList:Array = null;
        	if(destinationUsers.length!=0){
        		destinationUsersList = destinationUsers;
        	}
        	var r5msg:Red5Message = new Red5Message(user,userId,userToken,Red5Event.RED5_USER_MESSAGE,msj,destinationUsersList);
            so_data.setProperty(appName,r5msg);
        }
        
        
        
        public function clearUsers():void{
        	so_user.setProperty("Users",new Array());
        }
        
        
        private function onDataUpdate(e:SyncEvent):void {            
            if(so_data.data[appName] != undefined) { 
            	var msgObj:Object = so_data.data[appName];
            	var msj:Red5Message =  new Red5Message(msgObj['userName'],
            										   msgObj['userId'],
            										   msgObj['userToken'],
            										   msgObj['msgType'],
            										   msgObj['message'],
            										   msgObj['destinationUsers']); 
            	if(msj.msgType==Red5Event.RED5_USER_MESSAGE){              		
            		if(msgObj['destinationUsers']!=null){
            			if(findToken(msgObj['destinationUsers'] as Array)||msgObj['userToken']==userToken){  
            				StaticEvent.dispatchEvent(new Red5Event(Red5Event.RED5_USER_MESSAGE,msj));
            			}
            		}else{
            			StaticEvent.dispatchEvent(new Red5Event(Red5Event.RED5_USER_MESSAGE,msj));
            		}
            	}else{            		            			 	         	            
                	StaticEvent.dispatchEvent(new Red5Event(Red5Event.RED5_DATA_SYNC,msj));
	             }
            }
        }
        
        private function findToken(users:Array):Boolean{
        	var res:Boolean = false;
        	for(var n:Number=0;n<users.length;n++){
        		if(users[n].userToken==userToken){
        			res = true;
        			break;
        		}
        	}
        	return res;
        }
        
        private function onUsersUpdate(e:SyncEvent):void{
        	userList = new Array();
        	var tempUserList:Array = so_user.data["Users"] as Array;
        	var n:Number = 0;
        	if(logged){
	        	for(n=0;n<tempUserList.length;n++){
	        	 	userList.push({userName:tempUserList[n].userName,userId:tempUserList[n].userId,userToken:tempUserList[n].userToken});
	        	 }	        	
	        }else{
	        	if(so_user.data["Users"] != undefined) {		        	 
		        	 for(n=0;n<tempUserList.length;n++){
		        	 	userList.push({userName:tempUserList[n].userName,userId:tempUserList[n].userId,userToken:tempUserList[n].userToken});
		        	 }
	        	}
	        	userList.push({userName:user,userId:userId,userToken:userToken});	
	        	so_user.setProperty("Users",userList);
          		logged = true;	        	
	        }
	        if(logOutUser){
	        	nc.close();
	        	userList= new Array();
	        	logged = false;
	        }
        } 
        
        
        public function logOut():void{ 
        	var tempUserList:Array = new Array();
        	for(var n:Number = 0;n<userList.length;n++){
        		if(userList[n].userToken!=userToken){
        			tempUserList.push(userList[n]);
        		}
        	}
        	so_user.setProperty("Users",tempUserList); 
        	logOutUser = true;         	       	   	        		     
        }
        
        
        private function onConnectErrorHandler(e:SecurityErrorEvent):void {
            Alert.show(e.text,"Error on Connect");
        }  

    }

}