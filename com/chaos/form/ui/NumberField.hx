package com.chaos.form.ui;

import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.form.ui.classInterface.IValidUI;
import com.chaos.form.ui.classInterface.IValidateField;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;
import com.chaos.utils.Validator;
import openfl.events.Event;

/**
 * The input field for making sure user type a vaild numnber
 */

class NumberField extends ValidateField implements IFormUI implements IValidateField implements ITextInput implements IValidUI implements IBaseUI
{
    
    /** Creates a numeric field with optional component data. */
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	/** Applies numeric field settings and validation options. */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);	
	}

    override function initialize() {

        super.initialize();

        _textField.restrict = "0-9";
    }
	
    
    /** Parses the input value as a number. */
    override public function getValue():Dynamic
    {
        var value = Std.parseFloat(super.getValue());
        return Math.isNaN(value) ? null : value;
    }

    /** Runs base validation and updates the numeric field’s state. */
    override public function onValidateCheck(event : Event) : Void
    {
        super.onValidateCheck(event);
        
        isValid();
    }
    
    /** Checks whether the current input is a valid number. */
    override public function isValid() : Bool
    {
        
        if (isEmpty()) 
            backgroundValidate.visible = false;
        
        
        // If it's not empty then run values  
        return ((!isEmpty())) ? Validator.isValidNumber(text) : false;
    }
}
