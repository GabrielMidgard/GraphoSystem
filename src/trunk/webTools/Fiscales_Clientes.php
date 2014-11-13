<?php
require_once("DataSource.php");
class Fiscales_Clientes{

  protected $ds;
  protected $table           = "fiscales_clientes";
  protected $mainId          = "_idCliente";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'");
  }

  public function createRecord($params){
      return   $this->ds->insertSQL($this->table,$params,true);
  }

  public function getFolio($folio,$fill=0){
       for($n=0;$n<($fill-strlen($folio));$n++) $fillData .= "0";
       return $fillData.$folio;
  }

  public function getRecords($params){
      $res =  $this->ds->query("select * from ".$this->table);

    $dataArray = array();
      while($fila = $res->fetch_object()){
        //$fila->_tieneFotografia             = file_exists($_SERVER["DOCUMENT_ROOT"]."/".$this->ds->employesDir.$fila->_numeroEmpleado.".jpg");
        //$fila->_tieneFirma                  = file_exists($_SERVER["DOCUMENT_ROOT"]."/".$this->ds->signsDir.$fila->_numeroEmpleado.".xml");
        $fila->_tieneRepresentante            = $this->checkExist("fiscales_clientes_representantes"        ,$fila->_idCliente);
        $fila->_tieneContacto                 = $this->checkExist("fiscales_clientes_contactos"             ,$fila->_idCliente);
        //$fila->_tieneDocumentos               = $this->checkExist("fiscales_clientes_documentos"            ,$fila->_idCliente);
        $fila->_tieneRecoleccion              = $this->checkExist("fiscales_direcciones_recoleccion"        ,$fila->_idCliente);
        //$fila->_tieneContrasenas              = $this->checkExist("fiscales_clientes_contrasenas"           ,$fila->_idCliente);
        //$fila->_tieneObligaciones             = $this->checkExist("fiscales_clientes_obligaciones"          ,$fila->_idCliente);
        //$fila->_tieneServicios                = $this->checkExist("fiscales_clientes_servicios"             ,$fila->_idCliente);
        $fila->_representante = "";
        if($fila->_tieneRepresentante ){
            $repRes = mysql_fetch_object($this->ds->query("select _nombre,_paterno,_materno from fiscales_clientes_representantes where _idCliente = ".$fila->_idCliente));
            $fila->_representante = $repRes->_nombre." ".$repRes->_paterno." ".$repRes->_materno;
        }

        $fila->_contacto = "";
        if($fila->_tieneContacto ){
			 $tempRes = $this->ds->query("select _nombre,_paterno,_materno from fiscales_clientes_contactos where _idCliente = ".$fila->_idCliente);
            $repRes = $tempRes->fetch_object();
            $fila->_contacto = $repRes->_nombre." ".$repRes->_paterno." ".$repRes->_materno;
        }


        array_push($dataArray,$fila);
      }
      return $dataArray;
  }

  public function checkExist($table,$id){
        $result = "false";
		$res = $this->ds->query("select * from ".$table." where _idCliente = ".$id);
        if($res->num_rows!=0) $result = "true";
        return $result;
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>