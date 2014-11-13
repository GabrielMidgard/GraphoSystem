package mx.random.cms.renderers{
	import components.AuthIcon;
	
	import mx.controls.CheckBox;
	import mx.controls.treeClasses.*;

	
	public class TreeRenderer extends TreeItemRenderer{
		public var chk:AuthIcon;
        public var itemXml:XML;

		public function TreeRenderer(){
			super();
            mouseEnabled = false
		}
		
		override public function set data(value:Object):void{
		    super.data = value;
            this.itemXml = XML(value);
        }
        
        override protected function createChildren():void{
            super.createChildren();
            chk = new AuthIcon();
            chk.mouseEnabled = false;
            addChild(chk);
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
            super.updateDisplayList(unscaledWidth,unscaledHeight);
            if(super.data){              
                if(TreeListData(super.listData).item.@icon == "__fld"){
                    this.chk.visible 	= false;
                }else{
                    this.chk.visible = true;
                    updateChBox();
                }  
            } 
        }
        

        private function updateChBox():void{
        	this.chk.x 			= super.icon.x
            super.icon.x		= this.chk.x + 17;
            super.label.x 		= super.label.x + 17;
            this.chk.y 			= super.label.y+3; 
            switch(new Number(XML(super.data).@auth)){
            	case 2:
            		this.chk.imgIcon.source= "assets/auth_false.png";
            		break;
            	case 1:
            		this.chk.imgIcon.source= "assets/auth_true.png";
            		break;
            	case 0:
            		this.chk.imgIcon.source= "assets/auth_ind.png";
            		break;	
            }
        }
        
	}
}