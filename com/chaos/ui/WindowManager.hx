package com.chaos.ui;

import openfl.errors.Error;



import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

import com.chaos.utils.Debug;

/**
 * Manages window stacking and focus when windows are added or clicked.
 *
 * @author Erick Feiling
 *
 */

class WindowManager extends Sprite
{
    /** Creates an empty window display container. */
    public function new()
    {
        super();
    }
    
	/** Adds a window, listens for clicks, and gives it focus. */
	public function addWindow( window:Window ):Window
	{
        if (!window.hasEventListener(MouseEvent.MOUSE_DOWN)) 
            window.addEventListener(MouseEvent.MOUSE_DOWN, moveForward, false, 0, true);
        
		addChild(window);
		setFocusedWindow(window);

        return window;
		
	}
	
	/** Removes a window and focuses the remaining topmost window. */
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
    
    /** Moves a display object to the top and focuses it if it is a window. */
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

