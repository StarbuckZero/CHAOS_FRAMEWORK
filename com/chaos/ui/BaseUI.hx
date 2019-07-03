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

    private var _width : Float = 0;
    private var _height : Float = 0;
    
    private var _enabled : Bool = true;
    
    
    public function new( data:Dynamic = null )
    {
        super();
		
		
		// If object passed in then start setting defaults
		if (null != data)
			setComponentData(data);
		
		initialize();
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	public function setComponentData(data:Dynamic):Void
	{
		
		if (Reflect.hasField(data, "width"))
			_width = Reflect.field(data, "width");
		
		if (Reflect.hasField(data, "height"))
			_height = Reflect.field(data, "height");
			
		if (Reflect.hasField(data, "enabled"))
			_enabled = Reflect.field(data, "enabled");
			
		if (Reflect.hasField(data, "x"))
			x = Reflect.field(data, "x");
		
		if (Reflect.hasField(data, "y"))
			y = Reflect.field(data, "y");
			
		if (Reflect.hasField(data, "name"))
			name = Reflect.field(data, "name");
	}
	
	/**
	 * initialize all importain objects
	 */
	
	public function initialize():Void
	{
		// Init objects here
		reskin();
	}
	
    
    /**
	 * Reload all bitmap images and UI Styles
	 */
    public function reskin() : Void
    {
        // Style and set all bitmap data objects here
		draw();
    }	

	
    /**
	 * Update the UI class
	 */
    public function draw() : Void
    {
        // Update component(s) here
        
    }
	
	/**
	 * Unload Component
	 */
	
	public function destroy():Void
	{
		// Remove events and clear graphics here
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

}

