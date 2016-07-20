package com.chaos.ui.data;



import com.chaos.ui.Label;
import com.chaos.ui.classInterface.IBaseSelectData;
import openfl.display.DisplayObject;


/**
 * Base data class for any data objects
 * @author Erick Feiling
 */

class BaseObjectData implements IBaseSelectData
{
    public var name(get, set) : String;
    public var id(get, set) : Int;
    public var text(get, set) : String;
    public var value(get, set) : String;
    public var selected(get, set) : Bool;
    public var icon(get, set) : DisplayObject;
    public var label(get, set) : Label;

    private var _name : String = "";
    private var _id : Int = 0;
    private var _text : String = "";
    private var _value : String = "";
    private var _selected : Bool = false;
    private var _icon : DisplayObject;
    private var _label : Label;
    
    public function new(newId : Int = 0, newName : String = "", newText : String = "", newVal : String = "", isSelected : Bool = false, newIcon : Dynamic = null, newLabel : Dynamic = null)
    {
        _id = newIcon;
        _text = newText;
        _value = newVal;
        _selected = isSelected;
        _icon = newIcon;
        _label = newLabel;
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
    
    private function set_id(value : Int) : Int
    {
        _id = value;
        return value;
    }
    
    private function get_id() : Int
    {
        return _id;
    }
    
    private function set_text(value : String) : String
    {
        _text = value;
        return value;
    }
    
    private function get_text() : String
    {
        return _text;
    }
    
    private function set_value(value : String) : String
    {
        _value = value;
        return value;
    }
    
    private function get_value() : String
    {
        return _value;
    }
    
    private function set_selected(value : Bool) : Bool
    {
        _selected = value;
        return value;
    }
    
    private function get_selected() : Bool
    {
        return _selected;
    }
    
    private function set_icon(value : DisplayObject) : DisplayObject
    {
        _icon = value;
        return value;
    }
    
    private function get_icon() : DisplayObject
    {
        return _icon;
    }
    
    private function set_label(value : Label) : Label
    {
        _label = value;
        return value;
    }
    
    private function get_label() : Label
    {
        return _label;
    }
}

