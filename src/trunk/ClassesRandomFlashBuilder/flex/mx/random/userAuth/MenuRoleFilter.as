package mx.random.userAuth{
	
	public class MenuRoleFilter	{
		
		public function MenuRoleFilter(){
			
		}
		
		static public function filterMenuItemXMLList(unfilteredXMLList:XMLList, user:User):XMLList{
			if (!user) return null;

			var filtered:XMLList = unfilteredXMLList.copy();
			filterNodes(filtered, user);
						
			return filtered;
		}
		
		static protected function filterNodes(node:XMLList, user:User):void{
			
			var deleteList:Array = [];
			deleteList.length = 0;
			var i:Number = 0;
			
			if(node.hasComplexContent()){
				
				for each (var menuItem:XML in node) {
					if (! user.inAnyRole(menuItem.@roles)&&menuItem.@roles!="*") {
						deleteList.push(i);
					};
					i++;
				}
				
				for (i = deleteList.length - 1; i >= 0; i--) {
					delete node[deleteList[i]]; 
				} 
				
				// Run through what's left to see if we need to go a level deeper:
				for each (var submenuItem:XML in node) {
					if (submenuItem.hasComplexContent()) filterNodes(submenuItem.menuitem, user)
				}
			
			}
			
		}

	}
}