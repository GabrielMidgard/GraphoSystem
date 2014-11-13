package mx.random.cms.converters
{
	
	import mx.collections.ArrayCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	
	public class Converter
	{
		public function Converter()
		{
		}
		
		public static function strReplace( replace_with:String, replace_in:String, original:String ):String{
			var array:Array = original.split(replace_in);
			return array.join(replace_with);
		}
		
		public static function numberFormat(amount:Number):String {
				if (isNaN(amount)) {
					return "0.00";
				}
				amount = Math.round(amount*100)/100;
				var amount_str:String = String(amount);
				var amount_array:Array = amount_str.split(".");
				if (amount_array[1] == undefined) {
					amount_array[1] = "00";
				}
				if (amount_array[1].length == 1) {
					amount_array[1] += "0";
				}
				var dollar_array:Array = new Array();
				var start:Number;
				var end:Number = amount_array[0].length;
				while (end>0) {
					start = Math.max(end-3, 0);
					dollar_array.unshift(amount_array[0].slice(start, end));
					end = start;
				}
			
				amount_array[0] = dollar_array.join(",");
				return (amount_array.join("."));
			}
			
		public static function columNumberConverter(item:Object,dg:DataGridColumn):String{
			return Converter.numberFormat(Number(item[dg.dataField]));
		}
		
		public static function arrayConverter(data:*):ArrayCollection{
			var resultArray:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0; n<data.length;n++){
        		resultArray.addItem(data[n]);
        	}
            return resultArray;
		}
		
		public static function unconvertNumber(num:String):Number{
			var temp:String = "";
			var pattern:RegExp = /,/gi;
			temp = num.replace(pattern, "");
			return new Number(temp);
		}
		
		public static function convertDate(dateString:String):Date{
			var dayArray:Array = dateString.split("-");
			var date:Date = new Date(parseInt(dayArray[0]),parseInt(dayArray[1])-1,parseInt(dayArray[2]));
			return date;
		}
		
		public static function getDaysDifference(minDate:Date, maxDate:Date):Number{
			var res:Number = 0;
			if(minDate<maxDate){
				res = Math.abs(Math.ceil(( minDate.getTime() - maxDate.getTime()) / 86400000));
			}else{
				res = Math.abs(Math.ceil(( maxDate.getTime() - minDate.getTime()) / 86400000));	
			}
		    return res;
		} 
		
		
		public static function dateToView(date:Date):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "DD/MM/YYYY";
			return formatter.format(date);
		}
		
		public static function dateToSQL(date:Date):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY-MM-DD";
			return formatter.format(date);
		}
		
		
		public static function systemToViewDate(date:String):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "DD/MM/YYYY";
			return formatter.format(convertDate(date));
		}
		
		
		public static function viewToSystemDate(dateString:String):String{
			var dayArray:Array = dateString.split("/");
			var date:Date = new Date(parseInt(dayArray[2]),parseInt(dayArray[1])-1,parseInt(dayArray[1]));
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY-MM_DD";
			return formatter.format(date);
		}
		
		public static function bool(value:*):Boolean{
			if(value=="true"||value==1||value=="1"){
				return true;
			}else{
				return false;
			}
		}
		
		
		
		public static function getLTPVWeeks(minDate:Date, maxDate:Date):Number{
			var res:Number 		= 0;
			var dif:Number 		= getDaysDifference(minDate,maxDate);
			var week:Number		= dif/7;
			var weeks:Number	= Math.floor(week);
			var module:Number	= week-Math.floor(week);
			var minDay:Number  	= minDate.getDay();
			var maxDay:Number 	= maxDate.getDay();
			var rule:Boolean 	= false;
			
			if(minDay==maxDay){
				//if(minDay==0||minDay==6){
					rule = true;
				//}
			}
			
			if(module==0){
				if(!rule){
						weeks++;
					}
			}else if(module>0){
					weeks++;
			}
		    return weeks;
		} 
		

	}
}

