package com.chaos.media.event;


import openfl.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class DisplayVideoEvent extends Event
{
    /** When meta data is loaded */
    public static inline var VIDEO_METADATA : String = "video_metadata";
    
    /** When video is done loading */
    public static inline var VIDEO_COMPLETE : String = "video_complete";
    
    /** When video hit buffer amount */
    public static inline var VIDEO_BUFFER : String = "video_buffer";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new DisplayVideoEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("DisplayVideoEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

