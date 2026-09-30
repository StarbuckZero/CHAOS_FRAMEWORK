package com.chaos.media.event;


import openfl.events.Event;

/**
 * Events for DisplayImage
 *
 * @author Erick Feiling
 */

class DisplayImageEvent extends Event
{
    /** Event type dispatched when an image finishes loading. */
    public static inline var IMAGE_LOADED : String = "loaded";
    
    /** Creates an image loading event. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy of this image loading event. */
    override public function clone() : Event
    {
        return new DisplayImageEvent(type, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("DisplayImageEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

