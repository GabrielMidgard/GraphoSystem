package mx.random.web{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.channels.SecureAMFChannel;
	import mx.random.files.PathData;
	import mx.random.users.UserData;
	import mx.random.events.LogoutEvent;
	import mx.random.events.WebApplicationEvent;
	import mx.random.userAuth.User;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class WebApplication extends EventDispatcher {
		
		private var _configXML:XMLList;
		private var _protocol:String;
		private var _uploadProtocol:String;
		private var _uploadPort:String;
		private var _auth:RemoteObject;
		private var _user:User;
		private var _ticketProcess:RemoteObject;

		private var _services:Object = {};
		private var _servicesB:Object = {};
		private var _userName:String = "";
		private var _password:String = "";
		private var _hostName:String;
		private var _ticket:String;

		private var _loginType:String;
		private var _channelId:String;
		private var _destination:String;
		
		
		private var _amfChannel:AMFChannel;
		private var _amfChannelSet:ChannelSet;
		private var _amfChannelB:AMFChannel;
		private var _amfChannelBSet:ChannelSet;
		
		
		

		[Event(name="logoutComplete", type="com.latranquil.events.LogoutEvent")]
		public function WebApplication(configXML:XMLList) {
			super();

			_configXML = configXML;
			_hostName = _configXML.webHost.@name;
			
			_channelId = _configXML.@channelId.toString();
			_destination = _configXML.@destination.toString()
			
			var version:String = Capabilities.version;
			if(true) {
				_protocol = "http";
				_uploadProtocol = "http";
				_uploadPort = "80";				
			} else if  ( version.indexOf("WIN") != -1 || version.indexOf("MAC") != -1 ) {
				_protocol = "https";
				_uploadProtocol = "https";
				_uploadPort = "443";
			} else {
				_protocol = "https";
				_uploadProtocol = "http";
				_uploadPort = "80";
			}
			
			
			if(_protocol == "http") {
				_amfChannel 	= new AMFChannel(_channelId, _configXML.@gateway); 
				_amfChannelB	= new AMFChannel(_channelId, _configXML.@secondaryGateway);
			} else {
				_amfChannel 	= new SecureAMFChannel(_channelId, _configXML.@securegateway);
				_amfChannelB	= new SecureAMFChannel(_channelId, _configXML.@secondarySecureGateway);
			}
			
			_amfChannelSet = new ChannelSet();
			_amfChannelSet.addChannel(_amfChannel);
			
			_amfChannelBSet = new ChannelSet();
			_amfChannelBSet.addChannel(_amfChannelB);
			
			_auth = getService("userAuth");
			if(_auth){
				_auth.silentLogout.addEventListener(mx.rpc.events.FaultEvent.FAULT,   handleSilentLogout);
				_auth.silentLogout.addEventListener(mx.rpc.events.ResultEvent.RESULT, handleSilentLogout);
				_auth.appLogout.addEventListener(mx.rpc.events.FaultEvent.FAULT,   handleLogout);
				_auth.appLogout.addEventListener(mx.rpc.events.ResultEvent.RESULT, handleLogout);
				_auth.login.addEventListener(mx.rpc.events.FaultEvent.FAULT,   loginFault);
				_auth.login.addEventListener(mx.rpc.events.ResultEvent.RESULT, loginResult);
			}
			dispatchEvent(new WebApplicationEvent(WebApplicationEvent.WEB_APPLICATION_READY));
		}
			
		public function getService(serviceName:String):RemoteObject {
			var service:RemoteObject = _services[serviceName];
			if (service) return service;
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (! serviceDefinition.hasComplexContent()) return null;
			service = new RemoteObject();
			service.destination = _destination;            
			service.source = serviceDefinition.@source;       			
			service.channelSet = _amfChannelSet;
			_services[serviceName] = service;
			service.setRemoteCredentials(_userName, _password);
			return service;
		}
		
		public function getSecundaryService(serviceName:String):RemoteObject {
			var service:RemoteObject = _servicesB[serviceName];
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (service) return service;
			if (! serviceDefinition.hasComplexContent()) return null;
			service = new RemoteObject();
			service.destination 	= _destination;             
			service.source 			= serviceDefinition.@source;       			
			service.channelSet 		= _amfChannelBSet;
			_servicesB[serviceName] 	= service;
			service.setRemoteCredentials(_userName, _password); 
			return service;
		}	

		public function getCleanService(serviceName:String):RemoteObject {
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (! serviceDefinition.hasComplexContent()) return null;
			var service:RemoteObject = new RemoteObject();
			service.destination = _destination;             
			service.source = serviceDefinition.@source;      			
			service.channelSet = _amfChannelSet;
			service.setRemoteCredentials(_userName, _password); 
			return service;
		}	

		public function logout():void{
			_auth.appLogout();
		}

		private function handleSilentLogout(e:Object):void {
			var service:RemoteObject;
			var p:String
			_auth.login({username:_userName, password:_password});
		}
		
		private function handleLogout(e:Object):void{
			dispatchEvent(new LogoutEvent(LogoutEvent.LOGOUT_COMPLETE));
		}

		public function login(userName: String, password:String):void {			
			_userName = userName;
			_password = password;
			_auth.silentLogout();
		}	

		private function loginFault(fault:FaultEvent):void{
			dispatchEvent( fault );
		}
		
		private function loginResult(event:ResultEvent):void{
			_user = new User(event.result.user);
			if(event.result.paths){
				UserData.ROOT = event.result.paths.ROOT;
				UserData.UP_PATH = event.result.paths.UPLOAD;
				UserData.HOST_PATH =  event.result.paths.HOST;
				UserData.PATHS = event.result.paths;
				
				PathData.CODES 		= event.result.paths.CODES;
				PathData.DATA 		= event.result.paths.DATA;
				PathData.EMPLOYES 	= event.result.paths.EMPLOYES;
				PathData.HOST 		= event.result.paths.HOST;
				PathData.UPLOAD 	= event.result.paths.UPLOAD;
				PathData.PUBLIC 	= event.result.paths.PUBLIC;
				PathData.ROOT 		= event.result.paths.ROOT;
				PathData.SIGNS 		= event.result.paths.SIGNS;
				PathData.TEMP 		= event.result.paths.TEMP;
			}			
			dispatchEvent( new Event("loginResult") );
		}

		public function get uploadProtocol():String {return _uploadProtocol;}
		public function get protocol():String 		{return _protocol;}
		public function get uploadPort():String 	{return _uploadPort;}
		public function get hostName():String 		{return _hostName;}
		public function get user():User				{return _user;}
		
	}
}