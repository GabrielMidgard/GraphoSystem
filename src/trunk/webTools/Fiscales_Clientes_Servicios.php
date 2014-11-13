<?php
require_once("DataSource.php");
class Fiscales_Clientes_Servicios{

  protected $ds;
  protected $table           = "fiscales_clientes_servicios";
  protected $mainId          = "_idServicioCliente";

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
     //$this->ds->debugQuery = true;
      return $this->ds->selectSQL($this->table,"*","_idCliente","=",$params["_idCliente"]);
  }

   public function getServiciosById($params){
     //$this->ds->debugQuery = true;
      $res =  $this->ds->query("SELECT
                              fiscales_clientes_servicios._idServicioCliente,
                              fiscales_clientes_servicios._idCliente,
                              fiscales_clientes_servicios._idProducto,
                              fiscales_clientes_servicios._descuento,
                              fiscales_clientes_servicios._observaciones,
                              productos._nombre,
                              productos._costo
                              FROM
                              fiscales_clientes_servicios
                              Inner Join productos ON  fiscales_clientes_servicios._idProducto = productos._idProducto
                              WHERE
                              fiscales_clientes_servicios._idCliente =  '".$params."'");
     $data = array();

     while($row=mysql_fetch_object($res)){
          $row->_cantidad = 1;
          $row->_total = ($row->_costo-(($row->_costo*$row->_descuento)/100))*$row->_cantidad;
          array_push($data,$row);
     }
     return $data;
  }

}
?>