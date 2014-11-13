package mx.random.encoders{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.utils.Base64Decoder;
	import mx.utils.Base64Encoder;
	
	public class Base64Tools{
		
		
		private var x:ByteArray = new ByteArray();
		
		public function Base64Tools(){
		}


		public static function encode64(data:*):String{
			var byteData:ByteArray = new ByteArray();
			var encoder:Base64Encoder = new Base64Encoder();
			byteData.writeObject(data);			
			byteData.position = 0;
			//encoder.encodeBytes(byteData);
			return encoder.toString();
		}
		
		public static function decode64(data:String):ByteArray{
			var decoder:Base64Decoder = new Base64Decoder();
			decoder.decode(data);
			return decoder.toByteArray();			
		}
		
		public static function decode64String(data:String):String{
			var decoder:Base64Decoder = new Base64Decoder();
			decoder.decode(data);
			var ba:ByteArray =  decoder.toByteArray();
			return ba.readUTFBytes(ba.bytesAvailable);
		}
		
		public static function base64ToArrayCollection(data:String):ArrayCollection{
			var dataArray:ByteArray = Base64Tools.decode64(data);
			var openData:ArrayCollection = new ArrayCollection();
			 while(dataArray.bytesAvailable){ 
            	openData = dataArray.readObject() as ArrayCollection;
         	 } 
         	 return openData;
		}
		
		public static function arrayCollectionToBase64(data:ArrayCollection):String{
			var byteData:ByteArray = new ByteArray();
			var encoder:Base64Encoder = new Base64Encoder();
			byteData.writeObject(data);			
			byteData.position = 0;
			//encoder.encodeBytes(byteData as ByteArray);
			return encoder.toString();
		}
		
		
	}
}