package mx.random.events
{
	import flash.events.Event;
	
	public class InstructionEvent extends Event
	{
		public static var INSTRUCTION_COMPLETE:String 	= "instructiont_complete";	
		public static var INSTRUCTION_SENT:String 		= "instructiont_sent";	
		public var _insructionData:Object;
		
		public function InstructionEvent(type:String,data:Object = null){
			_insructionData = data;
			super(type,true,true)
		}
	}
}