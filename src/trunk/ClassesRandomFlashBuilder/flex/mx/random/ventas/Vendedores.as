package mx.random.ventas{
	import mx.random.web.WebApplication;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	[Bindable]
	public class Vendedores	{
		
		private static var _webApplication:WebApplication;
 		public static var nombre:String;
 		public static var idEmpleado:String;
		private static var _idVendedor:Number;
		private static var _idPuesto:Number;
		private static var _mainService:RemoteObject;
		
		public function Vendedores()
		{
		}
		
		public static function config(webApplication:WebApplication,idPuesto:Number,serviceName:String):void{
			_webApplication		= webApplication;
			_idPuesto 			= idPuesto;
			_mainService 		= _webApplication.getService(serviceName);
		}
		
		public static function getVendor(idEmpleado:Number):void{
			_mainService.getRecords(idEmpleado);
			_mainService.getRecords.addEventListener(ResultEvent.RESULT,onVendorReady);
		}
		
		private static function onVendorReady(e:ResultEvent):void{
			_mainService.getRecords.removeEventListener(ResultEvent.RESULT,onVendorReady);
			if(e.result){
				var data:Object = e.result[0];
				if(data){
					nombre = data._nombre+" "+data._paterno+" "+data._materno;
					idEmpleado = data._idEmpleado;
				}
			}
		}

	}
}