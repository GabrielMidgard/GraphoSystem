package mx.random.dataManagers{
	import flash.display.MovieClip;
	import flash.events.Event;

	[Bindable]
	public class EventManager extends MovieClip{
		public var ready:Boolean = false;
		private var _ref:Object = new Object();
		private var _properties:Array = new Array();
		
		public function set properties(value:Array):void { _properties = value };
		
		public function EventManager(ref:Object){
			_ref = ref;
			addEventListener(Event.ENTER_FRAME,updateStatus);
		}
		
		private function updateStatus(e:Event):void{
			var estatus:Boolean = true;
			for(var n:Number = 0;n<_properties.length;n++){
				estatus = estatus&&_ref[_properties[n]]
			}
			ready = estatus;
		}
	}
}