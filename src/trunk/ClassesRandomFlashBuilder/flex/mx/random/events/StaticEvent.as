/*package mx.random.events{
import flash.events.EventDispatcher;
import flash.events.Event;

public class StaticEvent{	
protected static var dispatcher:EventDispatcher;

public static function addEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false, p_priority:int=0, p_useWeakReference:Boolean=false):void {
if (dispatcher == null) { dispatcher = new EventDispatcher(); }
dispatcher.addEventListener(p_type, p_listener, p_useCapture, p_priority, p_useWeakReference);
}
public static function removeEventListener(p_type:String, p_listener:Function, p_useCapture:Boolean=false):void {
if (dispatcher == null) { return; }
dispatcher.removeEventListener(p_type, p_listener, p_useCapture);
}
public static function dispatchEvent(p_event:Event):void {
if (dispatcher == null) { return; }
dispatcher.dispatchEvent(p_event);
}

}

}*/
package mx.random.events{
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	
	public class StaticEvent{	
		private static var dispatcher:EventDispatcher;
		private static var listenerList:Array = new Array();
		
		public static var debug:Boolean 		= false;
		public static var useSingelton:Boolean  = false;
		
		public static var addDebug:Boolean = true;
		public static var delDebug:Boolean = true;
		public static var disDebug:Boolean = true;
		
		public static function addEventListener(Type:String, Listener:Function, CallerName:String="Common", UseCapture:Boolean=false, Priority:int=0, UseWeakReference:Boolean=false):void {
			if (dispatcher == null) { dispatcher = new EventDispatcher(); }		
			if(useSingelton){
				if(!StaticEvent.findListenersByType(Type)){
					dispatcher.addEventListener(Type, Listener, UseCapture, Priority, UseWeakReference);
					listenerList.push({type:Type,listener:Listener,callerName:CallerName});
				}
			}else{
				dispatcher.addEventListener(Type, Listener, UseCapture, Priority, UseWeakReference);
				listenerList.push({type:Type,listener:Listener,callerName:CallerName});
			}
			if(StaticEvent.debug){ 
				trace("--------------Add Listener---------------");	
				trace(Type);
				StaticEvent.doDebug()
			}
		}
		public static function removeEventListener(Type:String, Listener:Function, UseCapture:Boolean=false):void {
			if (dispatcher == null) { return; }
			dispatcher.removeEventListener(Type, Listener, UseCapture);
			if(StaticEvent.debug){ 
				trace("--------------Remove Listener------------");	
				trace(Type);
				StaticEvent.doDebug()
			}
		}
		public static function dispatchEvent(p_event:Event):void {
			if (dispatcher == null) { return; }
			dispatcher.dispatchEvent(p_event);
			if(StaticEvent.debug){ 
				trace("--------------Dispatch Listener-----------");
				trace(p_event.type);
				StaticEvent.doDebug()
			}
		}
		
		public static function removeAllListeners():void{
			for(var n:Number = 0;n<StaticEvent.listenerList.length;n++){
				if(dispatcher.hasEventListener(StaticEvent.listenerList[n].type)){
					dispatcher.removeEventListener(StaticEvent.listenerList[n].type, StaticEvent.listenerList[n].listener);
				}
				
			}
			StaticEvent.listenerList = new Array();
		}
		
		public static function removeAllListenersByType(type:String):void{
			var newList:Array = new Array();
			for(var n:Number = 0;n<StaticEvent.listenerList.length;n++){
				if(type==StaticEvent.listenerList[n].type){
					if(dispatcher.hasEventListener(StaticEvent.listenerList[n].type)){
						dispatcher.removeEventListener(StaticEvent.listenerList[n].type, StaticEvent.listenerList[n].listener);
					}
				}else{
					newList.push({type:StaticEvent.listenerList[n].type,listener:StaticEvent.listenerList[n].listener,callerName:StaticEvent.listenerList[n].callerName})
				}
				
			}
			StaticEvent.listenerList = newList;
		}
		
		public static function removeAllListenersByCaller(callerName:String):void{
			var newList:Array = new Array();			
			
			if(StaticEvent.debug){ 
				trace("--------------Remove Caller Listener------");	
			}
			
			for(var n:Number = 0;n<StaticEvent.listenerList.length;n++){
				if(callerName==StaticEvent.listenerList[n].callerName){
					if(dispatcher.hasEventListener(StaticEvent.listenerList[n].type)){
						dispatcher.removeEventListener(StaticEvent.listenerList[n].type, StaticEvent.listenerList[n].listener);
						if(StaticEvent.debug){ 
							trace("--->"+StaticEvent.listenerList[n].type, StaticEvent.listenerList[n].callerName);	
						}
					}
				}else{
					newList.push({type:StaticEvent.listenerList[n].type,listener:StaticEvent.listenerList[n].listener,callerName:StaticEvent.listenerList[n].callerName})
				}
				
			}
			
			
			StaticEvent.listenerList = newList;
		}
		
		public static function findListenersByType(type:String):Boolean{	
			var res:Boolean = false
			for(var n:Number = 0;n<StaticEvent.listenerList.length;n++){
				if(type==StaticEvent.listenerList[n].type){
					res = true;
					break;
				} 
			}		
			return res;
		}
		
		public static function doDebug():void{
			trace("--------------Current Listeners--------------");		
			for(var n:Number = 0;n<StaticEvent.listenerList.length;n++){				
				trace("Name : "+StaticEvent.listenerList[n].type,"--> "+StaticEvent.listenerList[n].callerName)
			}		
		}
		
		
	}
	
}