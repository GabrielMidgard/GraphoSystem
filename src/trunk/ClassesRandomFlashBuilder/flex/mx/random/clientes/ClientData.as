package mx.random.clientes
{
	
	[Bindable]
	public class ClientData
	{
		
		public var nombre:String = "";
		public var idCliente:Number = 0;
		public var idPrograma:Number = 0;
		public var idMembresia:Number = 0;
		public var numeroCliente:String = "";	
		public var tipoVenta:Number = 0;
		public var ventaData:Object = new Object();	
		
		public function ClientData()
		{
		}
		
	}
}