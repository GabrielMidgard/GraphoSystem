package mx.random.forms
{
	import flash.display.MovieClip;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	[Bindable]
	public class ButtonControl extends MovieClip{
		
		public var _new:Object 			= new Object();
		public var _update:Object 		= new Object();
		public var _delete:Object 		= new Object();
		public var _add:Object 			= new Object();
		public var _cancel:Object 		= new Object();
		
		private var _newFunction:Function;
		private var _updateFunction:Function;
		private var _addFunction:Function;
		private var _deleteFunction:Function;
		private var _cancelFunction:Function;
		private var _currentAction:String;
			
		public function ButtonControl(){
		}	
				
		public function setControlButtons(newButton:Object,updateButton:Object,deleteButton:Object,addButton:Object,cancelButton:Object):void{
			_new 			= newButton;
			_update 		= updateButton;
			_delete 		= deleteButton;
			_add 			= addButton;
			_cancel			= cancelButton;
			Ini();
		}
		
		public function setControlFunctions(newFunction:Function,addFunction:Function,deleteFunction:Function,updateFunction:Function,cancelFunction:Function):void{
			_newFunction 	= newFunction;
			_addFunction 	= addFunction;
			_deleteFunction = deleteFunction;
			_updateFunction = updateFunction;
			_cancelFunction = cancelFunction;
		}
		
		public function Ini():void{
			_new.enabled 	= true;
			_update.enabled = false;
			_delete.enabled = true;
			_add.enabled 	= false;
			_cancel.visible = false;
			_currentAction = "Idle";
		}
		
		public function New():void{
			_newFunction();
			_new.enabled 	= false;
			_update.enabled = false;
			_delete.enabled = false;
			_add.enabled 	= true;
			_cancel.visible = true;
			_currentAction = "New";
		}
		
		public function Busy():void{
			_new.enabled 	= false;
			_update.enabled = false;
			_delete.enabled = false;
			_add.enabled 	= false;
			_cancel.visible = false;
		}
		
		public function Update():void{
			alertControl("Actualizar este registro?")
			_currentAction = "Update";
		}
		
		public function dataChange():void{
			_new.enabled 	= false;
			_delete.enabled = false;
			_add.enabled 	= false;
			_cancel.visible = true;
			_currentAction = "New";
			_update.enabled = true;
		}
		
		
		public function Add():void{
			alertControl("Agregar estos datos?")
			_currentAction = "Add";
		}
		
		public function Delete():void{
			alertControl("Borrar este registro?");
			_currentAction = "Delete";
		}
		
		public function Cancel():void{
			_cancelFunction();
			Ini();
		}
		
		private function alertControl(msg:String):void{
			Alert.show(msg,"Atención",Alert.OK|Alert.CANCEL,null,alertConfirm);
		}
		
		private function alertConfirm(e:CloseEvent):void{
			if(e.detail==Alert.OK){
				switch(_currentAction){
					case "Delete":
						_deleteFunction();
						
						break;
					case "Update":
					_updateFunction();
						
						break;
					case "Add":
						_addFunction();
						
						break;
					case "New":
						break;
				}
			}
		}
		
	}
}