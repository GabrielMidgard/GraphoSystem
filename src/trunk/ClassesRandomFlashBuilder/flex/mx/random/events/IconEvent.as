package mx.random.events  {
	import flash.events.Event;
	
	public class IconEvent extends Event{
		
		public static var ICON_PRESSED:String 		= "icon_pressed";
		public static var ICON_RELEASED:String 		= "icon_released";
		public static var ICON_DOUBLECLICK:String 	= "icon_double_click";
		
		public var _iconClass:String = new String();
		public var _windowMode:Boolean = true

		public function IconEvent(type:String,iconClass:String,windowMode:Boolean){
			_iconClass = iconClass;
			_windowMode = windowMode;
			super(type,true,true);
		}

	}
	
}
