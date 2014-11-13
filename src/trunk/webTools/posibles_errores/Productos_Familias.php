<?php
require_once("DataSource.php");
class Productos_Familias{

  protected $ds;
  protected $table           = "Productos_Familias";
  protected $mainId          = "_idFamilia";

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
      return $this->ds->normalize($this->ds->query(  'SELECT Productos_Familias._idFamilia, 
									Productos_Familias._idGrupoCobro, 
									Productos_Familias._nombre, 
									Productos_Grupos_Cobro._nombre as _nombreGrupo
									FROM Productos_Familias INNER JOIN Productos_Grupos_Cobro ON Productos_Familias._idGrupoCobro = Productos_Grupos_Cobro._idGrupoCobro order by Productos_Familias._idFamilia ASC'));
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