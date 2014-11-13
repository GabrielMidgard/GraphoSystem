<?php
require_once("DataSource.php");
class Catalogs{

  protected $ds;

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getCatalogs($tables){
        $dataArray = array(); 		
        for($n=0;$n<count($tables);$n++){			  
            $dataArray[$tables[$n]] = $this->ds->selectSQL($tables[$n],"*");
        }
        return $dataArray;
  }


}
?>