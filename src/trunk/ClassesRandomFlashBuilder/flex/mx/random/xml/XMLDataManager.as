package mx.random.xml{
	import flash.xml.XMLDocument;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.xml.SimpleXMLDecoder;
	import mx.utils.ArrayUtil;
	
	public class XMLDataManager{
		public function XMLDataManager(){
		}
		
		public static function getAtributes(list:XMLList):Object{
			var uData:Object = new Object();
			for (var n:Number=0;n<list.length();n++){				
				uData[list[n].name().toString()] = list[n].toString();
			}
			return uData;
		}
		
		public static function populate(ref:Object,data:Object):void{
			for( var p:String in data){
				if(ref.hasOwnProperty(p)){
					ref[p] = data[p];
				}
			}
		}
		
		public static function getItems(list:XMLList):ArrayCollection{
			var item:XML;
			var arrayData:ArrayCollection = new ArrayCollection();
			for each(item in list) {
            	arrayData.addItem({nombre:item.name().localName,xmlData:new XML(item)});
        	} 
        	return arrayData;
		}
		
		public static function getAtributesByName(nodeName:String,list:ArrayCollection):Object{
			var xmlList:XMLList;
			var xml:XML;
			for(var n:Number = 0;n<list.length;n++){
				if(list[n].nombre == nodeName) {
					xml = new XML(list[n].xmlData);
					xmlList = new XMLList(xml.attributes());
					break;
				}
			}			
			return XMLDataManager.getAtributes(xmlList);
		}
		
		public static function findItemIndex(nodeName:String,list:ArrayCollection):Number{
			var res:Number = -1;			
			for(var n:Number = 0;n<list.length;n++){
				if(list[n].nombre == nodeName) {
					res = n;
					break;
				}
			}			
			return res;
		}
		
		public static function getItemsByName(nodeName:String,list:ArrayCollection):ArrayCollection{
			var xmlList:XMLList;
			var xml:XML;
			for(var n:Number = 0;n<list.length;n++){
				if(list[n].nombre == nodeName) {
					xml = new XML(list[n].xmlData);
					xmlList = new XMLList(xml.attributes());
					break;
				}
			}			
			return XMLDataManager.getItems(xmlList);
		}
		
		public static function convertItemsToArrayCollection(list:ArrayCollection):ArrayCollection{
			var xmlList:XMLList;
			var xml:XML;
			var resArray:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0;n<list.length;n++){
				var data:Object = new Object();		
				xml = new XML(list[n].xmlData);
				xmlList = new XMLList(xml.attributes());
				resArray.addItem(XMLDataManager.getAtributes(xmlList));
			}			
			return resArray;
		}
		
		
		public static function convertXmlToArrayCollection( file:String ):ArrayCollection{
			var xml:XMLDocument = new XMLDocument( file );
			
			var decoder:SimpleXMLDecoder = new SimpleXMLDecoder();
			var data:Object = decoder.decodeXML( xml );
			var array:Array = ArrayUtil.toArray( data.rows.row );
			
			return new ArrayCollection( array );
		}

		
		


	}
}