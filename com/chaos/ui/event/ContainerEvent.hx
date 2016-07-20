package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Events for containers
 *
 * @author Erick Feiling
 */

class ContainerEvent extends Event
{
    public static inline var RESIZE : String = "resize";
    public static inline var UPDATE : String = "update";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new ContainerEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("ContainerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

