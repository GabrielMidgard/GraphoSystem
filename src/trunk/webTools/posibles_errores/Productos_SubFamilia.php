<?php
require_once("DataSource.php");
class Productos_SubFamilias{

  protected $ds;
  protected $table           = "Productos_SubFamilia";
  protected $mainId          = "_idSubFamilia";

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
      return $this->ds->normalize($this->ds->query(  'SELECT Productos_SubFamilias._idSubFamilia, 
									Productos_SubFamilias._idFamilia, 
									Productos_SubFamilias._nombre, 
									Productos_Familias._nombre as _nombreFamilia
									FROM Productos_SubFamilias INNER JOIN Productos_Familias ON Productos_SubFamilias._idFamilia = Productos_Familias._idFamilia order by Productos_SubFamilias._idSubFamilia ASC'));
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