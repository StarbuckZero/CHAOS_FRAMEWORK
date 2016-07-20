package com.chaos.widget.event;


import flash.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class MP3PlayerEvent extends Event
{
    public static inline var TRACK_CHANGE : String = "track_change";
    public static inline var STOP : String = "track_stop";
    public static inline var PAUSE : String = "track_pause";
    public static inline var PLAY : String = "track_play";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new MP3PlayerEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("MP3PlayerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

