<?php
require_once("DataSource.php");
class Empresa_Competencias{

  protected $ds;
  protected $table           = "empresa_competencias";
  protected $mainId          = "_idCompetencia";

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

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }


   public function getExtraData($params){
      $fila = "";
      $fila->_tieneFuncionesEspecificas     = $this->checkExist("empresa_competencias_funciones_especificas"        ,$params);
      $fila->_tieneConocimientos            = $this->checkExist("empresa_competencias_conocimientos"                ,$params);
      $fila->_tieneHabilidades              = $this->checkExist("empresa_competencias_habilidades"                  ,$params);
      $fila->_tieneActitudes                = $this->checkExist("empresa_competencias_actitudes"                    ,$params);
      $fila->_tieneIndicadores              = $this->checkExist("empresa_competencias_indicadores"                  ,$params);
      $fila->_tieneEscalas                  = $this->checkExist("empresa_competencias_escalas"                      ,$params);


      return $fila;
  }

  public function checkExist($table,$id){
        $result = "false";
        if(mysqli_num_rows($this->ds->query("select * from ".$table." where _idCompetencia = ".$id))!=0) $result = "true";
        return $result;
  }



}
?>