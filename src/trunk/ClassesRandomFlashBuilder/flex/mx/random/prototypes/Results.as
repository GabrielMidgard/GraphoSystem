package mx.random.prototypes{
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class Results	{
				
		public var records:Number 			= 0;
		public var recordId:Number 			= 0;
		public var average:Number 			= 0;
		public var subTotal:Number 			= 0;
		public var federalTax:Number 		= 0;
		public var estatalTax:Number 		= 0;
		public var total:Number 			= 0;
		public var utility:Number 			= 0;
		
		public var averageFix:Number 		= 0;
		public var subTotalFix:Number 		= 0;
		public var federalTaxFix:Number 	= 0;
		public var estatalTaxFix:Number 	= 0;
		public var totalFix:Number 			= 0;
		public var utilityFix:Number 		= 0;
		
		public var detail:ArrayCollection   = new ArrayCollection();		
		
		public function Results(){
			
		}			

	}
}