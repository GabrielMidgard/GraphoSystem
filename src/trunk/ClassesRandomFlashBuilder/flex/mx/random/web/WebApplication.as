package mx.random.web{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.system.Capabilities;
	
	import mx.controls.Alert;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.channels.SecureAMFChannel;
	import mx.random.events.LogoutEvent;
	import mx.random.events.WebApplicationEvent;
	import mx.random.files.PathData;
	import mx.random.soap.SoapService;
	import mx.random.userAuth.User;
	import mx.random.users.UserData;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.remoting.RemoteObject;
	
	public class WebApplication extends EventDispatcher {
		
		private var _configXML:XMLList;
		private var _protocol:String;
		private var _uploadProtocol:String;
		private var _uploadPort:String;
		private var _auth:*;
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
		
		public static var WA_MODE_SOAP:String = "wa_mode_soap";
		public static var WA_MODE_AMF:String  = "wa_mode_amf";
		private var _soapServer:String = "";
		private var _wa_mode:String;

		[Event(name="logoutComplete", type="com.latranquil.events.LogoutEvent")]
		public function WebApplication(configXML:XMLList) {
			super();
			
			_configXML 		= configXML;
			_hostName 		= _configXML.webHost.@name;
			_channelId 		= _configXML.@channelId.toString();
			_destination 	= _configXML.@destination.toString()
			
			switch(_channelId){
				case "my-amf":
					_wa_mode = WebApplication.WA_MODE_AMF;
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
					
					break;
				
				
				case 'soap':
					_wa_mode = WebApplication.WA_MODE_SOAP;
					_soapServer = _configXML.@gateway;
					_auth = getSoapService("Login");
					if(_auth){
						_auth.LoginUser.addEventListener(mx.rpc.events.FaultEvent.FAULT,   loginFault);
						_auth.LoginUser.addEventListener(mx.rpc.events.ResultEvent.RESULT, loginResult);
						_auth.LogOutUser.addEventListener(mx.rpc.events.FaultEvent.FAULT,   handleSilentLogout);
						_auth.LogOutUser.addEventListener(mx.rpc.events.ResultEvent.RESULT, handleSilentLogout);
						_auth.LogOutApp.addEventListener(mx.rpc.events.FaultEvent.FAULT,   handleLogout);
						_auth.LogOutApp.addEventListener(mx.rpc.events.ResultEvent.RESULT, handleLogout);
						
					}
					break;
			}
			
			
			dispatchEvent(new WebApplicationEvent(WebApplicationEvent.WEB_APPLICATION_READY));
		}
		
		
		
		public function getSoapService(serviceName:String):Object{
			var service:Object = _services[serviceName];
			if (service) return service;
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (! serviceDefinition.hasComplexContent()) return null;
			
			service = new Object();
			
			var children:XMLList = serviceDefinition.children();
			var child:XML;
			
			for each(child in children){
				service[child.@name] = new SoapService(_soapServer,'POST',serviceName+'.'+child.@name);
			}
			
			_services[serviceName] = service;
			return service;
		}
			
		public function getService(serviceName:String):RemoteObject {
			var service:RemoteObject = _services[serviceName];
			if (service) return service;
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (! serviceDefinition.hasComplexContent()) return null;
			service 				= new RemoteObject();
			service.destination 	= _destination;            
			service.source 			= serviceDefinition.@source;       			
			service.channelSet 		= _amfChannelSet;
			_services[serviceName] 	= service;
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
			_servicesB[serviceName] = service;
			service.setRemoteCredentials(_userName, _password); 
			return service;
		}	

		public function getCleanService(serviceName:String):RemoteObject {
			var serviceDefinition:XMLList = _configXML.services.service.(@name == serviceName);
			if (! serviceDefinition.hasComplexContent()) return null;
			var service:RemoteObject 	= new RemoteObject();
			service.destination 		= _destination;             
			service.source 				= serviceDefinition.@source;      			
			service.channelSet 			= _amfChannelSet;
			service.setRemoteCredentials(_userName, _password); 
			return service;
		}	

		public function logout():void{
			switch(this._wa_mode){
				case WebApplication.WA_MODE_AMF:				
					_auth.appLogout();
					break;
				case WebApplication.WA_MODE_SOAP:				
					_auth.LogOutApp.call();
					break;
				
			}
		}

		private function handleSilentLogout(e:Object):void {
			switch(this._wa_mode){
				case WebApplication.WA_MODE_AMF:				
					_auth.login({username:_userName, password:_password});
					break;
				case WebApplication.WA_MODE_SOAP:
					var params:Object =  {user:_userName,password:_password}
					_auth.LoginUser.call(params);
					break;
				
			}
		}
		
		private function handleLogout(e:Object):void{
			dispatchEvent(new LogoutEvent(LogoutEvent.LOGOUT_COMPLETE));
		}

		public function login(userName: String, password:String):void {	
			_userName = userName;
			_password = password;
			switch(this._wa_mode){
				case WebApplication.WA_MODE_AMF:				
					_auth.silentLogout();
					break;
				case WebApplication.WA_MODE_SOAP:				
					_auth.LogOutUser.call();
					break;
				
			}
			
		}	

		private function loginFault(fault:FaultEvent):void{
			dispatchEvent( fault );
		}
		
		private function loginResult(event:ResultEvent):void{
			
			switch(this._wa_mode){
				case WebApplication.WA_MODE_AMF:				
					_user = new User(event.result.user);
					break;
				case WebApplication.WA_MODE_SOAP:				
					_user = new User(event.result[0]);
					break;
				
			}
			
			
			
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