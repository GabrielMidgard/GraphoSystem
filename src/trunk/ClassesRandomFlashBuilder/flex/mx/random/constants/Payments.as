package mx.random.constants{
	import mx.collections.ArrayCollection;
	
	
	[Bindable]
	public class Payments{
		
		public static var PaymentStatus:ArrayCollection = new ArrayCollection([ 
			{label:"Por Cobrar",		value:0,	color:0x8e90fb},
			{label:"Pagada",			value:1,	color:0xc8fdc2},
			{label:"Vencida",			value:2,	color:0xfe8b8b},
			{label:"Cancelada",			value:3,	color:0xfdf27a}
			]);
			
		public static var PaymentStatusFilter:ArrayCollection = new ArrayCollection([ 
			{label:"Todas",			    value:""},
			{label:"Por Acreditar",		value:0},
			{label:"Pagadas",			value:1},
			{label:"Vencidas",			value:2},
			{label:"Canceladas",		value:3}
			
			]);																				
		
		public static var PaymentTypes:ArrayCollection = new ArrayCollection([
			{label:"Please Select",				value:0},
			{label:"Tarjeta de Crédito",		value:1},
			{label:"Transferencia Electrónica",	value:2},
			{label:"Depósito en Ventanilla",	value:3},
			{label:"PayPal",					value:4}
			]);
																	
		public static var BankStatus:ArrayCollection = new ArrayCollection([
			{label:"Sin Pagos", 	value:0},
			{label:"Liquidada", 	value:1},
			{label:"En Abono", 		value:2},
			{label:"Cancelada", 	value:5}
			]);

		public static var CardTypes:ArrayCollection = new ArrayCollection([	
			{label:"Select", 			value:0},
			{label:"Visa", 				value:1},
			{label:"MasterCard", 		value:2},
			{label:"American Express", 	value:3},
			{label:"Discover", 			value:4}
			]);
		
		
		public function Payments(){
		}
		
		

	}
}