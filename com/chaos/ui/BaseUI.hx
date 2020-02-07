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
	
	/**
	 * Calls draw function every time component width or height is adjusted
	 */
	public var drawOnResize(get, set) : Bool;
	
	/**
	 * Turns on or off image smoothing, which gives the image a nice anti aliasing effect
	 */
	
	public var imageSmoothing(get, set) : Bool;
	
	/**
	 * Enable or Disable component
	 */
    public var enabled(get, set) : Bool;
	
	/**
	 * This display object
	 */
	public var displayObject(get, never) : DisplayObject;
	
	/*
	* Use custom render created by theme. 
	*/
	public var useCustomRender(get,set):Bool;


    private var _width : Float = 0;
    private var _height : Float = 0;
    
    private var _enabled : Bool = true;
	private var _drawOnResize:Bool = false;
    
	private var _smoothImage : Bool = true;

	private var _useCustomRender:Bool = false;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new( data:Dynamic = null )
    {
        super();
		
		// Make sure all style and bitmap skinning is set first
		reskin();
		
		// If object passed in then start setting defaults
		if (null != data)
			setComponentData(data);
		
		// Init component parts
		initialize();
		
		// Draw and texture object
		draw();
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

		if (Reflect.hasField(data, "useCustomRender"))
			_useCustomRender = Reflect.field(data, "useCustomRender");		
			
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
	}
	
    
    /**
	 * Reload all bitmap images and UI Styles
	 */
	
    public function reskin() : Void
    {
        // Style and set all bitmap data objects here
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
	

	override private function set_width(value : Float) : Float
	{
        _width = value;
		
		if (_drawOnResize)
		draw();
        
		
		return value;
	}

	
    /**
	 * @inheritDoc
	 */
	

    override private function get_width() : Float
    {
        return _width;
    }
	
    
    /**
	 * @inheritDoc
	 */
	

    override private function set_height(value : Float) : Float
    {
		if (_drawOnResize)
		draw();
		
        _height = value;
        
		
        return value;
    }	
	
	
    /**
	 * @inheritDoc
	 */
	

    override private function get_height() : Float
    {
        return _height;
    }
	
	
	private function set_drawOnResize(value:Bool):Bool
	{
		_drawOnResize = value;
		return value;
	}
	
	private function get_drawOnResize():Bool
	{
		return _drawOnResize;
	}
	
	/**
	 * Turn on or off smoothing for image
	 */
	
	private function set_imageSmoothing( value:Bool ) : Bool
	{
		_smoothImage = value;
		
		return value;
	}
	
	/**
	 * Turn on or off smoothing for image
	 */
	
	private function get_imageSmoothing() : Bool
	{
		return _smoothImage;
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
	
	private function set_useCustomRender(value:Bool):Bool {

		_useCustomRender = value;

		return value;
	}

	private function get_useCustomRender():Bool {

		return _useCustomRender;
		
	}	
    
    
    /**
	 * Return the this class DisplayObject so it can be added and removed from the stage
	 */
    
    function get_displayObject() : DisplayObject
    {
        return this;
    }

}

