package com.chaos.ui;


import com.chaos.ui.classInterface.IRadioButtonGroup;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IRadioButton;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;

import com.chaos.ui.RadioButton;

import com.chaos.utils.Debug;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * Container that is made for and creating radio buttons. All buttons will be created started from the left.
 *
 * @author Erick Feiling
 */

class RadioButtonGroup extends HorizontalContainer implements IRadioButtonGroup implements IBaseContainer implements IAlignmentContainer implements IBaseUI
{

    private var _group : String = "";
    private var _list : Array<IRadioButton>;
    
    /**
	 * Once a name is passed in the container will create and add them to the display
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);       
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var dataObj:Dynamic = data[i];
				
				if (Reflect.hasField(dataObj,"name") && Reflect.hasField(dataObj,"text"))
					createRadioButton(Reflect.field(dataObj, "name"), Reflect.field(dataObj, "text"), Reflect.hasField(dataObj, "selected") ? Reflect.field(dataObj, "selected") : false);
			}
			
		}
		else
		{
			if (null == _list)
				_list = new Array<IRadioButton>();
		}
		
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
		if (null == _list)
			_list = new Array<IRadioButton>();
		
        var radio : IRadioButton = new RadioButton({"name": radioName, "groupName":_group, "text":labelText, "selected":selected, "width": 100, "height":20});
		
        radio.addEventListener(MouseEvent.CLICK, onChange, false, 0, true);
		
		
        _list.push(radio);
		
        return radio;
    }
    
    /**
	 * Remove a radio button
	 *
	 * @param	radio The radio button you want to remove out of the container
	 */
    
    public function removeRadioButton(radio : IRadioButton) : Void
    {
		
		// Remove out of display if there
		if (contentObject != null && contentObject.parent != null)
			contentObject.removeChild(radio.displayObject);
			
			
		radio.removeEventListener(MouseEvent.CLICK, onChange);
		
		_list.remove(radio);
		
		radio.destroy();
		radio = null;

    }
    
    /**
	 * Get selected radio button
	 *
	 * @return A radio button object. If nothing is selected it will return null.
	 */
    
    public function getSelected() : IRadioButton
    {
		
        // Loop display object
        for (i in 0 ... _list.length)
		{
			// Make sure item is checked
			if (_list[i].selected) 
				return _list[i];
        }
		
		return null;
		
    }
	
	override public function draw():Void 
	{
		super.draw();
		
		// Add the checkboxes into the display
		addElementList(_list);
	}	
    
    /**
	 * Remove all items out of group
	 */
    
    override public function removeAll() : Void
    {
        for (i in 0 ... _list.length)
        {
            var radio : IRadioButton = _list[i];
            removeRadioButton(radio);
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
        _group = groupName;
        
        // Check for radio buttons
        for (i in 0 ... _list.length)
		{
            // Make sure it's a radio button type
            _list[i].groupName = groupName;
        }
    }
    
    public function onChange(event : MouseEvent) : Void
    {
        displayObject.dispatchEvent(new Event(Event.CHANGE));
    }
}

