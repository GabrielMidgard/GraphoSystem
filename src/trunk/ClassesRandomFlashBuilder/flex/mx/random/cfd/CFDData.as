package mx.random.cfd{
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.random.xml.XMLDataManager;
	
[Bindable] public class CFDData{
				
		public var folio:String = "";
		public var fecha:String = "";
		public var hora:String = "";
		public var noAprobacion:String = "";
		public var anoAprobacion:String = "";		
		public var tipoDeComprobante:String = "";
		public var conceptos:ArrayCollection;
		public var formaDePago:String = "";
		public var subTotal:String = "";
		public var totalImpuestosTrasladados:String = "";		
		public var total:String = "";
		public var sello:String = "";
		public var serie:String = "";

		public var emisor:CFDDireccion = new CFDDireccion();
		public var receptor:CFDDireccion = new CFDDireccion();
		
		public function CFDData(){
		}
		
		
		public function createData(data:XMLListCollection):void{
			var Comprobante:XML = new XML(data[0]);
			XMLDataManager.populate(this,XMLDataManager.getAtributes(new XMLList(Comprobante.attributes())));

			var subData:XMLList = data.children();	
			var arrayData:ArrayCollection = XMLDataManager.getItems(data.children());						   
			
			XMLDataManager.populate(emisor,XMLDataManager.getAtributesByName("Emisor",arrayData));	
			var emisorData:XML = new XML(arrayData[XMLDataManager.findItemIndex("Emisor",arrayData)].xmlData);
			var emisroDir:ArrayCollection = XMLDataManager.getItems(emisorData.children());
			XMLDataManager.populate(emisor,XMLDataManager.getAtributesByName("DomicilioFiscal",emisroDir));	
			
			XMLDataManager.populate(receptor,XMLDataManager.getAtributesByName("Receptor",arrayData));	
			var receptorData:XML = new XML(arrayData[XMLDataManager.findItemIndex("Receptor",arrayData)].xmlData);
			var receptorDir:ArrayCollection = XMLDataManager.getItems(receptorData.children());
			XMLDataManager.populate(receptor,XMLDataManager.getAtributesByName("Domicilio",receptorDir));	
			
			var conceptosData:XML = new XML(arrayData[XMLDataManager.findItemIndex("Conceptos",arrayData)].xmlData);
			var conceptosDir:ArrayCollection = XMLDataManager.getItems(conceptosData.children());
			conceptos = XMLDataManager.convertItemsToArrayCollection(conceptosDir);
			
			XMLDataManager.populate(this,XMLDataManager.getAtributesByName("Impuestos",arrayData));										
				
			var fechaArray:Array 	= fecha.split("T");
			fecha 					= fechaArray[0];
			hora 					= fechaArray[1];		
				
		}
		
		public function updateData(contextObj:Object):void{
			for( var p:String in contextObj){
				if(this.hasOwnProperty(p)){
					this[p] = contextObj[p];
				}
			}
		}
	}
}