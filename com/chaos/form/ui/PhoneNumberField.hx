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
	 * The input field for making sure user type a vaild phone numnber
	 * @author Erick Feiling
	 */
class PhoneNumberField extends ValidateField implements IFormUI implements IValidateField implements com.chaos.ui.classInterface.ITextInput implements IValidUI implements com.chaos.ui.classInterface.IBaseUI
{
    
    public function new(labelText : String = "")
    {
        super(labelText);
        
        // Default for date
        defaultString("Phone Number");
    }
    
    override public function onValidateCheck(event : Event) : Void
    {
        super.onValidateCheck(event);
        
        isValid();
    }
    
    override public function isValid() : Bool
    {
        
        if (isEmpty()) 
            backgroundValidate.visible = false  // If it's not empty then run values  ;
        
        
        
        return ((!isEmpty())) ? Validator.isValidPhoneNumber(text) : false;
    }
}

