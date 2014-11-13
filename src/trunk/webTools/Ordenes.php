<?php
require_once("DataSource.php");
class Ordenes{

  protected $ds;
  protected $table           = "ordenes_orden_servicio";
  protected $clientTable     = "fiscales_clientes";
  protected $statesTable     = "estados";
  protected $statusTable     = "estatus";
  protected $typesTable      = "tipos_equipo";
  protected $tradeMarksTable = "marcas";
  protected $employeesTable  = "empleados";
  protected $systemsTable    = "equipos";
  protected $contactsTable   = "fiscales_clientes_contactos";
  protected $serviceTypesTable    = "areas_soporte_tecnico";
  protected $technicalSupportAreasTable    = "tipos_servicio";
  protected $mainId          = "_idOrden";

  public function __construct(){
    $this->ds     = new DataSource();
  }

  public function getFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$this->table."'"));
  }

  public function getDiagnosticFields(){
       return $this->ds->normalize($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = 'diagnosticos'"));
  }

  public function createRecord($params){
      return $this->ds->insertSQL($this->table,$params);
  }

  public function recordFailure($params){
      return $this->ds->insertSQL("fallas_orden",$params);
  }
  /*Registra un prediagnostico*/
  public function recordPreDiagnostic($params){
      $idOrdenFalla = $params["_idOrdenFalla"];
      /*Tenemos que borrar _idOrden Falla, pero el unset no sirve*/
      $newParams = new stdClass();
      foreach( $params as $key => $value){
        if($key != "_idOrdenFalla"){
          $newParams->$key = $value;
        }
      }
      $this->ds->insertSQL("diagnosticos",$newParams);
      $res = $this->ds->normalize($this->ds->query("SELECT _idDiagnostico FROM diagnosticos ORDER BY _idDiagnostico DESC LIMIT 1"));
      $res[0]->{"_idOrdenFalla"} = $idOrdenFalla;
      return $this->ds->insertSQL("orden_falla_diagnosticos",$res[0]);
  }

  public function getRecords($params){
      $this->ds->normalizeData = true;
      $query = "SELECT o.*,DATE(o._creado) as _fechaCreacion,TIME(o._creado) as _horaCreacion, 
                c._nombreEmpresa as _nombreCliente,e._nombreEstatus
                FROM ordenes_orden_servicio o 
                LEFT JOIN fiscales_clientes c
                ON o._idCliente = c._idCliente
                LEFT JOIN estatus e
                ON o._idEstatus = e._idEstatus";
      return $this->ds->query($query);
  }

  /*Obtiene la lista de pre-diagnosticos asignados a una falla reportada*/
  public function getPreDiagnosticRecords($params){
      $query = "SELECT d.*, f._falla FROM diagnosticos d
                LEFT JOIN fallas_orden f
                ON f._idOrdenFalla = $params
                WHERE _idDiagnostico IN (SELECT _idDiagnostico FROM orden_falla_diagnosticos WHERE _idOrdenFalla = ".$params.")
                ";
      return $this->ds->normalize($this->ds->query($query));
  }

  /*Obtiene todos los pre diagnosticos relacionados a una orden y no a una falla*/
  public function getPreDiagnosticRecordsFromOrder($params){
      $query = "SELECT d.* ,gf._falla
                FROM diagnosticos d
                INNER JOIN orden_falla_diagnosticos f
                ON f._idDiagnostico = d._idDiagnostico
                INNER JOIN fallas_orden gf
                ON f._idOrdenFalla = gf._idOrdenFalla
                WHERE _esPrediagnostico = 1 && d._idDiagnostico IN (
                                                                    SELECT _idDiagnostico 
                                                                    FROM orden_falla_diagnosticos 
                                                                    WHERE _idOrdenFalla IN (
                                                                                            SELECT _idOrdenFalla 
                                                                                            FROM fallas_orden 
                                                                                            WHERE _idOrden = $params));
                ";
      return $this->ds->normalize($this->ds->query($query));
  }

  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function deleteDiagnosticRecord($params){
     $this->ds->deleteSQL("orden_falla_diagnosticos","_idDiagnostico","=",$params["_idDiagnostico"]);
     return $this->ds->deleteSQL("diagnosticos","_idDiagnostico","=",$params["_idDiagnostico"]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateDiagnosticRecord($params){
      return $this->ds->updateSQL("diagnosticos",$params,"_idDiagnostico","=",$params["_idDiagnostico"]);
  }

  /*Obtiene datos de la orden como el nombre del técnico que va a atender el reporte por ejemplo*/
  public function getPrediagnosticData($params){
    $this->ds->normalizeData = true;
    $query = "SELECT o._idTecnico,o._habloCon,o._prediagnosticoNumeroTiempo,o._prediagnosticoUnidadTiempo,
                     o._servicioNumeroTiempo,o._servicioUnidadTiempo,
                     DATE(o._fechaHabloCon) AS _fechaHablo,
                     TIME(o._fechaHabloCon) AS _horaHablo,
                     CONCAT(trim(IFNULL(e._nombre,'')),' ',trim(IFNULL(e._paterno,'')),' ',trim(IFNULL(e._materno,''))) as _nombreTecnico
              FROM ordenes_orden_servicio o
              INNER JOIN empleados e
              ON o._idTecnico = e._idEmpleado
              WHERE _idOrden = $params";
    return $this->ds->query($query);
  }  
  /*Obtiene la lista de fallas reportadas por el cliente*/
  public function getFailuresFromOrder($params){
    $this->ds->normalizeData = true;
    $query = "SELECT _idOrdenFalla,_codigo,_falla 
              FROM fallas_orden WHERE _idOrden = $params";
    return $this->ds->query($query);
  }

  /*Obtiene la lista de fallas reportadas por el cliente*/
  public function getSpareParts($params){
    $this->ds->normalizeData = true;
    $query = "SELECT * FROM refacciones WHERE _idEquipo = ".$params;
    return $this->ds->query($query);
  }

  /*Obtiene el cliente asignado a la orden*/
  public function getClientFromOrder($params){
    $this->ds->normalizeData = true;
    $query = "SELECT cliente.*,CONCAT(trim(IFNULL(fr._nombre,'')),' ',trim(IFNULL(fr._paterno,'')),' ',trim(IFNULL(fr._materno,''))) as _nombreRepresentante
              FROM fiscales_clientes_representantes fr
              RIGHT JOIN
              (SELECT cl._idCliente,cl._nombreEmpresa,cl._telefonoOficina,cl._telefonoCasa,cl._ciudad,
                      cl._mailPrincipal,cl._mailSecundario, cl._estado
              FROM fiscales_clientes cl
              WHERE _idCliente = (SELECT _idCliente FROM ordenes_orden_servicio WHERE _idOrden = $params)) AS cliente
              ON fr._idCliente = cliente._idCliente";

    return $this->ds->query($query);
  }
  /*Obtiene todos los datos del equipo asignado a la orden*/
  public function getEquipmentFromOrder($params){
    $this->ds->normalizeData = true;
    $query = "SELECT e._idEquipo, e._modelo, e._serie, e._anioFabricacion,tp._nombreTipo, tm._nombreMarca
              FROM equipos e
              LEFT JOIN tipos_equipo tp
              ON e._idTipoEquipo = tp._idTipoEquipo
              LEFT JOIN marcas tm
              ON e._idMarca = tm._idMarca
              WHERE e._idEquipo = (SELECT _idEquipo FROM ordenes_orden_servicio WHERE _idOrden = $params)";
    return $this->ds->query($query);
  }
  /*Obtiene la lista de contactos asignados al cliente seleccionado*/
  public function getListOfContacts($params){
    $this->ds->normalizeData = true;
    $query = "SELECT _idContacto,_nombre FROM fiscales_clientes_contactos WHERE _idCliente = $params";
    return $this->ds->query($query);
  }
  /*Obtiene la lista de equipos asignados al cliente seleccionado*/
  public function getListOfEquipments($params){
    $this->ds->normalizeData = true;
    $query = "SELECT e._idEquipo, e._nombreEquipo FROM 
              equipos_clientes ec
              INNER JOIN equipos e
              ON ec._idEquipo = e._idEquipo
              WHERE ec._idCliente = $params";
    return $this->ds->query($query);
  }


  public function getSpecificOrder($params){      
    $this->ds->normalizeData = true;
    $query = "SELECT orden_cliente._idOrden,orden_cliente._operador,orden_cliente._nota,
                    orden_cliente._idTipoServicio,orden_cliente._idAreaSoporteTecnico,
                    orden_cliente._idEstatus, orden_cliente._idEmpleado,orden_cliente._idContacto,
                    orden_cliente._idEquipo,
                     DATE(orden_cliente._creado) as _fechaCreacion,
                     TIME(orden_cliente._creado) as _horaCreacion, es._nombreEstatus,
                     CONCAT(trim(IFNULL(et._nombre,'')),' ',trim(IFNULL(et._paterno,'')),' ',trim(IFNULL(et._materno,''))) as _nombreEmpleado,
                     CONCAT(trim(IFNULL(ct._nombre,'')),' ',trim(IFNULL(ct._paterno,'')),' ',trim(IFNULL(ct._materno,''))) as _nombreContacto,
                     tsa._areaSoporteTecnico as _nombreAreaSoporte, stt._nombre as _nombreTipoServicio
              FROM ordenes_orden_servicio orden_cliente
              LEFT JOIN estatus es
              ON orden_cliente._idEstatus = es._idEstatus
              LEFT JOIN empleados et /*El que atendió el reporte*/
              ON orden_cliente._idEmpleado = et._idEmpleado
              LEFT JOIN fiscales_clientes_contactos ct
              ON orden_cliente._idContacto = ct._idContacto /*el que reportó la orden*/
              LEFT JOIN tipos_servicio stt
              ON orden_cliente._idTipoServicio = stt._idTipoServicio
              LEFT JOIN areas_soporte_tecnico tsa
              ON orden_cliente._idAreaSoporteTecnico = tsa._idAreaSoporteTecnico
              WHERE _idOrden = $params";

    return $this->ds->query($query);
  }
}
?>