package mx.random.constant{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class CMSConstants{
		
		
		
		public static var tipoCuentas:ArrayCollection = new ArrayCollection([
			{value:0,	label:"USD"},
			{value:0,	label:"MXP"},
			{value:0,	label:"EUR"},
			{value:0,	label:"USD-MXP"}
			]);
			
			
		
		
		public function CMSConstants(){
		}

	}
}