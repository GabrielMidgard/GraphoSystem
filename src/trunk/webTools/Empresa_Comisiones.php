<?php
require_once("DataSource.php");
class Empresa_Comisiones{

  protected $ds;
  protected $table           = "empresa_comisiones";
  protected $mainId          = "_idComision";
  protected $tableMetas      = "empresa_metas_semanales";

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
      //return $this->ds->selectSQL($this->table,"*","_idTipoComision","=",$params);
      return $this->ds->normalize($this->ds->query("select * from ".$this->table." where _idTipoComision = ".$params." order by _condicion_min asc"));
  }

  public function getMetasSemanales($params){
      return $this->ds->selectSQL($this->tableMetas,"*");

  }


  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>