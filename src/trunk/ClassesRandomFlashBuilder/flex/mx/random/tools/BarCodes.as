package mx.random.tools{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.random.converters.Converter;
	
	[Bindable]
	public class BarCodes extends EventDispatcher{
		
		
		public static const BC_TYPE_CODE39:Number       = 1;
		public static const BC_TYPE_INTER25:Number      = 2;
		public static const BC_TYPE_STD25:Number        = 3;
		public static const BC_TYPE_CODE93:Number       = 4;
		public static const BC_TYPE_ROYMAIL4:Number     = 5;
		public static const BC_TYPE_POSTNET:Number      = 6;
		
		public function set context(contextObj:Object):void{
			for( var p:String in contextObj){
				if(this.hasOwnProperty(p)){
					this[p] = contextObj[p];
				}
			}			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public var bcTypes:ArrayCollection = new ArrayCollection([
			{value:BC_TYPE_CODE39,label:"Code 39"},
			{value:BC_TYPE_INTER25,label:"Inter 25"},
			{value:BC_TYPE_STD25,label:"Std 25"},
			{value:BC_TYPE_CODE93,label:"Code 93"},
			{value:BC_TYPE_ROYMAIL4,label:"Royal Mail 4"},
			{value:BC_TYPE_POSTNET,label:"Post Net"}			
		]);
	
		public static const BC_IMG_TYPE_PNG:Number      = 1;
		public static const BC_IMG_TYPE_JPG:Number      = 2;
		public static const BC_IMG_TYPE_GIF:Number      = 3;
		public static const BC_IMG_TYPE_WBMP:Number     = 4;
		
		public var imgTypes:ArrayCollection = new ArrayCollection([
			{value:BC_IMG_TYPE_PNG,label:"PNG",ext:".png"},
			{value:BC_IMG_TYPE_JPG,label:"JPG",ext:".jpg"},
			{value:BC_IMG_TYPE_GIF,label:"GIF",ext:".gif"},
			{value:BC_IMG_TYPE_WBMP,label:"BMP",ext:".bmp"}			
		]);
	
		public static const BC_ROTATE_0:Number          = 0;
		public static const BC_ROTATE_90:Number         = 1;
		public static const BC_ROTATE_180:Number        = 2;
		public static const BC_ROTATE_270:Number        = 3;
		
		public var rotationTypes:ArrayCollection = new ArrayCollection([
			{value:BC_ROTATE_0,		label:"  0 Grados"},
			{value:BC_ROTATE_90,	label:" 90 Grados"},
			{value:BC_ROTATE_180,	label:"180 Grados"},
			{value:BC_ROTATE_270,	label:"270 Grados"}			
		]);
		
		private var _BC_TYPE:Number 			= 1;
		private var _BC_IMG:Number 				= 2;
		private var _BC_ROTATE:Number 			= 0;
		private var _BC_DIM:Number 				= 1;          
        private var _BC_FACT:Number 			= 3;         
        private var _BC_GAP:Number 				= 1;          
        private var _BC_INVERT:String			= "FALSE";       
        private var _BC_HT:Number 				= 50;                   
        private var _BC_LABEL:String			= "TRUE";                       
        private var _BC_CHKD:String				= "FALSE";      
        private var _BC_FILE:String				= "TRUE";
		
		public function BarCodes(){
		}
		
		public function set bcType(value:Number):void 		{ _BC_TYPE 		= value } ;
		public function set bcImageType(value:Number):void 	{ _BC_IMG 		= value } ;
		public function set bcRotate(value:Number):void 	{ _BC_ROTATE 	= value } ;		
		public function set bcDimention(value:Number):void 	{ _BC_DIM 		= value } ;
		public function set bcScaleFactor(value:Number):void{ _BC_FACT 		= value } ;
		public function set bcGap(value:Number):void 		{ _BC_GAP 		= value } ;		
		public function set bcHeight(value:Number):void 	{ _BC_HT 		= value } ;
		
		public function set bcInvert(value:Boolean):void 	{ _BC_INVERT 	= bool(value) } ;
		public function set bcLabel(value:Boolean):void 	{ _BC_LABEL 	= bool(value) } ;
		public function set bcCheckDigit(value:Boolean):void{ _BC_CHKD 		= bool(value) } ;
		public function set bcCreateFile(value:Boolean):void{ _BC_FILE 		= bool(value) } ;
		
		public function get bcType():Number 		{ return _BC_TYPE} ;
		public function get bcImageType():Number 	{ return _BC_IMG} ;
		public function get bcRotate():Number 		{ return _BC_ROTATE} ;		
		public function get bcDimention():Number 	{ return _BC_DIM} ;
		public function get bcScaleFactor():Number	{ return _BC_FACT} ;
		public function get bcGap():Number 			{ return _BC_GAP} ;		
		public function get bcHeight():Number 		{ return _BC_HT} ;
		
		public function get bcInvert():Boolean 		{ return Converter.bool(_BC_INVERT)} ;
		public function get bcLabel():Boolean 		{ return Converter.bool(_BC_LABEL)} ;
		public function get bcCheckDigit():Boolean	{ return Converter.bool(_BC_CHKD)} ;
		public function get bcCreateFile():Boolean	{ return Converter.bool(_BC_FILE)} ;
		
		public static function bool(value:*):String{			
			if(value==true||value=="TRUE"||value=="True"||value=="true"){
				return "TRUE";
			}else{
				return "FALSE";
			}
		}
		
		public function getConfig():Object{
			var config:Object = {
				BC_TYPE:		_BC_TYPE,
				BC_IMG:			_BC_IMG,
				BC_ROTATE:		_BC_ROTATE,
				BC_DIM:			_BC_DIM,
				BC_FACT:		_BC_FACT,
				BC_GAP:			_BC_GAP,
				BC_INVERT:		_BC_INVERT,
				BC_HT:			_BC_HT,
				BC_LABEL:		_BC_LABEL,
				BC_CHKD:		_BC_CHKD,
				BC_FILE:		_BC_FILE
			}
			return config;
		}
		
		public function getData():Object{
			var config:Object = {
				bcType:			_BC_TYPE,
				bcImageType:	_BC_IMG,
				bcRotate:		_BC_ROTATE,
				bcDimention:	_BC_DIM,
				bcScaleFactor:	_BC_FACT,
				bcGap:			_BC_GAP,
				bcInvert:		_BC_INVERT,
				bcHeight:		_BC_HT,
				bcLabel:		_BC_LABEL,
				bcCheckDigit:	_BC_CHKD,
				bcCreateFile:	_BC_FILE
			}
			return config;
		}
	}
}