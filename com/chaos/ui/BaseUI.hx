package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;


import openfl.display.DisplayObject;
import openfl.display.Sprite;




/**
 * Base UI element used in the framework
 *
 * @author Erick Feiling
 */

class BaseUI extends Sprite implements IBaseUI
{
	

    public var enabled(get, set) : Bool;
    public var displayObject(get, never) : DisplayObject;

    private var _width : Float;
    private var _height : Float;
    
    private var _enabled : Bool = true;
    
    
    public function new()
    {
        super();
		
    }

    
    /**
	 * @inheritDoc
	 */
	
    #if flash @:setter(width)
    private function set_width(value : Float) : Void
    {
        _width = value;
        draw();
		
    }
	#else
	override private function set_width(value : Float) : Float
	{
        _width = value;
        draw();
		
		return value;
	}
	#end
	
    /**
	 * @inheritDoc
	 */
	
    #if flash @:getter(width) #else override #end
    private function get_width() : Float
    {
        return _width;
    }
	
    
    /**
	 * @inheritDoc
	 */
	
    #if flash @:setter(height)
    private function set_height(value : Float) : Void
    {
        _height = value;
        draw();
    }
	#else  
    override private function set_height(value : Float) : Float
    {
        _height = value;
        draw();
		
        return value;
    }	
	#end
	
    /**
	 * @inheritDoc
	 */
	
    #if flash @:getter(height) #else override #end
    private function get_height() : Float
    {
        return _height;
    }
	
    function set_enabled(value : Bool) : Bool
    {
        _enabled = value;
        return value;
    }
    
    function get_enabled() : Bool
    {
        return _enabled;
    }
    
    
    /**
	 * Return the this class DisplayObject so it can be added and removed from the stage
	 */
    
    function get_displayObject() : DisplayObject
    {
        return this;
    }
    
    /**
	 * Update the UI class
	 */
    public function draw() : Void
    {
        
        
    }
    
    /**
	 * Reload all bitmap images
	 */
    public function reskin() : Void
    {
        
        
    }
}

