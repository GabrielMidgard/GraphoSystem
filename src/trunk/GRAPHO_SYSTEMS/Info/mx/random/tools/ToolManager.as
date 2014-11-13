package mx.random.tools{
	
	[Bindable]
	public class ToolManager{
		
		
		public static var PICK_TOOL:String 				= "pick_tool";
		public static var SELECT_TOOL:String 			= "select_tool";
		public static var MOVE_TOOL:String 				= "move_tool";
		public static var NEW_TOOL:String 				= "new_tool";
		public static var DRAW_TOOL:String 				= "draw_tool";
		public static var DELETE_CONNECTION_TOOL:String = "delete_connection_tool";

		public static var currentTool:String;
		public static var toolIndex:Number;
		
		public function ToolManager(){
			currentTool = ToolManager.PICK_TOOL;
			toolIndex = 0;
		}
		
		public function changeTool(tool:String):void{
			switch(tool){
				case ToolManager.PICK_TOOL:
					ToolManager.currentTool = ToolManager.PICK_TOOL;
					ToolManager.toolIndex = 0;
					break;
				case ToolManager.MOVE_TOOL:
					ToolManager.currentTool = ToolManager.MOVE_TOOL;
					ToolManager.toolIndex = 1;
					break;
				case ToolManager.SELECT_TOOL:
					ToolManager.currentTool = ToolManager.SELECT_TOOL;
					ToolManager.toolIndex = 2;
					break;
				case ToolManager.NEW_TOOL:
					ToolManager.currentTool = ToolManager.NEW_TOOL;
					ToolManager.toolIndex = 3;
					break;
				case ToolManager.DRAW_TOOL:
					ToolManager.currentTool = ToolManager.DRAW_TOOL;
					ToolManager.toolIndex = 4;
					break;
				case ToolManager.DELETE_CONNECTION_TOOL:
					ToolManager.currentTool = ToolManager.DELETE_CONNECTION_TOOL;
					ToolManager.toolIndex = 5;
					break;
			}
		}

	}
}