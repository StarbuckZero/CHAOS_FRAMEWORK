package com.chaos.mobile.ui.event;

import openfl.events.Event;
import com.chaos.mobile.ui.Crumb;

/**
 * Reports a breadcrumb selection and its navigation level.
 * @author Erick Feiling
 */

class BreadcrumbEvent extends Event
{
    
    /**
	 * When clicked
	 * @eventType com.chaos.mobile.ui.event.BreadcrumbEvent.SELECTED
	 */
	
    public static inline var SELECTED : String = "selected";

    /** Breadcrumb item associated with the event. */
    public var crumb : Crumb;
    /** Navigation depth of the breadcrumb item. */
    public var level : Int;
    /** Creates a breadcrumb event with an item and navigation level. */
    public function new(type : String, eventCrumb:Crumb, eventLevel:Int, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);

        crumb = eventCrumb;
        level = eventLevel;
    }
    
    /** Returns a copy with the same breadcrumb item and level. */
    override public function clone() : BreadcrumbEvent
    {
        return new BreadcrumbEvent(type, crumb, level, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("BreadcrumbEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
