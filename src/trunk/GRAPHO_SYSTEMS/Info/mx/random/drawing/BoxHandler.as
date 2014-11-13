package mx.random.drawing
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	
	[Bindable]
	public class BoxHandler extends UIComponent{
		
		private var _box:DrawingObjects = new DrawingObjects();
		private var _boxHandler:DrawingObjects = new DrawingObjects();
		private var _boxBack:DrawingObjects = new DrawingObjects();
		private var _hdTL:DrawingObjects = new DrawingObjects();
		private var _hdTR:DrawingObjects = new DrawingObjects();
		private var _hdBL:DrawingObjects = new DrawingObjects();
		private var _hdBR:DrawingObjects = new DrawingObjects();
		private var _ref:DrawingObjects = new DrawingObjects();
		
		
		
		private var _keepAspect:Boolean = false
		private var _aspect:Number = 1;
		private var _WT:Number = 0;
		private var _HT:Number = 0;
		private var _X:Number = 0;
		private var _Y:Number = 0;
		
		private var _Xpress:Number = 0;
		private var _Ypress:Number = 0;
		private var _boxPressed:Boolean = false;
		private var _handlerPressed:Boolean = false;
		private var _boxHandlerPressed:Boolean = false;
		private var _offset:Number = 5;
		private var _handlerObject:Object;
		
		
		public var _coors:Coors = new Coors();
		
		public function BoxHandler(WT:Number = 50,HT:Number =50,keepAspect:Boolean = false){
			initHandler(WT,HT,keepAspect);
		}
		
		public function initHandler(WT:Number = 50,HT:Number =50,keepAspect:Boolean = false):void{
			_WT = WT;
			_HT = HT;
			_aspect = _HT/_WT;
			_keepAspect = keepAspect;
			createHandledBox();
			addListeners();	
		}
		
		private function createHandledBox():void{
			_box.box(_X,_Y,_WT,_HT);
			_boxHandler.boxHandler(_X,_Y,_WT,_HT);
			_boxBack.boxHandler(_X,_Y,_WT,_HT);
			_boxHandler.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_boxHandler.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			
			if(false){
				if(!_keepAspect){
					_hdTL.handlerRound(_X	,_Y);
					_hdTR.handlerRound(_X	,_Y);
					_hdBL.handlerRound(_X	,_Y);
				}else{
					_hdTL.handlerRoundRed(_X	,_Y);
					_hdTR.handlerRoundRed(_X	,_Y);
					_hdBL.handlerRoundRed(_X	,_Y);
				}
				_hdBR.handlerRound(_X	,_Y);
			}else{
				if(!_keepAspect){
					_hdTL.handlerSqr(_X	,_Y);
					_hdTR.handlerSqr(_X	,_Y);
					_hdBL.handlerSqr(_X	,_Y);
				}else{
					_hdTL.handlerRoundRed(_X	,_Y);
					_hdTR.handlerRoundRed(_X	,_Y);
					_hdBL.handlerRoundRed(_X	,_Y);
				}
				_hdBR.handlerSqr(_X	,_Y);
			}



			_hdTL.x = 0;	_hdTL.y = 0;
			_hdTR.x = _WT;	_hdTR.y = 0;
			_hdBL.x = 0;	_hdBL.y = _HT;
			_hdBR.x = _WT;	_hdBR.y = _HT;
			
			//_box.addChild(_ref);
			if(_keepAspect){
				_box.addChild(_boxBack);
			}
			_box.addChild(_boxHandler);
			
			_box.addChild(_hdTL);
			_box.addChild(_hdTR);
			_box.addChild(_hdBL);
			_box.addChild(_hdBR);
			
			_box.x = 10;
			_box.y = 10;
			
			addChild(_box);
		}
		
		private function addListeners():void{
			_hdTR.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_hdTR.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);		
			_hdTL.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_hdTL.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);			
			_hdBL.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_hdBL.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_hdBR.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_hdBR.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);	
			_boxBack.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_box.removeEventListener(Event.ENTER_FRAME,updateBox);
			
			if(!_keepAspect){
				_hdTR.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				_hdTR.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);		
				_hdTL.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				_hdTL.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);			
				_hdBL.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
				_hdBL.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}else{
				_boxBack.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
			_hdBR.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_hdBR.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);	
			_box.addEventListener(Event.ENTER_FRAME,updateBox);
		}
		

		private function onMouseDown(e:MouseEvent):void{
			if(e.currentTarget==_boxHandler){
				_box.startDrag(false);	
				_boxHandlerPressed = true;
			}else{
				if(!_keepAspect){
					e.currentTarget.startDrag(false);
				}
				_handlerObject = e.currentTarget;
				_handlerPressed = true;
			}
			
		}
		
		private function onMouseUp(e:MouseEvent):void{
			_handlerPressed = false;
			_boxHandlerPressed = false;
			stopDrag();
			if(!_keepAspect){
				matchHandlers();
			}	
		}
		
		private function updateBox(e:Event):void{
			if(_handlerPressed){	
				matchHandlers();
			}
			updateCoors();
		}
		
		
		private function matchHandlers():void{
			switch(_handlerObject){
					case _hdTL:
						_hdBL.x = _hdTL.x;
						_hdTR.y = _hdTL.y;
						break;
					case _hdTR:
						_hdBR.x = _hdTR.x;
						_hdTL.y = _hdTR.y;
						break;
					case _hdBL:
						_hdTL.x = _hdBL.x;
						_hdBR.y = _hdBL.y;
						break;
					case _hdBR:
						if(_keepAspect){
							if(_box.mouseX>0){
								_hdBR.x = _box.mouseX;
							}else{
								_hdBR.x = _hdTL.x + 1;
							}
							_hdBR.y = _hdTL.y+(_coors._w*_aspect);
						}
						_hdTR.x = _hdBR.x;
						_hdBL.y = _hdBR.y;
						break;
				}
		}
		
		
		private function updateCoors():void{
			var coorX:Number = 0;
			var coorY:Number = 0;

			_box.box(_hdTL.x,_hdTL.y,_hdBR.x,_hdBR.y);
			_boxHandler.boxHandler(_hdTL.x,_hdTL.y,_hdBR.x,_hdBR.y);
			
		
			if(_hdTL.y<_hdBL.y){
				if(_hdTL.x<_hdTR.x){	
					coorX=_hdTL.x
				}else{
					coorX=_hdTR.x
				}
			}else{
				if(_hdBL.x<_hdBR.x){	
					coorX=_hdBL.x
				}else{
					coorX=_hdBR.x
				}
			}
			
			if(_hdTL.x<_hdTR.x){
				
				if(_hdTL.y<_hdBL.y){	
					coorY=_hdTL.y
				}else{
					coorY=_hdBL.y
				}
				
			}else{
				if(_hdTR.y<_hdBR.y){	
					coorY=_hdTR.y
				}else{
					coorY=_hdBR.y
				}
			}
			
			
			if(coorX>0){
				_coors._x = _box.x + Math.abs(coorX);
			}else{
				_coors._x = _box.x - Math.abs(coorX);
			}
			
			if(coorY>0){
				_coors._y = _box.y + Math.abs(coorY);
			}else{ 
				_coors._y = _box.y - Math.abs(coorY);
			}

			_coors._w	= Math.abs(_hdTL.x	- _hdTR.x);
			_coors._h	= Math.abs(_hdBL.y	- _hdTL.y);
			if(_keepAspect){
				_boxBack.boxHandler(_hdTL.x-200,_hdTL.y-200,_hdTL.x+_coors._w+200,_hdTL.y+_coors._h+200);
			}
		}
		
		
		
	}
}