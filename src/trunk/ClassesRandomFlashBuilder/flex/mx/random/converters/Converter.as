package mx.random.converters
{
	
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	import mx.random.constants.ConstantData;
	import mx.random.constants.SystemGlobals;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	public class Converter
	{
		public function Converter()
		{
		}
		
		public static function strReplace( replace_with:String, replace_in:String, original:String ):String{
			var array:Array = original.split(replace_in);
			return array.join(replace_with);
		}
		
		public static function tagExtract( tag:String, original:String,allTag:Boolean = true ):String{
			var iniTag:String = "<"+tag+">";
			var endTag:String = "</"+tag+">";
			var iniIndex:Number = original.indexOf(iniTag);
			var endIndex:Number = original.indexOf(endTag);
			var res:String = new String();
			if(allTag){
				res = original.slice(iniIndex,endIndex+(endTag.length));
			}else{
				res = original.slice(iniIndex+(iniTag.length),endIndex);
			}
			return res;
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
			var result:String = "0.00";
			if(item[dg.dataField]) result = Converter.numberFormat(Number(item[dg.dataField]));
			return result;
		}
		
		
		public static function columStringNumberConverter(item:Object,dg:DataGridColumn):String{
			var result:String = "0.00";
			if(item[dg.dataField]) result = Converter.numberFormat(Converter.unconvertNumber(item[dg.dataField]));
			return result;
		}
		
		public static function columDateConverter(item:Object,dg:DataGridColumn):String{
			var result:String = "";
			if(item[dg.dataField]) result = Converter.systemToViewDate(item[dg.dataField]);			
			return result;
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
			var pattern:RegExp = /[^0-9 ^. ^-]/g;
			temp = num.replace(pattern, "");
			return new Number(temp);
		}
		
		public static function convertDate(dateString:String):Date{
			var date:Date = new Date
			if(dateString){
				var dayArray:Array = dateString.split("-");
				date = new Date(parseInt(dayArray[0]),parseInt(dayArray[1])-1,parseInt(dayArray[2]));
			}
			return date;
		}
		
		public static function unconvertDate(date:Date):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "DD/MM/YYYY";
			return formatter.format(date);
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
			formatter.formatString = SystemGlobals.userDateFormat;
			return formatter.format(date);
		}
		
		public static function dateToSQL(date:Date):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY-MM-DD";
			return formatter.format(date);
		}
		
		
		public static function systemToViewDate(date:String):String{
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = SystemGlobals.userDateFormat;
			return formatter.format(convertDate(date));
		}
		
		
		public static function viewToSystemDate(dateString:String):String{
			var dayArray:Array = dateString.split("/");
			var date:Date = new Date(parseInt(dayArray[2]),parseInt(dayArray[1])-1,parseInt(dayArray[1]));
			var formatter:DateFormatter = new DateFormatter();
			formatter.formatString = "YYYY-MM-DD";
			return formatter.format(date);
		}
		
		
		public static function bool(value:*):Boolean{
			if(value=="true"||value==1||value=="1"||value=="TRUE"||value=="True"){
				return true;
			}else{
				return false;
			}
		}
		
		
		public static function filterArray(sourceArray:ArrayCollection,searchField:String,searchValue:String):ArrayCollection{
			var resArray:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0; n<sourceArray.length;n++){
				var item:Object = sourceArray[n];
				var val:String = item[searchField];
				if(val==searchValue){
					resArray.addItem(sourceArray[n]);
				}
			}
			return resArray;
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
		
		
		public static function dateExploit(tempDate:String):Object{
			var day:Number 		= 0;
			var month:Number 	= 0;
			var year:Number 	= 0;			
			if(tempDate){
				var temp:Array 		= tempDate.split('-');
				day		= parseInt(temp[2]);
				month 	= parseInt(temp[1]);
				year 	= ConstantData.FindYearindex(temp[0]);				
			}
			
			return {day:day,month:month,year:year}
		}
		
		public static function dateExploitUP(tempDate:String):Object{
			var day:Number 		= 0;
			var month:Number 	= 0;
			var year:Number 	= 0;			
			if(tempDate){
				var temp:Array 		= tempDate.split('-');
				day		= parseInt(temp[2]);
				month 	= parseInt(temp[1]);
				year 	= ConstantData.FindYearUpIndex(temp[0]);				
			}
			
			return {day:day,month:month,year:year}
		}
		
		
		public static function addDays(currentDate:Date,days:Number):Date{
			var acDate:Date = new Date(currentDate.fullYear,currentDate.month,currentDate.date);
			acDate.setTime(acDate.getTime()+(86400000*days));
			return acDate;
		}
		
		
		public static function findIndex(dataArray:ArrayCollection,prop:String,value:Number):Number{
			var res:Number = -1;
			for(var n:Number = 0;n<dataArray.length;n++){
				if(Number(dataArray[n][prop])==value) {
					res = n;
					break;
				}
			}
			return res;
		}
		
		public static function findLabel(data:ArrayCollection,propIndex:String,labelName:String,index:Number):String{
			var res:String = "";
			for (var n:Number = 0;n<data.length;n++){
				if(data[n][propIndex] == index) {
					res = data[n][labelName];
					break;
				}
			}					
			return res;
		}
		public static function arrayToBase64(data:ArrayCollection):String{
			var byteData:ByteArray = new ByteArray();							
			var encoder:Base64Encoder = new Base64Encoder();
			byteData.writeObject(data);		
			encoder.encodeBytes(byteData)							
			return encoder.toString();
		}
		
		public static function base64ToArray(data:String):ArrayCollection{
			if(data==null) data = "";
			var decoder:Base64Decoder = new Base64Decoder();
			decoder.decode(data);
			var ba:ByteArray = decoder.toByteArray();
			var openData:ArrayCollection = new ArrayCollection();
			while(ba.bytesAvailable){ 
				openData = ba.readObject() as ArrayCollection;
			} 
			return openData;
		}
		
		public static function fillString(orgString:String,char:String,total:Number):String{
			var act:Number = orgString.length;
			var res:String = new String(); 
			for(var n:Number = 0;n<(total-act);n++){
				res += char;
			}
			return res+orgString;
		}
		
		
		public static function setFloatPrecision(val:Number, decimals:uint):Number{ 
			var multiplier:uint = Math.pow(10, decimals); 
			var truncatedVal:Number = Math.round(val*multiplier); 
			
			return truncatedVal/multiplier; 
			
		} 
		
	}
}

