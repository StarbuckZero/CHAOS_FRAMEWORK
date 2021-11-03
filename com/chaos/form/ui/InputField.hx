package com.chaos.form.ui;



import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.TextInput;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;

/**
 * This is pretty much an TextInput but with form support
 * @see
 * @author Erick Feiling
 */

class InputField extends TextInput implements ITextInput implements IFormUI implements IBaseUI
{
    private var _id : Int = 0;
	
	private var _data : Dynamic;
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	public function data():Dynamic
	{
		return {"name":name, "id":_id, "value":(_text != _defaultString) ? _text : "", "type":"label"};
	}
    
    /**
	 * Clear values
	 */
    
    public function clear() : Void
    {
		
        _textField.text = "";
    }
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
    
    public function getElementType() : String
    {
        return "input";
    }
    
    /**
	 * Get the id
	 *
	 * @return A int value
	 */
	
    public function getId() : Int
    {
        return _id;
    }
    
    /**
	 * Set the id of the element
	 *
	 * @param	value The id number
	 */
    
    public function setId(value : Int) : Void
    {
        _id = value;
    }
    
    /**
	 * Return the value that has been stored
	 *
	 * @return A string value from object
	 */
    
    public function getValue() : String
    {
        return _text;
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to see the value to
	 */
	
    public function setValue(value : String) : Void
    {
        _text = value;
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

