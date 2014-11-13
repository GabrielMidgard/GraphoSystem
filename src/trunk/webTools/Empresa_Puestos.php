<?php
require_once("DataSource.php");
class Empresa_Puestos{

  protected $ds;
  protected $table           = "empresa_puestos";
  protected $mainId          = "_idPuesto";

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



  public function reOrder(){
    $res = $this->ds->query("select * from empresa_puestos") ;
    $cont = 0;
    while($fila=mysqli_fetch_object($res)){
        $this->ds->query("update empresa_empleados set _idPuesto = ".$fila->_idTemp." where _idDepartamento = ".$fila->_idDepartamento." and _idArea = ".$fila->_idArea." and _idPuesto = ".$fila->_idPuesto) ;
        $cont++;
    }
    return $cont;
  }


  public function updateCECO(){
    $emp = $this->ds->query("select * from empleados");
    $cont = 0;
    while($fila = mysqli_fetch_object($emp)){
         $puesto = $this->ds->query("select _idCECO from empresa_puestos where
         _idCompania = ".$fila->_idCompania." and
         _idArea = ".$fila->_idArea." and
         _idDepartamento = ".$fila->_idDepartamento." and
         _idCategoria = ".$fila->_idCategoria." and
         _idPuesto = ".$fila->_idPuesto);
         if(mysqli_num_rows($puesto)>0){
           $ceco = mysqli_fetch_object($puesto)->_idCECO;
           $res =  $this->ds->query("update empleados set _idCECO = ".$ceco." where _idEmpleado = ".$fila->_idEmpleado);
           $cont++;
         }
    }
    return $cont;
  }


  public function getPuestos($params){
      return  $this->ds->normalize($this->ds->query("SELECT * FROM prm_puestos order by _nombre ASC"));
    }


  public function getExtraData($params){
      $fila = "";
      $fila->_tieneInformacionGeneral       = $this->checkExist("empresa_puestos_informacion_general"       ,$params);
      $fila->_tieneDescripcionEmpleado      = $this->checkExist("empresa_puestos_descripcion_empleado"      ,$params);
      $fila->_tieneIdiomas                  = $this->checkExist("empresa_puestos_idiomas"                   ,$params);
      $fila->_tieneEscolaridad              = $this->checkExist("empresa_puestos_escolaridad"               ,$params);
      $fila->_tienePerfil                   = $this->checkExist("empresa_puestos_perfil_carrera"            ,$params);
      $fila->_tieneCompetencias             = $this->checkExist("empresa_puestos_competencias"              ,$params);
      $fila->_tieneObservaciones            = $this->checkExist("empresa_puestos_observaciones"             ,$params);


      return $fila;
  }

  public function checkExist($table,$id){
        $result = "false";
        if(mysqli_num_rows($this->ds->query("select * from ".$table." where _idPuesto = ".$id))!=0) $result = "true";
        return $result;
  }

}
?>







