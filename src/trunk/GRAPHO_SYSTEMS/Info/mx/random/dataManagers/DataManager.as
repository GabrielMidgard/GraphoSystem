package mx.random.dataManagers{
	
	
	import flash.events.FocusEvent;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.random.cms.converters.Converter;
	
	
	[Bindable]
	public dynamic class DataManager{

		private var mx_internal_uid:String 	= "";	
		private var _props:Array 			= new Array();
		private var _exceptions:Array 		= new Array();
		private var _ref:Object				= new Object(); 

		public function DataManager(ref:Object){
			_ref = ref;
		}
		
		public function set exceptions(value:Array):void 	{ _exceptions = value; _exceptions.push("mx_internal_uid"); };
		public function get exceptions():Array 				{ return _exceptions };
		
		public function getProperty(propName:String):String{	return this[propName];	}
		
		public function loadData(record:Object=null):void{
			for (var p:String in record){ 
				var propertyName:String = p;
				this[propertyName] = record[p];	
						
				if(!findException(propertyName)){
					_props.push(propertyName);
				}else{
					var className:String = getQualifiedClassName(_ref[propertyName]);
					var classType:Array = className.split("::");
					className = classType[1];
					putValue(propertyName,className);
				}
				
			}
		}

		public function findException(propertyName:String):Boolean{
			for (var n:Number = 0;n<_exceptions.length;n++){
				if(_exceptions[n]==propertyName){
					return false
				}
			}
			return true;
		}
		
		
		
		
		public function makeData():Object{
			var res:Object = new Object();
			for (var n:Number = 0;n<_props.length;n++){
				if(findException(_props[n])){
					var className:String = getQualifiedClassName(_ref[_props[n]]);
					var classType:Array = className.split("::");
					className = classType[1];
					res[_props[n]] = extractValue(_props[n],className).toString();
				}
			}
			return res;
		}
		
		public function clear():void{
			var res:Object = new Object();
			for (var n:Number = 0;n<_props.length;n++){
				if(findException(_props[n])){
					var className:String = getQualifiedClassName(_ref[_props[n]]);
					var classType:Array = className.split("::");
					className = classType[1];
					clearData(_props[n],className);
				}
			}			
		}
		
		public function clearQuotes(text:String):String{
			return Converter.strReplace("'",'"',text); 
		}
		
		private function extractValue(prop:String,className:String):String{
			var res:String = "";
			switch(className){
				case "TextInput":
					res = clearQuotes(_ref[prop].text);
					break;
				case "TextArea":
					res = clearQuotes(_ref[prop].text);
					break;
				case "ComboBox":
					res = _ref[prop].selectedIndex;
					break;
				case "CheckBox":
					res = _ref[prop].selected;
					break;
				case "DateField":
					res = Converter.dateToSQL(_ref[prop].selectedDate);
					break;
				case "DateChooser":
					res = Converter.dateToSQL(_ref[prop].selectedDate);
					break;
				case "NumericStepper":
					res = _ref[prop].value;
					break;				
			}
			return res;
		}
		
		private function putValue(prop:String,className:String):void{
			switch(className){
				case "TextInput":
					_ref[prop].text = this[prop];
					break;
				case "TextArea":
					_ref[prop].text = this[prop];
					break;
				case "ComboBox":
					_ref[prop].selectedIndex = new Number(this[prop]);
					break;
				case "CheckBox":
					_ref[prop].selected = Converter.bool(this[prop]);
					break;
				case "DateField":
					_ref[prop].text = Converter.systemToViewDate(this[prop]);
					_ref[prop].selectedDate = Converter.convertDate(this[prop]);
					break;
				case "DateChooser":
					_ref[prop].selectedDate = Converter.convertDate(this[prop]);
					break;
				case "NumericStepper":
					_ref[prop].value = new Number(this[prop]);
					break;
					
			}
		}
		
		private function clearData(prop:String,className:String):void{
			switch(className){
				case "TextInput":
					_ref[prop].text = "";
					break;
				case "TextArea":
					_ref[prop].text = "";
					break;
				case "ComboBox":
					_ref[prop].selectedIndex = 0;
					break;
				case "CheckBox":
					_ref[prop].selected = false;
					break;
				case "DateField":
					//_ref[prop].text = "";
					_ref[prop].selectedDate = new Date();
					break;
				case "DateChooser":
					_ref[prop].selectedDate = new Date();
					break;
				case "NumericStepper":
					_ref[prop].value = 0;
					break;
					
			}
		}
				
		public function createFields(data:ArrayCollection):void{
			_props = new Array();
			for(var n:Number = 0;n<data.length;n++){				
				var propertyName:String = data[n].COLUMN_NAME;;
				this[propertyName] = "";				
				if(findException(propertyName)) _props.push(propertyName);
			}
		}		
		
	}
}