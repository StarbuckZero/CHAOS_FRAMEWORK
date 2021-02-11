package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.ComboBox;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IComboBox;


/**
 * Pretty much the ComboBox but with support for forms
 * @author Erick Feiling
 */

class DropDownMenu extends ComboBox implements IComboBox implements IBaseUI implements IFormUI
{
    
    public function new(data:Dynamic = null)
    {
		// comboWidth : Int = -1, comboHeight : Int = -1, comboList : DataProvider<Dynamic> = null
        super(data);
    }
    
	/**
	 * Data 
	 */
	 
     public function data():Dynamic {
        return {"id":getSelected().id,"name":name,"value":text};
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
        return "dropdown";
    }
    
    /**
	 * Get the id
	 *
	 * @return A int value
	 */
    
    public function getId() : Int
    {
        return ((dataProvider.length > 0)) ? getSelected().id : -1;
    }
    
    /**
	 * Set the id of the element
	 *
	 * @param	value The id number
	 */
    
    public function setId(value : Int) : Void
    {
        if (dataProvider.length > 0) 
            getSelected().id = value;
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

