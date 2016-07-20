package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;


import openfl.display.DisplayObject;
import openfl.display.Sprite;

import com.chaos.ui.UIDetailLevel;


/**
 * Base UI element used in the framework
 *
 * @author Erick Feiling
 */

class BaseUI extends Sprite implements IBaseUI
{
	

    public var enabled(get, set) : Bool;
    public var detail(get, set) : String;
    public var displayObject(get, never) : DisplayObject;

    
    private var _enabled : Bool = true;
    private var _detail : String = UIDetailLevel.HIGH;
    
    public function new()
    {
        super();
		
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
	 * Set the level of detail on the button. This degrade the button with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 */
    
    function set_detail(value : String) : String
    {
        _detail = value;
        return value;
    }
    
    /**
	 *
	 * Return low, medium or high as string.
	 *
	 * @see com.chaos.ui.UIDetailLevel
	 */
    
    function get_detail() : String
    {
        return _detail;
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

