package com.chaos.widget.event;


import flash.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class VideoPlayerEvent extends Event
{
    public static inline var PLAY : String = "play";
    public static inline var PAUSE : String = "pause";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new VideoPlayerEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("VideoPlayerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

