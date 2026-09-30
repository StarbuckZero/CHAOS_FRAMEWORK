package com.chaos.utils.event;


import flash.events.Event;

/**
	 * For the System Profiler when it
	 * @author Erick Feiling
	 */
class SystemProfilerEvent extends Event
{
    /** Performance level reported by this event. */
    public var level(get, never) : String;

    
    /** Event type for a frame-rate threshold hit. */
    public static inline var FPS_HIT : String = "fps_hit";
    
    /** High performance level value. */
    public static inline var HIGH : String = "high";
    /** Medium performance level value. */
    public static inline var MEDIUM : String = "medium";
    /** Low performance level value. */
    public static inline var LOW : String = "low";
    
    private var _level : String = "high";
    
    /** Creates a profiler event for a performance level. */
    public function new(type : String, fpsLevel : String = "high", bubbles : Bool = false, cancelable : Bool = false)
    {
        _level = fpsLevel;
        
        super(type, bubbles, cancelable);
    }
    
    private function get_level() : String
    {
        return _level;
    }
    
    /** Returns a copy of this profiler event. */
    override public function clone() : Event
    {
        return new SystemProfilerEvent(type, level, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("SystemProfilerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

