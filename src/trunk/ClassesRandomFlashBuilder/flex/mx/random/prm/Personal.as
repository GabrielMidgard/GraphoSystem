package mx.random.prm
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Personal{
		
		public static var Sex:ArrayCollection = new ArrayCollection([ 			
			{label:"Seleccionar",		value:0},
			{label:"Masculino",			value:1},
			{label:"Femenio",			value:2}																				
			]);
		
		public static var Status:ArrayCollection = new ArrayCollection([ 			
			{label:"Seleccionar",		value:0},
			{label:"Soltero(a)",		value:1},
			{label:"Union Libre",		value:2},
			{label:"Casado(a)",			value:3},
			{label:"Divorciado(a)",		value:4},
			{label:"Viudo(a)",			value:5}																				
			]);
			
		 public static var Prefix:ArrayCollection = new ArrayCollection([	
		 	{label: "Select", 	value: 0},
			{label: "Sr.", 		value: 1},
			{label: "Sra.", 	value: 2},
			{label: "Srita", 	value: 3}
			]);

		public static var Relationship:ArrayCollection = new ArrayCollection([	
			{label: "Select" , 		value: 0},
			{label: "Esposo(a)",  	value: 1},
			{label: "Hermano(a)",  	value: 2},
			{label: "Socio(a)",  	value: 3},
			{label: "Hijo(a)", 		value: 4},
			{label: "Amigo(a)", 	value: 5},
			{label: "Otro(a)", 		value: 6}
			]);
		
		public static var Languages:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",		value:0},
			{label:"Idioma Natal",		value:1},
			{label:"Español",			value:2},
			{label:"Inglés",			value:3},
			{label:"Francés",			value:4},
			{label:"Italiano",			value:5},
			{label:"Alemán",			value:6},
			{label:"Chino",				value:7},
			{label:"Japonés",			value:8},
			{label:"Mandarín",			value:9},
			{label:"Portugués",			value:10},
			]);
			
		public function Personal(){
		}
		

	}
}