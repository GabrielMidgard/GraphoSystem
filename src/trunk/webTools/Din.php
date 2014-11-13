<?php
require_once("DataSource.php");
class Din{

  protected $ds;
  protected $table           = "Clientes";
  protected $mainId          = "_idDin"; 

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
	  if(isset($params['idDin'])){
		  $where = " where Clientes._idDin = ".$params['idDin'];
	  }
	  
	  if(isset($params['nombre'])){
		  $where = " where CONCAT(_nombre,' ',_paterno,' ',_materno) like '%".$params['nombre']."%'";
	  }
	  
	  $this->ds->normalizeData = true;
	  $query = "SELECT Clientes._idDin, 
				Clientes._nombre, 
				Clientes._paterno, 
				Clientes._materno, 
				Clientes._fechaNacimiento, 
				Clientes._idSexo, 
				Clientes._idNacionalidad, 
				Clientes._idEstatus, 
				Clientes._idPresentador, 
				Clientes._correoPrincipal, 
				Clientes._correoSecundario, 
				Clientes._idEmpleado, 
				Clientes._telefonoCasa, 
				Clientes._telefonoMovil, 
				Clientes._telefonoOficina, 
				Clientes._ext, 
				Concat(Direcciones._calle,' #',Direcciones._noExterior,' Int.',Direcciones._noInterior,' Col.',Direcciones._colonia,' C.P.',Direcciones._cp) AS _direccion, 
				Clientes_Puntos._puntosAcumulados, 
				Clientes_Puntos._puntosGrupales, 
				Clientes_Puntos._puntosAcumuladosMes, 
				Clientes_Puntos._puntosGrupalesMes, 
				Clientes_Puntos._descuento
				FROM Clientes INNER JOIN Direcciones ON Clientes._idDin = Direcciones._idPropietario 
				INNER JOIN Clientes_Puntos ON Clientes._idDin = Clientes_Puntos._idDin ".$where;
				
				//throw new Exception($query);
				
	   $dinRes = $this->ds->query($query);
	   if(count($dinRes)){
		   $dinInfo = $dinRes[0];
		   $pres = $this->ds->query("SELECT Concat(_nombre,' ',_paterno,' ',_materno) as _nombrePresentador from Clientes where _idDin = ".$dinInfo->_idPresentador);  
		   if(count($pres)){
			   $dinInfo->_nombrePresentador = $pres[0]->_nombrePresentador;
		   }else{
			    $dinInfo->_nombrePresentador = "No asignado";
		   }
		   $result[] = $dinInfo;
	   }else{
		   $result = false;
	   }
       return $result;
  }
  
  
   public function getDins($params){
	  $where = "";
	  if(isset($params['idDin'])){
		  $where = " where Clientes._idDin = ".$params['idDin'];
	  }
	  
	  if(isset($params['nombre'])){
		  $where = " where CONCAT(_nombre,' ',_paterno,' ',_materno) like '%".$params['nombre']."%'";
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