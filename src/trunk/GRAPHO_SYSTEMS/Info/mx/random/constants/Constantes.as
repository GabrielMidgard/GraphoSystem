package mx.random.constants
{
	import mx.collections.ArrayCollection;
	
	public class Constantes{
		
		public static var Sexos:ArrayCollection = new ArrayCollection([ 			
			{label:"Seleccionar",		index:0},
			{label:"Masculino",			index:1},
			{label:"Femenino",			index:2}																				
			]);
		
		public static var EstadosCiviles:ArrayCollection = new ArrayCollection([ 			
			{label:"Seleccionar",		index:0},
			{label:"Soltero(a)",		index:1},
			{label:"Union Libre",		index:2},
			{label:"Casado(a)",			index:3},
			{label:"Divorciado(a)",		index:4},
			{label:"Separado(a)",		index:5},
			{label:"Viudo(a)",			index:6}																				
			]);
			
		 public static var Prefijos:ArrayCollection = new ArrayCollection([	
		 	{label: "Select", 	index: 0},
			{label: "Sr.", 		index: 1},
			{label: "Sra.", 	index: 2},
			{label: "Srita", 	index: 3}
			]);

		public static var Relaciones:ArrayCollection = new ArrayCollection([	
			{label: "Select" , 		index: 0},
			{label: "Padres",  		index: 1},
			{label: "Esposo(a)",  	index: 2},
			{label: "Hermano(a)",  	index: 3},
			{label: "Socio(a)",  	index: 4},
			{label: "Hijo(a)", 		index: 5},
			{label: "Amigo(a)", 	index: 6},
			{label: "Otro(a)", 		index: 7}
			]);
		
		public static var Languages:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",		index:0},
			{label:"Idioma Natal",		index:1},
			{label:"Español",			index:2},
			{label:"Inglés",			index:3},
			{label:"Francés",			index:4},
			{label:"Italiano",			index:5},
			{label:"Alemán",			index:6},
			{label:"Chino",				index:7},
			{label:"Japonés",			index:8},
			{label:"Mandarín",			index:9},
			{label:"Portugués",			index:10}
			]);
		
		
		
		public static const TiposSangre:ArrayCollection = new ArrayCollection([
			{label:"Sel",	index:0},
			{label:"O-",	index:1},
			{label:"O+",	index:2},
			{label:"A-",	index:3},
			{label:"A+",	index:4},
			{label:"B-",	index:5},
			{label:"B+",	index:6},
			{label:"AB-",	index:7},
			{label:"AB+",	index:8}
		]);
		
		public static var EstadosNacionales:ArrayCollection = new ArrayCollection([
			{ label:"Seleccionar", 			abr: "00", index: 0},
			{ label:"Aguascalientes", 		abr: "AS", index: 1},
			{ label:"Baja California", 		abr: "BC", index: 2},
			{ label:"Baja California Sur", 	abr: "BS", index: 3},
			{ label:"Campeche", 			abr: "CC", index: 4},
			{ label:"Chiapas",	 			abr: "CS", index: 5},
			{ label:"Chihuahua", 			abr: "CH", index: 6},
			{ label:"Coahuila", 			abr: "CL", index: 7},
			{ label:"Colima", 				abr: "CM", index: 8},
			{ label:"Distrito Federal", 	abr: "DF", index: 9},
			{ label:"Durango", 				abr: "DG", index: 10},
			{ label:"Guanajuato", 			abr: "GT", index: 11},
			{ label:"Guerrero", 			abr: "GR", index: 12},
			{ label:"Hidalgo", 				abr: "HG", index: 13},
			{ label:"Jalisco", 				abr: "JC", index: 14},
			{ label:"Estado de México", 	abr: "MC", index: 15},
			{ label:"Michoacán", 			abr: "MN", index: 16},
			{ label:"Morelos", 				abr: "MS", index: 17},
			{ label:"Nayarit", 				abr: "NT", index: 18},
			{ label:"Nuevo León", 			abr: "NL", index: 19},
			{ label:"Oaxaca", 				abr: "OC", index: 20},
			{ label:"Puebla", 				abr: "PL", index: 21},
			{ label:"Querétaro", 			abr: "QT", index: 22},
			{ label:"Quintana Roo", 		abr: "QR", index: 23},
			{ label:"San Luis Potosí", 		abr: "SP", index: 24},
			{ label:"Sinaloa", 				abr: "SL", index: 25},
			{ label:"Sonora", 				abr: "SR", index: 26},
			{ label:"Tabasco", 				abr: "TC", index: 27},
			{ label:"Tamaulipas", 			abr: "TS", index: 28},
			{ label:"Tlaxcala", 			abr: "TL", index: 29},
			{ label:"Veracruz", 			abr: "VZ", index: 30},
			{ label:"Yucatán", 				abr: "YN", index: 31},
			{ label:"Zacatecas", 			abr: "ZS", index: 32}
			]);
		
		
		public static var Grados:ArrayCollection = new ArrayCollection([ 
			{label:"Seleccionar",				index:0},
			{label:"Sin Estudio",				index:1},
			{label:"Primaria",					index:2},
			{label:"Secundaria",				index:3},
			{label:"Secundaria Técnica",		index:4},
			{label:"Preparatoria",				index:5},
			{label:"Preparatoria Técnica",		index:6},
			{label:"Licenciatura",				index:7},
			{label:"Maestria",					index:8},
			{label:"Doctorado",					index:9},
			{label:"Postgrado",					index:10}
			]);
		
		public static var Documentos:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",				index:0},
			{label:"Certificado",				index:1},
			{label:"Carta de Pasante",			index:2},
			{label:"Título Profesional",		index:3}
			]);
			
		public static var Areas:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",				index:0},
			{label:"Ventas",					index:1},
			{label:"Mercadotécnia",				index:2},
			{label:"Servicio a Clientes",		index:3},
			{label:"Suppply Chain",				index:4},
			{label:"Comercio Exterior",			index:5},
			{label:"Tráfico",					index:6},
			{label:"Calidad",					index:7},
			{label:"Manufactura",				index:8},
			{label:"Ingenierías",				index:9},
			{label:"Recursos Humanos",			index:10},
			{label:"Compras",					index:11},
			{label:"Finanzas",					index:12},
			{label:"EHS",						index:13},
			{label:"Agrícola",					index:14}
			
			]);	
		
		public static var TipoConocimientos:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",					index:0},
			{label:"Académico",						index:1},
			{label:"Exp. Curricular",				index:2},
			{label:"Management",					index:3},
			{label:"Sistemas de Calidad",			index:4},
			{label:"Software",						index:5},
			{label:"Maquinaria y Equipo",			index:6},
			{label:"Calidad",						index:7},
			{label:"Entrenamiento en la operación",	index:8},
			{label:"Métodos y procedimientos",		index:9},
			{label:"Idiomas",						index:10},
			{label:"Certificaciones",				index:11}
			]);	
		
		
		
		
		public function Constantes(){
		}

	}
}