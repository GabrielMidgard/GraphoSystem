package mx.random.drawing
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	import mx.random.events.SelectionEvent;
	import mx.random.events.StaticEvent;
	import mx.random.tools.ToolManager;

	public class DrawingObjects extends UIComponent{
		
		private var _box:Shape;
		private var _line:Shape;
		private var _handler:Shape;
		private var _ref:Shape;
		private var _ini:Shape;
		private var _end:Shape;
		private var _connectorLine:Shape;
		private var _baseConnectorLine:Shape;
		
		public static var DIRECT_LINE:String = "direct_line";
		public static var BEZIER_LINE:String = "bezier_line";
		public static var SQRT_LINE:String 	 = "sqrt_line";
		
		public static var currentConnectorType:String = DIRECT_LINE;
		private var _over:Boolean = false;
		private var _currentIniX:Number = 0;
		private var _currentIniY:Number = 0;
		private var _currentEndX:Number = 0;
		private var _currentEndY:Number = 0;
		private var _curretnFlip:Boolean = false;			
		
		public function DrawingObjects(){
			_box = new Shape();
			_line = new Shape();
			_handler = new Shape();
			_ref = new Shape();
			_connectorLine = new Shape();
			_baseConnectorLine = new Shape();
			_ini = new Shape();
			_end = new Shape();
			addEventListener(MouseEvent.MOUSE_OVER,mouseControl);
			addEventListener(MouseEvent.MOUSE_OUT,mouseControl);
			addEventListener(MouseEvent.CLICK,mouseControl);
		}
		
		private function mouseControl(e:MouseEvent):void{
			switch(e.type){
				case MouseEvent.MOUSE_OUT:
					_over = false;
					break;
				case MouseEvent.MOUSE_OVER:
					if(ToolManager.currentTool==ToolManager.DELETE_CONNECTION_TOOL){
						_over = true;
					}
					break;
				case MouseEvent.CLICK:
					if(ToolManager.currentTool==ToolManager.DELETE_CONNECTION_TOOL){
						StaticEvent.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_DELETE,this));
					}
			}
			connectLine(_currentIniX,_currentIniY,_currentEndX,_currentEndY,_curretnFlip);
		}
		
		public function line(endX:Number,iniY:Number,color:uint,alpha:Number):void{
			_line.graphics.clear();
			_line.graphics.moveTo(0,0);
			_line.graphics.lineStyle(1,color,alpha);
			_line.graphics.lineTo(endX,iniY);
			this.addChild(_line);
		}
		
		public function box(iniX:Number,iniY:Number,endX:Number,endY:Number):void{
			_box.graphics.clear();
			_box.graphics.beginFill(0xffffff,.2);
			_box.graphics.drawRect(iniX,iniY,endX-iniX,endY-iniY);
			
			_line.graphics.clear();
			_line.graphics.lineStyle(1,0xffffff,0.5);
			_line.graphics.moveTo(iniX,iniY);
			_line.graphics.lineTo(endX,iniY);
			_line.graphics.lineTo(endX,endY);
			_line.graphics.lineTo(iniX,endY);
			_line.graphics.lineTo(iniX,iniY);
			
			this.addChild(_box);
			this.addChild(_line);
		}
		
		public function boxHandler(iniX:Number,iniY:Number,endX:Number,endY:Number):void{
			_box.graphics.clear();
			_box.graphics.beginFill(0xffffff,0);
			_box.graphics.drawRect(iniX,iniY,endX-iniX,endY-iniY);
			this.addChild(_box);
		}
		
		public function handlerRound(iniX:Number,iniY:Number):void{
			with(_handler.graphics){
				clear();
				beginFill(0xffffff,1);
				drawCircle(iniX,iniY,3);
			}
			this.addChild(_handler);
		}
		
		public function handlerRoundRed(iniX:Number,iniY:Number):void{
			with(_handler.graphics){
				clear();
				beginFill(0xff0000,1);
				drawCircle(iniX,iniY,3);
			}
			this.addChild(_handler);
		}
		
		public function handlerSqr(iniX:Number,iniY:Number):void{
			with(_handler.graphics){
				clear();
				beginFill(0xffffff,1);
				drawRect(iniX-2,iniY-2,4,4);
			}
			this.addChild(_handler);
		}
		
		public function handlerSqrRed(iniX:Number,iniY:Number):void{
			with(_handler.graphics){
				clear();
				beginFill(0xff0000,1);
				drawRect(iniX-2,iniY-2,4,4);
			}
			this.addChild(_handler);
		}
		
		public function ref(iniX:Number,iniY:Number):void{
			with(_ref.graphics){
				clear();
				beginFill(0x0f8fe8,.5);
				drawCircle(iniX,iniY,3);
			}
			this.addChild(_ref);
		}
		
		public function connectLine( _iniX:Number, _iniY:Number, _finX:Number, _finY:Number,flip:Boolean = false):void{
			_currentIniX = _iniX;
			_currentIniY = _iniY;
			_currentEndX = _finX;
			_currentEndY = _finY;
			_curretnFlip  = flip;
			
			_ini.graphics.clear();
			_ini.graphics.beginFill(0x52da6f,1);
			_ini.graphics.drawCircle(_iniX,_iniY,2.5);
			_end.graphics.clear();
			_end.graphics.beginFill(0xfda1a1,1);
			_end.graphics.drawCircle(_finX,_finY,2.5);	
					
			_connectorLine.graphics.clear();
			_baseConnectorLine.graphics.clear();
			
			_connectorLine.graphics.lineStyle(.25,0xaaaab8,1);
			
			if(_over){
				_baseConnectorLine.graphics.lineStyle(5,0xFF0000,.5);
			}else{
				_baseConnectorLine.graphics.lineStyle(5,0xFF0000,0);
			}
			
			switch(currentConnectorType){
				case DrawingObjects.DIRECT_LINE:			
					_connectorLine.graphics.moveTo(_iniX,_iniY);
					_connectorLine.graphics.lineTo(_finX,_finY);
					
					_baseConnectorLine.graphics.moveTo(_iniX,_iniY);
					_baseConnectorLine.graphics.lineTo(_finX,_finY);
					break;
					
				case DrawingObjects.BEZIER_LINE:
					var cpX:Number = 0;
					var cpY:Number = 0;
					var mX:Number = (_iniX+((_finX-_iniX)/2));
					var mY:Number = (_iniY+((_finY-_iniY)/2));
					
					_connectorLine.graphics.moveTo(_iniX,_iniY);
					_baseConnectorLine.graphics.moveTo(_iniX,_iniY);
					
					if(flip){
						cpX = _iniX;
						cpY = _iniY+((mY-_iniY)/2);
						_connectorLine.graphics.curveTo(cpX,cpY, mX, mY);
						_baseConnectorLine.graphics.curveTo(cpX,cpY, mX, mY);
						cpX = _finX;
						cpY = _finY-((_finY-mY)/2);			
						_connectorLine.graphics.curveTo(cpX,cpY, _finX, _finY);
						_baseConnectorLine.graphics.curveTo(cpX,cpY, _finX, _finY);
					}else{
						cpX = _iniX+((mX-_iniX)/2);
						cpY = _iniY;
						_connectorLine.graphics.curveTo(cpX,cpY, mX, mY);
						_baseConnectorLine.graphics.curveTo(cpX,cpY, mX, mY);
						cpX = _finX-((_finX-mX)/2);
						cpY = _finY;			
						_connectorLine.graphics.curveTo(cpX,cpY, _finX, _finY);
						_baseConnectorLine.graphics.curveTo(cpX,cpY, _finX, _finY);
					}
					
					
					break;
				
				case DrawingObjects.SQRT_LINE:					
					_connectorLine.graphics.moveTo(_iniX,_iniY);
					_baseConnectorLine.graphics.moveTo(_iniX,_iniY);
					var middle:Number = 0;
					if(flip){
						middle = Math.floor(_iniY+((_finY-_iniY)/2));
						_connectorLine.graphics.lineTo(_iniX,middle);
						_connectorLine.graphics.lineTo(_finX,middle);
						_connectorLine.graphics.lineTo(_finX,_finY);
						
						_baseConnectorLine.graphics.lineTo(_iniX,middle);
						_baseConnectorLine.graphics.lineTo(_finX,middle);
						_baseConnectorLine.graphics.lineTo(_finX,_finY);
					}else{
						middle = Math.floor(_iniX+((_finX-_iniX)/2));
						_connectorLine.graphics.lineTo(middle,_iniY);
						_connectorLine.graphics.lineTo(middle,_finY);
						_connectorLine.graphics.lineTo(_finX,_finY);
						
						_baseConnectorLine.graphics.lineTo(middle,_iniY);
						_baseConnectorLine.graphics.lineTo(middle,_finY);
						_baseConnectorLine.graphics.lineTo(_finX,_finY);
					}
					break;
				
			}
			
			this.addChild(_baseConnectorLine);
			this.addChild(_connectorLine);
			this.addChild(_ini);
			this.addChild(_end);
		}
	
	}
}