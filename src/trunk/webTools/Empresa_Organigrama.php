<?php
require_once("DataSource.php");
class Empresa_Organigrama{

  protected $ds;
  protected $areas          = "empresa_areas";
  protected $departamentos  = "empresa_departamentos";
  protected $cecos          = "empresa_cecos";
  protected $puestos        = "empresa_puestos";
  protected $empleados      = "empleados";



  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }

  public function createRecord($params){
      //return $this->ds->insertSQL($this->table,$params);
  }

  public function getRecords($params){
      $data['puestos'] =  $this->ds->selectSQL($this->puestos,"*");
      $data['areas'] =  $this->ds->selectSQL($this->areas,"*");
      $data['departamentos'] =  $this->ds->selectSQL($this->departamentos,"*");
      return $data;
  }
   //$table,$fields,$where="",$condition="",$id=""
  public function getOrgB(){
      $data['organigrama'] =  array();
      $areas = $this->ds->selectSQL($this->areas,"*");
      $areaCont = 0;
      while($row=mysqli_fetch_object($areas)){
          array_push($data['organigrama'],$row);

          $departamentos = $this->ds->selectSQL($this->departamentos,"*","_idArea","=",$row->_idArea);
          $deptos['departamentos'] =  array();
          while($rowDeptos=mysqli_fetch_object($departamentos)){
               array_push($deptos['departamentos'],$rowDeptos);


               $puestos = $this->ds->selectSQL($this->puestos,"*","_idDepartamento","=",$rowDeptos->_idDepartamento);
               $pst['puestos'] =  array();
               $deptoCount = 0;
               while($rowPuestos=mysqli_fetch_object($puestos)){
                    array_push($pst['puestos'],$rowPuestos);
               }

               $deptos['departamentos'][$deptoCount]->_puestos = $pst['puestos'];
               $deptoCount++;


          }
          $data['organigrama'][$areaCont]->_deptos = $deptos['departamentos'];
          $areaCont++;
      }

      return $data;
  }

  public function getOrg(){
     $data['organigrama'] =  array();
     $areas = $this->ds->selectSQL($this->areas,"*");
      $cont = 0;
     while($row=mysqli_fetch_object($areas)){
       array_push($data['organigrama'],$row);
       $data['organigrama'][$cont]->_deptos = $this->getDeptos($row->_idArea);
        $cont++;
     }
     return $data;
  }

   public function getDeptos($idArea){
     $data =  array();
     $deptos = $this->ds->selectSQL($this->departamentos,"*","_idArea","=",$idArea);
     $cont = 0;
     while($row=mysqli_fetch_object($deptos)){
       array_push($data,$row);
       $data[$cont]->_puestos = $this->getPuestos($row->_idDepartamento);
       $cont++;
     }
     return $data;
  }

   public function getPuestos($idDepartamento){
     $data =  array();
     //$puestos = $this->ds->selectSQL("dsm_puestos","*","_idDepartamento","=",$idDepartamento);

     $query =  "SELECT
    empresa_puestos._idPuesto,
    empresa_puestos._idArea,
    empresa_puestos._idDepartamento,
    empresa_puestos._idPuestoSuperior,
    empresa_puestos._nombre,
    empleados._numeroEmpleado,
    empleados._nombre as _nombreEmpleado,
    empleados._paterno,
    empleados._materno
    FROM
    empresa_puestos
    Inner Join empleados ON empresa_puestos._idPuesto = empleados._idPuesto
    WHERE
    empresa_puestos._idDepartamento = '".$idDepartamento."'";

    $query = "select * from empresa_puestos where _idDepartamento = '".$idDepartamento."'";

    $puestos = $this->ds->query($query);

     $cont = 0;
     while($row=mysqli_fetch_object($puestos)){
        $empleados = $this->ds->query("Select _nombre,_paterno,_materno,_idEmpleado from empleados where _idPuesto = ".$row->_idPuesto);
        $ea = array();
        while($empleado = mysqli_fetch_object($empleados)){
           array_push($ea,$empleado);
        }

       $ps = mysqli_fetch_object($this->ds->query("Select _nombre from empresa_puestos where _idPuesto = ".$row->_idPuestoSuperior));
       $row->_empleados  = $ea;
       $row->_idEmpleado = $ps->_idEmpleado;
       array_push($data,$row);
     }
     return $data;
  }




  public function deleteRecord($params){
     //return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      //return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }



}
?>