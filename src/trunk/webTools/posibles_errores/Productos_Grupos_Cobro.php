<?php
require_once("DataSource.php");
class Productos_Grupos_Cobro{

  protected $ds;
  protected $table           = "Productos_Grupos_Cobro";
  protected $mainId          = "_idGrupoCobro";

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
  
  public function getRecordsById($params){
      return $this->ds->selectSQL($this->table,"*");
  }
  
  public function deleteRecord($params){
     return $this->ds->deleteSQL($this->table,$this->mainId,"=",$params[$this->mainId]);
  }

  public function updateRecord($params){
      return $this->ds->updateSQL($this->table,$params,$this->mainId,"=",$params[$this->mainId]);
  }

  public function testRule($params){
	  $result = "";
	  $reglasNegocio = $this->ds->query("select _reglasNegocio,_aplicaDespues from Productos_Grupos_Cobro where _idGrupoCobro = ".$params['_idGrupoCobro'])->fetch_object();
	  if($reglasNegocio->_reglasNegocio==""){
		  $result = array();
		  $result[] = $this->createTestItem('No rules to apply','','','','','','');
		  return $result;
	  }
	  	
	  $rules = explode("|",$reglasNegocio->_reglasNegocio);
	  $apply = explode("|",$reglasNegocio->_aplicaDespues);
	  $rule = array();	  
	  for($n=0;$n<count($rules);$n++){
		  $rule[] = $this->ds->query("select * from Productos_Reglas_Negocio where _idReglaNegocio = ".$rules[$n])->fetch_object();
	  }
	  
	  $idProducto = $this->ds->query("select _idProducto from Productos  where _idLIOR = '".$params['_idProducto']."' or _idNICE = '".$params['_idProducto']."'");
	 
	  if($idProducto->num_rows){
		 $idProducto = $idProducto->fetch_object();
		 
		 $producto = $this->ds->query("select * from Productos_Precios where _idProducto = ".$idProducto->_idProducto)->fetch_object(); 
		 $precioInicial = $producto->_precioCatalogo;
		 
		 if($params['_precio']!=0){
			 $precioInicial = $params['_precio'];
		 }
		 
		 $result[] = $this->createTestItem('Precio Catalogo',0,0,0,0,0,$precioInicial);
		 $precioActual = $precioInicial;
		 for($n=0;$n<count($rule);$n++){
			$ruleData = $rule[$n]; 
			
			if($ruleData->_tabla!=''){
				$ruleData->_idDin = 1;//$params['_idDin'];
				$ruleData->_idProducto = $idProducto->_idProducto;
				$ruleData->_valor = $this->getFieldValue($ruleData);				 				
			}
			
			$cargo = 0.0000;
			$abono = 0.0000;
			$extra = 0.0000;
			$valor = 0.0000;
			$monto = 0.0000;
			$sign = "$ ";
			
			if($apply[$n]!='0'){
				
				$item = $result[$apply[$n][1]];
				$itemType = $apply[$n][0];
				
				switch($itemType){
					case "C":
						$precioCalculado = $item->_costo;
						break;
					case "V":
						$precioCalculado = $item->_monto;						
						break;
				}
				
				$applyTo = " -> ".$item->_nombre;
			}else{
				$applyTo = "";
				$precioCalculado = $precioActual;
			}
			
	  	 	switch($ruleData->_tipo){
				case 0:
					switch($ruleData->_tipoPorcentaje){
						case 0:
							$valor = $ruleData->_valor;
							break;
						case 1:
							$valor = $precioCalculado-($precioCalculado*$ruleData->_valor);
							$sign = "% ";
							break;
						case 2:
							$valor = $precioCalculado-($precioCalculado/$ruleData->_valor);
							$sign = "% ";
							break;
						case 3:
							$valor = (($precioCalculado*$ruleData->_valor)/100);
							$sign = "% ";
							break; 
					}
					$abono = $valor;
					$monto = $valor;
					$precioActual = $precioActual+$abono;
					break;
					
				case 1:
					switch($ruleData->_tipoPorcentaje){
						case 0:
							$valor = $ruleData->_valor;
							break;
						case 1:
							$valor = $precioCalculado-($precioCalculado*$ruleData->_valor);
							$sign = "% ";
							break;
						case 2:
							$valor = $precioCalculado-($precioCalculado/$ruleData->_valor);
							$sign = "% ";
							break;
						case 3:
							$valor = (($precioCalculado*$ruleData->_valor)/100);
							$sign = "% ";
							break; 
						
					}
					
					$cargo = $valor;
					$monto = $valor;
					$precioActual = $precioActual-$cargo;
					break;
				case 2:										
					$extra = $ruleData->_valor ;
					$sign = "† ";
					break;
			}
			$result[] = $this->createTestItem($ruleData->_nombre.$applyTo,$ruleData->_valor,$cargo,$abono,$extra,$monto,$this->trunkNumber($precioActual),$sign);
		 }
 
	  }else{
		  $result[] = $this->createTestItem('Product not found','','','','','','');		  
	  }
	  
	  return $result;
  }
  
  private function createTestItem($nombre,$val,$cargo,$abono,$extra,$monto,$costo,$sign=''){
	  $item = new stdClass();
	  $item->_nombre = $nombre;
	  $item->_valor = ($val!=0 ? $sign.$this->trunkNumber($val,2) : '');
	  $item->_cargo = ($cargo!=0 ? $this->trunkNumber($cargo,2) : '');
	  $item->_abono = ($abono!=0 ? $this->trunkNumber($abono,2) : '');
	  $item->_extra = ($extra!=0 ? $sign.$this->trunkNumber($extra,2) : '');
	  $item->_monto = ($monto!=0 ? $this->trunkNumber($monto,2) : '');
	  $item->_costo = ($costo!=0 ? $this->trunkNumber($costo,2) : '');
	  return $item;
  }
  
  private function trunkNumber($number,$decimals=0){
	  return number_format(floor($number * 10000) / 10000, 2, '.', '');
  }
  
  private function getFieldValue($params){
	  $id 		= $params->_llave;
	  $field 	= $params->_campo;
	  $table	= $params->_tabla;	 
	  
	  $res = $this->ds->query('select '.$field.' from '.$table.' where '.$id.' = '.$params->{$id});
	  if($res->num_rows!=0){
		  $result = $res->fetch_object();
	  }
	  //throw new exception('select '.$field.' from '.$table.' where '.$id.' = '.$params->{$id});
	  return $result->{$field};
  }


}
?>