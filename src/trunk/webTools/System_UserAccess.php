<?php

require_once("DataSource.php");

class System_UserAccess{

	protected $ds;
	protected $logger;
    protected $table        = "___adminUsers";
    protected $roleTable    = "___adminRoles";
    protected $groupTable    = "___adminGroups";
    protected $employeTable    = "empleados_accesos";
    protected $cClock ;

	public function __construct(){
		$this->ds = new DataSource();
	}


    public function login($params){
		//$params["username"] = $user;
		//$params["password"] = $pas;	
						
		$result = $this->ds->query("SELECT * FROM ".$this->table." WHERE _login='".$params["username"]."' AND _psw = '".$params["password"]."'");
		if($result->num_rows==1){
			$userInfo      		  = mysqli_fetch_object($result);
	
			$roles                  = mysqli_fetch_object($this->ds->query("SELECT * FROM ".$this->roleTable." WHERE _roleId='".$userInfo->_roleId."'"));
			$userInfo->role         = $roles->_roleName;
			$groups                 = mysqli_fetch_object($this->ds->query("SELECT * FROM ".$this->groupTable." WHERE _groupId='".$userInfo->_groupId."'"));
			$userInfo->_groupName   = $groups->_groupName;
			$userInfo->_accessType  = -1;
			$userInfo->_idSucursal  = 0;
			$userInfo->_idEmpleado  = 0;
	
			$userStruct["user"]     = $userInfo;
			$userStruct["paths"]    = $this->ds->getPaths();		
			$_SESSION["RND_DATA"]   = true;
			$_SESSION["USER"]       = $userInfo;
			return $userStruct;
		}else{
			throw new Exception('Invalid Username or Password');
		}
	 }


	public function silentLogout($parameters){
		$_SESSION["RND_DATA"] = false;
		$_SESSION["USER"] = "";
        
		return "OK";
	}
	
	public function appLogout($parameters){
		$_SESSION["RND_DATA"] = false;
		$_SESSION["USER"] = "";
       
		return "OK";
	}
	
	public function checkCredentials($roles){
				
	}
	
	
}

?>
