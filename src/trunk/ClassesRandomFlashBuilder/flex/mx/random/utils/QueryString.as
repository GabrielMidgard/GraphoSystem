package mx.random.utils{
	
	import flash.external.*;
	
	public class QueryString{
		

		private var _queryString:String;
		private var _all:String;
		private var _params:Object;
		private var _host:Object;
		
		public function get qryString():String{
			return _queryString;
		}
		public function get url():String{
			return _all;
		}
		public function get parameters():Object	{
			return _params;
		}		
		public function get host():Object	{
			return _host;
		}		

		
		public function QueryString():void{
			readQueryString();
		}

		private function readQueryString():void{
			_params = {};
			try 
			{
				_all =  ExternalInterface.call("window.location.href.toString");
				_queryString = ExternalInterface.call("window.location.search.substring", 1);
				
				var orgPathArray:Array = _all.split("/");
					
				if(orgPathArray.length > 1){
					_host = orgPathArray[2];	
				}
				
				
				if(_queryString)
				{
					
					var params:Array = _queryString.split('&');
					var length:int = params.length;
					var index:Number=-1;
					for (var i:int=0; i<length; i++) 
					{
						var kvPair:String = params[i];
						if((index = kvPair.indexOf("=")) > 0)
						{
							var key:String = kvPair.substring(0,index);
							var value:String = kvPair.substring(index+1);
							_params[key] = value;
						}
					}
				}
			}catch(e:Error) { trace("Some error occured. ExternalInterface doesn't work in Standalone player."); }
		}


	}
}