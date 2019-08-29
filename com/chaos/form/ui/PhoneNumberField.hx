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
 * The input field for making sure user type a vaild phone numnber
 */

class PhoneNumberField extends ValidateField implements IFormUI implements IValidateField implements ITextInput implements IValidUI implements IBaseUI
{
    
    public function new(data:Dynamic = null)
    {
        super(data);
        
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		// Set default if none is passed
		if (!Reflect.hasField(data, "defaultString"))
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
            backgroundValidate.visible = false;
        
        
        // If it's not empty then run values  
        return ((!isEmpty())) ? Validator.isValidPhoneNumber(text) : false;
    }
}

