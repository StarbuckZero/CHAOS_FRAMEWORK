package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;

/**
	 * Configure the InputField as a Password Field
	 * @author Erick Feiling
	 */

class PasswordField extends InputField implements IFormUI implements com.chaos.ui.classInterface.ITextInput implements com.chaos.ui.classInterface.IBaseUI
{
    
    public function new(labelText : String = "")
    {
        super(labelText);
        
        textField.displayAsPassword = true;
    }
}

