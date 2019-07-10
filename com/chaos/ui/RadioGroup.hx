package com.chaos.ui;


import com.chaos.data.DataProvider;
import com.chaos.ui.data.SelectObjectData;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IRadioButton;
import com.chaos.ui.classInterface.IRadioGroup;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.utils.Object;

import com.chaos.ui.RadioButton;

import com.chaos.utils.Debug;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
	 * Container that is made for and creating radio buttons. All buttons will be created started from the left.
	 *
	 * @author Erick Feiling
	 */

class RadioGroup extends HorizontalContainer implements IRadioGroup implements IBaseContainer implements IAlignmentContainer implements IBaseUI
{
    public var dataProvider(get, set) : DataProvider<IRadioButton>;

    private var group : String = "";
    private var nameList : Object = new Object();
    private var _list : DataProvider<IRadioButton>;
    
    /**
	 * Once a name is passed in the container will create and add them to the display
	 *
	 * @param	groupName The name of the group that the radio buttons will be created under.
	 * @eventType openfl.events.Event.CHANGE
	 */
    
    public function new(groupName : String, defaultWidth : Int = 300, defaultHeight : Int = 30)
    {
        super();
        
        group = name = groupName;
        background = false;
        width = defaultWidth;
        height = defaultHeight;
		
		
    }
    
    /**
	 * Replace the current data provider
	 */
    
    private function set_dataProvider(value : DataProvider<IRadioButton>) : DataProvider<IRadioButton>
    {
        if (null == _list) 
            return null;
        
        _list = value;
        
        // Clear everything out
        removeAll();
        
        for (i in 0..._list.length)
		{
            var item : SelectObjectData = cast(_list.getItemAt(i), IBaseObjectData);
            
            if (item.name != "" && item.text != "") 
            {
                createRadioButton(item.name, item.text, item.selected);
            }
        }
		
        return value;
    }
    
    /**
	 * Returns the data provider being used
	 */
    
    private function get_dataProvider() : DataProvider<IRadioButton>
    {
        return _list;
    }
    
    /**
	 * Creates a radio button and adds it to the container
	 * @param 	radioName The name of the radio button
	 * @param	labelText The radio button name
	 * @param	selected True the radio button is selected an false if not
	 * @return The newly created radio button.
	 */
    
    public function createRadioButton(radioName : String, labelText : String, selected : Bool = false) : IRadioButton
    {
        var radio : IRadioButton = new RadioButton(labelText);
		
        radio.name = radioName;
        radio.groupName = group;
        radio.selected = selected;
        radio.addEventListener(MouseEvent.CLICK, onChange, false, 0, true);
		
        Reflect.setField(nameList, radioName, radio);
		
        addElement(radio);
        
        return radio;
    }
    
    /**
	 * Remove a radio button
	 *
	 * @param	radio The radio button you want to remove out of the container
	 */
    
    public function removeRadioButton(radio : IRadioButton) : Void
    {
        contentObject.removeChild(radio.displayObject);
    }
    
    /**
	 * Get selected radio button
	 *
	 * @return A radio button object. If nothing is selected it will return null.
	 */
    
    public function getSelected() : IRadioButton
    {
        for (index in Reflect.fields(nameList))
        {
            var radio : IRadioButton = Reflect.field(nameList, index);
            
            // If selected then return
            if (radio.selected) 
                return radio;
        }
        
        return null;
    }
    
    /**
	 * Remove all items out of group
	 */
    
    override public function removeAll() : Void
    {
        Debug.print("[RadioGroup::removeAll] " + contentObject.numChildren);
        
        for (index in Reflect.fields(nameList))
        {
            var radio : IRadioButton = Reflect.field(nameList, index);
            removeRadioButton(radio);
            
            Debug.print("[RadioGroup::removeAll] " + radio.name);
        }
    }
    
    /**
	 * Change the name of the group being used
	 *
	 * @param	groupName The name of the group
	 */
    
    public function setGroupName(groupName : String) : Void
    {
        // Set the group
        group = groupName;
        
        // Check for radio buttons
        for (i in 0...contentObject.numChildren)
		{
            // Make sure it's a radio button type
            if (Std.is(contentObject.getChildAt(i), RadioButton)) 
            {
                var radio : IRadioButton = cast(contentObject.getChildAt(i), IRadioButton);
                radio.groupName = groupName;
            }
        }
    }
    
    public function onChange(event : MouseEvent) : Void
    {
        displayObject.dispatchEvent(new Event(Event.CHANGE));
    }
}

