package com.chaos.ui.data;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;

class ToolTipData
{
    public var width(get, set) : Float;
    public var height(get, set) : Float;
    public var text(get, set) : String;
    public var textColor(get, set) : Int;
    public var displayObject(get, set) : DisplayObject;
    public var border(get, set) : Bool;
    public var backgroundColor(get, set) : Int;
    public var borderColor(get, set) : Int;

    
    private var _text : String;
    private var _textColor : Int;
    private var _displayObject : DisplayObject;
    private var _backgroundColor : Int;
    private var _border : Bool;
    private var _borderColor : Int;
    private var _width : Float;
    private var _height : Float;
    
    public function new(displayObj : DisplayObject, text : String = "", width : Float = -1, height : Float = -1, textColor : Int = -1, backgroundColor : Int = -1, border : Bool = false, borderColor : Int = -1)
    {
        _displayObject = displayObj;
        _text = text;
        _textColor = textColor;
        _border = border;
        _borderColor = borderColor;
        _backgroundColor = backgroundColor;
        _width = width;
        _height = height;
    }
    
    private function set_width(value : Float) : Float
    {
        _width = value;
        return value;
    }
    
    private function get_width() : Float
    {
        return _width;
    }
    
    private function set_height(value : Float) : Float
    {
        _height = value;
        return value;
    }
    
    private function get_height() : Float
    {
        return _height;
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
    
    private function set_textColor(value : Int) : Int
    {
        _textColor = value;
        return value;
    }
    
    private function get_textColor() : Int
    {
        return _textColor;
    }
    
    private function set_displayObject(value : DisplayObject) : DisplayObject
    {
        _displayObject = value;
        return value;
    }
    
    private function get_displayObject() : DisplayObject
    {
        return _displayObject;
    }
    
    private function set_border(value : Bool) : Bool
    {
        _border = value;
        return value;
    }
    
    private function get_border() : Bool
    {
        return _border;
    }
    
    private function set_backgroundColor(value : Int) : Int
    {
        _backgroundColor = value;
        return value;
    }
    
    private function get_backgroundColor() : Int
    {
        return _backgroundColor;
    }
    
    private function set_borderColor(value : Int) : Int
    {
        _borderColor = value;
        return value;
    }
    
    private function get_borderColor() : Int
    {
        return _borderColor;
    }
}

