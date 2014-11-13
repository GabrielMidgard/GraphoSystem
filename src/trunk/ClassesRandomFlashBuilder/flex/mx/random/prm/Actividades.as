package mx.random.prm
{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Actividades{
		
	public static var FunctionDescriptions:ArrayCollection = new ArrayCollection([
		{type:1,name:"Responsible",desc:"Persona a cargo"},
		{type:2,name:"Accountable",desc:"Rinde cuentas y autoriza"},
		{type:3,name:"Supportive",desc:"Proporciona apoyo y/o recursos"},
		{type:4,name:"Consulted",desc:"Debe ser consultado"},
		{type:5,name:"Informed",desc:"Debe ser informado"}
	]);
	
	public static var CompetenciaStatus:ArrayCollection = new ArrayCollection([
		{type:1,name:"Sin Fecha",val:0},
		{type:2,name:"En Tiempo",val:1},
		{type:3,name:"Vencido Recientemente",val:2},
		{type:4,name:"Vencido Hace Tiempo",val:3}
	]);
	



	}
}