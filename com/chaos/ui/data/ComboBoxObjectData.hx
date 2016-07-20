package com.chaos.ui.data;


import com.chaos.ui.Label;
import com.chaos.ui.classInterface.IBaseSelectData;
import openfl.display.DisplayObject;

//TODO: Update to use BaseSelectData class later

/**
 * The data object used for ComboBox
 *
 * @author Erick Feiling
 */

class ComboBoxObjectData implements IBaseSelectData
{
    public var name(get, set) : String;
    public var id(get, set) : Int;
    public var text(get, set) : String;
    public var value(get, set) : String;
    public var selected(get, set) : Bool;
    public var label(get, set) : Label;
    public var icon(get, set) : DisplayObject;

    private var _name : String = "";
    private var _id : Int = 0;
    private var _text : String = "";
    private var _value : String = "";
    private var _selected : Bool = false;
    private var _label : Label;
    
    /**
	 * The combo box data object
	 *
	 * @param	text The text that will be set
	 * @param	value The value that will be used
	 * @param	selected If the object is selected or not
	 */
    
    public function new(text : String, value : String = "", selected : Bool = false)
    {
        _text = text;
        _value = value;
        _selected = selected;
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
	 * Set the id
	 */
    private function set_id(value : Int) : Int
    {
        _id = value;
        return value;
    }
    
    /**
	 * Get id
	 */
    private function get_id() : Int
    {
        return _id;
    }
    
    /**
	 * The text that will be used
	 */
    
    private function set_text(value : String) : String
    {
        _text = value;
        return value;
    }
    
    /**
	 * Return the text being used
	 */
    
    private function get_text() : String
    {
        return _text;
    }
    
    /**
	 * The value that will be used
	 */
    
    private function set_value(value : String) : String
    {
        _value = value;
        return value;
    }
    
    /**
	 * Return the value being used
	 */
    
    private function get_value() : String
    {
        return _value;
    }
    
    /**
	 * Set if the object will be selected or not
	 */
    
    private function set_selected(value : Bool) : Bool
    {
        _selected = value;
        return value;
    }
    
    /**
	 * Return true if the object has been selected and false if not
	 */
    
    private function get_selected() : Bool
    {
        return _selected;
    }
    
    /**
	 * Set the label
	 */
    private function set_label(value : Label) : Label
    {
        _label = value;
        return value;
    }
    
    /**
	 * Get the label
	 */
    
    private function get_label() : Label
    {
        return _label;
    }
    
    private function set_icon(value : DisplayObject) : DisplayObject
    {
        return value;
    }
    
    private function get_icon() : DisplayObject
    {
        return null;
    }
}

