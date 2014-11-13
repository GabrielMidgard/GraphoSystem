package mx.random.forms
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.events.ValidationResultEvent;
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;
	import mx.formatters.PhoneFormatter;
	import mx.random.constants.Languages;
	import mx.validators.CreditCardValidator;
	import mx.validators.DateValidator;
	import mx.validators.EmailValidator;
	import mx.validators.NumberValidator;
	import mx.validators.PhoneNumberValidator;
	import mx.validators.StringValidator;
	
	public class Validator{
		
		private static var _phoneFormatString:String 		= "(###) ###-####"//"(###) ###-####";
		private static var _expirationFormatString:String  	= "MM/YYYY";
		private static var _dateFormatString:String  		= "DD/MM/YYYY";
		private static var _numberFormatString:String  		= "# ### ###.##";
				
		private static var validCC:CreditCardValidator 	= new CreditCardValidator();
		private static var validEM:EmailValidator 		= new EmailValidator();
		private static var validPN:PhoneNumberValidator = new PhoneNumberValidator();
		private static var validNV:NumberValidator 		= new NumberValidator();
		private static var validED:DateValidator 		= new DateValidator();
		private static var validST:StringValidator 		= new StringValidator();
		private static var validCB:ComboValidator		= new ComboValidator();
		
		public static const STRING_VAL:String 		= "string_val";
		public static const MAIL_VAL:String 		= "mail_val";
		public static const COMBO_VAL:String 		= "combo_val";
		public static const NUMBER_VAL:String 		= "number_val";
		public static const PHONE_VAL:String 		= "phone_val";
		public static const DATE_VAL:String 		= "date_val";
		public static const EXPIRATION_VAL:String 	= "expiration_val";
		public static const CREDITCARD_VAL:String 	= "creditcard_val";
		public static const SOME_REQUIRED:String	= "some_required";
		public static const SOME_EQUAL:String		= "some_equal";
		
		public static const CIRCLE_KNOT:String 		= "circle_knot";
		public static const SQUARE_KNOT:String 		= "square_knot";
		public static const ARROR_KNOT:String 		= "arrow_knot";
		
		private var _fields:ArrayCollection = new ArrayCollection();
		private var _knotType:String = CIRCLE_KNOT;
		private var _knotColor:uint = 0xFF0000;
		public var newData:Boolean = false;
		public var errors:String = "";
		public var errorsRequired:String = "";
		public var errorsEqual:String = "";
		
		private   var _someRequired:ArrayCollection = new ArrayCollection();
		private   var _someEqual:ArrayCollection = new ArrayCollection();
		
		
		public function get validFields():ArrayCollection{
			return _fields;
		}
		
		public function Validator(){
			_fields = new ArrayCollection();
		}

		public function setErrorKnot(type:String,color:uint = 0xFF0000):void{
			_knotType 	= type;
			_knotColor	= color;
		}

		public function addStringVal(o:UIComponent,min:Number = 0,max:Number = 255,errorName:String = ""):void{
			_fields.addItem({obj:o,type:STRING_VAL,params:{min:min,max:max,errorName:errorName}});
			addListeners(o);
		}
		
		public function addDateVal(o:UIComponent,string:Boolean=true,errorName:String = ""):void{
			_fields.addItem({obj:o,type:DATE_VAL,params:{string:string,errorName:errorName}});
			addListeners(o);
		}
		
		public function addMailVal(o:UIComponent,required:Boolean = false,errorName:String = ""):void{
			_fields.addItem({obj:o,type:MAIL_VAL,params:{errorName:errorName,required:required}});
			addListeners(o);
		}
		
		public function addNumberVal(o:UIComponent,format:Boolean = false,errorName:String = ""):void{
			_fields.addItem({obj:o,type:NUMBER_VAL,params:{format:format,errorName:errorName}});
			addListeners(o);
		}
		
		public function addPhoneVal(o:UIComponent,format:Boolean,required:Boolean = true,errorName:String = ""):void{
			o["maxChars"] = _phoneFormatString.length;
			_fields.addItem({obj:o,type:PHONE_VAL,params:{format:format,required:required,errorName:errorName}});
			addListeners(o);
		}
		
		public function addCreidtCardVal(o:UIComponent,cardType:UIComponent,cardTypeProperty:String,isCombo:Boolean = true,errorName:String = ""):void{
			_fields.addItem({obj:o,type:CREDITCARD_VAL,params:{cardType:cardType,cardTypeProperty:cardTypeProperty,isCombo:isCombo,errorName:errorName}});
			addListeners(o);
		}
		
		public function addExpirationVal(o:UIComponent,format:Boolean,errorName:String = ""):void{
			_fields.addItem({obj:o,type:EXPIRATION_VAL,params:{format:format,errorName:errorName}});
			addListeners(o);
		}
		
		/*
		public function addSomeRequired(o:UIComponent,errorName:String = ""):void{			
			_someRequired.push({obj:o,type:SOME_REQUIRED,params:{errorName:errorName}});
			addListeners(o);
		}*/
		
		public function addSomeEquals(firsObject:UIComponent,secondObject:UIComponent,errorName:String = "",equal:Boolean = false):void{				
			_someEqual.addItem({firstObject:firsObject,secondObject:secondObject,errorName:errorName,equal:equal});
		}
		
		public function addSomeRequired(os:Array,errorName:String = ""):void{	
			var someRequiredGroup:Array= new Array();	
			for(var n:Number=0;n<os.length;n++){	
				someRequiredGroup.push({obj:os[n]});
				addListeners(os[n]);
			}
			_someRequired.addItem({os:someRequiredGroup,type:SOME_REQUIRED,params:{errorName:errorName}});
		}
		
		public function addObject(o:UIComponent,type:String,params:Object = null,errorName:String = ""):void{
			_fields.addItem({obj:o,type:type,params:params});
			addListeners(o);
		}
		
		public function addComboVal(o:UIComponent,errorName:String = ""):void{
			_fields.addItem({obj:o,type:COMBO_VAL,params:{errorName:errorName}});
			addListeners(o);
		}
		
		private function addListeners(o:UIComponent):void{
			o.addEventListener(ValidationResultEvent.VALID,updateSkin);
			o.addEventListener(ValidationResultEvent.INVALID,updateSkin);
		}
		
		public function validateAll():Boolean{
			//removeKnots();
			errors = "▪ Faltan Campos Requeridos :\n";
			var res:Boolean = true;	
			var req:Boolean = checkRequired();	
			var equ:Boolean = checkEquals();	
			for(var n:Number = 0;n<_fields.length;n++){
				switch(_fields[n].type){
					case STRING_VAL:
						if(!stringVal(_fields[n].obj,_fields[n].params.min,_fields[n].params.max)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						
						break;
					case PHONE_VAL:
						if(!phoneVal(_fields[n].obj,_fields[n].params.format,_fields[n].params.required)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;
					case EXPIRATION_VAL:
						if(!expiratonDateVal(_fields[n].obj,_fields[n].params.format)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;
					case MAIL_VAL:
						if(!mailVal(_fields[n].obj,_fields[n].params.required)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;
					case NUMBER_VAL:
						if(!numberVal(_fields[n].obj,_fields[n].params.format)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;
					case COMBO_VAL:
						if(!comboVal(_fields[n].obj)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;					
					case CREDITCARD_VAL:
						if(!cardVal(_fields[n].obj,_fields[n].params.cardType,_fields[n].params.cardTypeProperty,_fields[n].params.isCombo)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;
					case DATE_VAL:
						if(!dateVal(_fields[n].obj,_fields[n].params.string)) {
							res = false;
							if(_fields[n].params.errorName!="") errors += "  - "+_fields[n].params.errorName+"\n";
						}
						break;					
				}				
			}
			res = res&&req&&equ;
			if(errorsRequired!=""){
				errors += "▪ Agluno de estos campos :"+"\n"+errorsRequired;
			}
			if(errorsEqual!=""){
				errors += "▪ Campos con Errores :"+"\n"+errorsEqual;
			}
			return res;
		}
		
		public function validateOne(o:String):Boolean{
			//removeKnots();
			var res:Boolean = true;
			var _field:Object = findItem(o);
			var req:Boolean = checkRequired();
			switch(_field.type){
				case STRING_VAL:
					if(!stringVal(_field.obj,_field.params.min,_field.params.max)) res = false;
					break;
				case PHONE_VAL:
					if(!phoneVal(_field.obj,_field.params.format)) res = false;					
					break;
				case EXPIRATION_VAL:
					if(!expiratonDateVal(_field.obj,_field.params.format)) res = false;
					break;
				case MAIL_VAL:
					if(!mailVal(_field.obj)) res = false;
					break;
				case NUMBER_VAL:
					if(!numberVal(_field.obj,_field.params.format)) res = false;
					break;
				case COMBO_VAL:
					if(!comboVal(_field.obj)) res = false;
					break;				
				case CREDITCARD_VAL:
					if(!cardVal(_field.obj,_field.params.cardType,_field.params.cardTypeProperty,_field.params.isCombo)) res = false;
					break;
				case DATE_VAL:
					if(!dateVal(_field.obj,_field.params.string)) res = false;
					break;				
			}			
			res = res&&req;
			
			return res;
		}
		
		
		private function checkRequired():Boolean{			
			var res:Boolean = false;
			var resSum:Number = 0;			
			removeRequiredKnots(-1);
			errorsRequired = "";
			
			for(var h:Number = 0;h<_someRequired.length;h++){
				var someRequired:Array = _someRequired[h].os;
				var req:Boolean = false;
				var checked:Number = 0;
				for(var m:Number = 0;m<someRequired.length;m++){				
					if(someRequired[m].obj.text!="") {					
						req = true;						
						checked++;
					}					
					addRequiredKnot(someRequired[m].obj);										
				}
				if(checked>0) resSum++;	
				if(req){
					removeRequiredKnots(h);
				}else{					
					errorsRequired += 	"  - "+_someRequired[h].params.errorName+"\n";	
				}
			}
			
			if(resSum==_someRequired.length) res = true;			
			return res;
		}
		
		private function checkEquals():Boolean{
			var res:Boolean = true;
			errorsEqual = "";
			for(var n:Number=0;n<_someEqual.length;n++){
				if(_someEqual[n].firstObject.text != ""&& _someEqual[n].secondObject.text!= ""){
					if(!_someEqual[n].equal){					
						if(_someEqual[n].firstObject.text != _someEqual[n].secondObject.text){
							res = false;
							errorsEqual += 	"  - "+_someEqual[n].errorName+"\n";	
						}
					}else{
						if(_someEqual[n].firstObject.text == _someEqual[n].secondObject.text){
							res = false;
							errorsEqual += 	"  - "+_someEqual[n].errorName+"\n";	
						}					
					}
				}
			}
			return res;
		}
		
		
		/*private function checkRequired():Boolean{
			var req:Boolean = false;
			removeRequiredKnots();
			errorsRequired = "";
			for(var m:Number = 0;m<_someRequired.length;m++){				
				if(_someRequired[m].obj.text!="") {					
					req = true	
							
				}	
				addRequiredKnot(_someRequired[m].obj);										
			}
			if(req){
				removeRequiredKnots();
			}else{
				for(var n:Number = 0;n<_someRequired.length;n++){
					errorsRequired += 	"  - "+_someRequired[n].params.errorName+"\n";	
				}
			}
			return req;
		}*/
		
		public function findItem(o:String):Object{
			var res:Object;
			for(var n:Number = 0;n<_fields.length;n++){
				if(o==_fields[n].obj.name) res = _fields[n];
			}
			return res;
		}
		
		public function removeRequiredKnots(group:Number):void{
			if(group==-1){
				for(var n:Number = 0;n<_fields.length;n++){						
					if(_fields[n].obj.getChildByName("RK")) _fields[n].obj.removeChild(_fields[n].obj.getChildByName("RK"));				
				}
			}else{
				var fields:Array = _someRequired[group].os;
				for(var n:Number = 0;n<fields.length;n++){						
					if(fields[n].obj.getChildByName("RK")) fields[n].obj.removeChild(fields[n].obj.getChildByName("RK"));				
				}
			}
		}
		
		public function removeAllKnots():void{
			removeRequiredKnots(-1);
			for(var n:Number = 0;n<_fields.length;n++){										
				if(_fields[n].obj.getChildByName("EK")) _fields[n].obj.removeChild(_fields[n].obj.getChildByName("EK"));
			}
		}
		
		public   function updateSkin(e:Event):void{
			var ekRef:Object = e.currentTarget.getChildByName("EK");
       		if(ekRef) e.currentTarget.removeChild(ekRef);
       		
			switch(e.type){
       			case ValidationResultEvent.VALID:
       				//e.currentTarget.setStyle('borderSkin',e.currentTarget.getStyle('normalSkin'));
       				addErrorKnot(e.currentTarget,true);
       				break;
       			case ValidationResultEvent.INVALID:
       				addErrorKnot(e.currentTarget);
       				//e.currentTarget.setStyle('borderSkin',e.currentTarget.getStyle('errorSkin'));
       				break;
       		}
		}
		
		private   function addRequiredKnot(o:Object):void{
			var rk:MovieClip = new MovieClip();
			rk = ErrorKnot.getCircleKnot(0x000FF);
			rk.name = "RK";
   			rk.x = o.width+5;
   			rk.y = (o.height/2);
   			o.addChild(rk);
		}
		
		private   function addErrorKnot(o:Object,ok:Boolean = false,req:Boolean = false):void{
			var ek:MovieClip = new MovieClip();
			switch(_knotType){
				case CIRCLE_KNOT:
					ek = ErrorKnot.getCircleKnot(_knotColor);
					break;
				case SQUARE_KNOT:
					ek = ErrorKnot.getSquareKnot(_knotColor);
					break;
				case ARROR_KNOT:
					ek = ErrorKnot.getArrowKnot(_knotColor);
					break;
			}
			if(req){
				//ek = ErrorKnot.getCircleKnot(0x000FF);
			}			
			if(ok){
				ek = ErrorKnot.getCircleKnot(0x00FF00);
			}
			
			
			ek.name = "EK";
   			ek.x = o.width+5;
   			ek.y = (o.height/2);
   			o.addChild(ek);
		}

		public   function changeLanguage(language:String):void{
			switch(language){
				case Languages.ENGLISH:
					validCC = new CreditCardValidator();
					validEM = new EmailValidator();
					validPN = new PhoneNumberValidator();
					validNV = new NumberValidator();
					validST = new StringValidator();
					break;
				case Languages.SPANISH:
					validCC.invalidCharError 	= "Caracteres inválidos en el número de tarjeta (Ingrese sólo números)";
					validCC.invalidNumberError 	= "El número de tarjeta es inválido";
					validCC.noNumError			= "No se ha ingresado nungún numero";
					validCC.noTypeError			= "No se ha especificado el tipo de tarjeta o el tipo es inválido";
					validCC.wrongLengthError	= "El número de tarjeta de crédito tiene un número inválido de digitos";
					validCC.wrongTypeError		= "El tipo de tarjeta de crédito es incorrecto";
					
					validPN.wrongLengthError	= "Número inválido";
					break;
			}
			
		}

		public   function mailVal(o:Object,required:Boolean = false):Boolean{
			validEM.source = o;
			validEM.property = "text";
			validEM.required = required;
			if(validEM.validate().type == "valid"){
				return true;
		 	} 
		 	return false;
		}
		
		public   function comboVal(o:Object):Boolean{
			validCB.source = o;
			validCB.property = "selectedIndex";
			validCB.required = true;
			if(validCB.validate().type == "valid"){
				return true;
		 	} 
		 	return false;
		}
		
		public   function phoneVal(o:Object,format:Boolean = false,required:Boolean = false):Boolean{
			validPN.source = o;
			validPN.property = "text";
			validPN.required = required;
			
			var tempPhone:String = o["text"];
			var myPattern:RegExp = /[^0-9]/g;
			
			o["text"] = tempPhone.replace(myPattern,"");
		 	if(validPN.validate().type == "valid"&&format){
		 		o["text"] = phoneFormat(o["text"]);
		 		if(o["text"]=="") {		 		
			 		o["text"] = tempPhone.replace(myPattern,"");			 					 		
		 		}
		 		o.setSelection(o["text"].length,o["text"].length);
		 		return true;		 	
		 	}
		 	return false;
		}
		
		public   function phoneFormat(phone:String):String{
			var form:PhoneFormatter = new PhoneFormatter();
			form.formatString 		= _phoneFormatString;
			return form.format(phone);
		}
		
		public   function numberVal(o:Object,format:Boolean = false):Boolean{
			validNV.source = o;
			validNV.property = "text";
			validNV.required = true;
			
			var tempNumber:String = o["text"];
			var validChars:RegExp = /[^0-9 ^.]/g;
			o["text"] = tempNumber.replace(validChars,"");
			
			if(Number(o["text"])!=0&&format){
				o["text"] = numberFormat(o["text"]);
				return true;
		 	} 
		 	return false;
		}
		
		public   function numberFormat(number:String):String{
			var form:NumberFormatter = new NumberFormatter();			
			form.decimalSeparatorFrom = ".";
			form.decimalSeparatorTo = ".";
			form.precision = 2;
			form.thousandsSeparatorFrom = ",";
			form.thousandsSeparatorTo  = ",";
			form.useThousandsSeparator = true;
			form.useNegativeSign = true;
			return form.format(number);
		}

		public   function stringVal(o:Object,min:Number=0,max:Number=255):Boolean{
			validST.source = o;
			validST.property = "text";
			validST.required = true;
			validST.maxLength = max;
			validST.minLength = min;
			if(validST.validate().type == "valid"){
				return true;
		 	} 
		 	return false;
		}
		
		public   function dateVal(o:Object,string:Boolean=true):Boolean{
			validST.source = o;
			validST.property = "text";
			validST.required = true;			
			if(validST.validate().type == "valid"){
				return true;
		 	} 
		 	return false;
		}
		
		public   function expiratonDateVal(o:Object,format:Boolean = false):Boolean{
			validED.source = o;
			validED.property = "text";
			validED.required = true;
			validED.inputFormat = _expirationFormatString;
			validED.allowedFormatChars = "/- ";
			if(validED.validate().type == "valid"&&format){
		 		o["text"] = dateFormat(o["text"]);
		 		return true;
		 	} 
		 	return false;
		}
		
		public   function dateFormat(date:String):String{
			var form:DateFormatter = new DateFormatter();
			form.formatString 		= _expirationFormatString;
			return form.format(date);
		}
		
		
		
		public   function cardVal(o:Object,cardType:Object,cardTypeProperty:String,isCombo:Boolean = true):Boolean{
			validCC.cardNumberSource = o;
			validCC.cardNumberProperty = "text";
			validCC.cardTypeProperty = cardTypeProperty;
			validCC.required = true;
			if(isCombo){
				validCC.cardTypeSource = cardType.selectedItem;
			}else{
				validCC.cardTypeSource = cardType["text"];
			}
			if(validCC.validate().type == "valid"){
				return true;
		 	} 
		 	return false;
		}
		
		

	}
}