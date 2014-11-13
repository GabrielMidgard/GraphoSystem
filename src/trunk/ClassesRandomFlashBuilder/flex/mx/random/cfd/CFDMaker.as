package mx.random.cfd{
	import mx.collections.ArrayCollection;
	
	public class CFDMaker{
		public 	var cfd:XML;
		
		private var _folio:String = "";
		private var _fecha:String = "";
		private var _hora:String = "";
		private var _noAprobacion:String = "";
		private var _anoAprobacion:String = "";		
		private var _tipoDeComprobante:String = "";
		private var _conceptos:ArrayCollection;
		private var _formaDePago:String = "";
		private var _subTotal:String = "";
		private var _totalImpuestosTrasladados:String = "";		
		private var _total:String = "";
		private var _sello:String = "";
		private var _serie:String = "";
		private var _certificado:String = "";
		private var _noCertificado:String = "";
		
		private var _e_rfc:String 				= new String();
		private var _e_calle:String 			= new String();
		private var _e_noExterior:String 		= new String();
		private var _e_codigoPostal:String 		= new String();
		private var _e_municipio:String 		= new String();
		private var _e_pais:String 				= new String();
		private var _e_estado:String 			= new String();
		private var _e_nombre:String 			= new String();
		private var _e_colonia:String 			= new String();
		
		private var _r_rfc:String 				= new String();
		private var _r_calle:String 			= new String();
		private var _r_noExterior:String 		= new String();
		private var _r_codigoPostal:String 		= new String();
		private var _r_municipio:String 		= new String();
		private var _r_pais:String 				= new String();
		private var _r_estado:String 			= new String();
		private var _r_nombre:String 			= new String();
		private var _r_colonia:String 			= new String();

		private var _emisor:CFDDireccion = new CFDDireccion();
		private var _receptor:CFDDireccion = new CFDDireccion();
		
		
		
		private const _elements:ArrayCollection = new ArrayCollection([	{nodo:"Emisor",subNodos:"DomicilioFiscal"},
																				{nodo:"Receptor",subNodos:"Domicilio"},
																				{nodo:"Conceptos",subNodos:""},
																				{nodo:"Impuestos",subNodos:"Traslados"}																		
																			]);
		
		public function CFDMaker(){
			crearCFD();
		}
		
		public function  crearCFD():void{
			cfd = <Comprobante/>;
			for(var n:Number = 0;n<_elements.length;n++){
				cfd[_elements[n].nodo] = "";
				if(_elements[n].subNodos != "")
				cfd[_elements[n].nodo][_elements[n].subNodos] = "";
			}	
			
			cfd.@["xmlns"]				="http://www.sat.gob.mx/cfd/2";
            cfd.@["xmlns:xsi"] 			="http://www.w3.org/2001/XMLSchema-instance";
            cfd.@["xmlns:terceros"] 		="http://www.sat.gob.mx/terceros";
            cfd.@["xsi:schemaLocation"] 	="http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd http://www.sat.gob.mx/terceros http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros.xsd";		
		}
			
		public function limpiarConceptos():void{
			cfd.Conceptos = "";
		}
		
		public function limpiarImpuestos():void{
			cfd.Impuestos = "";
		}
		
		public function agregarConcepto(cantidad:String,descripcion:String,valorUnitario:String,importe:String):void{
			var concepto:XML = <Concepto/>;			
			concepto.@cantidad 		= cantidad;
			concepto.@descripcion 	= descripcion;
			concepto.@valorUnitario = valorUnitario;
			concepto.@importe 		= importe;			
			cfd.Conceptos.appendChild(concepto);		
		}
		
		public function agregarImpuesto(impuesto:String,tasa:String,importe:String):void{
			var impuestoItem:XML = <Impuesto/>;				
			impuestoItem.@impuesto 	= impuesto;
			impuestoItem.@tasa 		= tasa;
			impuestoItem.@importe 	= importe;			
			cfd.Impuestos.Traslados.appendChild(impuestoItem);
		}
		
		public function set folio(value:String):void{
			_folio 		= value
			cfd.@folio 	= value;
		};
		
		public function set certificado(value:String):void{
			_certificado 		= value
			cfd.@certificado 	= value;
		};
		
		public function set noCertificado(value:String):void{
			_noCertificado 		= value
			cfd.@noCertificado 	= value;
		};
		
		public function set fecha(value:String):void{
			_fecha 		= value
			cfd.@fecha 	= _fecha+"T"+_hora;
		};
		
		public function set hora(value:String):void{
			_hora 		= value
			cfd.@fecha 	= _fecha+"T"+_hora;
		};
		
		public function set noAprobacion(value:String):void{
			_noAprobacion 		= value
			cfd.@noAprobacion 	= value;
		};
		
		public function set anoAprobacion(value:String):void{
			_anoAprobacion		= value
			cfd.@anoAprobacion 	= value;
		};
		
		public function set tipoDeComprobante(value:String):void{
			_tipoDeComprobante		= value
			cfd.@tipoDeComprobante 	= value;
		};
		
		public function set conceptos(value:ArrayCollection):void{
			_conceptos		= value
			cfd.@conceptos 	= value;
		};
		
		public function set formaDePago(value:String):void{
			_formaDePago		= value
			cfd.@formaDePago 	= value;
		};
		
		public function set subTotal(value:String):void{
			_subTotal		= value
			cfd.@subTotal 	= value;
		};
		
		public function set totalImpuestosTrasladados(value:String):void{
			_totalImpuestosTrasladados		= value
			cfd.Impuestos.@totalImpuestosTrasladados 	= value;
		};
		
		public function set total(value:String):void{
			_total		= value
			cfd.@total 	= value;
		};						
							
		public function set sello(value:String):void{
			_sello		= value
			cfd.@sello 	= value;
		};	
				
		public function set serie(value:String):void{
			_serie		= value
			cfd.@serie 	= value;
		};	
		
		
		public function set e_nombre(value:String):void{
			_e_nombre			= value
			cfd.Emisor.@nombre 	= value;
		};	
		
		public function set e_rfc(value:String):void{
			_e_rfc				= value
			cfd.Emisor.@rfc 	= value;
		};	
		
		
		public function set e_calle(value:String):void{
			_e_calle			= value
			cfd.Emisor.DomicilioFiscal.@calle 	= value;
		};	
		public function set e_noExterior(value:String):void{
			_e_noExterior			= value
			cfd.Emisor.DomicilioFiscal.@noExterior 	= value;
		};	
		public function set e_codigoPostal(value:String):void{
			_e_codigoPostal				= value
			cfd.Emisor.DomicilioFiscal.@codigoPostal 	= value;
		};	
		
		public function set e_municipio(value:String):void{
			_e_municipio			= value
			cfd.Emisor.DomicilioFiscal.@municipio 	= value;
		};	
		public function set e_pais(value:String):void{
			_e_pais				= value
			cfd.Emisor.DomicilioFiscal.@pais 	= value;
		};	
		public function set e_estado(value:String):void{
			_e_estado			= value
			cfd.Emisor.DomicilioFiscal.@estado 	= value;
		};	
		
		public function set e_colonia(value:String):void{
			_e_colonia				= value
			cfd.Emisor.DomicilioFiscal.@colonia 	= value;
		};	
		

		public function set r_nombre(value:String):void{
			_r_nombre				= value
			cfd.Receptor.@nombre 	= value;
		};	
		public function set r_rfc(value:String):void{
			_r_rfc				= value
			cfd.Receptor.@rfc 	= value;
		};	
		public function set r_calle(value:String):void{
			_r_calle				= value
			cfd.Receptor.Domicilio.@calle 	= value;
		};	
		public function set r_noExterior(value:String):void{
			_r_noExterior				= value
			cfd.Receptor.Domicilio.@noExterior 	= value;
		};	
		public function set r_codigoPostal(value:String):void{
			_r_codigoPostal				= value
			cfd.Receptor.Domicilio.@codigoPostal 	= value;
		};			
		public function set r_municipio(value:String):void{
			_r_municipio				= value
			cfd.Receptor.Domicilio.@municipio 	= value;
		};	
		public function set r_pais(value:String):void{
			_r_pais				= value
			cfd.Receptor.Domicilio.@pais 	= value;
		};	
		public function set r_estado(value:String):void{
			_r_estado				= value
			cfd.Receptor.Domicilio.@estado 	= value;
		};			
		public function set r_colonia(value:String):void{
			_r_colonia				= value
			cfd.Receptor.Domicilio.@colonia 	= value;
		};	
					
			
		
			
	}
}