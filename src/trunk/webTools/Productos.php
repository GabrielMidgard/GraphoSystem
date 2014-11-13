<?php
require_once("DataSource.php");
class Productos{

  protected $ds;
  protected $table           = "Productos";
  protected $mainId          = "_idProducto";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){
      return $this->ds->selectSQL($this->table,"*");
  }
  
  public function getRecordsById($params){
      return $this->ds->selectSQL($this->table,"*");
  }
  
  public function getRecordsByCode($params){
	  $this->ds->normalizeData = true;
	  $code = str_ireplace("\n","",$params);
	  $code = str_ireplace("\r","",$params);	
      return $this->ds->query("select * from ".$this->table." where _idLIOR = '".$params."' or _idNICE = '".$params."'" );
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>