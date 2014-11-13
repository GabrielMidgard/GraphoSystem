package mx.random.cms.userAuth {

	import mx.utils.StringUtil;
	[Bindable]
	public class User {

		private var _roleHash:Object;
		
		public var user_id:Number;
		public var email:String;
		public var phone:String;
		public var firstName:String = "";
		public var lastName1:String = "";
		public var lastName2:String = "";
		public var password:String;
		public var role:String;
		public var status:String;
		public var username:String;
		public var version:Number;
		public var path:String = "";
		public var upload:String = "";
		public var download:String = "";
		public var auth:String = "";
		
		
		public function get fullName():String{
			
			if(!firstName) firstName = "";
			if(!lastName1) lastName1 = "";
			if(!lastName2) lastName2 = "";
			
			var lastName:String = "";
			if(lastName1 != "" && lastName2 != ""){
				lastName = " "+lastName1 +" "+lastName2;
			} else if(lastName1 != ""){
				lastName = " "+lastName1;
			} else if(lastName2 != ""){
				lastName = " "+lastName2;
			}
			
			if(firstName != "" && lastName != ""){
				return " "+firstName +" "+lastName;
			} else if(firstName != ""){
				return " "+firstName;
			} else if(lastName != ""){
				return " "+lastName;
			}else{
				return "";
			}
		}

		/*
		 *
		 */
		public static var validUserPropertyNames:Object = {
			user_name: "username",
			username: "username",
			userName: "username",
			phone: "phone",
			telephone: "phone",
			first_name: "firstName",
			firstname: "firstName",
			last_name: "lastName1",
			lastname: "lastName1",
			last_name1: "lastName1",
			lastname1: "lastName1",
			last_name2: "lastName2",
			lastname2: "lastName2",
			version: "version",
			email: "email",
			e_mail: "email",
			role: "role",
			status: "status",
			password: "password",
			user_id: "user_id",
			download: "download",
			upload:"upload",
			path:"path",
			auth:"auth"
		};


		/**
		 * <p></p>
		 */
		function User(userRecord:Object=null) {
			update(userRecord);
		}

		/**
		 * <p></p>
		 */
		public function inAnyRole(rolesString:String):Boolean {
			var roles:Array = rolesString.split(",");
			for (var i:Number = 0; i < roles.length; i++){
				var roleName:String = StringUtil.trim(roles[i]);
				if (_roleHash[roleName]) return true;
			}
			return false;
		}

		/**
		 * <p></p>
		 */
		public function update(userRecord:Object=null):void {
			if(!userRecord) return;
			// Fill the user object's properties from whatever is in the userRecord
			for (var p:String in userRecord){ 
				var propertyName:String = validUserPropertyNames[p.toLowerCase()];
				if (propertyName) this[propertyName] = userRecord[p];
			}

			// Fill the roleHash with role names in the roles string.
			var roleNames:Array = role.split(",");
			_roleHash = {};
			for (var i:Number = 0; i < roleNames.length; i++){
				_roleHash[roleNames[i]] = true;
			}


		}
	}
}






