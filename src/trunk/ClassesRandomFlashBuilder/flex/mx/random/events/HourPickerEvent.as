package mx.random.events  {
	import flash.events.Event;
	
	public class HourPickerEvent extends Event{
		
		public static var HOUR_SELECTION_COMPLETE:String = "hour_selection_complete";	
		public static var HOUR_SELECTION_CANCEL:String 	= "hour_selection_cancel";
		
		public var selectedHour:String = new String();		

		public function HourPickerEvent(type:String,SelectedHour:String = "00:00:00"){
			selectedHour 	= SelectedHour;			
			super(type,true,true)
		}

	}
	
}
