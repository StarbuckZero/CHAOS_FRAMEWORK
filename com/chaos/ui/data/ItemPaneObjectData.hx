package com.chaos.ui.data;


//TODO: Update to use BaseSelectData class later

/**
 * ...
 * @author Erick Feiling
 */

import com.chaos.ui.classInterface.IBaseSelectData;
import com.chaos.ui.classInterface.IItemPaneObjectData;
import openfl.display.DisplayObject;

import com.chaos.ui.Label;



class ItemPaneObjectData implements IItemPaneObjectData implements IBaseSelectData
{
    public var name(get, set) : String;
    public var text(get, set) : String;
    public var value(get, set) : String;
    public var toolTipText(get, set) : String;
    public var selected(get, set) : Bool;
    public var item(get, set) : DisplayObject;
    public var label(get, set) : Label;
    public var icon(get, set) : DisplayObject;
    public var id(get, set) : Int;
    public var itemButton(get, set) : ToggleButton;

    private var _itemButton : ToggleButton;
    
    private var _name : String = "";
    private var _id : Int = -1;
    private var _text : String = "label";
    private var _value : String = "";
    private var _toolTipText : String = "";
    private var _selected : Bool = false;
    private var _item : DisplayObject = null;
    private var _label : Label = null;
    private var _icon : DisplayObject = null;
    
    /**
	 * The ItemPanel DisplayObject
	 *
	 * @param	itemText The object text if the labels is being displayed
	 * @param	toolTipText The tool-tip text. If nothing is set then no tool-tip will be displayed.
	 * @param	itemSelected If the object is already selected or not
	 * @param	item The DisplayObject that you want to display
	 * @param	itemIcon An icon that can be displayed
	 */
    
    public function new(itemText : String = "", value : String = "", toolTipText : String = "", itemSelected : Bool = false, item : DisplayObject = null, itemIcon : DisplayObject = null)
    {
        _text = itemText;
        _value = value;
        _toolTipText = toolTipText;
        _selected = itemSelected;
        _item = item;
        _icon = itemIcon;
    }
    
    private function set_name(value : String) : String
    {
        _name = value;
        return value;
    }
    
    private function get_name() : String
    {
        return _name;
    }
    
    /**
	 * The object text if the labels is being displayed
	 */
    
    private function set_text(value : String) : String
    {
        _text = value;
        return value;
    }
    
    /**
	 * Return the text that is being used
	 */
    
    private function get_text() : String
    {
        return _text;
    }
    
    /**
	 * The object value
	 */
    
    private function set_value(value : String) : String
    {
        _value = value;
        return value;
    }
    
    /**
	 * Return the value that is being used
	 */
    
    private function get_value() : String
    {
        return _value;
    }
    
    /**
	 * Set the tool-tip
	 */
    
    private function set_toolTipText(value : String) : String
    {
        _toolTipText = value;
        return value;
    }
    
    /**
	 * Return the text that item is being used
	 */
	
    private function get_toolTipText() : String
    {
        return _toolTipText;
    }
    
    /**
	 * Set if the object is selected or not
	 */
    private function set_selected(value : Bool) : Bool
    {
        _selected = value;
        return value;
    }
    
    /**
	 * Return if object is selected or not
	 */
    private function get_selected() : Bool
    {
        return _selected;
    }
    
    /**
	 * Set the item
	 */
    
    private function set_item(value : DisplayObject) : DisplayObject
    {
        _item = value;
        return value;
    }
    
    /**
	 * Return the DisplayObject being used
	 */
    
    private function get_item() : DisplayObject
    {
        return _item;
    }
    
    /**
	 * Set the label being used.
	 */
    
    private function set_label(value : Label) : Label
    {
        _label = value;
        return value;
    }
    
    /**
	 * Return the label
	 */
    
    private function get_label() : Label
    {
        return _label;
    }
    
    /**
	 * Set the icon being used
	 */
    
    private function set_icon(value : DisplayObject) : DisplayObject
    {
        _icon = value;
        return value;
    }
    
    /**
	 * Return the icon
	 */
    
    private function get_icon() : DisplayObject
    {
        return _icon;
    }
    
    /**
	 * Set the id
	 */
    
    private function set_id(value : Int) : Int
    {
        _id = value;
        return value;
    }
    
    /**
	 * Return the id
	 */
    
    private function get_id() : Int
    {
        return _id;
    }
    
    /**
	 * Set the button being used
	 */
    
    private function set_itemButton(value : ToggleButton) : ToggleButton
    {
        _itemButton = value;
        return value;
    }
    
    /**
	 * Return the toggle button being used
	 */
    
    private function get_itemButton() : ToggleButton
    {
        return _itemButton;
    }
}

