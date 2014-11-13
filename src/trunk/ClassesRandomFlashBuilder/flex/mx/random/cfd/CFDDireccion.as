package mx.random.cfd{
	[Bindable]
	public class CFDDireccion{
		
		public var rfc:String 				= new String();
		public var calle:String 			= new String();
		public var noExterior:String 		= new String();
		public var codigoPostal:String 		= new String();
		public var municipio:String 		= new String();
		public var pais:String 				= new String();
		public var estado:String 			= new String();
		public var nombre:String 			= new String();
		public var colonia:String 			= new String();
		
		
		public function CFDDireccion(){
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