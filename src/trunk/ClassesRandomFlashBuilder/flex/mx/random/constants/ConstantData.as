package mx.random.constants{
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
	
	[Bindable]
	public class ConstantData{
		
		
		
		public static var SystemFormatString:String	=	"YYYY-MM-DD";
		public static var ViewFormatString:String 	=  "DD/MM/YYYY";
		
		public static var DayNames:Array	=	['D', 'L', 'M','M', 'J', 'V', 'S'];
		public static var MonthNames:Array	=	["Enero", "Febrero", "Marzo", "Abril", "Mayo","Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"];
		
		
		
		
		public static var Discapacidades:ArrayCollection = new ArrayCollection([{label:"Ninguna",		value:0},
			{label:"Motríz",		value:1},
			{label:"Visual",		value:2},
			{label:"Mental",		value:3},
			{label:"Auditiva",		value:4},
			{label:"De lenguaje",	value:5}																				
		]);		
		
		
		public static var AccessTypes:ArrayCollection = new ArrayCollection([ 	
			{label:"Total",				value:0},
			{label:"Ventas",			value:1},
			{label:"Ingeniería",		value:2}
			//{label:"Limitado",			value:0}
			/*{label:"Ubicaciones",			value:4},
			{label:"CECO",					value:5},
			{label:"Categorías",			value:6},
			{label:"Total",					value:7}*/
			
		]);
		
		public static var CompanyAccessTypes:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},
			{label:"Empleado",				value:1},												
			{label:"Superior",				value:2},
			{label:"Instructor",			value:3},
			{label:"RH",					value:4}																				
		]);
		
		public static var LocationAccessTypes:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},
			{label:"Vendedor",				value:1},												
			{label:"Supervisor",			value:2},
			{label:"Gerente",				value:3},
			{label:"Director",				value:4},
			{label:"Contador",				value:5},												
			{label:"RH",					value:6},
			{label:"Reservaciones",			value:7},
			{label:"FullFillment",			value:8},
			{label:"ATC",					value:9}																				
		]);
		
		public static var LocationAccessTypesSuc:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		    value:0},
			{label:"Vendedor",				value:1},												
			{label:"Supervisor",			value:2},
			{label:"Gerente",				value:3}																				
		]);
		public static var ISCOAccessTypes:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},
			{label:"Ejecutivo de Cuenta",	value:1},												
			{label:"Gerente de Cuenta",		value:2},
			{label:"Administracion",		value:3},
			{label:"Capturista",			value:4},
			{label:"Mensajero",				value:5}																				
		]);																					
		
		
		
		public static var Activities:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},												
			{label:"Culturales",			value:1},
			{label:"Sociales",				value:2},
			{label:"Hobby",					value:3},
			{label:"Deportivas",			value:4},
			{label:"Otro",					value:5}
		]);
		
		public static var HomeTypes:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},												
			{label:"Casa",					value:1},
			{label:"Departamento",			value:2},
			{label:"Condominio Horizontal",	value:3},
			{label:"Asistencia",			value:4},
			{label:"Otro",					value:5}
		]);
		
		public static var HomeStatus:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",			value:0},												
			{label:"Propia",				value:1},
			{label:"Credito Hipotecario",	value:2},
			{label:"Prestado",				value:3},
			{label:"Renta",					value:4},
			{label:"Compartido",			value:5}
		]);
		
		public static var HomeCondition:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},												
			{label:"Excelenta",				value:1},
			{label:"Buena",					value:2},
			{label:"Regular",				value:3},
			{label:"Mala",					value:4},
			{label:"Deficiente",			value:5}
		]);
		
		public static var AdminLevels:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},												
			{label:"Agente",			value:1},
			{label:"Sucursal",			value:2},
			{label:"Administrador",		value:3},
			{label:"System",			value:4}
		]);
		
		public static var Priority:ArrayCollection = new ArrayCollection([ 		{label:"Seleccionar",	value:0},												
			{label:"Baja",			value:1},
			{label:"Media",			value:2},
			{label:"Alta",			value:3}
		]);																				
		
		public static var AdminLevelsFTP:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		value:0},
			{label:"Guest",				value:1},
			{label:"User",				value:2},
			{label:"System",			value:3}
		]);																								
		
		public static var Sex:ArrayCollection = new ArrayCollection([ 			{label:"Seleccionar",		value:0},
			{label:"Masculino",			value:1},
			{label:"Femenio",			value:2}																				
		]);
		
		public static var LicenceType:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",					value:0},
			{label:"Ninguna",  						value:1},
			{label:"Automivilista",  				value:2},
			{label:"Chofer",						value:3},
			{label:"Conductor de Servicios",		value:4},
			{label:"Motociclista",					value:5},
			{label:"Lic. Federal",					value:6}																				
		]);																																					
		
		public static var Source:ArrayCollection = new ArrayCollection([ 		{label:"Seleccionar",		value:0},
			{label:"Interno",			value:1},
			{label:"Externo",			value:2},
			{label:"Otro",				value:3}																				
		]);
		
		public static var Periods:ArrayCollection = new ArrayCollection([ 		{label:"Seleccionar",		value:0},
			{label:"Minutos",			value:1},
			{label:"Horas",				value:2},
			{label:"Días",				value:3},
			{label:"Meses",				value:4},
			{label:"Años",				value:5}																				
		]);		
		public static var TestPeriods:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},
			{label:"Diario",			value:1},
			{label:"Semanal",				value:2},
			{label:"Quincenal",				value:3},
			{label:"Mensual",				value:4},
			{label:"Bimestral",				value:5},
			{label:"Trimestral",				value:6},
			{label:"Semestral",				value:7},
			{label:"Anual",				value:8},
			{label:"por Proyecto",				value:9}																				
		]);				
		public static var LongPeriods:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},																				
			{label:"Días",				value:1},
			{label:"Meses",				value:2},
			{label:"Años",				value:3}																				
		]);	
		
		public static var LongPeriodsEval:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		value:0},																				
			{label:"Diario",				value:1},
			{label:"Mensual",				value:2},
			{label:"Anual",				value:3}																				
		]);																			
		
		
		public static var Frecuency:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},
			{label:"por Dia",			value:1},
			{label:"por Semana",		value:2},
			{label:"por Mes",			value:3},
			{label:"por Año",			value:4}																																						
		]);																																										
		
		public static var StatusColors:ArrayCollection = new ArrayCollection([ 	{label:"Por Cobrar",		value:2836542},
			{label:"Pagada",			value:2347623},
			{label:"Vencida",			value:5645322},
			{label:"Cancelada",			value:5643453}
		]);
		
		
		public static var PaymentStatus:ArrayCollection = new ArrayCollection([ {label:"Seleccionar",		value:0,	color:0x8e90fb},
			{label:"Por Cobrar",		value:1,	color:0x8e90fb},
			{label:"Pagada",			value:2,	color:0xc8fdc2},
			{label:"Vencida",			value:3,	color:0xfe8b8b},
			{label:"Cancelada",			value:4,	color:0xfdf27a}
		]);
		
		public static var MembershipStatus:ArrayCollection = new ArrayCollection([ {label:"Seleccionar",	value:0,	color:0x8e90fb},
			{label:"Activa",			value:1,	color:0x8e90fb},
			{label:"Inactiva",			value:2,	color:0xc8fdc2},
			{label:"Vencida",			value:3,	color:0xfe8b8b},
			{label:"Cancelada",			value:4,	color:0xfdf27a}
		]);
		public static var DocumentStatus:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		value:0,	color:0x8e90fb},
			{label:"En Proceso",		value:1,	color:0x8e90fb},
			{label:"Por Imprimir",		value:2,	color:0xc8fdc2},
			{label:"Impresa",			value:3,	color:0xfe8b8b},
			{label:"Entregada",			value:4,	color:0xfe8b8b},
			{label:"Enviada",			value:5,	color:0xfe8b8b},
			{label:"Cancelada",			value:6,	color:0xfdf27a},
			{label:"Vencida",			value:7,	color:0xfdf27a}
		]);	
		
		public static var BlogStatus:ArrayCollection = new ArrayCollection([{label:"Seleccionar",			value:0,	color:0x8e90fb},
			{label:"Iniciado",			value:1,	color:0x8e90fb},
			{label:"Activo",			value:2,	color:0xc8fdc2},
			{label:"Concluído",			value:3,	color:0xfe8b8b}
		]);	
		
		
		public static var PaymentStatusFilter:ArrayCollection = new ArrayCollection([ 
			{label:"Todas",			    value:""},
			{label:"Por Acreditar",		value:0},
			{label:"Pagadas",			value:1},
			{label:"Vencidas",			value:2},
			{label:"Canceladas",		value:3}
			
		]);	
		
		public static var PaymentStatusFilterB:ArrayCollection = new ArrayCollection([ 
			{label:"Todas",			    value:0},
			{label:"Por Cobrar",		value:1},
			{label:"Pagadas",			value:2},
			{label:"Vencidas",			value:3},
			{label:"Canceladas",		value:4}
			
		]);																																				
		
		
		
		public static var PaymentTypes:ArrayCollection = new ArrayCollection([  {label:"Seleccionar",				value:0},
			{label:"Tarjeta de Crédito",		value:1},
			{label:"Transferencia Electrónica",	value:2},
			{label:"Depósito en Ventanilla",	value:3},
			{label:"Cheque",				    value:4},
			{label:"Efectivo",				    value:5},																				
			{label:"Otro",				    	value:6}
		]);
		
		public static var PaymentTypesFilter:ArrayCollection = new ArrayCollection([  	{label:"Todos",						value:0},
			{label:"Tarjeta de Crédito",		value:1},
			{label:"Transferencia Electrónica",	value:2},
			{label:"Depósito en Ventanilla",	value:3},
			{label:"Cheque",				    value:4},
			{label:"Efectivo",				    value:5},																				
			{label:"Otro",				    	value:6}
		]);
		
		
		
		public static var BankStatus:ArrayCollection = new ArrayCollection([{label:"Sin Pagos", 		value:0},
			{label:"Liquidada", 	value:1},
			{label:"En Abono", 		value:2},
			{label:"Cancelada", 	value:5}
		]);
		
		
		
		public static var EstadosCiviles:ArrayCollection = new ArrayCollection([ 			
			{label:"Seleccionar",		index:0},
			{label:"Soltero(a)",		index:1},
			{label:"Union Libre",		index:2},
			{label:"Casado(a)",			index:3},
			{label:"Divorciado(a)",		index:4},
			{label:"Separado(a)",		index:5},
			{label:"Viudo(a)",			index:6}																				
		]);
		
		public static var Prefijos:ArrayCollection = new ArrayCollection([	
			{label: "Select", 	index: 0},
			{label: "Sr.", 		index: 1},
			{label: "Sra.", 	index: 2},
			{label: "Srita", 	index: 3}
		]);
		
		public static var RelationShip:ArrayCollection = new ArrayCollection([	
			{label: "Select" , 		index: 0},
			{label: "Padres",  		index: 1},
			{label: "Esposo(a)",  	index: 2},
			{label: "Hermano(a)",  	index: 3},
			{label: "Socio(a)",  	index: 4},
			{label: "Hijo(a)", 		index: 5},
			{label: "Amigo(a)", 	index: 6},
			{label: "Unión Libre", 	index: 7},
			{label: "Otro(a)", 		index: 8}
		]);
		
		public static var Languages:ArrayCollection = new ArrayCollection([ 	
			{label:"Seleccionar",		index:0},
			{label:"Idioma Natal",		index:1},
			{label:"Español",			index:2},
			{label:"Inglés",			index:3},
			{label:"Francés",			index:4},
			{label:"Italiano",			index:5},
			{label:"Alemán",			index:6},
			{label:"Chino",				index:7},
			{label:"Japonés",			index:8},
			{label:"Mandarín",			index:9},
			{label:"Portugués",			index:10}
		]);
		
		
		
		public static const BloodTypes:ArrayCollection = new ArrayCollection([
			{label:"Sel",	index:0},
			{label:"O-",	index:1},
			{label:"O+",	index:2},
			{label:"A-",	index:3},
			{label:"A+",	index:4},
			{label:"B-",	index:5},
			{label:"B+",	index:6},
			{label:"AB-",	index:7},
			{label:"AB+",	index:8}
		]);
		
		public static var CardTypes:ArrayCollection = new ArrayCollection([	{label:"Select", 			value:0},
			{label:"Visa", 				value:1},
			{label:"MasterCard", 		value:2},
			{label:"American Express", 	value:3},
			{label:"Discover", 			value:4},
			{label:"Interval", 			value:5}
		]);
		
		public static var Days:ArrayCollection = new ArrayCollection([		{label:"Dia",	value:0},	{label:"01",	value:1},	{label:"02",	value:2},
			{label:"03",	value:3},	{label:"04",	value:4},
			{label:"05",	value:5},	{label:"06",	value:6},
			{label:"07",	value:7},	{label:"08",	value:8},
			{label:"09",	value:9},	{label:"10",	value:10},
			{label:"11",	value:11},	{label:"12",	value:12},
			{label:"13",	value:13},	{label:"14",	value:14},
			{label:"15",	value:15},	{label:"16",	value:16},
			{label:"17",	value:17},	{label:"18",	value:18},
			{label:"19",	value:19},	{label:"20",	value:20},
			{label:"21",	value:21},	{label:"22",	value:22},
			{label:"23",	value:23},	{label:"24",	value:24},
			{label:"25",	value:25},	{label:"26",	value:26},
			{label:"27",	value:27},	{label:"28",	value:28},
			{label:"29",	value:29},	{label:"30",	value:30},
			{label:"31",	value:31}]);
		
		public static var Months:ArrayCollection = new ArrayCollection([	{label:"Mes",		value:0},{label:"Enero",	value:1},{label:"Febrero",	value:2},
			{label:"Marzo",		value:3},{label:"Abril",	value:4},
			{label:"Mayo",		value:5},{label:"Junio",		value:6},
			{label:"Julio",		value:7},{label:"Agosto",	value:8},
			{label:"Septiembre",	value:9},{label:"Octubre",	value:10},
			{label:"Noviembre",	value:11},{label:"Diciembre",	value:12}]);
		
		public static var Prefix:ArrayCollection = new ArrayCollection([	{ value: 0, label: "Select" },
			{ value: 1, label: "Sr." },
			{ value: 2, label: "Sra." },
			{ value: 3, label: "Srita" }
		]);
		
		public static var AccountTypes:ArrayCollection = new ArrayCollection([	{ value: 0, label: "Seleccionar" },
			{ value: 1, label: "Cheques" },
			{ value: 2, label: "Ahorros" },
			{ value: 3, label: "Crédito" },
			{ value: 4, label: "Inversión"},
			{ value: 5, label: "Terminal Punto de Venta"},
			{ value: 6, label: "Terminal Virtual WEB Post"}
		]);	
		
		public static var ShortCountries:ArrayCollection = new ArrayCollection([{ value: 0, label: "Seleccionar" },
			{ value: 1, label: "México" },
			{ value: 2, label: "Estados Unidos" },
			{ value: 3, label: "Canada" },
			{ value: 4, label: "Otro" }
		]);				        													        														
		
		public static var CoPrefix:ArrayCollection = new ArrayCollection([	{ value: 0, label: "Select" },
			{ value: 1, label: "Esposo(a)" },
			{ value: 2, label: "Hermano(a)" },
			{ value: 3, label: "Socio(a)" },
			{ value: 4, label: "Hijo(a)" },
			{ value: 4, label: "Amigo(a)" },
			{ value: 5, label: "Otro(a)" }]);
		
		public static var Professions:ArrayCollection = new ArrayCollection([{ value: 0, label: "Select" },
			{ value: 1, label: "Empleado(a)" },
			{ value: 2, label: "Profesionista" },
			{ value: 3, label: "Empresario" },
			{ value: 4, label: "Hogar" },
			{ value: 4, label: "Ninguna" },
			{ value: 5, label: "Otro(a)" }]);			        																	        									
		
		
		public static var Countries:ArrayCollection = new ArrayCollection([	{ value: "00", label: "Select" },
			{ value: "AD", label: "Andorra" },
			{ value: "AE", label: "United Arab Emirates" },
			{ value: "AF", label: "Afghanistan" },
			{ value: "AG", label: "Antigua & Barbuda" },
			{ value: "AI", label: "Anguilla" },
			{ value: "AL", label: "Albania" },
			{ value: "AM", label: "Armenia" },
			{ value: "AN", label: "Netherlands Antilles" },
			{ value: "AO", label: "Angola" },
			{ value: "AQ", label: "Antarctica" },
			{ value: "AR", label: "Argentina" },
			{ value: "AS", label: "American Samoa" },
			{ value: "AT", label: "Austria" },
			{ value: "AU", label: "Australia" },
			{ value: "AW", label: "Aruba" },
			{ value: "AZ", label: "Azerbaijan" },
			{ value: "BA", label: "Bosnia and Herzegovina" },
			{ value: "BB", label: "Barbados" },
			{ value: "BD", label: "Bangladesh" },
			{ value: "BE", label: "Belgium" },
			{ value: "BF", label: "Burkina Faso" },
			{ value: "BG", label: "Bulgaria" },
			{ value: "BH", label: "Bahrain" },
			{ value: "BI", label: "Burundi" },
			{ value: "BJ", label: "Benin" },
			{ value: "BM", label: "Bermuda" },
			{ value: "BN", label: "Brunei Darussalam" },
			{ value: "BO", label: "Bolivia" },
			{ value: "BR", label: "Brazil" },
			{ value: "BS", label: "Bahama" },
			{ value: "BT", label: "Bhutan" },
			{ value: "BU", label: "Burma (no longer exists)" },
			{ value: "BV", label: "Bouvet Island" },
			{ value: "BW", label: "Botswana" },
			{ value: "BY", label: "Belarus" },
			{ value: "BZ", label: "Belize" },
			{ value: "CA", label: "Canada" },
			{ value: "CC", label: "Cocos (Keeling) Islands" },
			{ value: "CF", label: "Central African Republic" },
			{ value: "CG", label: "Congo" },
			{ value: "CH", label: "Switzerland" },
			{ value: "CI", label: "C&ocirc;te D'ivoire (Ivory Coast)" },
			{ value: "CK", label: "Cook Iislands" },
			{ value: "CL", label: "Chile" },
			{ value: "CM", label: "Cameroon" },
			{ value: "CN", label: "China" },
			{ value: "CO", label: "Colombia" },
			{ value: "CR", label: "Costa Rica" },
			{ value: "CS", label: "Czechoslovakia (no longer exists)" },
			{ value: "CU", label: "Cuba" },
			{ value: "CV", label: "Cape Verde" },
			{ value: "CX", label: "Christmas Island" },
			{ value: "CY", label: "Cyprus" },
			{ value: "CZ", label: "Czech Republic" },
			{ value: "DD", label: "German Democratic Republic (no longer exists)" },
			{ value: "DE", label: "Germany" },
			{ value: "DJ", label: "Djibouti" },
			{ value: "DK", label: "Denmark" },
			{ value: "DM", label: "Dominica" },
			{ value: "DO", label: "Dominican Republic" },
			{ value: "DZ", label: "Algeria" },
			{ value: "EC", label: "Ecuador" },
			{ value: "EE", label: "Estonia" },
			{ value: "EG", label: "Egypt" },
			{ value: "EH", label: "Western Sahara" },
			{ value: "ER", label: "Eritrea" },
			{ value: "ES", label: "Spain" },
			{ value: "ET", label: "Ethiopia" },
			{ value: "FI", label: "Finland" },
			{ value: "FJ", label: "Fiji" },
			{ value: "FK", label: "Falkland Islands (Malvinas)" },
			{ value: "FM", label: "Micronesia" },
			{ value: "FO", label: "Faroe Islands" },
			{ value: "FR", label: "France" },
			{ value: "FX", label: "France, Metropolitan" },
			{ value: "GA", label: "Gabon" },
			{ value: "GB", label: "United Kingdom (Great Britain)" },
			{ value: "GD", label: "Grenada" },
			{ value: "GE", label: "Georgia" },
			{ value: "GF", label: "French Guiana" },
			{ value: "GH", label: "Ghana" },
			{ value: "GI", label: "Gibraltar" },
			{ value: "GL", label: "Greenland" },
			{ value: "GM", label: "Gambia" },
			{ value: "GN", label: "Guinea" },
			{ value: "GP", label: "Guadeloupe" },
			{ value: "GQ", label: "Equatorial Guinea" },
			{ value: "GR", label: "Greece" },
			{ value: "GS", label: "South Georgia and the South Sandwich Islands" },
			{ value: "GT", label: "Guatemala" },
			{ value: "GU", label: "Guam" },
			{ value: "GW", label: "Guinea-Bissau" },
			{ value: "GY", label: "Guyana" },
			{ value: "HK", label: "Hong Kong" },
			{ value: "HM", label: "Heard & McDonald Islands" },
			{ value: "HN", label: "Honduras" },
			{ value: "HR", label: "Croatia" },
			{ value: "HT", label: "Haiti" },
			{ value: "HU", label: "Hungary" },
			{ value: "ID", label: "Indonesia" },
			{ value: "IE", label: "Ireland" },
			{ value: "IL", label: "Israel" },
			{ value: "IN", label: "India" },
			{ value: "IO", label: "British Indian Ocean Territory" },
			{ value: "IQ", label: "Iraq" },
			{ value: "IR", label: "Islamic Republic of Iran" },
			{ value: "IS", label: "Iceland" },
			{ value: "IT", label: "Italy" },
			{ value: "JM", label: "Jamaica" },
			{ value: "JO", label: "Jordan" },
			{ value: "JP", label: "Japan" },
			{ value: "KE", label: "Kenya" },
			{ value: "KG", label: "Kyrgyzstan" },
			{ value: "KH", label: "Cambodia" },
			{ value: "KI", label: "Kiribati" },
			{ value: "KM", label: "Comoros" },
			{ value: "KN", label: "St. Kitts and Nevis" },
			{ value: "KP", label: "Korea, Democratic People's Republic of" },
			{ value: "KR", label: "Korea, Republic of" },
			{ value: "KW", label: "Kuwait" },
			{ value: "KY", label: "Cayman Islands" },
			{ value: "KZ", label: "Kazakhstan" },
			{ value: "LA", label: "Lao People's Democratic Republic" },
			{ value: "LB", label: "Lebanon" },
			{ value: "LC", label: "Saint Lucia" },
			{ value: "LI", label: "Liechtenstein" },
			{ value: "LK", label: "Sri Lanka" },
			{ value: "LR", label: "Liberia" },
			{ value: "LS", label: "Lesotho" },
			{ value: "LT", label: "Lithuania" },
			{ value: "LU", label: "Luxembourg" },
			{ value: "LV", label: "Latvia" },
			{ value: "LY", label: "Libyan Arab Jamahiriya" },
			{ value: "MA", label: "Morocco" },
			{ value: "MC", label: "Monaco" },
			{ value: "MD", label: "Moldova, Republic of" },
			{ value: "MG", label: "Madagascar" },
			{ value: "MH", label: "Marshall Islands" },
			{ value: "ML", label: "Mali" },
			{ value: "MN", label: "Mongolia" },
			{ value: "MM", label: "Myanmar" },
			{ value: "MO", label: "Macau" },
			{ value: "MP", label: "Northern Mariana Islands" },
			{ value: "MQ", label: "Martinique" },
			{ value: "MR", label: "Mauritania" },
			{ value: "MS", label: "Monserrat" },
			{ value: "MT", label: "Malta" },
			{ value: "MU", label: "Mauritius" },
			{ value: "MV", label: "Maldives" },
			{ value: "MW", label: "Malawi" },
			{ value: "MX", label: "Mexico" },
			{ value: "MY", label: "Malaysia" },
			{ value: "MZ", label: "Mozambique" },
			{ value: "NA", label: "Namibia" },
			{ value: "NC", label: "New Caledonia" },
			{ value: "NE", label: "Niger" },
			{ value: "NF", label: "Norfolk Island" },
			{ value: "NG", label: "Nigeria" },
			{ value: "NI", label: "Nicaragua" },
			{ value: "NL", label: "Netherlands" },
			{ value: "NO", label: "Norway" },
			{ value: "NP", label: "Nepal" },
			{ value: "NR", label: "Nauru" },
			{ value: "NT", label: "Neutral Zone (no longer exists)" },
			{ value: "NU", label: "Niue" },
			{ value: "NZ", label: "New Zealand" },
			{ value: "OM", label: "Oman" },
			{ value: "PA", label: "Panama" },
			{ value: "PE", label: "Peru" },
			{ value: "PF", label: "French Polynesia" },
			{ value: "PG", label: "Papua New Guinea" },
			{ value: "PH", label: "Philippines" },
			{ value: "PK", label: "Pakistan" },
			{ value: "PL", label: "Poland" },
			{ value: "PM", label: "St. Pierre & Miquelon" },
			{ value: "PN", label: "Pitcairn" },
			{ value: "PR", label: "Puerto Rico" },
			{ value: "PT", label: "Portugal" },
			{ value: "PW", label: "Palau" },
			{ value: "PY", label: "Paraguay" },
			{ value: "QA", label: "Qatar" },
			{ value: "RE", label: "R&eacute;union" },
			{ value: "RO", label: "Romania" },
			{ value: "RU", label: "Russian Federation" },
			{ value: "RW", label: "Rwanda" },
			{ value: "SA", label: "Saudi Arabia" },
			{ value: "SB", label: "Solomon Islands" },
			{ value: "SC", label: "Seychelles" },
			{ value: "SD", label: "Sudan" },
			{ value: "SE", label: "Sweden" },
			{ value: "SG", label: "Singapore" },
			{ value: "SH", label: "St. Helena" },
			{ value: "SI", label: "Slovenia" },
			{ value: "SJ", label: "Svalbard & Jan Mayen Islands" },
			{ value: "SK", label: "Slovakia" },
			{ value: "SL", label: "Sierra Leone" },
			{ value: "SM", label: "San Marino" },
			{ value: "SN", label: "Senegal" },
			{ value: "SO", label: "Somalia" },
			{ value: "SR", label: "Suriname" },
			{ value: "ST", label: "Sao Tome & Principe" },
			{ value: "SU", label: "Union of Soviet Socialist Republics (no longer exists)" },
			{ value: "SV", label: "El Salvador" },
			{ value: "SY", label: "Syrian Arab Republic" },
			{ value: "SZ", label: "Swaziland" },
			{ value: "TC", label: "Turks & Caicos Islands" },
			{ value: "TD", label: "Chad" },
			{ value: "TF", label: "French Southern Territories" },
			{ value: "TG", label: "Togo" },
			{ value: "TH", label: "Thailand" },
			{ value: "TJ", label: "Tajikistan" },
			{ value: "TK", label: "Tokelau" },
			{ value: "TM", label: "Turkmenistan" },
			{ value: "TN", label: "Tunisia" },
			{ value: "TO", label: "Tonga" },
			{ value: "TP", label: "East Timor" },
			{ value: "TR", label: "Turkey" },
			{ value: "TT", label: "Trinidad & Tobago" },
			{ value: "TV", label: "Tuvalu" },
			{ value: "TW", label: "Taiwan, Province of China" },
			{ value: "TZ", label: "Tanzania, United Republic of" },
			{ value: "UA", label: "Ukraine" },
			{ value: "UG", label: "Uganda" },
			{ value: "UM", label: "United States Minor Outlying Islands" },
			{ value: "US", label: "United States of America" },
			{ value: "UY", label: "Uruguay" },
			{ value: "UZ", label: "Uzbekistan" },
			{ value: "VA", label: "Vatican City State (Holy See)" },
			{ value: "VC", label: "St. Vincent & the Grenadines" },
			{ value: "VE", label: "Venezuela" },
			{ value: "VG", label: "British Virgin Islands" },
			{ value: "VI", label: "United States Virgin Islands" },
			{ value: "VN", label: "Viet Nam" },
			{ value: "VU", label: "Vanuatu" },
			{ value: "WF", label: "Wallis & Futuna Islands" },
			{ value: "WS", label: "Samoa" },
			{ value: "YD", label: "Democratic Yemen (no longer exists)" },
			{ value: "YE", label: "Yemen" },
			{ value: "YT", label: "Mayotte" },
			{ value: "YU", label: "Yugoslavia" },
			{ value: "ZA", label: "South Africa" },
			{ value: "ZM", label: "Zambia" },
			{ value: "ZR", label: "Zaire" },
			{ value: "ZW", label: "Zimbabwe" },
			{ value: "ZZ", label: "Otra" }]);
		
		
		public static var NationalStates:ArrayCollection = new ArrayCollection([
			{ label:"Seleccionar", 			value: "00"},
			{ label:"Aguascalientes", 		value: "AS"},
			{ label:"Baja California", 		value: "BC"},
			{ label:"Baja California Sur", 		value: "BS"},
			{ label:"Campeche", 			value: "CC"},
			{ label:"Chiapas",	 		value: "CS"},
			{ label:"Chihuahua", 			value: "CH"},
			{ label:"Coahuila", 			value: "CL"},
			{ label:"Colima", 			value: "CM"},
			{ label:"Distrito Federal", 		value: "DF"},
			{ label:"Durango", 			value: "DG"},
			{ label:"Guanajuato", 			value: "GT"},
			{ label:"Guerrero", 			value: "GR"},
			{ label:"Hidalgo", 			value: "HG"},
			{ label:"Jalisco", 			value: "JC"},
			{ label:"Estado de México", 		value: "MC"},
			{ label:"Michoacán", 			value: "MN"},
			{ label:"Morelos", 			value: "MS"},
			{ label:"Nayarit", 			value: "NT"},
			{ label:"Nuevo León", 			value: "NL"},
			{ label:"Oaxaca", 			value: "OC"},
			{ label:"Puebla", 			value: "PL"},
			{ label:"Querétaro", 			value: "QT"},
			{ label:"Quintana Roo", 		value: "QR"},
			{ label:"San Luis Potosí", 		value: "SP"},
			{ label:"Sinaloa", 			value: "SL"},
			{ label:"Sonora", 			value: "SR"},
			{ label:"Tabasco", 			value: "TC"},
			{ label:"Tamaulipas", 			value: "TS"},
			{ label:"Tlaxcala", 			value: "TL"},
			{ label:"Veracruz", 			value: "VZ"},
			{ label:"Yucatán", 			value: "YN"},
			{ label:"Zacatecas", 			value: "ZS"}
		]);
		
		public static var TiempoEstimado:ArrayCollection = new ArrayCollection([
			{label:"Seleccionar", value:"0"},
			{label:"Horas", value:"H"},
			{label:"Días", value:"D"},
			{label:"Semanas", value:"S"},
			{label:"Meses", value:"M"}
		]);
		
		public static var TipoTransporte:ArrayCollection = new ArrayCollection([
			{label:"Seleccionar", value:"0"},
			{label:"Automóvil", value:"M"},
			{label:"Autobus", value:"B"},
			{label:"Avion", value:"O"}
		]);
		
		public static var EstatusLlamada:ArrayCollection = new ArrayCollection([
			{label:"Seleccionar", value:"0"},
			{label:"Venta Caída", value:"v"},
			{label:"Se llegó a una negociación", value:"n"},
			{label:"Se culminó la venta", value:"c"},
			{label:"No se llegó a nada", value:"l"}
		]);
		
		public static var SiNo:ArrayCollection = new ArrayCollection([
			{label:"Seleccionar", value:"0"},
			{label:"Sí", value:"s"},
			{label:"No", value:"n"}
		]);
		
		public static var Years:ArrayCollection = new ArrayCollection();
		public static var YearsUP:ArrayCollection = new ArrayCollection();
		
		public function ConstantData(){
			
			Years.addItem({label:"Año",value:0});
			var currYear:Number = new Date().fullYear;
			for(var n:Number = 1920;n<=currYear;n++){
				Years.addItem({label:n,value:n});
			}
			
			YearsUP.addItem({label:"Año",value:0});
			var currentYear:Number = new Date().fullYear;
			for(var m:Number = currentYear;m<(currentYear+30);m++){
				YearsUP.addItem({label:m,value:m});
			}
		}
		
		public static function FindYearindex(year:String):Number{
			for(var n:Number = 0;n<Years.length;n++){
				if(year==Years[n].label) break;
			}
			return n;
		}
		
		public static function FindYearUpIndex(year:String):Number{
			for(var n:Number = 0;n<YearsUP.length;n++){
				if(year==YearsUP[n].label) {				
					break;
				}
			}			
			return n;
		}
		
		public static function SystemFormatDate(date:Date):String{
			var _formatter:DateFormatter = new DateFormatter();
			_formatter.formatString = SystemFormatString;
			
			return _formatter.format(date);
		}
		
		public static function ViewFormatDate(date:Date):String{
			var _formatter:DateFormatter = new DateFormatter();
			_formatter.formatString = ViewFormatString;
			
			return _formatter.format(date);
		}
	}
}













