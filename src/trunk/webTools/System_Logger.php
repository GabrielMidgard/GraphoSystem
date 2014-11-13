<?php

class System_Logger{

	
	
	public function trace($msg){
		
		

		if(!isset($_SERVER['DOCUMENT_ROOT'])){ 
			$n = $_SERVER['SCRIPT_NAME']; 
			$f = ereg_replace('\\\\', '/',$_SERVER["PATH_TRANSLATED"]); 
			$f = str_replace('//','/',$f); 
			$_SERVER['DOCUMENT_ROOT'] = eregi_replace($n, "", $f); 
		} 
		$file = fopen($_SERVER['DOCUMENT_ROOT']."/___WoLogger/logger.txt","a");
		$contenido =  "\n ".date("Y-n-j")." ".date("h:m:s")." ||    ".$msg;
		fwrite($file,$contenido);
		fclose($file);
	}
	
}

?>