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
    
    /** Creates a drop-down form control with optional component data. */
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
	/**
	 * Data 
	 */
	 
     public function data():Dynamic {
        return {"id":getId(),"name":name,"value":getValue()};
    }

    /**
	 * Clear values
	 */
    
    public function clear() : Void
    {
        setValue(null);
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
        return getSelected() != null ? getSelected().id : -1;
    }
    
    /**
	 * Set the id of the element
	 *
	 * @param	value The id number
	 */
    
    public function setId(value : Int) : Void
    {
        if (getSelected() != null)
            getSelected().id = value;
    }
    
    /**
	 * Return the value that has been stored
	 *
	 * @return A string value if found or text in label
	 */
    
    public function getValue() : Dynamic
    {
        return getSelected() != null ? getSelected().value : text;
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value What you want to see the value to
	 */
	
    public function setValue(value : Dynamic) : Void
    {
        _selectIndex = -1;
        for (i in 0..._list.length) {
            var item = _list.getItemAt(i);
            item.selected = value != null && item.value == value;
            if (item.selected) _selectIndex = i;
        }
        text = getSelected() == null ? "" : getSelected().text;
        draw();
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

