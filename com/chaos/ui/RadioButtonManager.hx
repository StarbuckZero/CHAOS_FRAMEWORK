package com.chaos.ui;

import com.chaos.data.DataProvider;
import com.chaos.ui.classInterface.IRadioButton;
import openfl.utils.Dictionary;
import openfl.utils.Object;

class RadioButtonManager
{
	private static var _groupArray : Dictionary<String,DataProvider> = new Dictionary<String,DataProvider>(true);
	
	public function new()
    {
		
    }
	
	/**
	 * Check to see if group is already in manager
	 *
	 * @return Return true if the radio button is in the manager and false if not
	 */  
	public static function groupCheck(value : String) : Bool 
	{
		
		if (null != _groupArray.get(value))
		{
			return true;
		}
		else 
			return false;
    }
	
	
	/**
	 * Add a new group to the manager
	 *
	 * @param The name of the radio button group
	 * @default RadioButtonGroup
	 */ 
	public static function addGroup(value : String = "RadioButtonGroup") : Void 
	{
		if (!groupCheck(value)) 
		{
			var dataList : DataProvider = new DataProvider();
			_groupArray.set(value, dataList);
        }
    } 
	
	
	/**
	 * Remove a group from the manager
	 *
	 * @param The name of the radio button group
	 *
	 */
	public static function removeGroup(value : String) : Void 
	{ 
		if (groupCheck(value)) 
		{
			_groupArray.set(value, null);
        }
    } 
	
	/**
	 * Add a radio button to a group
	 *
	 * @param groupName The radio button group name
	 * @param radioButton The radio button you want to add to the group
	 *
	 */ 
	
	public static function addItem(groupName : String, radioButton : IRadioButton) : Bool
	{	
		if (groupCheck(groupName)) 
		{
			cast(_groupArray.get(groupName),DataProvider).addItem(radioButton);
			return true;
		}
		else 
		{
			return false;
		}
    }
	
	/**
	 * Remove a radio button from a group
	 *
	 * @param groupName The radio button group name
	 * @param radioButton The radio button you want to remove from the group
	 *
	 */
	public static function removeItem(groupName : String, radioButton : IRadioButton) : Void
	{
		if (groupCheck(groupName)) 
		{
			var dataList : DataProvider = _groupArray.get(groupName);
			var tempRadioButton : Dynamic = dataList.removeItem(radioButton);
			tempRadioButton = null;
        }
    }
	
	/**
	 * Get the radio manager group
	 *
	 * @param groupName The radio button group name
	 *
	 * @return Return the radio button group. If the group is not found then a null object will be returned.
	 */ 
	public static function getGroup(groupName : String) : DataProvider 
	{
		if (groupCheck(groupName)) 
		{
			return cast(_groupArray.get(groupName),DataProvider);
        }
		
        else 
		{
			return null;
        }
    } 
	
	/**
	 * Set a group of radio button(s)
	 *
	 * @param groupName The radio button group name
	 * @param listData The DataProvider filled with radio button objects.
	 *
	 */
	public static function setGroup(groupName : String, listData : DataProvider) : Void 
	{
		_groupArray.set(groupName, listData);
    } 
	
	/**
	 * Set the state of all the radio buttons in the group.
	 *
	 * @param groupName The radio button group name
	 * @param value The state you want to set the radio button(s) to. If true all the buttons are selected and if false all the buttons are in there unselected state.
	 * @default false
	 */
	public static function setGroupState(groupName : String, value : Bool = false) : Void 
	{
		if (groupCheck(groupName)) 
		{
			var dataList : DataProvider = _groupArray.get(groupName);
			
			for (i in 0...dataList.length - 1 + 1)
			{
				cast(dataList.getItemAt(i),IRadioButton).selected = value;
            }
        }
    }
}