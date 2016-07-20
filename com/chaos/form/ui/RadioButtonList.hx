package com.chaos.form.ui;




import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.RadioButton;
import com.chaos.ui.RadioGroup;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IRadioButton;
import com.chaos.ui.classInterface.IRadioGroup;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;

/**
 * A list of radio buttons
 * @author Erick Feiling
 */

class RadioButtonList extends RadioGroup implements IFormUI implements IRadioGroup implements IAlignmentContainer implements IBaseContainer implements IBaseUI
{
    
    private var id : Int = 0;
    
    public function new(groupName : String)
    {
        super(groupName);
    }
    
    /**
	 * Clear values
	 */
    public function clear() : Void
    {
        for (i in 0...contentObject.numChildren)
		{
            if (Std.is(contentObject.getChildAt(i), RadioButton)) 
                (try cast(contentObject.getChildAt(i), com.chaos.ui.classInterface.IRadioButton) catch(e:Dynamic) null).selected = false;
        }
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
        return getSelected().name;
    }
    
    /**
		 * Set the value being used
		 *
		 * @param	value which radio button that will be selected based on name
		 */
    
    public function setValue(value : String) : Void
    {
        for (i in 0...contentObject.numChildren){
            // Search for radio button by name
            if (Std.is(contentObject.getChildAt(i), RadioButton) && (try cast(contentObject.getChildAt(i), com.chaos.ui.classInterface.IRadioButton) catch(e:Dynamic) null).name == value) 
            {
                // Clear and set the new values
                clear();
                
                (try cast(contentObject.getChildAt(i), com.chaos.ui.classInterface.IRadioButton) catch(e:Dynamic) null).selected = true;
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

