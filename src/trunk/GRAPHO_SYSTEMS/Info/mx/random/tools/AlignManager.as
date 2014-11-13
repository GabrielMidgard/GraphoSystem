package mx.random.tools
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.random.events.SelectionEvent;
	import mx.random.events.StaticEvent;
	
	public class AlignManager{
		
		public static var TOP:String 						= "top";
		public static var BOTTOM:String 					= "bottom";
		public static var LEFT:String 						= "left";
		public static var RIGHT:String 						= "right";
		public static var CENTER_HORIZONTAL:String 			= "center_horizontal";
		public static var CENTER_VERTICAL:String 			= "center_vertical";
		public static var VERTICAL_DISTRIBUTION:String 		= "vertical_distribution";
		public static var HORIZONTAL_DISTRIBUTION:String 	= "horizontal_distribution";
		
		public function AlignManager(){
		}
		
		public static function align(alignType:String,objects:ArrayCollection):void{
			var n:Number = 0;
			var alignValue:Number = 0;
			switch(alignType){
				case AlignManager.TOP:
					
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].y;
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].y = alignValue;
					}
					break;
				case AlignManager.BOTTOM:
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].y+objects[n].height;
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].y = alignValue-objects[n].height;
					}					
					break;
				case AlignManager.LEFT:
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].x;
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].x = alignValue;
					}
					break;
				case AlignManager.RIGHT:
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].x+objects[n].width;
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].x = alignValue-objects[n].width;
					}	
					break;
				case AlignManager.CENTER_HORIZONTAL:
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].y+(objects[n].height/2);
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].y = alignValue-(objects[n].height/2);
					}					
					break;
				case AlignManager.CENTER_VERTICAL:
					for(n=0;n<objects.length;n++){
						alignValue += objects[n].x+(objects[n].width/2);
					}
					alignValue = alignValue/objects.length;
					for(n=0;n<objects.length;n++){
						objects[n].x = alignValue-(objects[n].width/2);
					}	
					break;
				case AlignManager.VERTICAL_DISTRIBUTION:
					var sort:Sort = new Sort();
					var sortItems:ArrayCollection = new ArrayCollection();
					for(n=0;n<objects.length;n++){						
						sortItems.addItem({item:objects[n],__y:objects[n].y});
					}
					sort.fields = [new SortField("__y", true,false,true)]
					sortItems.sort = sort
					sortItems.refresh();
					
					
					alignValue = (sortItems[sortItems.length-1].item.y - sortItems[0].item.y);
					
					alignValue = alignValue/(sortItems.length-1);
					for(n=0;n<sortItems.length;n++){
						sortItems[n].item.y = sortItems[0].item.y + alignValue*n;
					}
					break;
				case AlignManager.HORIZONTAL_DISTRIBUTION:
					var sort:Sort = new Sort();
					var sortItems:ArrayCollection = new ArrayCollection();
					for(n=0;n<objects.length;n++){						
						sortItems.addItem({item:objects[n],__x:objects[n].x});
					}
					sort.fields = [new SortField("__x", true,false,true)]
					sortItems.sort = sort
					sortItems.refresh();
					
					
					alignValue = (sortItems[sortItems.length-1].item.x - sortItems[0].item.x);
					
					alignValue = alignValue/(sortItems.length-1);
					for(n=0;n<sortItems.length;n++){
						sortItems[n].item.x = sortItems[0].item.x + alignValue*n;
					}
					break;
			}
			StaticEvent.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_UPDATE));
		}

	}
}