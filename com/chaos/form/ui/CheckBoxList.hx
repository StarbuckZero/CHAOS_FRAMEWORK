package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.CheckBoxGroup;
import com.chaos.ui.CheckBox;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.classInterface.ICheckBox;
import com.chaos.utils.Debug;

/**
 * CheckBox Group that is made for forms
 * @author Erick Feiling
 */

class CheckBoxList extends CheckBoxGroup implements IFormUI implements IAlignmentContainer implements IBaseContainer implements ICheckBoxGroup implements IBaseUI
{
    private var id : Int = 0;
    
    /** Creates a checkbox list with optional component data. */
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
	/**
	 * Data 
	 */
	 
    public function data():Dynamic {
        return {"id":id,"name":name,"value":getValue()};
    }
    
    /**
	 * Clear values
	 */
    public function clear() : Void
    {
        setValue([]);
    }
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
    public function getElementType() : String
    {
        return "checkbox";
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
	 * @return The list of check boxes
	 */
    public function getValue() : Dynamic
    {
        return [for (item in getSelected()) item.name];
    }
    
    /**
	 * Set the names given to true
	 *
	 * @param	value Set one or more check boxes based on a "," list
	 *
	 * @example checkBoxList("check1,check3");
	 */
    
    public function setValue(value : Dynamic) : Void
    {
        var values:Array<Dynamic> = Std.isOfType(value, Array) ? cast value
            : value == null ? [] : cast Std.string(value).split(",");
        for (item in _list) {
            item.selected = values.indexOf(item.name) >= 0;
            item.draw();
        }
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

