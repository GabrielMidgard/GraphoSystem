<?php
require_once("DataSource.php");
class System_Catalogs{

  protected $ds;

  public function __construct(){
    $this->ds 		= new DataSource();
  }

  public function getCatalogs($tables){
        $dataArray = array();
        for($n=0;$n<count($tables);$n++){
            if(mysql_num_rows($this->ds->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME = '".$tables[$n]."' and COLUMN_NAME = '_active'"))!=0){
                 $dataArray[$tables[$n]] = $this->ds->query("select * from ".$tables[$n]." where _active = 'true'");
            }else{
                $dataArray[$tables[$n]] = $this->ds->selectSQL($tables[$n],"*");
            }

        }
        return $dataArray;
  }


}
?>