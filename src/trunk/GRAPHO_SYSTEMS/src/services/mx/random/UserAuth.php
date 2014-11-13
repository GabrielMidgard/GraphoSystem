<?php
require_once("Logger.php");
require_once("DataSource.php");

class UserAuth{

	protected $ds;
	protected $logger;

	public function __construct(){
		$this->ds = new DataSource();
		$this->logger = new Logger();
		$this->logger->trace("UserAuth > ==========================================================================");		
	}

	
    public function login($parameters){

		$username = $parameters["username"];
		$password = $parameters["password"];
		
		$this->logger->trace("UserAuth > login attempt with: user =".$username.", password = ".$password.", hashed password = ".md5($password));
		
		// connect to the database where the settings are, execute the query and make sure records are returned
		$this->ds->connect();		
		
		//First lets make sure it is a user
		$userInfoSQL = "
			select u.*, r.name as role from admin_user as u, admin_user_role as ur, admin_role as r
			where u.user_name = '".$username."'
			and u.password = '".$password."'
			and ur.user_id = u.user_id 
			and ur.role_id = r.role_id 
		";
		
		//and u.password = '".md5($password)."'

		$userInfoRecords = $this->ds->query($userInfoSQL);
		$userRecordCount = mysql_num_rows($userInfoRecords);
		if($userRecordCount != 1){
			throw new Exception("Invalid credentials");
		}
		
		$userInfo = mysql_fetch_object($userInfoRecords);
		
		$this->logger->trace("UserAuth > Login successful");
		
		$userStruct["user"] = $userInfo;
		
		$_SESSION["user"] = $userInfo;
		$_SESSION["isVXAuthenticated"] = true;
		
		$this->ds->disconnect();
				
		return $userStruct;

    }	
	
	
	public function silentLogout($parameters){
		$_SESSION["isVXAuthenticated"] = false;
		$_SESSION["user"] = "";
		return "OK";
	}
	
	public function appLogout($parameters){
		$_SESSION["isVXAuthenticated"] = false;
		$_SESSION["user"] = "";
		return "OK";
	}
	
	public function checkCredentials($roles){
		
		$this->logger->trace("UserAuth > checkCredentials user = ".var_dump($_SESSION["user"]));
		$this->logger->trace("UserAuth > checkCredentials roles = ".$roles);
		// If there is no authentication throw exception
		if(!$_SESSION["isVXAuthenticated"]){
			$this->logger->trace("UserAuth > Unauthenticated, Access denied, please login");	
			throw new Exception("Unauthenticated Access, denied, please login");
		}else{
			// If there is authentication but the role is not sufficient, throw exception
			if($roles){
				
				$roleArray = explode(",", $roles);
				$this->logger->trace("UserAuth > checkCredentials roles exploded");
				reset($roleArray);
				$roleMatched = false;
				foreach ($roleArray as $value){
					$this->logger->trace("UserAuth > checkCredentials ".$_SESSION["user"]->role." vs ".$value);
					if($_SESSION["user"]->role == $value) $roleMatched = true;
				}
				if(!$roleMatched){
					$this->logger->trace("UserAuth >Insufficient Role, Access denied");	
					throw new Exception("Insufficient Role, Access denied");
					
				}
				
			}
		}
	}
	
	
}
/*
$userAuth = new UserAuth();
$params["username"] = "oros";
$params["password"] = "asdasd";

$loginRes = $userAuth->login($params);
var_dump($loginRes);
*/

?>
