package mx.random.tools{
	import mx.collections.ArrayCollection;
	import mx.random.cms.converters.Converter;
	import mx.random.constants.SystemGlobals;
	import mx.random.prototypes.Results;

	public class Operators	{				
		
		public function Operators(){	
		}
		
		public static function sumTool(_data:ArrayCollection,_itemField:String = "",detal:Boolean = false):Results{
			var results:Results = new Results();	
			if(_itemField!=""){			
				results.subTotal = 0;
				for(var n:Number = 0;n<_data.length;n++){
					results.subTotal += Number(_data[n][_itemField]);
					if(detal){
						var detailResult:Results = new Results();
						detailResult.recordId 			= n;
						detailResult.subTotal 			= Number(_data[n][_itemField]);
						detailResult.federalTax			= detailResult.subTotal * SystemGlobals.federalTax;
						detailResult.estatalTax			= detailResult.subTotal * SystemGlobals.estatalTax;
						detailResult.total				= detailResult.subTotal + detailResult.federalTax + detailResult.estatalTax;
						// Totals * TcFix
						detailResult.averageFix 		= detailResult.average 		* SystemGlobals.tcFix;
						detailResult.federalTaxFix 		= detailResult.federalTax 	* SystemGlobals.tcFix;
						detailResult.estatalTaxFix 		= detailResult.estatalTax 	* SystemGlobals.tcFix;
						detailResult.totalFix 			= detailResult.total 		* SystemGlobals.tcFix;
						detailResult.subTotalFix 		= detailResult.subTotal 	* SystemGlobals.tcFix;
						
						results.detail.addItem(detailResult);
					}
				}
				results.records				= _data.length;
				results.average 			= results.subTotal / _data.length;
				results.federalTax			= results.subTotal * SystemGlobals.federalTax;
				results.estatalTax			= results.subTotal * SystemGlobals.estatalTax;
				results.total				= results.subTotal + results.federalTax + results.estatalTax;
				// Totals * TcFix
				results.averageFix 			= results.average 	 * SystemGlobals.tcFix;
				results.federalTaxFix 		= results.federalTax * SystemGlobals.tcFix;
				results.estatalTaxFix 		= results.estatalTax * SystemGlobals.tcFix;
				results.totalFix 			= results.total 	 * SystemGlobals.tcFix;
				results.subTotalFix 		= results.subTotal 	 * SystemGlobals.tcFix;
			}				Converter				
			return results;
		}

	}
}