package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.CheckBoxGroup;
import com.chaos.ui.CheckBox;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.layout.Interface.IAlignmentContainer;
import com.chaos.ui.layout.Interface.IBaseContainer;
import com.chaos.ui.classInterface.ICheckBox;
import com.chaos.utils.Debug;

/**
 * CheckBox Group that is made for forms
 * @author Erick Feiling
 */

class CheckBoxList extends CheckBoxGroup implements IFormUI implements com.chaos.ui.layout.classInterface.IAlignmentContainer implements IBaseContainer implements com.chaos.ui.classInterface.ICheckBoxGroup implements com.chaos.ui.classInterface.IBaseUI
{
    private var id : Int = 0;
    
    public function new(checkBoxName : String)
    {
        super(checkBoxName);
    }
    
    /**
	 * Clear values
	 */
    public function clear() : Void
    {
        for (i in 0..._content.numChildren){
            if (Std.is(_content.getChildAt(i), CheckBox)) 
                (try cast(_content.getChildAt(i), com.chaos.ui.classInterface.ICheckBox) catch(e:Dynamic) null).selected = false;
        }
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
    public function getValue() : String
    {
        return getSelected().join(",");
    }
    
    /**
	 * Set the names given to true
	 *
	 * @param	value Set one or more check boxes based on a "," list
	 *
	 * @example checkBoxList("check1,check3");
	 */
    
    public function setValue(value : String) : Void
    {
        var i : Int;
        
        if (value.indexOf(",") != -1) 
        {
            var checkBoxList : Array<Dynamic> = value.split(",");
            
            // Search based on broken down array list
            for (i in 0 ... _content.numChildren)
			{
                for (j in 0 ... checkBoxList.length)
				{
                    // Search for radio button by name
                    if (Std.is(_content.getChildAt(i), CheckBox) && cast(_content.getChildAt(i), ICheckBox).name == checkBoxList[j]) 
                        cast(_content.getChildAt(i), com.chaos.ui.classInterface.ICheckBox).selected = true;
                }
            }
        }
        else 
        {
            for (i in 0 ... _content.numChildren)
			{
                // Search for radio button by name
                if (Std.is(_content.getChildAt(i), CheckBox) && cast(_content.getChildAt(i), ICheckBox).name == value) 
                    cast(_content.getChildAt(i), ICheckBox).selected = true;
            }
        }
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

