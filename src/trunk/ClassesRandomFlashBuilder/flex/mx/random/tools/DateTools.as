package mx.random.tools{
	import mx.collections.ArrayCollection;
	
	public class DateTools{
		
		public static const MS_IN_SEC:int 		= 1000;
		public static const MS_IN_MIN:int 		= 1000 * 60;
		public static const MS_IN_HOUR:int 		= 1000 * 60 * 60;
		public static const MS_IN_DAY:int 		= 1000 * 60 * 60 * 24;
		public static const MS_IN_WEEK:uint 	= 1000 * 60 * 60 * 24  * 7;
		public static const MS_IN_YEAR:Number 	= 1000 * 60 * 60 * 24 * 365;
		
		public static const MONTHS:Array = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
		public static const DAYS:Array = ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sábado"];
		
		
		public function DateTools(){
		}

		public static function weekDiference(date:Date):int {
		    var fristDate:Date = new Date(date.fullYear, 0, 1);
		    var diff:Number = date.time - fristDate.time;
		    var diffInWeeks:uint = diff / MS_IN_WEEK;
		    return diffInWeeks;
		}
		
		public static function currentWeek():int {
			var date:Date = new Date();
		    var fristDate:Date = new Date(date.fullYear, 0, 1);
		    var diff:Number = date.time - fristDate.time;
		    var diffInWeeks:uint = diff / MS_IN_WEEK;
		    diffInWeeks++;
		    return diffInWeeks;
		}
		
		public static function getAllWeeks():ArrayCollection{
			var weeks:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0;n<52;n++){
				var z:String = "";
				if((n+1)<10) z = "0";
				var lab:String = z+(n+1);
				weeks.addItem({label:lab,value:n});
			}
			return weeks;
		}
		
		public static function getActualWeeks():ArrayCollection{
			var weeks:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0;n<DateTools.currentWeek();n++){
				var z:String = "";
				if((n+1)<10) z = "0";
				var lab:String = z+(n+1);
				weeks.addItem({label:lab,value:n});
			}
			return weeks;
		}
		
		public static function getWeekDays(week:Number):ArrayCollection{
			var days:ArrayCollection = new ArrayCollection();	
			var fDate:Date	= new Date();						
			var date:Date 	= new Date(fDate.fullYear,0,1);						
			date.setTime(date.getTime()+(week * MS_IN_WEEK));
			
			for(var n:Number = 0;n<7;n++){
				var day:Object = new Object();
				day.date 		= date;
				day.day 		= date.date;
				day.year 		= date.fullYear;
				day.dayName 	= DAYS[date.day];
				day.month 		= MONTHS[date.month];
				days.addItem(day);
				date = addDays(date,1);
			}	
			return days;
		}
		
		public static function addDays(currentDate:Date,days:Number):Date{
			var acDate:Date = new Date(currentDate.fullYear,currentDate.month,currentDate.date);
			acDate.setTime(acDate.getTime()+(86400000*days));
			return acDate;
		}

	}
}