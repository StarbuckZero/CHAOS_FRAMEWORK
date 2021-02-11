package com.chaos.form;


import com.chaos.form.ui.classInterface.IFormUI;

/**
 * Pretty much a hidden data field something the user can't type into
 *
 * @author Erick Feiling
 */

class FormData implements IFormUI
{
    
    private var _id : Int = 0;
    private var _name : String = "";
    private var _value : String = "";
    
    public function new(formName : String, dataString : String = "")
    {
        _name = formName;
        _value = dataString;
    }
    
	/**
	 * Data 
	 */
	 
    public function data():Dynamic {
        return {"id":_id,"name":_name,"value":_value};
    }

    /**
	 * Clear values
	 */
    public function clear() : Void
    {
        _value = "";
    }
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
    public function getElementType() : String
    {
        return "hidden";
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
        return _value;
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to see the value to
	 */
    public function setValue(value : String) : Void
    {
        _value = value;
    }
    
    /**
	 * Return the name
	 *
	 * @return The name that is used
	 */
    
    public function getName() : String
    {
        return _name;
    }
    
    /**
	 * Set the name
	 *
	 * @param	value The name
	 */
    public function setName(value : String) : Void
    {
        _name = value;
    }
}

