package mx.random.payments{
	import flash.utils.getQualifiedClassName;
	
	import mx.random.dataManagers.DataManager;
	
	
	[Bindable]	
	public class Payment{
		
		public var _idPago:Number 				= new Number();
		public var _idEstatusPago:Number 		= new Number();
		public var _idTarjetaCredito:Number 	= new Number(); 
		public var _numeroTarjeta:String 		= new String();
		public var _idCuentaDestino:Number 		= new Number(); 
		public var _idCuentaOrigen:Number 		= new Number();
		public var _idTipoPago:Number 			= new Number();
		public var _idTipoMoneda:Number 		= new Number();
		public var _idConcepto:Number 			= new Number();
		public var _idContrato:Number 			= new Number();
		public var _idTipoTarjeta:Number 		= new Number();
		public var _idCliente:Number 			= new Number();		  
		public var _idEmpleado:String 			= new String();		
		public var _fechaPago:String 			= new String();
		public var _fechaVencimiento:String 	= new String();		
		public var _numeroCuentaDestino:String 	= new String();
		public var _numeroCuentaOrigen:String 	= new String();
		public var _numeroCliente:String 		= new String(); 
		public var _numeroContrato:String 		= new String(); 
		public var _numeroEmpleado:String 		= new String(); 
		public var _numeroReferencia:String 	= new String();
		public var _numeroCheque:String 		= new String();
		public var _tcFix:String 				= new String();
		public var _monto:String 				= new String();
		public var _descripcion:String 			= new String();
		public var _idVenta:String 				= new String();
		public var _idSucursal:Number 			= new Number();
		
		private var _ref:Object = new Object();
		
		public function Payment(){
			
		}
		
		public function makeData():Object{
			var params:Object = new Object();
			params['_idPago'] 				= this._idPago;
			params['_idEstatusPago'] 		= this._idEstatusPago;
			params['_idTarjetaCredito'] 	= this._idTarjetaCredito;
			params['_numeroTarjeta'] 		= this._numeroTarjeta;
			params['_idCuentaDestino'] 		= this._idCuentaDestino;
			params['_idCuentaOrigen'] 		= this._idCuentaOrigen;
			params['_idTipoPago'] 			= this._idTipoPago;
			params['_idTipoMoneda'] 		= this._idTipoMoneda;
			params['_idConcepto'] 			= this._idConcepto;
			params['_idContrato'] 			= this._idContrato;
			params['_idTipoTarjeta'] 		= this._idTipoTarjeta;
			params['_idCliente'] 			= this._idCliente;
			params['_idEmpleado'] 			= this._idEmpleado;
			params['_fechaPago'] 			= this._fechaPago;
			params['_fechaVencimiento'] 	= this._fechaVencimiento;	
			params['_numeroCuentaDestino'] 	= this._numeroCuentaDestino;
			params['_numeroCuentaOrigen'] 	= this._numeroCuentaOrigen;
			params['_numeroCliente'] 		= this._numeroCliente;
			params['_numeroContrato'] 		= this._numeroContrato;
			params['_numeroEmpleado'] 		= this._numeroEmpleado;
			params['_numeroReferencia'] 	= this._numeroReferencia;
			params['_numeroCheque'] 		= this._numeroCheque;
			params['_tcFix'] 				= this._tcFix;
			params['_monto'] 				= this._monto;
			params['_descripcion'] 			= this._descripcion;
			params['_idVenta'] 				= this._idVenta;
			params['_idSucursal'] 			= this._idSucursal;
			return params;			
		}
		
	}
}