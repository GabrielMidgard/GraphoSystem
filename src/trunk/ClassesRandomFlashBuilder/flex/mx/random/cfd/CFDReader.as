package mx.random.cfd{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	
	[Bindable]
	public class CFDReader extends EventDispatcher{
		
		public 	var cfd:XML;

		private var _folio:String 						= new String();
		private var _fecha:String 						= new String();
		private var _hora:String 						= new String();
		private var _noAprobacion:String 				= new String();
		private var _anoAprobacion:String 				= new String();		
		private var _tipoDeComprobante:String 			= new String();
		private var _conceptos:ArrayCollection 			= new ArrayCollection();
		private var _impuestos:ArrayCollection 			= new ArrayCollection();
		private var _formaDePago:String 				= new String();
		private var _subTotal:String 					= new String();
		private var _totalImpuestosTrasladados:String 	= new String();		
		private var _total:String 						= new String();
		private var _sello:String 						= new String();
		private var _serie:String 						= new String();
		private var _certificado:String  				= new String();
		private var _noCertificado:String 				= new String();
		
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

		public function CFDReader(){
			crearCFD();
		}
		
		public function  crearCFD():void{
			var tempCFD:XML = 	new XML(<Comprobante/>);
			for(var n:Number = 0;n<_elements.length;n++){
				tempCFD[_elements[n].nodo] = "";
				if(_elements[n].subNodos != "")
				tempCFD[_elements[n].nodo][_elements[n].subNodos] = "";
			}	
			
			//cfd.@["xmlns"]				="http://www.sat.gob.mx/cfd/2";
            //cfd.@["xmlns:xsi"] 			="http://www.w3.org/2001/XMLSchema-instance";
            //cfd.@["xmlns:terceros"] 	="http://www.sat.gob.mx/terceros";
            //cfd.@["xsi:schemaLocation"] ="http://www.sat.gob.mx/cfd/2 http://www.sat.gob.mx/sitio_internet/cfd/2/cfdv2.xsd http://www.sat.gob.mx/terceros http://www.sat.gob.mx/sitio_internet/cfd/terceros/terceros.xsd";
            cfd	= ResolveNameSpace(tempCFD);
            updateData();		
		}
		
		public function  leerCFD(xmlFile:XML):void{				
			cfd	= ResolveNameSpace(xmlFile);			
			updateData();
		}
		
		public function ResolveNameSpace( value:XML ):XML {  
			return new XML(    value.toXMLString().replace(     /(xmlns(:\w*)?=\".*?\")/gim    , ""        ).replace(     /\w+:/gim,     ""    )  ); 
		}
		
		public function updateData():void{			
			var res:Object = ObjectUtil.getClassInfo(this);	
			var prop:Array = res.properties;		
			for( var n:Number=0;n<prop.length;n++){
				if(prop[n].localName!="cfd"){
					this[prop[n].localName]=this[prop[n].localName];					
				}
			}
			this.conceptos = this.conceptos;
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
			_conceptos.addItem({cantidad:cantidad,descripcion:descripcion,valorUnitario:valorUnitario,importe:importe});	
		}
		
		public function agregarImpuesto(impuesto:String,tasa:String,importe:String):void{
			var impuestoItem:XML = <Impuesto/>;				
			impuestoItem.@impuesto 	= impuesto;
			impuestoItem.@tasa 		= tasa;
			impuestoItem.@importe 	= importe;			
			cfd.Impuestos.Traslados.appendChild(impuestoItem);
			_impuestos.addItem({impuesto:impuesto,tasa:tasa,importe:importe});			
		}
		
		public function get conceptos():ArrayCollection{ 
			_conceptos = new ArrayCollection();
			var conceptosItem:XMLList = cfd.Conceptos;			
			for each(var item:XML in cfd.Conceptos.elements()){
				_conceptos.addItem({cantidad:item.@cantidad.toString(),
									descripcion:item.@descripcion.toString(),
									valorUnitario:item.@valorUnitario.toString(),
									importe:item.@importe.toString()});
			}
			return _conceptos;
		}
		public function set conceptos(value:ArrayCollection):void{
			_conceptos		= value
			//cfd.@conceptos 	= value;
		};
		
		public function get impuestos():ArrayCollection{ return _impuestos;}
		public function set impuestos(value:ArrayCollection):void{
			_impuestos		= value
			//cfd.@conceptos 	= value;
		};
		
		[Bindable(event="dataCh")]
		public function get folio():String{ return cfd.@folio.toString();}
		public function set folio(value:String):void{
			_folio 		= value
			cfd.@folio 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get certificado():String{ return cfd.@certificado.toString();}
		public function set certificado(value:String):void{
			_certificado 		= value
			cfd.@certificado 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get noCertificado():String{ return cfd.@noCertificado.toString();}
		public function set noCertificado(value:String):void{
			_noCertificado 		= value
			cfd.@noCertificado 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get fecha():String{ return cfd.@fecha.toString();}		
		public function set fecha(value:String):void{
			_fecha 		= value
			cfd.@fecha 	= _fecha;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get hora():String{ return cfd.@hora.toString();}
		public function set hora(value:String):void{
			_hora 		= value
			//cfd.@fecha 	= _hora;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get noAprobacion():String{ return cfd.@noAprobacion.toString();}
		public function set noAprobacion(value:String):void{
			_noAprobacion 		= value
			cfd.@noAprobacion 	= value;
		};
		
		[Bindable(event="dataCh")]
		public function get anoAprobacion():String{ return cfd.@anoAprobacion;}
		public function set anoAprobacion(value:String):void{
			_anoAprobacion		= value
			cfd.@anoAprobacion 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get tipoDeComprobante():String{ return cfd.@tipoDeComprobante.toString();}
		public function set tipoDeComprobante(value:String):void{
			_tipoDeComprobante		= value
			cfd.@tipoDeComprobante 	= value;
			dispatchEvent(new Event("dataCh"));
		};

		[Bindable(event="dataCh")]
		public function get formaDePago():String{ return cfd.@formaDePago.toString();}
		public function set formaDePago(value:String):void{
			_formaDePago		= value
			cfd.@formaDePago 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get subTotal():String{ return cfd.@subTotal.toString();}
		public function set subTotal(value:String):void{
			_subTotal		= value
			cfd.@subTotal 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get totalImpuestosTrasladados():String{ return cfd.Impuestos.@totalImpuestosTrasladados.toString();}
		public function set totalImpuestosTrasladados(value:String):void{
			_totalImpuestosTrasladados		= value
			cfd.Impuestos.@totalImpuestosTrasladados 	= value;
			dispatchEvent(new Event("dataCh"));
		};
		
		[Bindable(event="dataCh")]
		public function get total():String{ return cfd.@total.toString();}
		public function set total(value:String):void{
			_total		= value
			cfd.@total 	= value;
			dispatchEvent(new Event("dataCh"));
		};						
		
		[Bindable(event="dataCh")]
		public function get sello():String{ return cfd.@sello.toString();}				
		public function set sello(value:String):void{
			_sello		= value
			cfd.@sello 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get serie():String{ return cfd.@serie.toString();}	
		public function set serie(value:String):void{
			_serie		= value
			cfd.@serie 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
				
		[Bindable(event="dataCh")]
		public function get e_nombre():String{ return cfd.Emisor.@nombre.toString();}
		public function set e_nombre(value:String):void{
			_e_nombre			= value
			cfd.Emisor.@nombre 	= value;
			dispatchEvent(new Event("dataCh"));
		}	
		
		[Bindable(event="dataCh")]
		public function get e_rfc():String{ return cfd.Emisor.@rfc.toString();}
		public function set e_rfc(value:String):void{
			_e_rfc				= value
			cfd.Emisor.@rfc 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_calle():String{ return cfd.Emisor.DomicilioFiscal.@calle.toString();}
		public function set e_calle(value:String):void{
			_e_calle			= value
			cfd.Emisor.DomicilioFiscal.@calle 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_noExterior():String{ return cfd.Emisor.DomicilioFiscal.@noExterior.toString();}
		public function set e_noExterior(value:String):void{
			_e_noExterior			= value
			cfd.Emisor.DomicilioFiscal.@noExterior 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_codigoPostal():String{ return cfd.Emisor.DomicilioFiscal.@codigoPostal.toString();}
		public function set e_codigoPostal(value:String):void{
			_e_codigoPostal				= value
			cfd.Emisor.DomicilioFiscal.@codigoPostal 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_municipio():String{ return cfd.Emisor.DomicilioFiscal.@municipio.toString();}
		public function set e_municipio(value:String):void{
			_e_municipio			= value
			cfd.Emisor.DomicilioFiscal.@municipio 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_pais():String{ return cfd.Emisor.DomicilioFiscal.@pais.toString();}
		public function set e_pais(value:String):void{
			_e_pais				= value
			cfd.Emisor.DomicilioFiscal.@pais 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_estado():String{ return cfd.Emisor.DomicilioFiscal.@estado.toString();}
		public function set e_estado(value:String):void{
			_e_estado			= value
			cfd.Emisor.DomicilioFiscal.@estado 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get e_colonia():String{ return cfd.Emisor.DomicilioFiscal.@colonia.toString();}
		public function set e_colonia(value:String):void{
			_e_colonia				= value
			cfd.Emisor.DomicilioFiscal.@colonia 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_nombre():String{ return cfd.Receptor.@nombre.toString();}
		public function set r_nombre(value:String):void{
			_r_nombre				= value
			cfd.Receptor.@nombre 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_rfc():String{ return cfd.Receptor.@rfc.toString();}
		public function set r_rfc(value:String):void{
			_r_rfc				= value
			cfd.Receptor.@rfc 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_calle():String{ return cfd.Receptor.Domicilio.@calle.toString();}
		public function set r_calle(value:String):void{
			_r_calle				= value
			cfd.Receptor.Domicilio.@calle 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_noExterior():String{ return cfd.Receptor.Domicilio.@noExterior.toString();}
		public function set r_noExterior(value:String):void{
			_r_noExterior				= value
			cfd.Receptor.Domicilio.@noExterior 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_codigoPostal():String{ return cfd.Receptor.Domicilio.@codigoPostal.toString();}
		public function set r_codigoPostal(value:String):void{
			_r_codigoPostal				= value
			cfd.Receptor.Domicilio.@codigoPostal 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_municipio():String{ return cfd.Receptor.Domicilio.@municipio.toString();}		
		public function set r_municipio(value:String):void{
			_r_municipio				= value
			cfd.Receptor.Domicilio.@municipio 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_pais():String{ return cfd.Receptor.Domicilio.@pais.toString();}	
		public function set r_pais(value:String):void{
			_r_pais				= value
			cfd.Receptor.Domicilio.@pais 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
		
		[Bindable(event="dataCh")]
		public function get r_estado():String{ return cfd.Receptor.Domicilio.@estado.toString();}
		public function set r_estado(value:String):void{
			_r_estado				= value
			cfd.Receptor.Domicilio.@estado 	= value;
			dispatchEvent(new Event("dataCh"));
		};			
		
		[Bindable(event="dataCh")]
		public function get r_colonia():String{ return cfd.Receptor.Domicilio.@colonia.toString();}
		public function set r_colonia(value:String):void{
			_r_colonia				= value
			cfd.Receptor.Domicilio.@colonia 	= value;
			dispatchEvent(new Event("dataCh"));
		};	
					
			
		
			
	}
}