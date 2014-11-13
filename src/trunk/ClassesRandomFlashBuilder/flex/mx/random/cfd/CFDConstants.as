package mx.random.cfd
{
	import mx.collections.ArrayCollection;
	
	public class CFDConstants
	{
		public static const tipoDeComprobante:ArrayCollection = new ArrayCollection([{label:"ingresos",value:0},{label:"egresos",value:0},{label:"traslado",value:0}])
		public static const formaDePago:ArrayCollection = new ArrayCollection([{label:"PAGO EN UNA SOLA EXHIBICION",value:0}])
		
		public function CFDConstants()
		{
		}

	}
}