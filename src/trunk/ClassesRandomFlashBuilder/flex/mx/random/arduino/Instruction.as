package mx.random.arduino
{
	public class Instruction{
		
		public var instructionArray:Array = new Array();
		
		public function Instruction(){
		}
		
		public function addValue(value:*):void{
			instructionArray.push(value);
		}
		
		public function addValueAt(value:*,index:Number):void{
			instructionArray[index]= value;
		}
		
		public function clear():void{
			instructionArray = new Array();
		}
		
		
	}
}