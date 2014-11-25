package mx.random.constants{
	import mx.collections.ArrayCollection;
	import mx.random.converters.Converter;
	import mx.random.web.WebApplication;
	import mx.random.events.CatalogEvent;
	import mx.random.events.StaticEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	public class Catalogs{
		
		
[Bindable]	public static var DataArray:ArrayCollection = new ArrayCollection();
[Bindable]	public static var DataObject:Object 		= new Object();
[Bindable]	public static var Tables:Array 				= new Array();

			private static var WA:WebApplication;
			private static var SRV:RemoteObject;
		
			public function Catalogs(){
			}
			
			public static function config(wa:WebApplication,tables:Array):void{
				SystemGlobals.systemStatus = "Loading Catalogs...";
				StaticEvent.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_INIT));
				Tables = tables;
				WA = wa;
				SRV = WA.getService("Catalogs");
				SRV.addEventListener(FaultEvent.FAULT,onFault);
				SRV.getCatalogs(tables);
				SRV.getCatalogs.addEventListener(ResultEvent.RESULT,onResult);
			}
			
			private static function onFault(e:FaultEvent):void{
				SystemGlobals.systemStatus = "Catalog Loading Errors...";
				StaticEvent.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_ERROR));
			}
			
			private static function onResult(e:ResultEvent):void{
				SystemGlobals.systemStatus = "";
				SRV.getCatalogs.removeEventListener(ResultEvent.RESULT,onResult);
				
				if(e.result) DataObject = e.result;
				if(DataObject['System_Labels']) 		SystemGlobals.LABELS 			= Converter.arrayConverter(DataObject['System_Labels']);
				if(DataObject['empresa_areas']) 		SystemGlobals.AREAS 			= Converter.arrayConverter(DataObject['empresa_areas']);
				if(DataObject['empresa_ceco']) 			SystemGlobals.CECO 		    	= Converter.arrayConverter(DataObject['empresa_ceco']);
				if(DataObject['empresa_departamentos']) SystemGlobals.DEPARTAMENTOS 	= Converter.arrayConverter(DataObject['empresa_departamentos']);
				if(DataObject['empresa_companias']) 	SystemGlobals.COMPANIAS 		= Converter.arrayConverter(DataObject['empresa_companias']);
				if(DataObject['empresa_puestos']) 		SystemGlobals.PUESTOS 			= Converter.arrayConverter(DataObject['empresa_puestos']);
				if(DataObject['empresa_ubicaciones'])   SystemGlobals.UBICACIONES		= Converter.arrayConverter(DataObject['empresa_ubicaciones']);
				if(DataObject['empresa_sucursales'])    SystemGlobals.SUCURSALES		= Converter.arrayConverter(DataObject['empresa_sucursales']);
				if(DataObject['empresa_categorias'])    SystemGlobals.CATEGORIAS		= Converter.arrayConverter(DataObject['empresa_categorias']);
				if(DataObject['___calendarConfig'])     SystemGlobals.CALENDAR_CONFIG 	= Converter.arrayConverter(DataObject['___calendarConfig']);
				
				if(DataObject['___adminRoles'])     	SystemGlobals.ADMIN_ROLES 		= Converter.arrayConverter(DataObject['___adminRoles']);
				if(DataObject['___adminGroups'])     	SystemGlobals.ADMIN_GROUPS 		= Converter.arrayConverter(DataObject['___adminGroups']);
				
				
				
				if(DataObject['Productos_Familias'])    	SystemGlobals.PRODUCTOS_FAMILIAS		= Converter.arrayConverter(DataObject['Productos_Familias']);
				if(DataObject['Productos_SubFamilias'])    	SystemGlobals.PRODUCTOS_SUBFAMILIAS		= Converter.arrayConverter(DataObject['Productos_SubFamilias']);
				if(DataObject['Productos_Grupos_Cobro'])    SystemGlobals.PRODUCTOS_GRUPOS_COBRO	= Converter.arrayConverter(DataObject['Productos_Grupos_Cobro']);
				if(DataObject['Productos_Reglas_Negocio'])  SystemGlobals.PRODUCTOS_REGLAS_NEGOCIO	= Converter.arrayConverter(DataObject['Productos_Reglas_Negocio']);
				if(DataObject['tipos_servicio'])  SystemGlobals.TIPOS_SERVICIO	= Converter.arrayConverter(DataObject['tipos_servicio']);
				if(DataObject['areas_soporte_tecnico'])  SystemGlobals.AREAS_SOPORTE	= Converter.arrayConverter(DataObject['areas_soporte_tecnico']);
				if(DataObject['estatus'])  SystemGlobals.ORDEN_ESTATUS	= Converter.arrayConverter(DataObject['estatus']);
				if(DataObject['empleados'])  SystemGlobals.EMPLEADOS	= Converter.arrayConverter(DataObject['empleados']);				
				if(DataObject['equipos'])  SystemGlobals.EQUIPOS        = Converter.arrayConverter(DataObject['equipos']);
				if(DataObject['marcas'])  SystemGlobals.MARCAS        = Converter.arrayConverter(DataObject['marcas']);
				if(DataObject['tipos_equipo'])  SystemGlobals.TIPOS_EQUIPOS        = Converter.arrayConverter(DataObject['tipos_equipo']);
				
				if(SystemGlobals.TIPOS_SERVICIO.length == 0 || SystemGlobals.TIPOS_SERVICIO[0]._idTipoServicio != 0){
					SystemGlobals.TIPOS_SERVICIO.addItemAt({_idTipoServicio:0,_nombre:'Seleccionar'},0);	
				}
				if(SystemGlobals.AREAS_SOPORTE.length == 0 || SystemGlobals.AREAS_SOPORTE[0]._idAreaSoporteTecnico != 0){
					SystemGlobals.AREAS_SOPORTE.addItemAt({_idAreaSoporteTecnico:0,_areaSoporteTecnico:'Seleccionar'},0);	
				}
				if(SystemGlobals.ORDEN_ESTATUS.length == 0 || SystemGlobals.ORDEN_ESTATUS[0]._idEstatus != 0){
					SystemGlobals.ORDEN_ESTATUS.addItemAt({_idEstatus:0,_nombreEstatus:'Seleccionar'},0);	
				}
				if(SystemGlobals.EMPLEADOS.length == 0 || SystemGlobals.EMPLEADOS[0]._idEmpleado != 0){
					SystemGlobals.EMPLEADOS.addItemAt({_idEmpleado:0,_nombre:'Seleccionar'},0);	
				}
				if(SystemGlobals.DEPARTAMENTOS.length == 0 || SystemGlobals.DEPARTAMENTOS[0]._idDepartamento != 0){
					SystemGlobals.DEPARTAMENTOS.addItemAt({_idDepartamento:0,_nombre:'Seleccionar'},0);	
				}
				if(SystemGlobals.PUESTOS.length == 0 || SystemGlobals.PUESTOS[0]._idPuesto != 0){
					SystemGlobals.PUESTOS.addItemAt({_idPuesto:0,_nombre:'Seleccionar'},0);	
				}
				
				StaticEvent.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_COMPLETE));
			}
			
			public static function reload():void{
				SystemGlobals.systemStatus = "Updating Catalogs...";
				StaticEvent.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_RELOAD_INIT));
				DataObject = new Object();
				SRV.getCatalogs(Tables);	
				SRV.getCatalogs.addEventListener(ResultEvent.RESULT,onResult);
			}
			
			public static function reloadSpecificTables(specificTables:Array):void{
				SystemGlobals.systemStatus = "Updating Catalogs...";
				StaticEvent.dispatchEvent(new CatalogEvent(CatalogEvent.CATALOG_RELOAD_INIT));
				DataObject = new Object();
				SRV.getCatalogs(specificTables);	
				SRV.getCatalogs.addEventListener(ResultEvent.RESULT,onResult);
			}

	}
}