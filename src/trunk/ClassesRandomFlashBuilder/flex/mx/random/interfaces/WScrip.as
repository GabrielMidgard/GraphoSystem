package mx.random.interfaces{
	import flash.events.EventDispatcher;
	import flash.external.ExternalInterface;;

	public class WScrip extends EventDispatcher	{
		public function WScrip(){
			
		}
		
		public static function runCmd(command:String):void{
			ExternalInterface.call("runCmd",command);
		}
		
	}
}