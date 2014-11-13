package mx.random.forms{
	import mx.collections.ArrayCollection;
	

	public class FormValidator {
		
		public function FormValidator():void{
		}
		
		
		
		public function validate(fieldData:ArrayCollection,ref:Object):ArrayCollection{
			var errors:ArrayCollection = new ArrayCollection();
			var n:Number = 0;
			
			for(n=0;n<fieldData.length;n++){
				if(fieldData[n].required){
					switch(fieldData[n].type){
						case "S":
							if(ref[fieldData[n].field] == ""){
								errors.addItem({name:fieldData[n].name});
							}else{
								if(ref[fieldData[n].field].length < fieldData[n].minChars){
									errors.addItem({name:fieldData[n].name+" too short"});
								}
							}
							break;
						case "C":
							if(ref[fieldData[n].field] == 0){
								errors.addItem({name:fieldData[n].name});
							};
							break;
						case "N":
							if(!ref[fieldData[n].field]){
								errors.addItem({name:fieldData[n].name});
							}else{
								
								if(ref[fieldData[n].field].toString().length < fieldData[n].minChars){
									errors.addItem({name:fieldData[n].name+" too short"});
								}
							}
							break;
						case "M":
							if(!ref[fieldData[n].field]){
								errors.addItem({name:fieldData[n].name});
							}else{
								if(!validateMail(ref[fieldData[n].field])){
									errors.addItem({name:fieldData[n].name+" Invalid"});
								};
							}
							break;
						case "V":
							if(!ref[fieldData[n].field]){
								errors.addItem({name:fieldData[n].name});
							};
							break;
						case "CB":
							if(ref[fieldData[n].field]){
								errors.addItem({name:fieldData[n].name});
							};
							break;
					}
				}
			}
			
			return errors;
		}
		
		
		
		public function validateNumber(number:String):Object{
			var _vlidation:Boolean = false;
			var _error:String = "";
			
			var res:Object = {field:"",validation:false,error:""};
			
			if(int(number)==0){
				number="Invalid Number";
			} 
			return res;
		}
		
		
		
		public function validateMail(mail:String):Object {
			
			var emailBool:Boolean = false;
			var _error:String = "";
			var res:Object = {validation:false,error:""};
			
			if (mail.indexOf("@") == -1 || mail.indexOf("@") == 0) {
				emailBool = false;
				_error = "Incorrect E-Mail";
			} else {
				emailBool = true;
				if (mail.lastIndexOf(".") == -1 || mail.lastIndexOf(".") == mail.length-1) {
					emailBool = false;
					_error = "Incorrect E-Mail";
				} else {
					emailBool = true;
					if (mail.lastIndexOf(".") < mail.indexOf("@")  || mail.lastIndexOf(".") == mail.indexOf("@")+1 ) {
						emailBool = false;
						_error = "Incorrect E-Mail";
					} else {
						emailBool = true;
						for (var i:Number = 0; i < mail.length; i++) {
							if (mail.charAt(i) == " ") {
								emailBool = false;
								_error = "Incorrect E-Mail";
							}
						}
					}
				}
			}
			res._error 			= _error;
			res._validation 	= emailBool;
			
			return emailBool;
		}
	}
}