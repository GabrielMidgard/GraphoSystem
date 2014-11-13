<?php 

date_default_timezone_set('America/Mexico_City');
setlocale(LC_TIME, "es_MX.UTF-8","es_ES.UTF-8","es_ES","es_MX");

class DataSource{

	protected $hostname 	= "localhost";
	protected $userid 	    = "root";
	protected $password 	= "cl10311112#";
	protected $port 		= "3306";
	protected $database 	= "randomestudio_grapho";
	

	protected $mysqli;
	
	public	  $mailerUser		= "developer@nice.com";
	public	  $mailerPsw		= "000000";
	public 	  $mailHost		= "{mail.grapho.com:143/novalidate-cert}INBOX";
	
		
	public    $TEST = false;
	public 	  $tools;
	
    public    $host         = "http://grapho.random.mx/";
    public    $tempHost     = "http://grapho.random.mx/";

    public    $publicDir    = "___PublicData/";
    public    $rootDir      = "___PublicData/___ROOT/";
    public    $tempDir      = "___PublicData/___TEMPFILES/";
    public    $upldDir      = "___PublicData/___UPLOADER/";

    public    $dataDir      = "___DATA/";
    public    $codesDir     = "___DATA/_codigos/";
    public    $employesDir  = "___DATA/_empleados/";
    public    $signsDir     = "___DATA/_firmas/";
	
	public	  $xmlHost					= "___PublicDataB/_xml/";	
	public	  $comHost					= "___PublicDataB/_com/";
	public	  $tmpHost					= "___PublicDataB/_tmp/";
	public	  $errHost					= "___PublicDataB/_err/";
	
	public	  $processedPdfHost		= "___PublicDataB/_processed/_pdf/";
	public	  $processedXmlHost		= "___PublicDataB/_processed/_xml/";
	
		
	
	
	public	  $procXmlHost	= "___PublicData/_procXml/";
	public	  $errXmlHost	= "___PublicData/_errXml/";
	public	  $procPdfHost	= "___PublicData/_procPdf/";
	
	public	  $certDir		= "___PublicData/_userData/";
	public	  $CFDIDir		= "___PublicData/_userData/_cfdi/";
	//public	  $tmpHost		= "___PublicData/_tmp/";
	
	
	
	public 	  $WSDL_User		= "factura@nice.random.com/";
	public 	  $WSDL_Psw		= "0000000";	
	
	
	public 	  $PWSDL_User		= "demo";
	public 	  $PWSDL_Psw		= "123456789";	
	public	  $PKey				= "0000000";
	public 	  $PPass			= "0000000";
	
	
	
	
	public	  $WSDL_Auth			= "https://service.asmx?wsdl";
	public	  $WSDL_Timbrado		= "https://service.asmx?wsdl";
	public	  $WSDL_Cancelacion	= "https://service.asmx?wsdl";
	
	
	public	  $PWSDL_Auth			= "https://service.asmx?wsdl";
	public	  $PWSDL_Timbrado		= "https://service.asmx?wsdl";
	public	  $PWSDL_Cancelacion	= "https://service.asmx?wsdl";
	
	public $FOUND_ROWS ="";
	public $normalizeData = false;
	
	public function __construct(){
   		//$this->tools = new Tools();
    }
		

    public function getPaths(){
      $paths                = "";
      $paths['HOST']        = $this->host;
      $paths['ROOT']        = $this->rootDir; 
      $paths['TEMP']        = $this->tempDir;
      $paths['UPLOAD']      = $this->upldDir;
      $paths['PUBLIC']      = $this->publicDir;

      $paths['DATA']        = $this->dataDir;
      $paths['CODES']       = $this->codesDir;
      $paths['EMPLOYES']    = $this->employesDir;
      $paths['SIGNS']       = $this->signsDir;

      return $paths;
    }

	
	public function connect(){
		$this->mysqli = new mysqli($this->hostname, $this->userid, $this->password,$this->database);
		if ($this->mysqli->connect_error) throw new Exception($this->mysqli->connect_error);	
		$this->mysqli->set_charset('utf8');					
	}

	public function disconnect(){
		$this->mysqli->close();
	}

	public function query($query,$id = false,$foundRounds=false,$debug=false){
        $this->connect();
        $res = $this->mysqli->query($query);		 
		if($debug){
			$debugRes  = "MySQL_Query : ".$query."\n";
			$debugRes .= "MySQL_Error : ".$this->mysqli->error."\n";
        	return $debugRes;
		}
        if($id){
          $res = $this->mysqli->insert_id;
		   return $res;
        }	
		if($foundRounds){
			$sqlTotal='SELECT FOUND_ROWS() AS total;';
			$queryTotal=$this->mysqli->query($sqlTotal);
			$totalCampos=$queryTotal->fetch_object()->total;	
			$this->FOUND_ROWS=$totalCampos;
		}	
		
		if($this->normalizeData){
			return $this->normalize($res);
		}
       				
		$this->disconnect();
		 
        return $res;
	}

     public function insertSQL($table,$params,$resId = false){
        foreach( $params as $key => $value){
        	$fields .= $key.",";
            $values .= "'".($value)."',";
        }
        //throw new Exception("insert into ".$table." (".substr($fields,0,-1).") values(".substr($values,0,-1).")");
        return $this->query("insert into ".$table." (".substr($fields,0,-1).") values(".substr($values,0,-1).")",$resId);
    }
	
	
	  public function insertSQLWCH($table,$params,$resId = false){
		$tableFields = $this->getFields($table);   
		  
        foreach( $params as $key => $value){
			if($this->searchField($tableFields,$key)){
				$fields .= $key.",";
				$values .= "'".($value)."',";
			}
        }
        //throw new Exception("insert into ".$table." (".substr($fields,0,-1).") values(".substr($values,0,-1).")");
        return $this->query("insert into ".$table." (".substr($fields,0,-1).") values(".substr($values,0,-1).")",$resId);
    }
	
	public function getFields($table){
		$res =   $this->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$table."'");
		$fields = array();
		while($row=$res->fetch_object()){
			array_push($fields,$row->COLUMN_NAME);
		}
		return $fields;
	}
	
	public function searchField($tableFields,$key){		
		for($n=0;$n<count($tableFields);$n++){
			if($tableFields[$n] == $key) return true;
		}
		return false;
	}
	
	public function pushNot($idCliente,$message){
		
		$token='68be467783a7122641e3b39216962c461a317acd22da25dbb0eb35b61faa2e15'; 
		$ctx = stream_context_create();
		stream_context_set_option($ctx, 'ssl', 'local_cert', 'MRM_PushNotPemKey.pem');
		stream_context_set_option($ctx, 'ssl', 'passphrase', 'cmm2kcmm2k');
		
		$fp = stream_socket_client('ssl://gateway.sandbox.push.apple.com:2195', $err,$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);
		
		if (!$fp){
			echo("Failed to connect: $err $errstr" . PHP_EOL);
			return;
		}
		
		$body['aps'] = array('alert' => $message,'sound' => 'default');
		$payload = json_encode($body);
		$msg = chr(0).pack('n', 32).pack('H*', $token).pack('n', strlen($payload)).$payload;
		$result = fwrite($fp, $msg, strlen($msg));
		fclose($fp);
		
		return;
	}

    public function updateSQL($table,$params,$idName,$condition,$id){
        $values = "";
        foreach( $params as $key => $value){
          if($key!=$idName) $values .= $key."='".($value)."',";
        }
        $values = substr($values,0,-1);
        //throw new Exception("update ".$table." set ".$values." where ".$idName.$condition."'".$id."'");
        return $this->query("update ".$table." set ".$values." where ".$idName.$condition."'".$id."'");
    }

     public function selectSQL($table,$fields,$where="",$condition="",$id=""){
       if($where != "") $where = " where ".$where.$condition."'".$id."'";  
	 
		//throw new Exception("select ".$fields." from ".$table.$where);      
		return $this->normalize($this->query("select ".$fields." from ".$table.$where));    
	  }    
	  
	  public function deleteSQL($table,$field,$condition,$id){      
	  	return $this->query("delete from ".$table." where ".$field.$condition."'".$id."'");    
	  }		
	  
	  
	  public function normalize($res){		
	  	$result = array();	
			if($res)	{		while($row = $res->fetch_object()){			
				array_push($result,$row);		
			}		
	  	}
		return $result;	
	   }
}
			
?>
