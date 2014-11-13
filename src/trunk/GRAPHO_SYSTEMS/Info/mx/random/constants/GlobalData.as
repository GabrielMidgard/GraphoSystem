package mx.random.constants
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class GlobalData
	{
		public static var COMPANIA:String = "";
		public static var EMPLEADO:String = "";
		public static var Locations:ArrayCollection = new ArrayCollection();
		
		public function GlobalData()
		{
		}

	}
}