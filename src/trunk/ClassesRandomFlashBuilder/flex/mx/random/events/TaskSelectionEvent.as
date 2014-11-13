package mx.random.events  {
	import flash.events.Event;
	
	public class TaskSelectionEvent extends Event{
		
		public static var TASK_SELECTION_COMPLETE:String = "task_selection_complete";			
		public static var TASK_SELECTION_DOUBLE_CLICK:String 	= "task_selection_double_click";
		
		public var selectedId:Number = new Number();
		public var itemData:Object = new Object();			

		public function TaskSelectionEvent(type:String,SelectedId:Number=0,ItemData:Object = null){
			selectedId = SelectedId;
			itemData 	= ItemData;			
			super(type,true,true)
		}

	}
	
}
