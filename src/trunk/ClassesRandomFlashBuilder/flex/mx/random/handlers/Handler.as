package mx.random.handlers{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	import mx.random.events.SelectionEvent;
	import mx.random.events.StaticEvent;
	
	[Bindable]
	public class Handler extends MovieClip{
		
		public static var Snap:Boolean 				= false;
		public static var SmartConnection:Boolean 	= false;
		public static var SnapValue:Number 			= 5;
		
		private var _boxHandler:Shape 	= new Shape();
		private var _ref:Object 		= new Object();
		private var _tl:MovieClip 		= createBoxHandler("tl");
		private var _t:MovieClip 		= createBoxHandler("t");
		private var _tr:MovieClip 		= createBoxHandler("tr");
		private var _l:MovieClip 		= createBoxHandler("l");
		private var _r:MovieClip 		= createBoxHandler("r");
		private var _bl:MovieClip 		= createBoxHandler("bl");
		private var _b:MovieClip 		= createBoxHandler("b");
		private var _br:MovieClip 		= createBoxHandler("br");
		private var _center:MovieClip 	= createBoxCenter();
		
		private var _boxSize:Number = 6;		
		private var _handlerActive:Boolean = false;
		private var _currentHanlder:String = "";
		private var _refStartX:Number = 0;
		private var _refStartY:Number = 0;
		
		
		public function Handler(){			
			this.addChild(_boxHandler);
			this.addChild(_tl);
			this.addChild(_t);
			this.addChild(_tr);
			this.addChild(_l);
			this.addChild(_r);
			this.addChild(_bl);
			this.addChild(_b);
			this.addChild(_br);
			this.addChild(_center);
			_boxHandler.addEventListener(MouseEvent.MOUSE_DOWN,mouseControl);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseControl);
			this.addEventListener(Event.ENTER_FRAME,update);
			StaticEvent.addEventListener(HanlderEvent.HANDLER_HIDE,staticControl);
			StaticEvent.addEventListener(HanlderEvent.HANDLER_SHOW,staticControl);
			StaticEvent.addEventListener(HanlderEvent.UPDATE_HANDLER_REF,staticControl);
			StaticEvent.addEventListener(MouseEvent.MOUSE_UP,mouseControl);
		}
		
		public function updateHandler(ref:Object):void{
			_ref = ref;			
			updateBoxes();
		}
		
		private function createBoxHandler(boxName:String):MovieClip{			
			var boxShape:Shape = new Shape();
			boxShape.graphics.beginFill(0xFFFFFF);
			boxShape.graphics.lineStyle(1,0x000000,1);			
			boxShape.graphics.drawRect((-_boxSize)/2,(-_boxSize)/2,_boxSize,_boxSize);
			var box:MovieClip = new MovieClip();
			box.buttonMode = true;
			box.name = boxName;
			box.addChild(boxShape);
			box.addEventListener(MouseEvent.MOUSE_DOWN,mouseControl);
			box.addEventListener(MouseEvent.MOUSE_UP,mouseControl);
			return box;
		}
		
		private function createBoxCenter():MovieClip{
			var center:Shape = new Shape();
			center.graphics.clear();
			center.graphics.beginFill(0x000000,0);
			center.graphics.lineStyle(1);			
			center.graphics.drawCircle(0,0,3);
			var centerMc:MovieClip = new MovieClip();
			centerMc.addChild(center);
			return centerMc;
		}
		
		private function drawBoxHandler():void{
			_boxHandler.graphics.clear();
			_boxHandler.graphics.beginFill(0x000000,0);
			_boxHandler.graphics.lineStyle(1);
			_boxHandler.graphics.drawRect(0,0,20,20);
		}
		
		private function mouseControl(e:MouseEvent):void{
			switch(e.type){
				case MouseEvent.MOUSE_UP:
					_handlerActive = false;
					_currentHanlder = "";
					stopDrag();
					updateBoxes();
					break;
				case MouseEvent.MOUSE_DOWN:	
					_handlerActive = true;										
					e.currentTarget.startDrag(false);
					_currentHanlder = e.currentTarget.name;
					_refStartX = e.currentTarget.x;
					_refStartY = e.currentTarget.y;
					break;
			}
		}
		
		public function staticControl(e:HanlderEvent):void{
			switch(e.type){
				case HanlderEvent.HANDLER_HIDE: 
					this.visible = false;
					break;
				case HanlderEvent.HANDLER_SHOW: 
					this.visible = true;
					break;
				case HanlderEvent.UPDATE_HANDLER_REF: 
					updateHandler(e.newRef);
					break;
			}		
		}
		
		private function update(e:Event):void{
			var rect:Rectangle;			
			if(_handlerActive){
				var maxMove:Number = 1000;
				var iniX:Number = 0;
				var iniY:Number = 0;
				var endX:Number = 0;
				var endY:Number = 0;

				switch(_currentHanlder){
					case "br":
						rect = new Rectangle(0,0,maxMove,maxMove);
						iniX = -_br.x;
						iniY = -_br.y;									
						break;
					case "r":
						rect = new Rectangle(0,0,maxMove,0);
						iniX = -_r.x;
						iniY = -_br.y;										
						break;
					case "tr":
						rect = new Rectangle(0,0,maxMove,-maxMove);	
						iniX = -_tr.x;
						iniY = _tr.y;								
						break;
					case "t":
						rect = new Rectangle(0,0,0,-maxMove);
						iniX = -_br.x;
						iniY = _t.y;									
						break;
					case "tl":
						rect = new Rectangle(0,0,-maxMove,-maxMove);
						iniX = _tl.x;
						iniY = _tl.y;									
						break;
					case "l":
						rect = new Rectangle(0,0,-maxMove,0);
						iniX = _l.x;
						iniY = -_br.y;									
						break;
					case "bl":
						rect = new Rectangle(0,0,-maxMove,maxMove);	
						iniX = _bl.x;
						iniY = -_bl.y;								
						break;
					case "b":
						rect = new Rectangle(0,0,0,maxMove);
						iniX = _tl.x;
						iniY = -_b.y;									
						break;
				}
				this["_"+_currentHanlder].startDrag(false,rect);
				if(Handler.Snap){
					iniX = Math.floor(iniX/Handler.SnapValue)*Handler.SnapValue;
					iniY = Math.floor(iniY/Handler.SnapValue)*Handler.SnapValue;
					endX = Math.floor(endX/Handler.SnapValue)*Handler.SnapValue;
					endY = Math.floor(endX/Handler.SnapValue)*Handler.SnapValue;
				}
				updateOthers(iniX,iniY,Math.abs(iniX),Math.abs(iniY));
			}			
		}

		private function updateOthers(iniX:Number,iniY:Number,endX:Number,endY:Number):void{			
			_boxHandler.x = _boxHandler.y = 0;
			_boxHandler.graphics.clear();			
			_boxHandler.graphics.lineStyle(1);
			_boxHandler.graphics.drawRect(iniX,iniY,endX*2,endY*2);
			
			_ref.width = _boxHandler.width;
			_ref.height = _boxHandler.height;
			_ref.x = this.x+iniX;
			_ref.y = this.y+iniY;
			
			if(_currentHanlder!="tl"){
				_tl.x 	= iniX; 				
				_tl.y 	= iniY; 
			}
			if(_currentHanlder!="t"){				
				_t.x 	= 0;
				_t.y 	= iniY; 
			}
			if(_currentHanlder!="tr"){				
				_tr.x 	= endX; 	
				_tr.y 	= iniY; 
			}
			if(_currentHanlder!="l"){				
				_l.x 	= iniX; 				
				_l.y 	= 0;
			}
			if(_currentHanlder!="r"){
				_r.x 	= endX; 	
				_r.y 	= 0;
			}
			if(_currentHanlder!="bl"){
				_bl.x 	= iniX; 				
				_bl.y 	= endY;
			}
			if(_currentHanlder!="b"){	
				_b.x 	= 0;
				_b.y 	= endY;
			}
			if(_currentHanlder!="br"){	
				_br.x 	= endX; 	
				_br.y 	= endY;
			}
			StaticEvent.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_UPDATE));
		}


		private function updateBoxes():void{			
			var _iniX:Number = 0-(_ref.width/2);
			var _iniY:Number = 0-(_ref.height/2);
			var _endX:Number = _iniX+_ref.width;
			var _endY:Number = _iniY+_ref.height;
			
			this.x = _ref.x+Math.abs(_iniX);
			this.y = _ref.y+Math.abs(_iniY);
			
			_boxHandler.x = _boxHandler.y = 0;
			_boxHandler.graphics.clear();			
			_boxHandler.graphics.lineStyle(1);
			_boxHandler.graphics.drawRect(_iniX,_iniY,_endX*2,_endY*2);
			
			
			_tl.x 	= _iniX; 				
			_tl.y 	= _iniY; 
							
			_t.x 	= 0;
			_t.y 	= _iniY; 
							
			_tr.x 	= _endX; 	
			_tr.y 	= _iniY; 
							
			_l.x 	= _iniX; 				
			_l.y 	= 0;
			
			_r.x 	= _endX; 	
			_r.y 	= 0;
			
			_bl.x 	= _iniX; 				
			_bl.y 	= _endY;
				
			_b.x 	= 0;
			_b.y 	= _endY;
				
			_br.x 	= _endX; 	
			_br.y 	= _endY;
			StaticEvent.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_UPDATE));
		}
		
	}
}