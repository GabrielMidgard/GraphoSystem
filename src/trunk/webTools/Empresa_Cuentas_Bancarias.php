<?php
require_once("DataSource.php");
class Empresa_Cuentas_Bancarias{

  protected $ds;
  protected $table           = "empresa_cuentas_bancarias";
  protected $mainId          = "_idCuenta";

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
      if($params['_idCompania']){
          return $this->ds->normalize($this->ds->query("select * from ".$this->table." where _idCompania = '".$params['_idCompania']."'"));
      }else{
          return $this->ds->normalize($this->ds->query("select * from ".$this->table));
      }
  }



  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>