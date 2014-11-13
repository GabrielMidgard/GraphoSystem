package mx.random.constants{
	
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;
 
	[Bindable]
	public class ConstantData{
		
		
		
		public static var SystemFormatString:String		= "YYYY-MM-DD";
		public static var ViewFormatString:String 		= "DD/MM/YYYY";		
		
		public static var DayNames:Array	=	['D', 'L', 'M','M', 'J', 'V', 'S'];
		public static var MonthNames:Array	=	["Enero", "Febrero", "Marzo", "Abril", "Mayo","Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"];
		
		
		
		public static var AdminLevels:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},												
																				{label:"Administrator",		value:1},
																				{label:"System",			value:2}
																				]);
		public static var AdminLevelsFTP:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		value:0},
																				{label:"Guest",				value:1},
																				{label:"User",				value:2},
																				{label:"System",			value:3}
																				]);																						
		public static var Languages:ArrayCollection = new ArrayCollection([ 	{label:"Seleccionar",		value:0},
																				{label:"Idioma Natal",		value:1},
																				{label:"Español",			value:2},
																				{label:"Inglés",			value:3},
																				{label:"Francés",			value:4},
																				{label:"Italiano",			value:5},
																				{label:"Alemán",			value:6},
																				{label:"Chino",				value:7},
																				{label:"Japonés",			value:8},
																				{label:"Mandarín",			value:9},
																				]);

		public static var Sex:ArrayCollection = new ArrayCollection([ 			{label:"Seleccionar",		value:0},
																				{label:"Masculino",			value:1},
																				{label:"Femenio",			value:2}																				
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
		public static var DocumentStatus:ArrayCollection = new ArrayCollection([{label:"Seleccionar",		value:0,	color:0x8e90fb},
																				{label:"En Proceso",		value:1,	color:0x8e90fb},
																				{label:"Por Imprimir",		value:2,	color:0xc8fdc2},
																				{label:"Impresa",			value:3,	color:0xfe8b8b},
																				{label:"Entregada",			value:4,	color:0xfe8b8b},
																				{label:"Enviada",			value:5,	color:0xfe8b8b},
																				{label:"Cancelada",			value:6,	color:0xfdf27a}
																				]);																				
		public static var PaymentStatusFilter:ArrayCollection = new ArrayCollection([ 
																				{label:"Todas",			    value:""},
																				{label:"Por Acreditar",		value:0},
																				{label:"Pagadas",			value:1},
																				{label:"Vencidas",			value:2},
																				{label:"Canceladas",		value:3}
																				
																				]);																				
		
		

		public static var PaymentTypes:ArrayCollection = new ArrayCollection([{label:"Please Select",				value:0},
																				{label:"Tarjeta de Crédito",		value:1},
																				{label:"Transferencia Electrónica",	value:2},
																				{label:"Depósito en Ventanilla",	value:3},
																				{label:"PayPal",				value:4}
																				]);
		
		
																			
		public static var BankStatus:ArrayCollection = new ArrayCollection([{label:"Sin Pagos", 		value:0},
																				{label:"Liquidada", 	value:1},
																				{label:"En Abono", 		value:2},
																				{label:"Cancelada", 	value:5}
																			]);
		
		
		
		public static var CardTypes:ArrayCollection = new ArrayCollection([	{label:"Select", 			value:0},
																			{label:"Visa", 				value:1},
																			{label:"MasterCard", 		value:2},
																			{label:"American Express", 	value:3},
																			{label:"Discover", 			value:4}]);
		
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

		public static var CoPrefix:ArrayCollection = new ArrayCollection([	{ value: 0, label: "Select" },
			        														{ value: 1, label: "Esposo(a)" },
			        														{ value: 2, label: "Hermano(a)" },
			        														{ value: 3, label: "Socio(a)" },
			        														{ value: 4, label: "Hijo(a)" },
			        														{ value: 4, label: "Amigo(a)" },
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

        public static var Years:ArrayCollection = new ArrayCollection();
		
		public function ConstantData(){
			
			Years.addItem({label:"Año",value:0});
			for(var n:Number = 1940;n<2012;n++){
				Years.addItem({label:n,value:n});
			}
		}
		
		public static function FindYearindex(year:String):Number{
			for(var n:Number = 0;n<Years.length;n++){
				if(year==Years[n].label) break;
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













