<?php
require_once("DataSource.php");
class MailButlerClass{
  
  
  	private $host;			//= "{mail.sumakuatro.com:143/novalidate-cert}INBOX"; 
	private $login;		//= "bridge@sumakuatro.com"; 
	private $password;		//= "mail_user_2014"; 
	private $savedirpath;
	private $savedirPDFpath;  
	private $facturas;
	
	private $XMLpath;
	private $TMPpath;
	private $ProcessedPDFpath;
	private $ProcessedXMLpath;
	private $COMpath;
	private $ERRpath;
  	
	protected $imap;
	protected $ds;
	protected $table           = "mail_Butler";
	protected $mainId          = "_idConfig";

  	public function __construct(){
    	$this->ds 				= new DataSource();
		//$this->facturas 		= new Facturas();
		$this->host 			= $this->ds->mailHost;
		$this->login 			= $this->ds->mailerUser;
		$this->password 		= $this->ds->mailerPsw;
		
		$this->XMLpath 				= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->xmlHost;		
		$this->COMpath 				= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->comHost;
		$this->ERRpath 				= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->errHost;
		$this->TMPpath  				= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->tmpHost;
		
		$this->ProcessedPDFpath 		= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->processedPdfHost;
		$this->ProcessedXMLpath 		= $_SERVER["DOCUMENT_ROOT"]."/".$this->ds->processedXmlHost;
  	}

	private function connectImap(){		
		return ($this->imap = @imap_open($this->host, $this->login, $this->password));
	}
	
	private function colseImap(){		
		return imap_close($this->imap);
	}
	
	
	public function getMail(){
		$this->connectImap();
		$message_count 		= imap_num_msg($this->imap);
		$mails 					= array();
		$unseen 	= 1;
		$att 	 	= 0;
		for ($m = 1; $m <= $message_count; ++$m){		
			$header 				= imap_header($this->imap, $m);
			$mail 					= '';
			$mail->_from 			= $header->from[0]->mailbox.'@'.$header->from[0]->host;
			$mail->_fromAddress 	= $header->from[0]->personal;
			$mail->_to 			= $header->to[0]->mailbox;
			$mail->_subject 		= $header->subject;
			$mail->_messageId 		= $header->message_id;
			$mail->_udate 			= $header->udate;
			$mail->_msgNo 			= $header->Msgno;
			$mail->_date 			= $header->date;
			$mail->_recent			= $header->Recent;
			$mail->_unseen			= $header->Unseen;
			$mail->_flagged		= $header->Flagged;
			$mail->_answered		= $header->Answered;
			$mail->_deleted		= $header->Deleted;
			$mail->_draft			= $header->Draft;
			$mail->_size			= $header->Size;
			
			$structure 			= imap_fetchstructure($this->imap, $m);		
			$mail->_attachments	= $this->checkAttachments($m,$structure,array(),1);	
					
		
			
			if($mail->_unseen!=''){							
				$unseen 	= 0;				
			}
			if(count($mail->_attachments)!=0){
				//return $mail;  
				$att 	   = 2;	
			}
			
				
			$mail->_status			= $unseen.$att;
			$mails[] 				= $mail;
			
		}
		//throw new Exception($mail->_messageId);
		$this->colseImap();
		return $mails;
	}
	
	public function getAttachments($messageId,$saveFiles=false){
		$this->connectImap();
		$message_count 		= imap_num_msg($this->imap);
		$result = array();
		for ($m = 1; $m <= $message_count; ++$m){		
			$header 				= imap_header($this->imap, $m);
			if($header->message_id==$messageId){
				$structure 			= imap_fetchstructure($this->imap, $m);		
				$attachments		    = $this->extractAttachments($m,$structure,array(),1);
				if($saveFiles){
					foreach ($attachments as $key => $attachment) {
						$result[] = $this->saveAttachment($attachment);
					}
				}
				$this->colseImap();				
				return $this->processFileNames($result);
				return $result;
			}
		}
		
		$this->colseImap();
		return false;
	}
	
	
	public function processFileNames($fileArray){
		for($n=0;$n<count($fileArray);$n++){
			$xmlFile = $fileArray[$n];
			if($xmlFile->type == 'xml'){
				for($m=0;$m<count($fileArray);$m++){
					$pdfFile = $fileArray[$m];
					if($xmlFile->fileName==$pdfFile->fileName){						
						rename($this->ProcessedPDFpath.$pdfFile->newFileName,$this->ProcessedPDFpath.$xmlFile->uuid.'.pdf');
						//return $this->ProcessedPDFpath.$pdfFile->newfileName;
					}
				}
			}
		}
		return $fileArray; 
	}
	
	
	
	public function saveAttachment($attachment){
		$name 		= $attachment['filename'];
		$ext 		= strtolower($this->getFileExtension($name));												
		$contents 	= $attachment['attachment'];
		
		switch($ext){
			case 'xml':
				$result = $this->processXML($name,$contents);
				break;
			case 'pdf':
				$result = $this->processPDF($name,$contents);				
				break;
			case 'zip':
				$result = $this->processCompFile($name,$contents,true);	
				break;
			case 'rar':
				$result = $this->processCompFile($name,$contents,false);				
				break;
			default:
				$result->uuid 		= '';
				$result->type 		= $ext;				
				$result->error = false;	
				$result->fileName  = $name;
				break;
		}
		return $result;
	}

	private function processXML($name,$contents){
		$uuid 				 = '';
		$result				 = '';
		
		file_put_contents($this->TMPpath.$name, $contents);
		$xml = @simplexml_load_file($this->TMPpath.$name);													
		if(!$xml){																			
			$result->uuid = "INVALID_FILE";
			$result->error = true;												
		}else{
			$result = $this->extractUUID($contents);
		}
		unlink($this->TMPpath.$name);
		
		if($result->error){
			$compFileName = $result->uuid.'__'.str_ireplace(' ','',$msgId).'__'.$from_email.'__'.$name;
			$counterFile++;
			file_put_contents($this->ERRpath.$compFileName, $contents);					
		}else{			
			$compFileName = $result->uuid.'.xml';	
			file_put_contents($this->XMLpath.$compFileName, $contents);
		}
		$result->type 		 = 'xml';
		$result->fileName  = $this->getFileName($name);
		return $result;
	}
	
	
	private function processPDF($name,$contents){
		$uuid = "PDF FILE";						
		$compFileName = sha1($name.date("Y-m-d H:i:s").$from_email).'.pdf';	
		$fileResult = file_put_contents($this->ProcessedPDFpath.$compFileName, $contents);	
		
		$result 				= '';
		$result->newFileName 	= $compFileName;
		$result->type 			= 'pdf';
		if(!$fileResult) {
			$result->error = true;	
		}
		$result->fileName  = $this->getFileName($name);
		
		return $result;		
	}
	private function processCompFile($name,$contents,$zipFile){
		$uuid = "COMP FILE";	
		$ext = $this->getFileExtension($name);					
		$compFileName = sha1($name.date("Y-m-d H:i:s").$from_email).'.'.$ext;	
		$fileResult = file_put_contents($this->COMpath.$compFileName, $contents);	
		$result->fileName  = $this->getFileName($name);
		$result->error = false;
		$result->newFileName 	= $compFileName;
		$result->type 			= 'zip';
		if(!$fileResult) {
			$result->error = true;	
		}
		$resultArray = array(); 
		
		if($zipFile){
			$compRes = $this->unzip($this->COMpath.$compFileName);
		}else{
			$compRes = $this->unrar($this->COMpath.$compFileName);
		}
		if($compRes){			
			$attachments = $this->extractFiles($this->TMPpath,array());						
			foreach ($attachments as $key => $attachment) {				
				$resultArray[] = $this->saveAttachment($attachment);
			}		
			$this->processFileNames($resultArray);
			$result->zipFiles = $resultArray;
		}else{
			$result->error = true;	
		}
		$this->recursiveRemove($this->TMPpath);
		return $result;	
	}
	
	public function extractFiles($dir,$fileResult){	
		$files	 = scandir($dir);			
		for($n=0;$n<count($files);$n++){
			$attachment = "";
			if(!is_dir($dir.$files[$n])){
				$attachment['filename'] = $files[$n];												
				$attachment['attachment'] = file_get_contents($dir.$files[$n]);
				$fileResult[] = $attachment;
			}else{
				if($files[$n]!='.'&&$files[$n]!='..')
					$this->extractFiles($dir.$files[$n].'/',$fileResult);
			}
		}
		
		
		return $fileResult;
	}
	
	private function recursiveRemove($dir) {
		$structure = glob(rtrim($dir, "/").'/*');
		if (is_array($structure)) {
			foreach($structure as $file) {
				if (is_dir($file)) $this->recursiveRemove($file);
				elseif (is_file($file)) unlink($file);
			}
		}
		rmdir($dir);
	}
	
	
	
	
	
	private function checkAttachments($m,$structure,$attachments,$partNum){
		if(isset($structure->parts) && count($structure->parts)) {
			for($i = 0; $i < count($structure->parts); $i++) {
				$partsArray = $structure->parts[$i];			
				if( isset( $partsArray->parts) && count($partsArray->parts)  ){				
					$attachments = $this->checkAttachments($m,$partsArray,$attachments,$partNum+1);
				}
				if($partsArray->ifdparameters || $partsArray->type==3) {
					if(isset($partsArray->parameters)) $params = $partsArray->parameters;
					if(isset($partsArray->dparameters)) $params = $partsArray->dparameters;
					foreach($params as $object) {
						$attObject = '';
						if(strtolower($object->attribute) == 'filename') {
							$attObject['filename'] = $object->value;
						}
						if(strtolower($object->attribute) == 'name'){
							$attObject['filename'] = $object->value;
						}
						$attObject['is_attachment'] = true;
											
						$attObject['filename'] = htmlentities($attObject['filename']); 						
						if($attObject['is_attachment']) array_push($attachments,$attObject);
					}
				}
			}
		}
		return $attachments;	
	}
	
	
	
	private function extractAttachments($m,$structure,$attachments,$partNum){
		if(isset($structure->parts) && count($structure->parts)) {
			for($i = 0; $i < count($structure->parts); $i++) {
				$partsArray = $structure->parts[$i];			
				if( isset( $partsArray->parts) && count($partsArray->parts)  ){				
					$attachments = $this->extractAttachments($m,$partsArray,$attachments,$partNum+1);
				}
				if($partsArray->ifdparameters || $partsArray->type==3) {
					if(isset($partsArray->parameters)) $params = $partsArray->parameters;
					if(isset($partsArray->dparameters)) $params = $partsArray->dparameters;
					foreach($params as $object) {
						$attObject = '';
						if(strtolower($object->attribute) == 'filename') {
							$attObject['filename'] = $object->value;
						}
						if(strtolower($object->attribute) == 'name'){
							$attObject['filename'] = $object->value;
						}
						$attObject['is_attachment'] = true;
						$resName = str_replace('=?utf-8?Q?','',($attObject['filename']));
						$resName = str_replace('?=','',$resName);
						$resName = str_replace('\r','',$resName);
						$resName = str_replace('\n','',$resName);
						preg_replace('/[^a-zA-Z0-9_ %\[\]\.\(\)%&-]/s', '', $resName);
						$out .= ("FileName : ".$resName."\n"); 
						$attObject['filename'] = $resName; 
						if($partNum>1){
							$attachment = imap_fetchbody($this->imap, $m, $partNum.".".($i+1));
						}else{
							$attachment = imap_fetchbody($this->imap, $m, ($i+1));
						}
						
						if($partsArray->encoding == 3) { // 3 = BASE64							
							$attObject['attachment'] = base64_decode($attachment);
						}
						elseif($partsArray->encoding == 4) { // 4 = QUOTED-PRINTABLE
							$attObject['attachment'] = quoted_printable_decode($attachment);
						}
						if($attObject['is_attachment']) array_push($attachments,$attObject);
					}
				}
			}
		}
		return $attachments;	
	}

	private function getFileExtension($fileName){
	   $parts=explode(".",$fileName);
	   return $parts[count($parts)-1];
	}
	
	private function getFileName($fileName){
	   $parts=explode(".",$fileName);
	   $filename = '';
	   for($n=0;$n<count($parts)-1;$n++){
		   $filename .= $parts[$n];
	   }
	   return $filename;
	}
	
	private function extractUUID($xmlFile){
		$result = '';
		$result->error = false;
		$result->uuid = '';
		if($xmlFile[0]=='?') {
			$xmlFile = substr($xmlFile,1); 
		}
		try{
			$xml = simplexml_load_string($xmlFile);
		}catch (Exception $e){
			$result->uuid = "INVALID";
			$result->error = true;
			return $result;
		}
		
		try{		
			$ns = $xml->getNamespaces(true);
		}catch (Exception $e){
			$xml = simplexml_load_string(utf8_decode($xmlFile));
			try{
				$ns = $xml->getNamespaces(true);
			}catch (Exception $e){
				
				$result->uuid = "INVALID_FILE";
				$result->error = true;
				return $result;
			}
		}
		
		try{
			$xml->registerXPathNamespace('t', $ns['tfd']);	
		}catch (Exception $e){
			$result->uuid = "INVALID_NAMESPACE";
			$result->error = true;
			return $result;
		}
		foreach ($xml->xpath('//t:TimbreFiscalDigital') as $tfd) {
			try{
				$result->uuid = (string)$tfd['UUID'];
				$result->error = false;			
			}catch (Exception $e){
				$result->uuid = "INVALID_UUID";
				$result->error = true;
				return $result;
			}
			
		}
		if($result->uuid==''){
			$result->uuid = 'NO_UUID';
			$result->error = true;		
		}
		return $result;
	}
	
	
	public function unzip($file){
		$zip = new ZipArchive;
		if ($zip->open($file) === TRUE) {
			$zip->extractTo($this->TMPpath);
			$zip->close();			
			return true;
		} else {
			return false;
		}
		
	}
	
	public function unrar($file){
		$rar = new RarArchive;
		if($rar->open($file)=== TRUE) {
			$entries = $rar->getEntries();
			foreach ($entries as $entry) {			
				$entry->extract($this->TMPpath);
			}
			$rar->close();			
			return true;
		} else {
			return false;
		}								
	}
	
	
	
	public function getFields(){
	   return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
	}
	
	public function createRecord($params){
	  return $this->ds->insertSQL($this->table,$params);
	}
	
	public function getRecords($params){
	  return $this->ds->normalize($this->ds->selectSQL($this->table,"*"));
	}
	
	public function deleteRecord($params){
	 return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
	}
	
	public function updateRecord($params){
	  return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
	}
	
}
?>