package mx.random.red5{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.random.events.Red5Event;
	import mx.random.events.StaticEvent;

	[Bindable]
	public class Red5Core extends EventDispatcher{

		public static var onLineUsers:ArrayCollection = new ArrayCollection();
		
		public function Red5Core(){
			StaticEvent.addEventListener(Red5Event.RED5_USER_LOGIN,onUserLogIn);
			StaticEvent.addEventListener(Red5Event.RED5_USER_LOGOUT,onUserLogOut);
		}
		
		public static function addOnlineUser(userName:String,userId:Number):void{
			Red5Core.onLineUsers.addItem({userName:userName,userId:userId});
		}
		
		public static function removeOnlineUser(userId:Number):void{
			var index:Number = Red5Core.findUser(userId);
			Red5Core.onLineUsers.removeItemAt(index);
		}
		
		private static function findUser(userId:Number):Number{
			var index:Number = 0;
			for(var n:Number = 0;n<Red5Core.onLineUsers.length;n++){
				if(Red5Core.onLineUsers[n].userId==userId){
					index = n;
					break;
				}
			}
			return index;
		}
		
		private function onUserLogIn(e:Red5Event):void{
			var msg:Red5Message = e.red5Message as Red5Message;
			Red5Core.addOnlineUser(msg.userName,msg.userId);
		}
		
		private function onUserLogOut(e:Red5Event):void{
			var msg:Red5Message = e.red5Message as Red5Message;
			Red5Core.removeOnlineUser(msg.userId);
		}
		
	}
}