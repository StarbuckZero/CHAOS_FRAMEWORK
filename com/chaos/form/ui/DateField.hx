package com.chaos.form.ui;

import com.chaos.form.ui.ValidateField;

import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.form.ui.classInterface.IValidUI;
import com.chaos.form.ui.classInterface.IValidateField;
import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.ITextInput;
import com.chaos.utils.Validator;
import openfl.events.Event;

/**
	 * The input field for making sure user type the correct date
	 * @author Erick Feiling
	 */

class DateField extends ValidateField implements IFormUI implements IValidateField implements com.chaos.ui.classInterface.ITextInput implements IValidUI implements com.chaos.ui.classInterface.IBaseUI
{
    /**
		 * @inheritDoc
		 * @param	labelText The default text
		 */
    
    public function new(labelText : String = "")
    {
        super(labelText);
        
        // Default for date
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
            if ((try cast(dateArray[0], String) catch(e:Dynamic) null).length == 1) 
                dateArray[0] = "0" + dateArray[0]  // Make sure the value is 1 and add a 0 in front if that is the case  ;
            
            
            
            if ((try cast(dateArray[1], String) catch(e:Dynamic) null).length == 1) 
                dateArray[1] = "0" + dateArray[1]  //trace(dateArray.join("/"));  ;
            
            
            
            textField.text = dateArray.join("/");
        }
        
        if (isEmpty()) 
            backgroundValidate.visible = false  // If it's not empty then run values  ;
        
        
        
        return ((!isEmpty())) ? Validator.isValidDate(text) : false;
    }
}

