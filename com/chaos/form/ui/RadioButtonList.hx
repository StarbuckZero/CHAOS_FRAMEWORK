package com.chaos.form.ui;




import com.chaos.form.ui.classInterface.IFormUI;

import com.chaos.ui.RadioButtonGroup;
import com.chaos.ui.classInterface.IBaseUI;

import com.chaos.ui.classInterface.IRadioButtonGroup;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;

/**
 * A list of radio buttons
 */

class RadioButtonList extends RadioButtonGroup implements IFormUI implements IRadioButtonGroup implements IAlignmentContainer implements IBaseContainer implements IBaseUI
{
    
    private var id : Int = 0;
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	public function data():Dynamic
	{
		return {"id":id, "name":name, "value":getValue()};
	}
	
    
    /**
	 * Clear values
	 */
    public function clear() : Void
    {
		
        for (i in 0 ... _list.length)
            _list[i].selected = false;
    }
    
    /**
	 * Get the type of form object
	 *
	 * @return The type of form object as a string
	 */
    public function getElementType() : String
    {
        return "radio";
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
	 * @return The name of the radio button that was selected
	 */
    public function getValue() : String
    {
        return (getSelected() != null) ? getSelected().name : "";
    }
    
    /**
	 * Set the value being used
	 *
	 * @param	value which radio button that will be selected based on name
	 */
    
    public function setValue(value : String) : Void
    {
		
        for (i in 0 ... _list.length)
		{
			// Search for radio button by name
			if (_list[i].name == value) 
			{
				// Clear and set the new values
				clear();
				
				// Set the item that should be true
				_list[i].selected = true;
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

