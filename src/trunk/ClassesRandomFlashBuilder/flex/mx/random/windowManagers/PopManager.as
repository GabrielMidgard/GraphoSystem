package mx.random.windowManagers{
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	
	import mx.containers.TitleWindow;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	
	public class PopManager extends DisplayObject{
		
		private var _openWindows:Object = new Object();
		
		public function PopManager(){
		}
		
		public function openPopUp(popUpName:String,ref:Object):void{
			if(!_openWindows.hasOwnProperty(popUpName)){
				var pop:TitleWindow = PopUpManager.createPopUp(this, getDefinitionByName("views."+popUpName) as Class, false) as TitleWindow;
				pop.name = popUpName;
				pop.addEventListener(CloseEvent.CLOSE, closePopup);
				_openWindows[popUpName] = pop;
				
				if(pop.hasOwnProperty("context")){
					var popupContext:Object = {
						webApplication: ref.webApplication,
						workManager: ref
					}
					Object(pop).context = popupContext;
					
				}
				PopUpManager.centerPopUp(pop);
    		}
		}
		
		private function closePopup(e:CloseEvent):void{
			var pop:TitleWindow = e.target as TitleWindow;
        	if(_openWindows.hasOwnProperty(pop.name)){
            	PopUpManager.removePopUp(_openWindows[pop.name]);
            	delete _openWindows[pop.name]
        	}
		}


	}
}