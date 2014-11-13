package mx.random.events  {
	import flash.events.Event;
	
	public class SelectionEvent extends Event{
		
		public static var SELECTION_COMPLETE:String = "selection_complete";	
		public static var SELECTION_START:String 	= "selection_start";
		public static var SELECTION_RESET:String 	= "selection_reset";
		public static var SELECTION_SOURCE:String 	= "selection_source";
		public static var SELECTION_TARGET:String 	= "selection_target";
		public static var SELECTION_UPDATE:String 	= "selection_update";
		public static var SELECTION_DELETE:String 	= "selection_delete";
		public static var SELECTION_DOUBLE_CLICK:String 	= "selection_double_click";
		public var itemData:Object = new Object();
		public var itemsData:Array = new Array();			

		public function SelectionEvent(type:String,ItemData:Object = null,ItemsData:Array = null){
			itemData 	= ItemData;
			itemsData =  ItemsData;
			super(type,true,true)
		}

	}
	
}
