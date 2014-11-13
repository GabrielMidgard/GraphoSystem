package mx.random.constants{
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	
	[Bindable]
	public class Dates{
		
		public static var SystemFormatString:String	=	"YYYY-MM-DD";
		public static var ViewFormatString:String 	=  "DD/MM/YYYY";
		
		public static var DayNames:Array	=	['D', 'L', 'M','M', 'J', 'V', 'S'];
		public static var MonthNames:Array	=	[	"Enero", "Febrero", "Marzo", "Abril", "Mayo","Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"];
		
		
		public static var Periods:ArrayCollection =  new ArrayCollection([
			{label:"Seleccionar",	value : 0},
			{label:"Dias",			value : 1},
			{label:"Meses",			value : 2},
			{label:"Años",			value : 3}
			])
		
		public static var Days:ArrayCollection = new ArrayCollection([		
			{label:"Dia",	value:0},	{label:"01",	value:1},	{label:"02",	value:2},
			{label:"03",	value:3},	{label:"04",	value:4},
			{label:"05",	value:5},	{label:"06",	value:6},
			{label:"07",	value:7},	{label:"08",	value:8},
			{label:"09",	value:9},	{label:"10",	value:10},
			{label:"11",	value:11},	{label:"12",	value:12},
			{label:"13",	value:13},	{label:"14",	value:14},
			{label:"15",	value:15},	{label:"16",	value:16},
			{label:"17",	value:17},	{label:"18",	value:18},
			{label:"19",	value:19},	{label:"20",	value:20},
			{label:"21",	value:21},	{label:"22",	value:22},
			{label:"23",	value:23},	{label:"24",	value:24},
			{label:"25",	value:25},	{label:"26",	value:26},
			{label:"27",	value:27},	{label:"28",	value:28},
			{label:"29",	value:29},	{label:"30",	value:30},
			{label:"31",	value:31}]);
		
		public static var Months:ArrayCollection = new ArrayCollection([	
			{label:"Mes",		value:0},	{label:"Enero",		value:1},	{label:"Febrero",	value:2},
			{label:"Marzo",		value:3},	{label:"Abril",		value:4},
			{label:"Mayo",		value:5},	{label:"Junio",		value:6},
			{label:"Julio",		value:7},	{label:"Agosto",	value:8},
			{label:"Septiembre",value:9},	{label:"Octubre",	value:10},
			{label:"Noviembre",	value:11},	{label:"Diciembre",	value:12}
			]);
        
        
        public static var Years:ArrayCollection = new ArrayCollection();
		
		public function Dates(){
			Years.addItem({label:"Year",value:0});
			for(var n:Number = 1940;n<2011;n++){
				Years.addItem({label:n,value:n});
			}
		}
		
		public static function FindYearindex(year:String):Number{
			for(var n:Number = 0;n<Years.length;n++){
				if(year==Years[n].label) break;
			}
			return n;
		}
		
		public static function SystemFormatDate(date:Date):String{
			var _formatter:DateFormatter = new DateFormatter();
			_formatter.formatString = SystemFormatString;
			
			return _formatter.format(date);
		}
		
		public static function ViewFormatDate(date:Date):String{
			var _formatter:DateFormatter = new DateFormatter();
			_formatter.formatString = ViewFormatString;
			
			return _formatter.format(date);
		}
		
		

	}
}