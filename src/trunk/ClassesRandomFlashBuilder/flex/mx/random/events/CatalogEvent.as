package mx.random.events  {
	import flash.events.Event;
	
	public class CatalogEvent extends Event{
		
		public static var CATALOG_COMPLETE:String 	 = "catalog_complete";
		public static var CATALOG_INIT:String 		 = "catalog_init";
		public static var CATALOG_RELOAD_INIT:String = "catalog_reload_init";	
		public static var CATALOG_ERROR:String 		 = "catalog_error";
		
		public var itemData:Object = new Object();			

		public function CatalogEvent(type:String){		
			super(type,true,true)
		}

	}
	
}
