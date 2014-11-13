package mx.random.forms{
	import flash.display.MovieClip;
	
	

	public class ErrorKnot{
		public function ErrorKnot(){
			
		}
		
		public static function getCircleKnot(color:uint):MovieClip{
			var knot:MovieClip = new MovieClip();
			knot.graphics.clear();
			knot.graphics.beginFill(color,1);
			knot.graphics.drawCircle(0,0,2);
			return knot;
		}
		
		public static function getSquareKnot(color:uint):MovieClip{
			var knot:MovieClip = new MovieClip();
			knot.graphics.clear();
			knot.graphics.beginFill(color,1);
			knot.graphics.drawRect(-2.5,-2.5,5,5);
			return knot;
		}
		
		public static function getArrowKnot(color:uint):MovieClip{
			var knot:MovieClip = new MovieClip();
			knot.graphics.clear();
			knot.graphics.beginFill(color,1);
			knot.graphics.lineStyle(1,color,1);
			knot.graphics.moveTo(0,0);
			knot.graphics.lineTo(2,-2);
			knot.graphics.lineTo(2,-1);
			knot.graphics.lineTo(5,-1);
			knot.graphics.lineTo(5,1);
			knot.graphics.lineTo(2,1);
			knot.graphics.lineTo(2,2);
			knot.graphics.lineTo(0,0);
			knot.scaleX = 1.4;
			knot.scaleY = 1.5;
			knot.x = knot.x-3;
			return knot;
		}
		
		
	}
}