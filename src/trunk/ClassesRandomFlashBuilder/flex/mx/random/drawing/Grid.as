package mx.random.drawing
{
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	import mx.core.UIComponent;
	
	public class Grid extends UIComponent
	{
		private var linea:Shape;
		private var snapVisible:Boolean = true;
		private var n:Number = 0;
		
		public function Grid()
		{
			linea = new Shape();
		}
		
		public function crearGrid(snapValue:Number,gridWidth:Number,gridHeigth:Number,color:uint = 0x00ff54,colorAlpha:Number = 0.1):void{
			this.width = gridWidth;
			this.height = gridHeigth;
			with (linea.graphics) {
				clear();
				lineStyle(1,color,colorAlpha);
				
				for(n=0;n<(gridWidth/snapValue);n++){
					moveTo(n*snapValue	,0);
					lineTo(n*snapValue	,gridWidth);
				}
				for(n=0;n<(gridHeigth/snapValue);n++){
					moveTo(0   	,n*snapValue);
					lineTo(gridHeigth	,n*snapValue);
				}
			}
			
			this.addChild(linea);
		}

	}
}