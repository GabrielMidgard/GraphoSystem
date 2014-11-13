package mx.random.tools
{
	import com.as3xls.xls.Cell;
	import com.as3xls.xls.Sheet;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	
	public class ExcelTools
	{
		public function ExcelTools(){
		}
		
		
		public static function loadRecords(sheet:Sheet,fields:Array):ArrayCollection{
				var rows:Number = sheet.rows;
				var cols:Number = sheet.cols;
				var result:ArrayCollection = new ArrayCollection();
				
				if(cols!=fields.length){ 
					Alert.show("Las número de columnas no coinciden","Formato inválido");
				}else{
					for(var row:Number=1;row<rows;row++){
						var rowData:Object = new Object();
						for(var col:Number=0;col<cols;col++){
							var cell:Cell = sheet.getCell(row,col);							
							if(cell.value.hasOwnProperty("day")) {								
								rowData[fields[col]] = ExcelTools.convertDate(cell);
							}else{
								rowData[fields[col]] = cell.toString();
							}
						}
						result.addItem(rowData);
					}
				}
				return result;
			}
			
			private static function convertDate(fecha:Cell):String{
				var year:Number 	= Number(fecha.value["fullYear"]);
				var month:Number 	= Number(fecha.value["month"]);
				var day:Number 		= Number(fecha.value["date"]); 
				
				day--;
				if(day<1){
					month--;
					if(month<0){
						month = 11;
						year--;
					}
					day = ExcelTools.getDayCount(year,month);
				}
				
				var res:String = year+"-"+fillZero(month+1)+"-"+fillZero(day)				
				return res;
			}
			
			private static function fillZero(num:Number):String{
				var res:String = num.toString()
				if(num<10) res = "0"+res;
				return res; 
			}
			
			private static function getDayCount(year:Number, month:Number):Number{ 
				var d:Date=new Date(year, month+1, 0); 
				return d.getDate();
			}
		
		

	}
}