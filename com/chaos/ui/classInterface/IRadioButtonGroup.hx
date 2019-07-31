package com.chaos.ui.classInterface;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;

/**
 * Interface for RadioGroup
 * @author Erick Feiling
 */

interface IRadioButtonGroup extends IAlignmentContainer
{

	/**
	 * Creates a radio button and adds it to the container
	 * @param 	radioName The name of the radio button
	 * @param	labelText The radio button name
	 * @param	selected True the radio button is selected an false if not
	 * @return The newly created radio button.
	 */

	function createRadioButton(radioName : String, labelText : String, selected : Bool = false) : com.chaos.ui.classInterface.IRadioButton;

	/**
	 * Remove a radio button
	 *
	 * @param	radio The radio button you want to remove out of the container
	 */

	function removeRadioButton(radio : com.chaos.ui.classInterface.IRadioButton) : Void;

	/**
	 * Get selected radio button
	 *
	 * @return Return a radio button
	 */

	function getSelected() : IRadioButton;

	/**
	 * Change the name of the group being used
	 *
	 * @param	groupName The name of the group
	 */

	function setGroupName(groupName : String) : Void;
}

