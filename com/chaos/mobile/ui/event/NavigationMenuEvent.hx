package com.chaos.mobile.ui.event;

import openfl.events.Event;
import com.chaos.mobile.ui.NavigationMenuItem;

/**
 * ...
 * @author Erick Feiling
 */

class NavigationMenuEvent extends Event
{
    
    /**
	 * When button selected
	 * @eventType com.chaos.mobile.ui.event.NavigationMenuEvent.SELECTED
	 */
	
    public static inline var SELECTED : String = "selected";

    public var menuButton : NavigationMenuItem;
    
    public function new(type : String, button:NavigationMenuItem, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);

        menuButton = button;
    }
    
    override public function clone() : NavigationMenuEvent
    {
        return new NavigationMenuEvent(type, menuButton, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("NavigationMenuEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
