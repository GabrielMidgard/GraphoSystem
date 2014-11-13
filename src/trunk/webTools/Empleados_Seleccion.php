<?php
require_once("DataSource.php");
class Empleados_Seleccion{

  protected $ds;
  protected $table           = "empleados";
  protected $mainId          = "_idEmpleado";

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
      return $this->ds->query("select _idArea,_idDepartamento,_idPuesto,_numFortia,_idEmpleado,_nombre,_paterno,_materno from ".$this->table);
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

  public function getExtraData($params){
      $fila = "";
      $fila->_tieneEvaluaciones             = $this->checkExist("evaluaciones_empleados"             ,$params);
      $fila->_tieneReportes                 = $this->checkExist("evaluaciones_empleados_reportes"             ,$params);
      return $fila;
  }

  public function checkExist($table,$id){
        $result = "false";
        if(mysql_num_rows($this->ds->query("select * from ".$table." where _idEmpleado = ".$id))!=0) $result = "true";
        return $result;
  }



}
?>