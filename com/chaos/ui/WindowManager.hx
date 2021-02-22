package com.chaos.ui;

import openfl.errors.Error;



import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

import com.chaos.utils.Debug;

/**
 * The Window Manager pulls any item that was clicked on to the front of the display.
 *
 * @author Erick Feiling
 *
 */

class WindowManager extends Sprite
{
        
	public var closeButtonUnFocusColor(get, set) : Int;
	public var minButtonUnFocusColor(get, set) : Int;
	public var maxButtonUnFocusColor(get, set) : Int;
	
	private var _closeUnFocusColor : Int = 0x999999;
	private var _maxUnFocusColor : Int = 0x999999;
	private var _minUnFocusColor : Int = 0x999999;
	
	private var _windowUnFocusColor : Int = 0xCCCCCC;
	private var _windowTitleUnFocusColor : Int = 0x333333;

    public function new()
    {
        super();
		
		// Set defaults for unfocus and focus colors
		// if ( -1 != UIStyleManager.WINDOW_TITLE_AREA_COLOR)   
		// 	_windowTitleFocusColor = UIStyleManager.WINDOW_TITLE_AREA_COLOR;
		
		// if ( -1 != UIStyleManager.WINDOW_FOCUS_COLOR)  
		// 	_windowFocusColor = UIStyleManager.WINDOW_FOCUS_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR)
			_windowTitleUnFocusColor = UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR;
				
		if ( -1 != UIStyleManager.WINDOW_UNFOCUS_COLOR)
			_windowUnFocusColor = UIStyleManager.WINDOW_UNFOCUS_COLOR;
			
		if ( -1 != UIStyleManager.WINDOW_CLOSE_UNFOCUS_COLOR)
			_closeUnFocusColor = UIStyleManager.WINDOW_CLOSE_UNFOCUS_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_UNFOCUS_COLOR)
			_maxUnFocusColor = UIStyleManager.WINDOW_MAX_UNFOCUS_COLOR;
			
		if ( -1 != UIStyleManager.WINDOW_MIN_UNFOCUS_COLOR)
			_minUnFocusColor = UIStyleManager.WINDOW_MIN_UNFOCUS_COLOR;
		
    }
    
	public function addWindow( window:Window ):Window
	{
        if (!window.hasEventListener(MouseEvent.MOUSE_DOWN)) 
            window.addEventListener(MouseEvent.MOUSE_DOWN, moveForward, false, 0, true);
        
		addChild(window);

        return window;
		
	}
	
	public function removeWindow( window:Window ):Window
	{
        window.removeEventListener(MouseEvent.MOUSE_DOWN, moveForward);
        
		removeChild(window);

        return window;
	}
	
	/**
	 * Set the minimize button unfocus state color.
	 */
	private function set_minButtonUnFocusColor(value : Int) : Int
	{
		_minUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	
	private function get_minButtonUnFocusColor() : Int 
	{
		return _minUnFocusColor;
    } 	
	
	/**
	 * Set the maximize button unfocus state color.
	 */
	
	private function set_maxButtonUnFocusColor(value : Int) : Int 
	{
		_maxUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	private function get_maxButtonUnFocusColor() : Int
	{
		return _maxUnFocusColor;
    }	
	
	/**
	 * Set the close button unfocus state color.
	 */ 
	
	private function set_closeButtonUnFocusColor(value : Int) : Int
	{
		_closeUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	private function get_closeButtonUnFocusColor() : Int 
	{
		return _closeUnFocusColor;
    } 	
	
	/**
	 * Set the color of the window which is
	 */  
	
	private function set_windowFocusColor(value : Int) : Int 
	{
		// _windowFocusColor = value;
		
        return value;
    }
	
	/**
	 * Return the color of the window
	 */
	
	private function get_windowFocusColor() : Int
	{
		// return _windowFocusColor;
		return 0;
    }	
	
	/**
	 * Set the color of the window title area once the user select
	 */
	private function set_windowTitleFocusColor(value : Int) : Int 
	{
		// _windowTitleFocusColor = value;
		
        return value;
	}
	
	/**
	 * Return the color of the window
	 */  
	
	private function get_windowTitleFocusColor() : Int
	{
		// return _windowTitleFocusColor;
		return 0;
    }	
	
	
	/**
	 * Set the color of the window once it is unfocused which is everywhere but the title area
	 */
	
	private function set_windowUnFocusColor(value : Int) : Int
	{
		_windowUnFocusColor = value;
		
        return value;
    }
	
	/**
	 * Return the color of the window for it's unfocus state
	 */ 
	
	private function get_windowUnFocusColor() : Int 
	{
		return _windowUnFocusColor;
    }	
	
	/**
	 * Set the color of the window title area once it is unfocused
	 */  
	
	private function set_windowTitleUnFocusColor(value : Int) : Int
	{
		_windowTitleUnFocusColor = value;
		
        return value;
    } 
	
	/**
	 * Return the color of the window title area for it's unfocus state
	 */
	
	private function get_windowTitleUnFocusColor() : Int 
	{
		return _windowTitleUnFocusColor;
    }	
	
  
    private function moveForward(event : MouseEvent) : Void
    {
        
        pushToFront((try cast(event.currentTarget, DisplayObject) catch (e:Dynamic) null));
    }
    
    public function pushToFront(displayObj : DisplayObject) : Void
    {
        
        try
        {
            super.setChildIndex(displayObj, this.numChildren - 1);
        }
        catch (error : Error)
        {
            Debug.print("[WindowManager::pushToFront] " + error.message);
        }
    }
}

