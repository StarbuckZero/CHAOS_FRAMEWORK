package com.chaos.ui.classInterface;



import com.chaos.ui.layout.classInterface.IAlignmentContainer;



/**
 * Interface for CheckBoxGroup
 * @author Erick Feiling
 */
interface ICheckBoxGroup extends IAlignmentContainer
{
    
    /**
	 * Creates a check box and adds it to the container
	 *
	 * @param 	checkBoxName The name of the checkbox being created
	 * @param	labelText The check box name
	 * @param	selected True the check box is selected an false if not
	 * @return The newly created check box.
	 */
    
    function createCheckBox(checkBoxName : String, labelText : String, selected : Bool = false) : ICheckBox;
    
    /**
	 * Remove a check box
	 *
	 * @param	checkbox The check box you want to remove out of the container
	 */
    
    function removeCheckBox(checkbox : ICheckBox) : Void;
    
    /**
	 * An array filled with checkboxes
	 *
	 * @return A list of checkboxes
	 */
    
    function getSelected() : Array<ICheckBox>;
}

