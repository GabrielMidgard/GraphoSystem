<?php class DataSource{

	protected $hostname 	= "localhost"; 
	protected $userid 		= "mmtti_usr";
	protected $password 	= "mmtti_psw";
	protected $port 		= "3306"; 
	protected $connection;
	protected $database 	= "Marmoletti_WEB";
	
	public function connect(){ 
		$this->connection = mysql_connect($this->hostname, $this->userid, $this->password); 
		if ($this->connection == false) throw new Exception(mysql_error()); 
		mysql_select_db($this->database, $this->connection);
       // return $this->database;
	} 
	
	public function disconnect(){
		mysql_close($this->connection); 
	} 
	
	public function query($query){ 
		return mysql_query($query); 
	} 
	
	public function backUp(){
		$backupFile = $this->database ."__". date("Y-m-d-H-i-s") . '.gz';
		$command = "mysqldump --opt -h ".$this->hostname." -u ".$this->userid." -p ".$this->password." ".$this->database." | gzip > $backupFile";
		system($command);
		
		$dump = ob_get_contents(); 
		ob_end_clean(); 
		
		
		$uploadDir = $_SERVER['DOCUMENT_ROOT'].'/db_BackUp/'; 
		$fp = fopen($uploadDir.$backupFile, "w"); 
		fputs($fp, $dump); 
		fclose($fp); 

		return $backupFile;
	}

} 
?>