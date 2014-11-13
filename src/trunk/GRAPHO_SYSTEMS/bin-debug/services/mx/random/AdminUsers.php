<?php
require_once("DataSource.php");
require_once("UserAuth.php");
require_once("Logger.php");
 
class AdminUsers {
 
    protected $ds;
    protected $userAuth;
    protected $logger;
    
    public function __construct(){
        $this->ds         	= new DataSource();
        $this->userAuth 	= new UserAuth();
        $this->logger     	= new Logger();
    }
 
	public function newUser($params){
		//$this->userAuth->checkCredentials();
		$user_id				= $params['user_id'];
		$user_name				= $params['user_name'];
		$password				= $params['password'];
		$firs_name				= $params['first_name'];
		$last_name1				= $params['last_name1'];
		$last_name2				= $params['last_name2'];
		$email					= $params['email'];

		$sql  = "insert into admin_user values (Null, ";
		$sql .=	"'".$user_name."', ";
		$sql .=	"'".$password."', ";
		$sql .=	"'".$firs_name."', ";
		$sql .=	"'".$last_name1."', ";
		$sql .=	"'".$last_name2."', ";
		$sql .=	"'".$email."')";

		//throw new Exception($sql);
		$this->ds->connect();
		$res 		= $this->ds->query($sql);
		$userId 	= mysql_insert_id();
		$sql 		= "insert into admin_user_role values(".$userId.",0)";
		$this->ds->disconnect();
		return $res;
	}
 
	public function getUsers(){
		$sql  = "select * from admin_user";
		//throw new Exception($sql);
		$this->ds->connect();
		$res = $this->ds->query($sql);
		$this->ds->disconnect();
		return $res;
	}
 
	public function deleteUser($params){
		//throw new Exception($sql);
		$this->ds->connect();
		$sql  = "delete from admin_user where user_id = ".$params ;
		$res = $this->ds->query($sql);
		$sql  = "delete from admin_user_role where user_id = ".$params ;
		$res = $this->ds->query($sql);
		$this->ds->disconnect();
		return $res;
	}
 
	public function updateUser($params){
		//$this->userAuth->checkCredentials();
		$user_id				= $params['user_id'];
		$user_name				= $params['user_name'];
		$password				= $params['password'];
		$firs_name				= $params['firs_name'];
		$last_name1				= $params['last_name1'];
		$last_name2				= $params['last_name2'];
		$email					= $params['email'];

		$sql  = "update admin_user set ";
		$sql .=	"user_name="."'".			$user_name."', ";
		$sql .=	"password="."'".			$password."', ";
		$sql .=	"first_name="."'".			$firs_name."', ";
		$sql .=	"last_name1="."'".			$last_name1."', ";
		$sql .=	"last_name2="."'".			$last_name2."', ";
		$sql .=	"email="."'".			$email."'";

		$sql .=  " where _id = ".$user_id.';';

		//throw new Exception($sql);
		$this->ds->connect();
		$res = $this->ds->queryId($sql);
		$this->ds->disconnect();
		return $res;
	}
 
	public function selectUserById($params){
		$sql  = "select * from admin_user where _id = ".$params ;

		//throw new Exception($sql);
		$this->ds->connect();
		$res = $this->ds->query($sql);
		$this->ds->disconnect();
		return $res;
	}
	
	public function getUserLevel($userId){
		$sql  = "select role_id from admin_user_role where user_id = ".$userId ;

		//throw new Exception($sql);
		$this->ds->connect();
		$res = $this->ds->query($sql);
		if($fila=mysql_fetch_row($res)){
			return $fila[0];
		}else{
			return false;
		}
		$this->ds->disconnect();
	}
	
	public function updateUserLevel($params){
		$sql  = "update admin_user_role set role_id = ".$params["userLevel"]." where user_id = ".$params["user_id"] ;
		//throw new Exception($sql);
		$this->ds->connect();
		if($this->ds->query($sql)){
			return true;
		}else{
			return false;
		}
		$this->ds->disconnect();
	}
 
}
?>