<?php
require_once("DataSource.php");
require_once("UserAuth.php");
require_once("Logger.php");
require_once("Clients.php");

class Users{
	
	public function __construct(){
		$this->ds 		= new DataSource();
		$this->userAuth = new UserAuth();
		$this->logger 	= new Logger();
		$this->clients 	= new Clients();
	}
	
	function newUser($params){
		$userMail		= $params["userMail"];
		$pass			= $params["pass"];
		$this->ds->connect();

		$res = $this->ds->query("select * from _ltpv_useraccess where _mail = '".$userMail."'");
		
		if(mysql_num_rows($res)==0){
			$userId = $this->clients->getUserId();
			$res 	= $this->ds->query("insert into _ltpv_useraccess values(NULL,'".$userId."','".$userMail."','".$pass."')");
			if($res){
				$params["userId"] 			= $userId;
				$params["userType"] 		= 4;
				$params["operationDate"] 	= date("Y-n-j");
				$params["birthdate"]		= date("Y-n-j");
				$params["mail"]				= $userMail;
				$resb 						= $this->clients->newTitularInformation($params);
				return $userId;
			}else{
				throw new Exception("Connection Error");
			}
		}else{
			return false;
		}
	}
	
	function tempUser(){
		
		$this->ds->connect();

		$userId = $this->clients->getUserId();
		$res 	= $this->ds->query("insert into _ltpv_useraccess values(NULL,'".$userId."','".$userId."','".$this->generatePassword(7,3)."')");
		if($res){
			$params["userId"] 			= $userId;
			$params["userType"] 		= 4;
			$params["operationDate"] 	= date("Y-n-j");
			$params["birthdate"]		= date("Y-n-j");
			$params["mail"]				= "";
			$resb 						= $this->clients->newTitularInformation($params);
			return $userId;
		}else{
			throw new Exception("Connection Error");
		}
		
	}
	
	function updateTempUser($params){
		$userMail		= $params["userMail"];
		$userId			= $params["userId"];
		$this->ds->connect();
		$res 	= $this->ds->query("update _ltpv_useraccess set _mail = '".$userMail."' where _userId = '".$userId."'");
		return true;
	}
	
	
	function loginUser($params){
		$userMail		= $params["userMail"];
		$pass			= $params["pass"];
		$this->ds->connect();
		
		$res = $this->ds->query("select * from _ltpv_useraccess where _mail = '".$userMail."' and _pass = '".$pass."'");
		
		if(mysql_num_rows($res)!=0){
			$row = mysql_fetch_row($res);
			return $row[1];
		}else{
			return false;
		}
	}
	
	function loginClient($params){
		$userMail		= $params["userMail"];
		$pass			= $params["pass"];
		$this->ds->connect();
		
		$res = $this->ds->query("select * from _ltpv_useraccess where _mail = '".$userMail."' and _pass = '".$pass."'");
		
		if(mysql_num_rows($res)!=0){
			$row = mysql_fetch_row($res);
			return $row[1];
		}else{
			throw new Exception("Invalid User or PassWord");
		}
	}
	
	
	
	function generatePassword($length=5, $strength=0) {
		$vowels = 'aeuy';
		$consonants = 'bdghjmnpqrstvz';
		if ($strength & 1) {
			$consonants .= 'BDGHJLMNPQRSTVWXZ';
		}
		if ($strength & 2) {
			$vowels .= "AEUY";
		}
		if ($strength & 4) {
			$consonants .= '23456789';
		}
		if ($strength & 8) {
			$consonants .= '@#$%';
		}
	 
		$password = '';
		$alt = time() % 2;
		for ($i = 0; $i < $length; $i++) {
			if ($alt == 1) {
				$password .= $consonants[(rand() % strlen($consonants))];
				$alt = 0;
			} else {
				$password .= $vowels[(rand() % strlen($vowels))];
				$alt = 1;
			}
		}
		return $password;
	}
			
}


?>