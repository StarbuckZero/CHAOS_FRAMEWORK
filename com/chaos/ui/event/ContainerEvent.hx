package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Events for containers
 *
 * @author Erick Feiling
 */

class ContainerEvent extends Event
{
    /** Container resize event type. */
    public static inline var RESIZE : String = "resize";
    /** Container update event type. */
    public static inline var UPDATE : String = "update";
    
    /** Creates a container event with the requested bubbling flags. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy of this container event. */
    override public function clone() : Event
    {
        return new ContainerEvent(type, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("ContainerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

