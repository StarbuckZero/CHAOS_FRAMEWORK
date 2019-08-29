package com.chaos.form.ui;

import com.chaos.form.ui.ValidateField;

import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.form.ui.classInterface.IValidUI;
import com.chaos.form.ui.classInterface.IValidateField;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;
import com.chaos.utils.Validator;
import openfl.events.Event;

/**
 * The input field for making sure user type the correct date
 */

class DateField extends ValidateField implements IFormUI implements IValidateField implements ITextInput implements IValidUI implements IBaseUI
{
    /**
	 * Makes sure that user input is valid
	 * @param	data The default text
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
		
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		
		super.setComponentData(data);
		
		// Set default if none is passed
		if (!Reflect.hasField(data, "defaultString"))
			defaultString("MM/DD/YYYY");
	}
	
	
    
    override public function onValidateCheck(event : Event) : Void
    {
        super.onValidateCheck(event);
        
        isValid();
    }
    
    override public function isValid() : Bool
    {
        // Only do anything if it's the right size
        if (!isEmpty() && text.indexOf("/") != -1 && text.split("/").length == 3)
        {
            var dateArray : Array<Dynamic> = text.split("/");
            
            // Make sure the value is 1 and add a 0 in front if that is the case
            if (cast(dateArray[0], String).length == 1) 
                dateArray[0] = "0" + dateArray[0];
            
             // Make sure the value is 1 and add a 0 in front if that is the case  
            if (cast(dateArray[1], String).length == 1) 
                dateArray[1] = "0" + dateArray[1];
            
            //trace(dateArray.join("/"));  
            
            textField.text = dateArray.join("/");
        }
        
		// If it's not empty then run values 
        if (isEmpty()) 
            backgroundValidate.visible = false;
        
        return ((!isEmpty())) ? Validator.isValidDate(text) : false;
    }
}

