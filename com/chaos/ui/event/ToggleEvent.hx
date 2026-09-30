package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Events for toggle buttons
 *
 * @author Erick Feiling
 */

class ToggleEvent extends Event
{
    
    /** Toggle event value for the normal state. */
    public static inline var NORMAL_STATE : String = "normal";
    /** Toggle event value for the hover state. */
    public static inline var OVER_STATE : String = "over";
    /** Toggle event value for the pressed state. */
    public static inline var DOWN_STATE : String = "down";
    /** Toggle event value for the disabled state. */
    public static inline var DISABLE_STATE : String = "disable";
    
    /** Creates a toggle event with the requested bubbling flags. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy of this toggle event. */
    override public function clone() : Event
    {
        return new ToggleEvent(type, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("ToggleEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

