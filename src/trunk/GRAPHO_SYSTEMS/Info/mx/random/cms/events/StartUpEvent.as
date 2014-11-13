package mx.random.cms.events{
	import flash.events.Event;
	
	public class StartUpEvent extends Event {
		public static const FAILURE:String = "failure";
		public static const COMPLETE:String = "complete";
		
		public var info:String;
		public var configXML:XML;
		
		function StartUpEvent(type:String, configXML:XML=null, info:String=null) {
			super(type);
			this.info = info;
			this.configXML = configXML;
		}
	
		override public function clone():Event {
			return new StartUpEvent(type, configXML, info);
		}
	}// class
}