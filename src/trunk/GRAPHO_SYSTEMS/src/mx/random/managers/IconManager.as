package mx.random.managers{
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	import mx.random.events.IconEvent;
	
	import views.components.Icon;
	
	public class IconManager extends UIComponent	{
		
		private var _iconsArray:ArrayCollection = new ArrayCollection();
		private var _rows:Number 	= 0;
		private var _columns:Number = 0;
		private var _xCoor:Number 	= 0;
		private var _yCoor:Number 	= 0;
		private var _parent:Object;
		private var _vertical:Boolean = true;
		private var _container:String;
		
		private var _xOffset:Number = 0;
		private var _yOffset:Number = 0;
		private var _gap:Number = 10;

		
		public function IconManager(xcoor:Number,ycoor:Number,rows:Number,columns:Number,iconArray:ArrayCollection,parent:Object,vertical:Boolean = true,container:String = "")		{
			_iconsArray = iconArray;
			_columns 	= columns;
			_rows 		= rows;
			_xCoor 		= xcoor;
			_yCoor 		= ycoor;
			_parent 	= parent;
			_vertical 	= vertical;
			_container 	= container;
			initManager();
		}
		
		
		private function initManager():void{
			this.x = _xCoor;
			this.y = _yCoor;
			
			for(var n:Number = 0;n<_iconsArray.length;n++){
				var icon:Icon = new Icon();
				icon.context = _iconsArray[n];
				icon.x = (_xOffset*icon.width)+_gap;
				icon.y = (_yOffset*icon.height)+_gap;
				
				if(_vertical){
					_xOffset++;
					if(_xOffset>_columns-1){
						_yOffset++;
						_xOffset = 0;
					}
				}else{
					_yOffset++;
					if(_yOffset>_rows-1){
						_xOffset++;
						_yOffset = 0;
					}
				}
				icon.addEventListener(IconEvent.ICON_PRESSED,ManagerControl);
				icon.addEventListener(IconEvent.ICON_RELEASED,ManagerControl);
				icon.addEventListener(IconEvent.ICON_DOUBLECLICK,ManagerControl);
				this.addChild(icon);
			}
			if(_container!=""){
				_parent[_container].addChild(this);
			}else{
				_parent.addChild(this);
			}
		}
		
		private function ManagerControl(e:IconEvent):void{
			switch(e.type){
				case IconEvent.ICON_PRESSED:					
					break;
				case IconEvent.ICON_RELEASED:					
					break;
				case IconEvent.ICON_DOUBLECLICK:
					if(e._windowMode){
						_parent.iniPopUp(e._iconClass);
					}else{
						_parent.iniApp(e._iconClass);
					}
					break;
			}
		}

	}
}