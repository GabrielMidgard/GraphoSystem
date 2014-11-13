package mx.random.cms
{
	[Bindable]
	public class FileData{
		
		public var name:String 		= "";
		public var size:String 		= "";
		public var object:Object 	= new Object();
		public var estatus:String 	= "";
		public var ind:Boolean 		= false
		public var modo:String 		= "";
		public var en:Boolean  		= false;
		public var vis:Boolean  	= true;
		public var prog:Number		= 0;
		
		public function FileData(_name:String,_size:String,_object:Object,_estatus:String,_ind:Boolean,_modo:String,_en:Boolean,_vis:Boolean){
			name	= _name;
			size	= _size;
			object	= _object;
			estatus	= _estatus;
			ind		= _ind;
			modo	= _modo;
			en		= _en;
			vis		= _vis;
		}

	}
}