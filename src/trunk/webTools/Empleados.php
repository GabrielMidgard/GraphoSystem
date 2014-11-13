<?php
require_once("DataSource.php");
class Empleados{

  protected $ds;
  protected $table           = "empleados";
  protected $mainId          = "_idEmpleado";

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'");
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){
  $active = "";
  if($params["_range"]==0) $active =" and _estatus = 'true'";
  if($params["_range"]==1)  $active =" and _estatus = 'false'";

      switch($params["_accessType"]){
        case -1:
            $query = "select * from ".$this->table." where _idEmpleado <> 0".$active;
            break;
        case 0:
            $query =  "select * from ".$this->table." where _idEmpleado = ".$params[$this->mainId];
            break;
        case 1:
            $query =  "select * from ".$this->table." where _idCompania = ".$params["_idCompania"].$active;
            break;
        case 2:
             $query =  "select * from ".$this->table." where _idArea = ".$params["_idArea"].$active;
            break;
        case 3:
             $query = "select * from ".$this->table." where _idDepartamento = ".$params["_idDepartamento"].$active;
            break;
        case 4:
             $query =  "select * from ".$this->table." where _idUbicacion = ".$params["_idUbicacion"].$active;
            break;
        case 5:
             $query =  "select * from ".$this->table." where _idCECO = ".$params["_idCECO"].$active;
            break;
        case 6:
             $query =  "select * from ".$this->table." where _idCategoria = ".$params["_idCategoria"].$active;
            break;
        case 7:
            $query =  "select * from ".$this->table." where _idEmpleado <> 0".$active;
            break;
      }


      $res = $this->ds->normalize($this->ds->query($query));

    

      return $res;
  }

  public function getExtraData($params,$paramsb){
      $fila = "";
      $fila->_tieneFotografia             = file_exists($_SERVER["DOCUMENT_ROOT"].$this->ds->imgsPaths.$params.".jpg");
      $fila->_tieneFirma                  = file_exists($_SERVER["DOCUMENT_ROOT"].$this->ds->signsPaths.$params.".xml");
      $fila->_tieneCredencial             = $this->checkExist("empleados_credenciales"            ,$params);
      $fila->_tieneIntereses              = $this->checkExist("empleados_intereses_personales"    ,$params);
      $fila->_tieneInmueble               = $this->checkExist("empleados_inmuebles"               ,$params);
      $fila->_tieneHistorialLaboral       = $this->checkExist("empleados_historial_laboral"       ,$params);
      $fila->_tieneDependientes           = $this->checkExist("empleados_dependientes_economicos" ,$params);
      $fila->_tienePerfil                 = $this->checkExist("empleados_perfil_carrera"          ,$params);
      $fila->_tieneAreasInteres           = $this->checkExist("empleados_areas_interes"           ,$params);
      $fila->_tieneAcceso                 = $this->checkExist("empleados_accesos"                 ,$params);
      $fila->_tieneCompetencias           = $this->checkExist("empleados_competencias"            ,$params);
       $fila->_tieneEvaluaciones          = $this->checkExist("evaluaciones_empleados"            ,$params);
       $fila->_tieneExpediente            = $this->checkExist("empleados_documentos"            ,$params);
      $historialAcademico = false;
      if(($this->checkExist("empleados_idiomas",$params)=="true"||$this->checkExist("empleados_cursos_actualizaciones",$params)=="true"||$this->checkExist("empleados_historial_academico",$params)=="true")){
         $historialAcademico = true;
      } else{
         $historialAcademico = false;
      }

      $fila->_tieneHistorialAcademico     = $historialAcademico;
      return $fila;
  }

  public function checkExist($table,$id){
        $result = "false";
        if(mysql_num_rows($this->ds->query("select * from ".$table." where _idEmpleado = ".$id))!=0) $result = "true";
        return $result;
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateFiles(){
    $dir = opendir($_SERVER["DOCUMENT_ROOT"].$this->ds->signsPaths);
    $filesRes = array();
    while (false !== ($file = readdir($dir))) {
        if ($file != "." && $file != "..") {
            $filename = explode(".",$file);
            $res = mysql_fetch_object($this->ds->query("select _idEmpleado from empleados where _numFortia = '".$filename[0]."'"));
            //array_push($filesRes,$file." ->".$res->_idEmpleado);
            rename($_SERVER["DOCUMENT_ROOT"].$this->ds->signsPaths."/".$file,$_SERVER["DOCUMENT_ROOT"].$this->ds->signsPaths."/".$res->_idEmpleado.".xml");
        }
    }
    closedir($dir);
    return true;
  }


}
?>