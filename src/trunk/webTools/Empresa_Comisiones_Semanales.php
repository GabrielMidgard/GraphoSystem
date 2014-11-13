<?php
require_once("DataSource.php");
class Empresa_Comisiones_Semanales{

  protected $ds;
  protected $table           = "empresa_metas_semanales";
  protected $mainId          = "_idSemana";


  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){ //$table,$fields,$where="",$condition="",$id=""
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