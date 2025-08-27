package com.chaos.media.event;


import openfl.events.Event;

/**
 * Events for DisplayImage
 *
 * @author Erick Feiling
 */

class DisplayImageEvent extends Event
{
    public static inline var IMAGE_LOADED : String = "loaded";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new DisplayImageEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("DisplayImageEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

