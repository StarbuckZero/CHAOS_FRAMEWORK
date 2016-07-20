package com.chaos.ui.classInterface;


import com.chaos.data.DataProvider;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;



/**
 * Interface for CheckBoxGroup
 * @author Erick Feiling
 */
interface ICheckBoxGroup extends com.chaos.ui.layout.classInterface.IAlignmentContainer
{
    
    
    /**
	 * Replace or return the current data provider
	 */

    
    var dataProvider(get, set) : DataProvider;

    
    /**
	 * Creates a check box and adds it to the container
	 *
	 * @param 	checkBoxName The name of the checkbox being created
	 * @param	labelText The check box name
	 * @param	selected True the check box is selected an false if not
	 * @return The newly created check box.
	 */
    
    function createCheckBox(checkBoxName : String, labelText : String, selected : Bool = false) : com.chaos.ui.classInterface.ICheckBox;
    
    /**
	 * Remove a check box
	 *
	 * @param	checkbox The check box you want to remove out of the container
	 */
    
    function removeCheckBox(checkbox : com.chaos.ui.classInterface.ICheckBox) : Void;
    
    /**
	 * An array filled with checkboxes
	 *
	 * @return A list of checkboxes
	 */
    
    function getSelected() : Array<Dynamic>;
}

