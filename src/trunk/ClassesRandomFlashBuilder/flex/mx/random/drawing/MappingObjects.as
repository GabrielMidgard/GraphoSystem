package mx.random.drawing
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.random.events.SelectionEvent;
	import mx.random.events.StaticEvent;
	import mx.random.tools.ToolManager;

	public class MappingObjects extends UIComponent{
		
		
		public static const FRONT_PROJECTOR:String = "front_projector";
		public static const LEFT_PROJECTOR:String = "left_projector";
		
		private var _box:Shape;
		private var _line:Shape;		
		private var _projector:Shape;
		private var _projection:Shape;
		private var _projectorHandler:Shape;
		private var _coor:Point;
		private var _shoot:Point;
		private var _lens:Number;
		
		public function MappingObjects(){
			_box 		= new Shape();
			_line 		= new Shape();
			_projector 	= new Shape();
			_projection	= new Shape();
			_projectorHandler = new Shape();
			this.addChild(_projector);
		}
		
		
		
		
		public function createProjector(coor:Point,shoot:Point,lens:Number=1):void{
			_coor	= coor;
			_shoot 	= shoot;
			_lens 	= lens;
			_projector.graphics.clear();
			_projector.graphics.beginFill(0x000000,.5);
			_projector.graphics.lineStyle(1,0xffffff,1);
			_projector.graphics.moveTo(coor.x,coor.y);
			_projector.graphics.lineTo(coor.x+0,coor.y+5);
			_projector.graphics.lineTo(coor.x-10,coor.y+0);
			_projector.graphics.lineTo(coor.x-10,coor.y+5);
			_projector.graphics.lineTo(coor.x-30,coor.y+5);
			_projector.graphics.lineTo(coor.x-30,coor.y-5);
			_projector.graphics.lineTo(coor.x-10,coor.y-5);
			_projector.graphics.lineTo(coor.x-10,coor.y+0);
			_projector.graphics.lineTo(coor.x+0,coor.y-5);
			_projector.graphics.lineTo(coor.x+0,coor.y+0);
			createProjection();
		}
		
		private function createProjection():void{
			_projector.graphics.clear();
			_projector.graphics.beginFill(0x00ff00,0.3);
			_projector.graphics.lineStyle(1,0x00ff00,0.5);
			_projector.graphics.moveTo(_projector.x,_projector.y);
			_projector.graphics.moveTo(_projector.x+_coor.x,_projector.y+_coor.y);
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
		
		
	
	}
}