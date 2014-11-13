package mx.random.managers{
	import mx.collections.ArrayCollection;
	
	public class SelectionManager	{
		
		public static var Selection:ArrayCollection = new ArrayCollection();
		public static var SelctionDrag:ArrayCollection = new ArrayCollection();	
		public static var MainPick:Object = new Object();
		
		public function SelectionManager(){
		}
		
		public static function reset():void{
			SelectionManager.Selection = new ArrayCollection();
			SelectionManager.SelctionDrag = new ArrayCollection();
			SelectionManager.MainPick = null;
		}
		
		public static function loadDrags():void{
			SelectionManager.SelctionDrag = new ArrayCollection();
			var mainX:Number = SelectionManager.MainPick.x;
			var mainY:Number = SelectionManager.MainPick.y;
			for(var n:Number = 0;n<SelectionManager.Selection.length;n++){
				if(SelectionManager.Selection[n]!=SelectionManager.MainPick){
					var offX:Number = mainX-SelectionManager.Selection[n].x;
					var offY:Number = mainY-SelectionManager.Selection[n].y;
					SelctionDrag.addItem({Item:SelectionManager.Selection[n],offsetX:offX,offsetY:offY})
				}
			}
		}
		
		public static function removeItem(item:Object):void{
			for(var n:Number = 0;n<SelectionManager.Selection.length;n++){
				if(SelectionManager.Selection[n]==item){
					SelectionManager.Selection.removeItemAt(n);
				}
			}
		}
		
		public static function setSingleSelection(item:Object):void{
			SelectionManager.reset();
			SelectionManager.Selection.addItem(item);
		} 

	}
}