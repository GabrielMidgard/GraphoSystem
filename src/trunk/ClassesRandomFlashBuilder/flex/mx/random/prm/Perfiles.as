package mx.random.prm
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Perfiles{
		
	public static var Profile:ArrayCollection = new ArrayCollection([
		{value:1,kind:1,code:1,label:"Practico"},
		{value:1,kind:1,code:2,label:"Atlético"},
		{value:1,kind:1,code:3,label:"Directo / Franco"},
		{value:1,kind:1,code:4,label:"Te gusta la Mecánica"},
		{value:1,kind:1,code:5,label:"Practico"}
	])
	
	public static var ProfileTypes:ArrayCollection = new ArrayCollection([
		{value:0,label:"Seleccionar",	 desc:""},
		{value:1,label:"Realistas",	 desc:"Gente con habilidades  atléticas o mecánicas, prefieren trabajar con objetos, máquinas, herramientas, plantas o animales, y trabajo de campo"},
		{value:2,label:"Investigador", desc:"Gente a la que le gusta observar, aprender, investigar, analizar, evaluar o resolver problemas matemáticos"},
		{value:3,label:"Artistico",	 desc:"Gente con habilidades artísticas, innovadores, intuitivos, a quienes les gusta trabajar en situaciones no estructuradas utilizando su imaginación y creatividad"},
		{value:4,label:"Sociable",	 desc:"Gente a la que le gusta trabajar con gente para ayudar, explicar, informar, entrenar, curar, donde pueden utilizar habilidades de comunicación"},
		{value:5,label:"Emprendedor",	 desc:"Gente a la que le gusta trabajar con gente, influenciando, persuadiendo, dirigiendo o gestionando para el logro de metas organizacionales o económicas"},
		{value:6,label:"Convencional", desc:"Gente a la que le gusta trabajar con datos, con habilidad numérica, actividades que demanden atención al detalle, seguir instrucciones en forma precisa"},
	]);
	
	public static var ProfileKinds:ArrayCollection = new ArrayCollection([
		{value:1,label:"Eres tu"},
		{value:2,label:"Puedes"},
		{value:3,label:"Te Gusta"},
		{value:4,label:"Hobbies"}
	])
		
		
		public function Perfiles()
		{
		}

	}
}