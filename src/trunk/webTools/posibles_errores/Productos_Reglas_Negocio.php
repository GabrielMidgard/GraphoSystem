<?php
require_once("DataSource.php");
class Productos_Reglas_Negocio{

  protected $ds;
  protected $table           = "Productos_Reglas_Negocio";
  protected $mainId          = "_idReglaNegocio";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }
  
  public function getTables(){
       $res = $this->ds->query("SHOW TABLES FROM randomestudio_nice ");
	   
	   $tables = array();
	   while($row = $res->fetch_object()){
		   $table = new stdClass();
		   $table->nombre = $row->Tables_in_randomestudio_nice;
		   $tables[] = $table;
	   }
	   
	   return $tables;
  }
  
  public function getTableFields($params){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME as nombre FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$params['_table']."'"));
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
  
  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>