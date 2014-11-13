package  mx.random.prm{
	import mx.collections.ArrayCollection;
	
	
	[Bindable]
	public class Academy{
		
		public static var Areas:ArrayCollection = new ArrayCollection([ 
			{label:"Seleccionar",				value:0},
			{label:"Administración de Alamcenes",value:1},
			{label:"Ley Federal del Trabajo",	value:2},
			{label:"Técnicas de Ventas",		value:3},
			{label:"Otros",		                value:4}
			]);
			
		public static var Profession:ArrayCollection = new ArrayCollection([ 
			{label:"Seleccionar",				value:0},
			{label:"Ing. Sistemas",value:1},
			{label:"Adm. de Empresas",	value:2},
			{label:"Lic. Mercadotecnia",		value:3},
			{label:"Otros",		                value:4}
			]);
		
		
		
		public static var Grados:ArrayCollection = new ArrayCollection([ 
			{label:"Seleccionar",				value:0},
			{label:"Sin Estudio",				value:1},
			{label:"Primaria",					value:2},
			{label:"Secundaria",				value:3},
			{label:"Secundaria Técnica",		value:4},
			{label:"Preparatoria",				value:5},
			{label:"Preparatoria Técnica",		value:6},
			{label:"Licenciatura",				value:7},
			{label:"Maestria",					value:8},
			{label:"Doctorado",					value:9},
			{label:"Postgrado",					value:10}
			]);
		
		public static var Documentos:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",				value:0},
			{label:"Certificado",				value:1},
			{label:"Carta de Pasante",			value:2},
			{label:"Título Profesional",		value:3}
			]);
		
	}
}