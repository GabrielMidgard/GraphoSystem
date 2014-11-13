package mx.random.tools
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class AverageColor
	{
		public function AverageColor()
		{
		}
		
		public static function getAverage(image:Bitmap):Object{
				var bitmap:BitmapData = new BitmapData(image.width,image.height,false);
				bitmap.draw(image);
				
				var sumColorR:Number = 0;
				var sumColorG:Number = 0;
				var sumColorB:Number = 0;
				var count:Number = 0;
				
				for(var h:Number = 0; h < image.height; h++){
					for(var w:Number = 0; w < image.width; w++){
						var col:Number = bitmap.getPixel(w, h);
						sumColorR += (col & 0xFF0000) >>> 16;
						sumColorG += (col & 0x00FF00) >>> 8;
						sumColorB += (col & 0x0000FF);
						count++;
					}
				}
								
				var colorR:Number 	= Math.round(sumColorR / count) << 16;
				var colorG:Number 	= Math.round(sumColorG / count) << 8;
				var colorB:Number 	= Math.round(sumColorB / count);
				var color:Number 	= colorR | colorG | colorB;
				var colorHex:String	= color.toString(16);
				return {colorNUM:color,colorHEX:colorHex};
			}

	}
}