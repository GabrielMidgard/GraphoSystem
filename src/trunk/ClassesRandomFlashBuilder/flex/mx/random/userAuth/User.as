package mx.random.userAuth {

	import mx.random.constants.SystemGlobals;
	import mx.utils.StringUtil;

	[Bindable]
	public class User {

		private var _roleHash:Object;
		
		public var userId:Number;
		public var roleId:Number;
		public var groupId:Number;
		public var accessType:Number;
		public var groupName:String = "";
		public var firstName:String = "";
		public var lastName_1:String = "";
		public var lastName_2:String = "";
		public var login:String;
		public var psw:String;
		public var mail:String;
		public var active:String;
		public var download:String = "";		
		public var upload:String = "";
		public var edit:String = "";
		public var path:String = "";
		public var auth:String = "";
		public var role:String = "";
		public var idEmpleado:String ="";
		public var token:String ="";
		
		public var idArea:Number;
		public var idPuesto:Number;
		public var idDepartamento:Number;
		public var idCECO:Number;
		public var idUbicacion:Number;
		public var idCategoria:Number;
		public var idCompania:Number;
		public var idSucursal:Number;
		
		
		public function get fullName():String{
			return firstName+" "+lastName_1+" "+lastName_2
		}

		/*
		 *
		 */
		public static var validUserPropertyNames:Object = {
			_userName: 		"username",
			_firstName: 	"firstName",	
			_lastName_1: 	"lastName_1",
			_lastName_2: 	"lastName_2",
			
			_nombre: 		"firstName",	
			_paterno: 		"lastName_1",
			_materno: 		"lastName_2",
			_nivel: 		"roleId",
			_idUsuario:		"userId",
			userId: 		"groupId",
			
			_mail: 			"mail",
			_roleId: 		"roleId",
			_active: 		"active",
			_psw: 			"psw",
			_userId: 		"userId",
			_download: 		"download",
			_upload:		"upload",
			_path:			"path",
			_auth:			"auth",
			_groupId:		"groupId",
			_groupName:		"groupName",
			_accessType:	"accessType",
			_idArea:		"idArea",
			_idPuesto:		"idPuesto",
			_idDepartamento:"idDepartamento",
			_idCECO:		"idCECO",
			_idUbicacion:	"idUbicacion",
			_idCategoria:	"idCategoria",
			_idCompania:	"idCompania",
			_idEmpleado:	"idEmpleado",
			_idSucursal:	"idSucursal",
			_token:			"token",
			token:			"token",
			role:			"role"
		};


		function User(userRecord:Object=null) {
			update(userRecord);
		}


		public function inAnyRole(rolesString:String):Boolean {
			if(rolesString != null){
				var roles:Array = rolesString.split(",");
				for (var i:Number = 0; i < roles.length; i++){
					var roleName:String = StringUtil.trim(roles[i]);
					if(_roleHash != null){
						if (_roleHash[roleName]) return true;	
					}
				}
			}
			
			return false;
		}


		public function update(userRecord:Object=null):void {
			if(!userRecord) return;
			// Fill the user object's properties from whatever is in the userRecord
			for (var p:String in userRecord){ 
				var propertyName:String = validUserPropertyNames[p];
				if (propertyName) this[propertyName] = userRecord[p];
				if (propertyName=='token') SystemGlobals.token = userRecord[p];
			}
			

			// Fill the roleHash with role names in the roles string.
			if(role != null){
				var roleNames:Array = role.split(",");
				_roleHash = {};
				for (var i:Number = 0; i < roleNames.length; i++){
					_roleHash[roleNames[i]] = true;
				}	
			}
		}
	}
}






