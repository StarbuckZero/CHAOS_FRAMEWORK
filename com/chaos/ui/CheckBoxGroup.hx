package com.chaos.ui;



import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBox;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;


import com.chaos.ui.CheckBox;

import openfl.events.MouseEvent;
import openfl.events.Event;

/**
 * Container that is made for and creating checkboxes. All checkboxes will be created started from the left.
 *
 * @author Erick Feiling
 */

class CheckBoxGroup extends HorizontalContainer implements ICheckBoxGroup implements IBaseContainer implements IAlignmentContainer implements IBaseUI
{
	private var _list:Array<ICheckBox>;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */	
    
    public function new(data:Dynamic = null)
    {
        super(data);
		
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
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
					createCheckBox(Reflect.field(dataObj, "name"), Reflect.field(dataObj, "text"), Reflect.hasField(dataObj, "selected") ? Reflect.field(dataObj, "selected") : false);
			}
			
		}
		else
		{
			if (null == _list)
				_list = new Array<ICheckBox>();			
		}
		
	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeAll();
	}
    
    
    /**
	 * Creates a check box and adds it to the container
	 *
	 * @param 	checkBoxName The name of the checkbox being created
	 * @param	labelText The check box name
	 * @param	selected True the check box is selected an false if not
	 * @return The newly created check box.
	 */
    
    public function createCheckBox(checkBoxName : String, labelText : String, selected : Bool = false) : ICheckBox
    {
		if (null == _list)
			_list = new Array<ICheckBox>();

        var checkbox : ICheckBox = new CheckBox({"name":checkBoxName, "text":labelText, "selected":selected, "width": 100, "height":20});
		
        checkbox.addEventListener(MouseEvent.CLICK, onChange, false, 0, true);
		
		_list.push(checkbox);
        
        return checkbox;
    }
    
    /**
	 * Remove a check box
	 *
	 * @param	checkbox The check box you want to remove out of the container
	 */
    
    public function removeCheckBox(checkbox : ICheckBox) : Void
    {
		// Remove out of display if there
		if (_content != null && _content.parent != null)
			_content.removeChild(checkbox.displayObject);
			
			
		checkbox.removeEventListener(MouseEvent.CLICK, onChange);
		
		_list.remove(checkbox);
		
		checkbox.destroy();
		checkbox = null;
    }
    
    /**
	 * An array filled with checkboxes
	 *
	 * @return A list of checkboxes objects
	 */
    
    public function getSelected() : Array<ICheckBox>
    {
        var checkboxArray : Array<ICheckBox> = new Array<ICheckBox>();
        
        // Loop display object
        for (i in 0 ... _list.length)
		{
			// Make sure item is checked
			if (_list[i].selected) 
				checkboxArray.push(_list[i]);
        }
        
        return checkboxArray;
    }
	
    /**
	 * Update the UI class
	 */
	
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
            var checkbox : ICheckBox = _list[i];
            removeCheckBox(checkbox);
        }
    }
    
    public function onChange(event : MouseEvent) : Void
    {
        displayObject.dispatchEvent(new Event(Event.CHANGE));
    }

	
	
}

