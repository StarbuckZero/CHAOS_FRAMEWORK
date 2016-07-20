package com.chaos.form.ui;


//import com.chaos.form.ui.Interface.IFormUI;
//import com.chaos.ui.interface.IBaseUI;
//import com.chaos.ui.interface.ITextInput;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.TextInput;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;

/**
	 * This is pretty much an TextInput but with form support
	 * @see
	 * @author Erick Feiling
	 */

class InputField extends TextInput implements com.chaos.ui.classInterface.ITextInput implements com.chaos.form.ui.classInterface.IFormUI implements com.chaos.ui.classInterface.IBaseUI
{
    private var id : Int = 0;
    
    public function new(labelText : String = "")
    {
        super(labelText);
    }
    
    /**
		 * Clear values
		 */
    
    public function clear() : Void
    {
        text = "";
    }
    
    /**
		 * Get the type of form object
		 *
		 * @return The type of form object as a string
		 */
    
    public function getElementType() : String
    {
        return "label";
    }
    
    /**
		 * Get the id
		 *
		 * @return A int value
		 */
    public function getId() : Int
    {
        return id;
    }
    
    /**
		 * Set the id of the element
		 *
		 * @param	value The id number
		 */
    
    public function setId(value : Int) : Void
    {
        id = value;
    }
    
    /**
		 * Return the value that has been stored
		 *
		 * @return A string value from object
		 */
    
    public function getValue() : String
    {
        return text;
    }
    
    /**
		 * Set the value being used
		 *
		 * @param	value What you want to see the value to
		 */
    public function setValue(value : String) : Void
    {
        text = value;
    }
    
    /**
		 * Return the name
		 *
		 * @return The name that is used
		 */
    
    public function getName() : String
    {
        return name;
    }
    
    /**
		 * Set the name
		 *
		 * @param	value The name
		 */
    
    public function setName(value : String) : Void
    {
        name = value;
    }
}

