package mx.random.constants{
	import mx.collections.ArrayCollection;
	import mx.random.cms.web.WebApplication;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class Catalogs{
		
		
[Bindable]	public static var DataArray:ArrayCollection = new ArrayCollection();
[Bindable]	public static var DataObject:Object 		= new Object();
[Bindable]	public static var Tables:Array 				= new Array();

			private static var WA:WebApplication;
			private static var SRV:RemoteObject;
		
			public function Catalogs(){
			}
			
			public static function config(wa:WebApplication,tables:Array):void{
				Tables = tables;
				WA = wa;
				SRV = WA.getService("Catalogs");
				SRV.addEventListener(FaultEvent.FAULT,onFault);
				SRV.getCatalogs(tables);
				SRV.getCatalogs.addEventListener(ResultEvent.RESULT,onResult);
			}
			
			private static function onFault(e:FaultEvent):void{
				
			}
			
			private static function onResult(e:ResultEvent):void{
				SRV.getCatalogs.removeEventListener(ResultEvent.RESULT,onResult);
				if(e.result) DataObject = e.result;
			}
			
			public static function reload():void{
				DataObject = new Object();
				SRV.getCatalogs(Tables);
				SRV.getCatalogs.addEventListener(ResultEvent.RESULT,onResult);
			}

	}
}