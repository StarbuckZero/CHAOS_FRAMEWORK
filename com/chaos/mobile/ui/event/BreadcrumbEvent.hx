package com.chaos.mobile.ui.event;

import openfl.events.Event;
import com.chaos.mobile.ui.Crumb;

/**
 * ...
 * @author Erick Feiling
 */

class BreadcrumbEvent extends Event
{
    
    /**
	 * When clicked
	 * @eventType com.chaos.mobile.ui.event.BreadcrumbEvent.SELECTED
	 */
	
    public static inline var SELECTED : String = "selected";

    public var crumb : Crumb;
    public var level : Int;
    public function new(type : String, eventCrumb:Crumb, eventLevel:Int, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);

        crumb = eventCrumb;
        level = eventLevel;
    }
    
    override public function clone() : BreadcrumbEvent
    {
        return new BreadcrumbEvent(type, crumb, level, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("BreadcrumbEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
