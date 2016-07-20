package com.chaos.ui;

import nme.errors.Error;


import com.chaos.ui.interface.IBaseUI;
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
    
    /** The type of UI Element */
    public static inline var TYPE : String = "WindowManager";
    
    public function new()
    {
        super();
    }
    
    override public function addChild(child : DisplayObject) : DisplayObject
    {
        if (!child.hasEventListener(MouseEvent.MOUSE_DOWN)) 
            child.addEventListener(MouseEvent.MOUSE_DOWN, moveForward, false, 0, true);
        
        return super.addChild(child);
    }
    
    override public function addChildAt(child : DisplayObject, index : Int) : DisplayObject
    {
        if (!child.hasEventListener(MouseEvent.MOUSE_DOWN)) 
            child.addEventListener(MouseEvent.MOUSE_DOWN, moveForward, false, 0, true);
        
        return super.addChildAt(child, index);
    }
    
    override public function removeChild(child : DisplayObject) : DisplayObject
    {
        child.removeEventListener(MouseEvent.MOUSE_DOWN, moveForward);
        
        return super.removeChild(child);
    }
    
    override public function removeChildAt(index : Int) : DisplayObject
    {
        var child : DisplayObject = super.removeChildAt(index);
        child.removeEventListener(MouseEvent.MOUSE_DOWN, moveForward);
        
        return child;
    }
    
    private function moveForward(event : MouseEvent) : Void
    {
        
        pushToFront((try cast(event.currentTarget, DisplayObject) catch(e:Dynamic) null));
    }
    
    public function pushToFront(displayObj : DisplayObject) : Void
    {
        
        try
        {
            super.setChildIndex(displayObj, this.numChildren - 1);
        }        catch (error : Error)
        {
            Debug.print("[WindowManager::pushToFront] " + error.message);
        }
    }
}

