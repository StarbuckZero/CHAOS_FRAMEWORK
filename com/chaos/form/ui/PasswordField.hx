package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;

/**
 * Configure the InputField as a Password Field with form support
 */

class PasswordField extends InputField implements IFormUI implements ITextInput implements IBaseUI
{
    
    /** Creates a password field with optional component data. */
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	/** Initializes the field and enables password text masking. */
	override public function initialize():Void 
	{
		super.initialize();
		
		textField.displayAsPassword = true;
	}
}

