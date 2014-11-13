<?php
require_once("DataSource.php");
class Clientes{

  protected $ds;
  protected $table           = "fiscales_clientes";
  protected $mainId          = "_idClientes"; 

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'");
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }
  
  public function getAllRecords($params){
      return $this->ds->selectSQL($this->table,"*");
  }

  public function getRecords($params){
	  $where = "";
	  if(isset($params['idCliente'])){
		  $where = " where _idCliente = ".$params['idCliente'];
	  }
	  
	  if(isset($params['nombre'])){
		   $where = " where CONCAT(_razonSocial,' ',_nombreEmpresa,' ',_rfc) like '%".$params['nombre']."%'";
	  }
	  
	  $this->ds->normalizeData = true;
	  $query = "SELECT * from  ".$this->table.$where;
				
				//throw new Exception($query);
				
	  
	   
       return $this->ds->query($query);
  }
  
  
   public function getDins($params){
	  $where = "";
	  if(isset($params['idDin'])){
		  $where = " where Clientes._idDin = ".$params['idDin'];
	  }
	  
	  if(isset($params['nombre'])){
		  $where = " where CONCAT(_razonSocial,' ',_nombreEmpresa,' ',_rfc) like '%".$params['nombre']."%'";
	  }
	  
	  $this->ds->normalizeData = true;
	  $query = "SELECT Clientes._idDin, 
					Clientes._nombre, 
					Clientes._paterno, 
					Clientes._materno, 
					Clientes_Puntos._idNivel, 
					Clientes_Puntos._periodo, 
					Clientes_Puntos._puntosAcumulados, 
					Clientes_Puntos._puntosGrupales, 
					Clientes_Puntos._puntosAcumuladosMes, 
					Clientes_Puntos._puntosGrupalesMes
				FROM Din INNER JOIN Clientes_Puntos ON Clientes._idDin = Clientes_Puntos._idDin".$where;
      return $this->ds->query($query);
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>