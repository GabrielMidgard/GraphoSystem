<?php
require_once("DataSource.php");
class Fiscales_Clientes_Contrasenas{

  protected $ds;
  protected $table           = "fiscales_clientes_contrasenas";
  protected $mainId          = "_idContrasena";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'");
  }

  public function createRecord($params){
    //$this->ds->debug();
      return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){
      return $this->ds->query("select * from ".$this->table." where ".$this->mainId." = '".$params."'");
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

    public function getRecordsById($params){
      //$this->ds->debug();
      return $this->ds->selectSQL($this->table,"*","_idCliente","=",$params["_idCliente"]);
  }



}
?>