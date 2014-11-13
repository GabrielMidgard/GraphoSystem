package mx.random.forms{
    import mx.validators.Validator;
    import mx.validators.ValidationResult;

    public class ComboValidator extends Validator {
        private var results:Array;
        public function ComboValidator() {
            super();
        }
    
        override protected function doValidation(value:Object):Array {
            var inputValue:Number = Number(value);
            results = [];
            results = super.doValidation(value);        
            if (results.length > 0)  return results;
            if (isNaN(inputValue) || !value ){
                results.push(new ValidationResult(true, null, "NaN","You must select one option.")); 
                return results;
            }       
            if (inputValue==0) {
                results.push(new ValidationResult(true, null, "NaN","You must select one option.")); 
                return results;
            }
            
            return results;
        }
    }
}
