package mx.random.handlers{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class HanlderEvent extends Event{
		
			public static var HANDLER_SHOW:String 		= "hanlder_show";
			public static var HANDLER_HIDE:String 		= "hanlder_hide";
			public static var HANDLER_RESIZE:String 	= "hanlder_resize";
			public static var UPDATE_HANDLER:String		= "update_hanlder";
			public static var UPDATE_HANDLER_REF:String	= "update_hanlder_ref";
			
			public var newRect:Rectangle = new Rectangle();
			public var newRef:Object = new Object();
		
		public function HanlderEvent(type:String,ref:Object = null,rect:Rectangle = null){
			newRect = rect;
			newRef = ref;
			super(type);
		}
	}
}