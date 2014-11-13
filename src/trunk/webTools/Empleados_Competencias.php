<?php
require_once("DataSource.php");
class Empleados_Competencias{

  protected $ds;
  protected $table           = "empleados_competencias";
  protected $mainId          = "_idCompetenciaEmpleado";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'");
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){
      return $this->ds->query("select * from ".$this->table." where _idEmpleado = ".$params);
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

  public function getCompetenciasPuesto($params){
      $idPuesto =  mysql_fetch_object($this->ds->query("select _idPuesto from empleados where _idEmpleado = ".$params))->_idPuesto;
      return $this->ds->query("select * from empresa_puestos_competencias where _idPuesto = ".$idPuesto);
  }



}
?>