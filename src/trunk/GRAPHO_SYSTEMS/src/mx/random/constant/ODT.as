package mx.random.constant
{
	import mx.random.converters.Converter;
	
	[Bindable]
	public class ODT{
		public var _idODT:Number 				= 0;
		public var _idEstatus:Number 			= 0;
		public var _idCliente:Number 			= 0;
		public var _idCreador:Number 			= 0;
		public var _idDIOT:Number 				= 0;
		public var _idCaptura:Number 			= 0;
		public var _idCierre:Number 			= 0;
		public var _numeroODT:String 			= "";
		public var _folio:String 				= "";
		public var _mes:String 					= "";
		public var _fechaRecoleccion:String 	= "No Asignada";
		public var _horaRecoleccion:String 		= "No Asignada";
		public var _fechaCreacion:String 		= "No Asignada";
		public var _horaCreacion:String 		= "No Asignada";
		public var _fechaInicio:String 			= "No Asignada";
		public var _horaInicio:String 			= "No Asignada";
		public var _fechaCaptura:String 		= "No Asignada";
		public var _horaCaptura:String 			= "No Asignada";
		public var _fechaCierre:String 			= "No Asignada";
		public var _horaCierre:String 			= "No Asignada";
		public var _fechaFacturacion:String 	= "No Asignada";
		public var _horaFacturacion:String 		= "No Asignada";
		public var _fechaEntrega:String 		= "No Asignada";
		public var _horaEntrega:String 			= "No Asignada";
		public var _fechaDIOT:String 			= "No Asignada";
		public var _horaDIOT:String 			= "No Asignada";
		public var _revision:String 			= "";
		public var _propuesta:String 			= "";
		public var _autorizado:String 			= "";
		public var _observaciones:String 		= "";
		public var _capturas:String 			= "";
		public var _servicios:String 			= "";
		public var _creada:String 				= "";
		public var _capturada:String 			= "";
		public var _facturada:String 			= "";
		public var _finalizada:String 			= "";
		
		public var _razonSocial:String 			= "";
		public var _rfc:String 					= "";
		public var _nombreEmpresa:String 		= "";
		public var _idTipoCliente:Number 		= 0;
		
		public var _nombreCreador:String 		= "";
		public var _nombreCaptura:String 		= "";
		public var _nombreDIOT:String 			= "";
		public var _nombreCierre:String 		= "";
		
		
		public function ODT(){
		}
		
		public function set context(contextObj:Object){
			for( var p:String in contextObj){
				if(this.hasOwnProperty(p)){
					this[p] = contextObj[p];
				}
			}							
		}
	}
}