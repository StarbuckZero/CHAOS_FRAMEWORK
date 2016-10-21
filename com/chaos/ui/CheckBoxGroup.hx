package com.chaos.ui;


import com.chaos.data.DataProvider;
import com.chaos.ui.classInterface.IBaseSelectData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBox;
import com.chaos.ui.classInterface.ICheckBoxGroup;
import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.utils.Object;

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
    public var dataProvider(get, set) : DataProvider;

    private var nameList : Object;
    private var _list : DataProvider;
    
    /**
	 * Creates a container and
	 * @eventType openfl.events.Event.CHANGE
	 */
    
    public function new(checkBoxName : String, defaultWidth : Int = 300, defaultHeight : Int = 30)
    {
        super();
		
        name = checkBoxName;
        background = false;
		
        nameList = new Object();
		
        width = defaultWidth;
        height = defaultHeight;
    }
    
    /**
	 * Replace the current data provider
	 */
    
    private function set_dataProvider(value : DataProvider) : DataProvider
    {
        if (null == _list) 
            return null;
        
        _list = value;
        
        // Clear everything out
        removeAll();
        
        for (i in 0..._list.length)
		{
            var item : IBaseSelectData = cast(_list.getItemAt(i), IBaseSelectData);
            
            if (item.name != "" && item.text != "") 
            {
                createCheckBox(item.name, item.text, item.selected);
            }
        }
		
        return value;
    }
    
    /**
	 * Returns the data provider being used
	 */
    
    private function get_dataProvider() : DataProvider
    {
        return _list;
    }
    
    /**
	 * Creates a check box and adds it to the container
	 *
	 * @param 	checkBoxName The name of the checkbox being created
	 * @param	labelText The check box name
	 * @param	selected True the check box is selected an false if not
	 * @return The newly created check box.
	 */
    
    public function createCheckBox(checkBoxName : String, labelText : String, selected : Bool = false) : com.chaos.ui.classInterface.ICheckBox
    {
        var checkbox : ICheckBox = new CheckBox(labelText);
        
        checkbox.name = checkBoxName;
        checkbox.selected = selected;
        checkbox.addEventListener(MouseEvent.CLICK, onChange, false, 0, true);
        Reflect.setField(nameList, checkBoxName, checkbox);
        
        addElement(checkbox);
        
        return checkbox;
    }
    
    /**
	 * Remove a check box
	 *
	 * @param	checkbox The check box you want to remove out of the container
	 */
    
    public function removeCheckBox(checkbox : ICheckBox) : Void
    {
        contentObject.removeChild(checkbox.displayObject);
    }
    
    /**
	 * An array filled with checkboxes
	 *
	 * @return A list of checkboxes objects
	 */
    
    public function getSelected() : Array<Dynamic>
    {
        var checkboxArray : Array<Dynamic> = new Array<Dynamic>();
        
        // Loop display object
        for (i in 0...contentObject.numChildren){
            // Make sure it's a check box
            if (Std.is(contentObject.getChildAt(i), CheckBox)) 
            {
                var checkbox : ICheckBox = try cast(contentObject.getChildAt(i), ICheckBox) catch(e:Dynamic) null;
                
                // Make sure item is checked
                if (checkbox.selected) 
                    checkboxArray.push(checkbox);
            }
        }
        
        return checkboxArray;
    }
    
    /**
	 * Remove all items out of group
	 */
    
    override public function removeAll() : Void
    {
        for (index in Reflect.fields(nameList))
        {
            var checkbox : ICheckBox = Reflect.field(nameList, index);
            removeCheckBox(checkbox);
        }
    }
    
    public function onChange(event : MouseEvent) : Void
    {
        displayObject.dispatchEvent(new Event(Event.CHANGE));
    }
}

