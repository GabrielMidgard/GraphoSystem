<?php
require_once("DataSource.php");
class Empresa_Sucursales{

  protected $ds;
  protected $table           = "empresa_sucursales";
  protected $mainId          = "_idSucursal";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

 public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }

  public function createRecord($params){

      $suc = $this->ds->insertSQL($this->table,$params,"true");
      //
      return $this->ds->query("CREATE TABLE saet_suc_".$suc." (
        _idFolio smallint(5) unsigned NOT NULL auto_increment,
        PRIMARY KEY  (_idFolio)
      ) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
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



}
?>