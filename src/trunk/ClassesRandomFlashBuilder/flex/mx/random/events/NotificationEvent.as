package mx.random.events  {
	import flash.events.Event;
	
	//import mx.random.notifications.Notifications;
	
	public class NotificationEvent extends Event{
		
		public static var NEW_NOTIFICATION:String 	= "new_notification";
		
		public var _notificationData:Object = new Object();
		public var _notificationType:String = new String()

		public function NotificationEvent(type:String,notificationData:Object,notificationType:String){
			_notificationData = notificationData;
			_notificationType = _notificationType;
			super(type,true,true);
		}

	}
	
}
