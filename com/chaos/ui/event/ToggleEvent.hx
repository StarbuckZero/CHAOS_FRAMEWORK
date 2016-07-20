package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Events for toggle buttons
 *
 * @author Erick Feiling
 */

class ToggleEvent extends Event
{
    
    public static inline var NORMAL_STATE : String = "normal";
    public static inline var OVER_STATE : String = "over";
    public static inline var DOWN_STATE : String = "down";
    public static inline var DISABLE_STATE : String = "disable";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new ToggleEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("ToggleEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

