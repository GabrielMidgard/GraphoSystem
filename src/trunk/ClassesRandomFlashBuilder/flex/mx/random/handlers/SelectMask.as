package mx.random.handlers{
	import flash.display.MovieClip;
	
	import mx.core.UIComponent;

	
	
	public class SelectMask extends MovieClip	{
		private var _mask:MovieClip = new MovieClip();
		
		public function SelectMask(){
			this.addChild(_mask);
		}
		
		public function createMask(iniX:Number,iniY:Number,endX:Number,endY:Number):void{
			_mask.graphics.clear();
			_mask.graphics.lineStyle(1,0x000000,.5);
			_mask.graphics.beginFill(0xffffff,.1);
			_mask.graphics.drawRect(iniX,iniY,endX-iniX,endY-iniY);
		}
		
		public function reset():void{
			_mask.graphics.clear();
		}
	}
	
	
}