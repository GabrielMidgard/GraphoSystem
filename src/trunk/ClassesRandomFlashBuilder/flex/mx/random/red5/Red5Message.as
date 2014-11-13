package mx.random.red5{

	[Bindable]
	public class Red5Message{
		
		
		public var userId:Number = 0;
		public var userToken:String = "";
		public var destinationUsers:Array = new Array();
		public var userName:String = "";
		public var msgType:String = "";
		public var message:Object = new Object();
		
		public function Red5Message(UserName:String,UserId:Number,UserToken:String,MsgType:String,Message:Object = null,DestinationUsers:Array = null){
			userId 				= UserId;
			userToken 			= UserToken;
			userName 			= UserName;
			message 			= Message;
			msgType 			= MsgType;
			destinationUsers 	= DestinationUsers;
		}
				
		
	}
}