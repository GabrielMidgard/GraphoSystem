package mx.random.drawing{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	public class XMLSignDrawing	extends MovieClip{
		
		private var _points:ArrayCollection = new ArrayCollection();
		private var _canvas:Sprite = new Sprite();
		
		public function XMLSignDrawing(){
			
		}
						
		public function doSign(XMLSign:XML,sacle:Number = 0.5):void{			
			_points = creatDataArray(new XML(XMLSign[0]));
			_canvas = drwawSign(sacle);
			this.addChild(_canvas);
		}
		
		public function drwawSign(scale:Number):Sprite{
			var canvas:Sprite = new Sprite();			
			var points:Array = new Array();
			var pointsGroup:Array = new Array();			
			var cnd:Boolean = false;
			for(var n:Number = 0;n<_points.length;n++){
				var cx:Number = _points[n].X*scale;
				var cy:Number = _points[n].Y*scale;
				
				if(_points[n].Pressure!=0){				
					points.push(new Point(cx,cy));
					cnd = true;
				}else{
					if(cnd){
						pointsGroup.push(points);
						points = new Array();
						cnd = false;		
					}
				}				
			}
			pointsGroup.push(points);
			
			
			
			for(var m:Number =0; m<pointsGroup.length;m++){
				var group:Array = pointsGroup[m];				
				canvas.graphics.lineStyle(1,0x0);
				canvas.graphics.moveTo(group[0].x, group[0].y);
				for (var i:Number = 1; i < group.length - 2; i ++){
					var xc:Number = (group[i].x + group[i + 1].x) / 2;
					var yc:Number = (group[i].y + group[i + 1].y) / 2;					
					canvas.graphics.curveTo(group[i].x, group[i].y, xc, yc);
				}				
			}
			/*
			for(var u:Number =0; u<pointsGroup.length;u++){
				var group:Array = pointsGroup[u];				
				canvas.graphics.lineStyle(1,0x0);
				canvas.graphics.moveTo(group[0].x, group[0].y+200);
				for (var o:Number = 1; o < group.length; o ++){									
					canvas.graphics.lineTo(group[o].x, group[o].y+200);
				}				
			}*/

			return canvas;
		}
		
		
		
		private function creatDataArray(sign:XML):ArrayCollection{
			var penPoint:XMLList = sign[0].children();
			var data:XML = new XML(penPoint[0]);
			var points:ArrayCollection = new ArrayCollection();
			for(var n:Number = 0;n<data.PenPoint.length();n++){
				var point:Object = {
					RawX:		Number(data.PenPoint[n].RawX.toString()),
					RawY:		Number(data.PenPoint[n].RawY.toString()),
					Pressure:	Number(data.PenPoint[n].Pressure.toString()),
					Time:		Number(data.PenPoint[n].Time.toString()),
					X:			Number(data.PenPoint[n].X.toString()),
					Y:			Number(data.PenPoint[n].Y.toString())
				}
				points.addItem(point);		
			}
			return points;
		}

	}
}