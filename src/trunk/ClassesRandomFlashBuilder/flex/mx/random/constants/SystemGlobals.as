package mx.random.constants{
	import mx.collections.ArrayCollection;
	import mx.random.sockets.SocketManager;
	
	[Bindable]
	public class SystemGlobals	{
		
		public static var federalTax:Number = 0.1600;
		public static var estatalTax:Number	= 0.0300;
		public static var utily:Number		= 0.1000;
		public static var tcFix:Number		= 12.10;
		public static var mainStage:Object;
		
		public static var SOCKET_SERVER_PORT:int  = 0;
		public static var SOCKET_SERVER_IP:String = "0.0.0.0";
		public static var USE_SOCKET_SYNK:Boolean  = false;
		public static var SOCKET_MANAGER:SocketManager;
		
		public static var userDateFormat:String		= "DD/MM/YYYY";
		
		public static var userId:String		= "";
		public static var userName:String		= "";		
		public static var userLevel:String		= "";
		public static var userLevelId:Number	= 0;
		public static var userGroup:String		= "";
		public static var userGroupId:Number	= 0;
		public static var sucursal:String		= "";
		public static var token:String			= "";
		
		public static var systemStatus:String   = "";
		public static var serverStatus:String   = "";
		
		public static var LANGUAGE:String		= "_EN";
		
		public static var ADMIN_ROLES:ArrayCollection 		= new ArrayCollection();
		public static var ADMIN_GROUPS:ArrayCollection 		= new ArrayCollection();
		
		
		public static var LABELS:ArrayCollection		= new ArrayCollection();
		public static var AREAS:ArrayCollection 		= new ArrayCollection();
		public static var DEPARTAMENTOS:ArrayCollection = new ArrayCollection();
		public static var PUESTOS:ArrayCollection 		= new ArrayCollection();
		public static var CECO:ArrayCollection 		    = new ArrayCollection();
		public static var COMPANIAS:ArrayCollection 	= new ArrayCollection();
		public static var UBICACIONES:ArrayCollection 	= new ArrayCollection();
		public static var CATEGORIAS:ArrayCollection 	= new ArrayCollection();
		public static var SUCURSALES:ArrayCollection 	= new ArrayCollection();
		public static var SUCURSALES_GRUPOS:ArrayCollection	= new ArrayCollection();
		public static var MONEDAS:ArrayCollection 		= new ArrayCollection();
		public static var BANCOS:ArrayCollection 		= new ArrayCollection();
		public static var CUENTAS_BANCARIAS:ArrayCollection 		= new ArrayCollection();
		public static var CALENDAR_CONFIG:ArrayCollection 	= new ArrayCollection();	
		public static var CURSOS_TIPO:ArrayCollection	= new ArrayCollection();
		
		
		//----- DSM ----
		public static var empleado:Boolean	=	false;
		public static var superior:Boolean	=	false;
		public static var instructor:Boolean	=	false;
		public static var rh:Boolean	=	false;
		//----- DSM ----
		
		//----- SAET ----
		public static var PRODUCTOS:ArrayCollection 	= new ArrayCollection();
		
		public static var PRODUCTOS_FAMILIAS:ArrayCollection 		= new ArrayCollection();
		public static var PRODUCTOS_SUBFAMILIAS:ArrayCollection 	= new ArrayCollection();
		public static var PRODUCTOS_GRUPOS_COBRO:ArrayCollection 	= new ArrayCollection();
		public static var PRODUCTOS_REGLAS_NEGOCIO:ArrayCollection 	= new ArrayCollection();
		
		public static var PROGRAMAS:ArrayCollection 	= new ArrayCollection();
		public static var DESCRIPCION_PAGOS:ArrayCollection 	= new ArrayCollection();
		public static var CONDICIONES_DE_PAGO:ArrayCollection	= new ArrayCollection();
		public static var TIPOS_COMISIONES:ArrayCollection	= new ArrayCollection();
		
		public static var DV_REGIONES:ArrayCollection	= new ArrayCollection();
		public static var DV_PAISES:ArrayCollection	= new ArrayCollection();
		public static var DV_CIUDADES:ArrayCollection	= new ArrayCollection();
		public static var DV_HOTELES:ArrayCollection	= new ArrayCollection();
		
		//----- SAET ----
		
		
		//---- PITAHIA ---
		public static var COLECCIONES:ArrayCollection 	= new ArrayCollection();
		//---- PITAHIA ---	
		
		//----- PRM ----
		public static var TIPOS_COMPETENCIAS:ArrayCollection	= new ArrayCollection();
		
		public static var NIVELES_CONOCIMIENTOS:ArrayCollection	= new ArrayCollection();
		public static var TIPOS_CONOCIMIENTOS:ArrayCollection	= new ArrayCollection();
		public static var MEDIOS_ADQUISICION:ArrayCollection	= new ArrayCollection();
		public static var HABILIDADES:ArrayCollection	= new ArrayCollection();
		public static var ACTITUDES:ArrayCollection	= new ArrayCollection();
		public static var NIVELES_HABILIDADES:ArrayCollection	= new ArrayCollection();
		public static var TIPOS_INDICADORES:ArrayCollection	= new ArrayCollection();
		
		public static var TIPOS_CONTRATOS:ArrayCollection	= new ArrayCollection();		
		public static var TURNOS:ArrayCollection	= new ArrayCollection();
		public static var NIEVELES_PUESTOS:ArrayCollection	= new ArrayCollection();
		public static var TIPOS_CARRERA:ArrayCollection	= new ArrayCollection();
		public static var COMPETENCIAS:ArrayCollection	= new ArrayCollection();
		public static var CONOCIMIENTOS:ArrayCollection	= new ArrayCollection();
		public static var NIVELES:ArrayCollection	= new ArrayCollection();
		
		//----- PRM ----
		
		
		//----- ISCO ----
		public static var TIPOS_CONTRASENAS:ArrayCollection	= new ArrayCollection();
		public static var EMPRESA_SERVICIOS:ArrayCollection	= new ArrayCollection();
		public static var FISCALES_DOCUMENTOS:ArrayCollection= new ArrayCollection();
		public static var OBLIGACIONES_FISCALES_PERIODOS:ArrayCollection= new ArrayCollection();
		public static var OBLIGACIONES_FISCALES:ArrayCollection= new ArrayCollection();
		public static var NIVELES_ACCESO:ArrayCollection= new ArrayCollection();
		public static var CONCEPTOS_CHECK:ArrayCollection= new ArrayCollection();
		
		//----- ISCO ----
		
		//------GRAPHO-----
		public static var TIPOS_SERVICIO:ArrayCollection= new ArrayCollection();
		public static var AREAS_SOPORTE:ArrayCollection	= new ArrayCollection();
		public static var ORDEN_ESTATUS:ArrayCollection	= new ArrayCollection();
		public static var EMPLEADOS:ArrayCollection	= new ArrayCollection();
		public static var EQUIPOS:ArrayCollection        = new ArrayCollection();
		public static var MARCAS:ArrayCollection        = new ArrayCollection();
		public static var TIPOS_EQUIPOS:ArrayCollection        = new ArrayCollection();
		public function SystemGlobals()		{
		}
		
	}
}