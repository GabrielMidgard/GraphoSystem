package mx.random.forms
{
	import mx.controls.Alert;
	
	public class DataValidator{		

		public var _object:Object; 	
		
		public function DataValidator(){

		}

		public function validate(_class:Object):Boolean{
			var errors:String = new String();
			var validation:Boolean = true;
			
			validation = _class.validate();
			
			if(!_class.validate()){
				for(var n:Number = 0;n<_class.errors.length;n++){
					errors += _class.errors[n].name+"\n";
				}
				Alert.show(errors,"Missing Fields");
			}

			return validation;
		}
		
	}
}