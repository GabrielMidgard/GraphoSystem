package mx.random.events  {
	import flash.events.Event;
	
	public class SelectEvent extends Event{
		public static var SELECTION_COMPLETE:String = "selection_complete";	
		public static var MENU_SELECTION_COMPLETE:String = "menu_selection_complete";	
		public static var OVER_COMPLETE:String = "over_complete";	
		public static var OUT_COMPLETE:String = "out_complete";
		public static var DOWN_COMPLETE:String = "down_complete";
		public static var UP_COMPLETE:String = "up_complete";
		public static var SELECTION_CHANGE:String = "selection_change";
		
		public var selectedId:Number = 0;
		public var resultData:Object = null;

		public function SelectEvent(type:String,SelectedId:Number ,ResultData:Object = null) {
			selectedId = SelectedId;
			resultData = ResultData;
			super(type,true,true)
		}

	}
	
}
