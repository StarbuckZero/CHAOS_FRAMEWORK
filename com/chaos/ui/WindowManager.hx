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
    public function new()
    {
        super();
    }
    
	public function addWindow( window:Window ):Window
	{
        if (!window.hasEventListener(MouseEvent.MOUSE_DOWN)) 
            window.addEventListener(MouseEvent.MOUSE_DOWN, moveForward, false, 0, true);
        
		addChild(window);
		setFocusedWindow(window);

        return window;
		
	}
	
	public function removeWindow( window:Window ):Window
	{
        window.removeEventListener(MouseEvent.MOUSE_DOWN, moveForward);
        
		removeChild(window);
		window.focus = true;

		if (numChildren > 0)
		{
			var topWindow = Std.downcast(getChildAt(numChildren - 1), Window);
			if (topWindow != null)
				setFocusedWindow(topWindow);
		}

        return window;
	}

	private function setFocusedWindow(window:Window):Void
	{
		for (i in 0...numChildren)
		{
			var childWindow = Std.downcast(getChildAt(i), Window);
			if (childWindow != null)
				childWindow.focus = childWindow == window;
		}
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

			var window = Std.downcast(displayObj, Window);
			if (window != null)
				setFocusedWindow(window);
        }
        catch (error : Error)
        {
            Debug.print("[WindowManager::pushToFront] " + error.message);
        }
    }
}

