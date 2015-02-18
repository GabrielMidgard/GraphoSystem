package mx.random.dataManagers{
	
	
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.random.converters.Converter;
	import mx.random.constants.SystemGlobals;
	
	
	[Bindable]
	public dynamic class DataManager{

		private var mx_internal_uid:String 	= "";	
		private var _props:Array 			= new Array();
		private var _exceptions:Array 		= new Array();
		private var _ref:Object				= new Object(); 
		private var _excludeAll:Boolean		= false;

		public function DataManager(ref:Object){
			_ref = ref;
		}
		
		public function set exceptions(value:Array):void 	{ _exceptions = value; _exceptions.push("mx_internal_uid"); };
		public function get exceptions():Array 				{ return _exceptions };
		public function set excludeAll(value:Boolean):void	{ _excludeAll = value};
		
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
			if(_excludeAll) return false;
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
					if(className != null){//Whe the control hasn't been created, we don't want to get it's value
						res[_props[n]] = extractValue(_props[n],className).toString();	
					}
				}
			}
			return res;
		}
		
		public function makeDataFromRecord(record:Object):Object{
			var res:Object = new Object();
			for (var n:Number = 0;n<_props.length;n++){
				if(findException(_props[n])){					
					res[_props[n]] = record[_props[n]].toString();
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
				case "RadioButtonGroup":
					res = _ref[prop].selectedValue;
					break;
				case "TextInput":
					res = clearQuotes(_ref[prop].text);
					break;
				case "TextArea":
					res = clearQuotes(_ref[prop].text);
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
				case "ComboBox":
					var item:Object = _ref[prop].selectedItem;
					if(item){
						if(item[prop]){
							res = item[prop];
						}
						else{
							res = _ref[prop].selectedIndex;
						}
					}else{
						res = "";
					}
					break;			
			}
			return res;
		}
		
		
		private function extractExternalValue(prop:String,className:String,ref:Object):String{
			var res:String = "";
			switch(className){
				case "RadioButtonGroup":
					res = _ref[prop].selectedValue;
					break;
				case "TextInput":
					res = clearQuotes(ref[prop].text);
					break;
				case "TextArea":
					res = clearQuotes(ref[prop].text);
					break;				
				case "CheckBox":
					res = ref[prop].selected;
					break;
				case "DateField":
					res = Converter.dateToSQL(ref[prop].selectedDate);
					break;
				case "DateChooser":
					res = Converter.dateToSQL(ref[prop].selectedDate);
					break;
				case "NumericStepper":
					res = _ref[prop].value;
					break;	
				case "ComboBox":
					var item:Object = ref[prop].selectedItem;
					if(item){
						if(item[prop]){
							res = item[prop];
						}else{
							res = ref[prop].selectedIndex;
						}
					}else{
						res = "";
					}
					break;			
			}
			return res;
		}
		
		private function putValue(prop:String,className:String):void{
			
			switch(className){
				case "RadioButtonGroup":
					_ref[prop].selectedValue = this[prop];
					break;
				case "TextInput":
					_ref[prop].text = this[prop];
					break;
				case "TextArea":
					_ref[prop].text = this[prop];
					break;
				case "ComboBox":
					var index:Number = findIndex(prop,Number(this[prop]),_ref[prop].dataProvider);
					if(index!=-1){
						_ref[prop].selectedIndex = index;
					}else{
						_ref[prop].selectedIndex = new Number(this[prop]);
					}
					
					break;
				case "CheckBox":
					_ref[prop].selected = Converter.bool(this[prop]);
					break;
				case "DateField":					
					_ref[prop].formatString = SystemGlobals.userDateFormat
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
		
		private function findIndex(prop:String,value:Number,data:Object):Number{
			var res:Number = -1;
			var list:ArrayCollection = Converter.arrayConverter(data);
				for(var n:Number = 0;n<list.length;n++){
					if(list[n]){ 
						if(list[n][prop]==value) res = n;
					}else{
						trace("--> comboBox "+prop+": Dataprovider Error!")
					}				
				}
			return res;
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
					_ref[prop].text = "";
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
		
		public function createFieldsFromArray(data:Array):void{
			_props = new Array();
			for(var n:Number = 0;n<data.length;n++){				
				var propertyName:String = data[n];
				this[propertyName] = "";
				if(findException(propertyName)) _props.push(propertyName);
			}
		}		
		
	}
}