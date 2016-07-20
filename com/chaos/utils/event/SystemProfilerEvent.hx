package com.chaos.utils.event;


import flash.events.Event;

/**
	 * For the System Profiler when it
	 * @author Erick Feiling
	 */
class SystemProfilerEvent extends Event
{
    public var level(get, never) : String;

    
    public static inline var FPS_HIT : String = "fps_hit";
    
    public static inline var HIGH : String = "high";
    public static inline var MEDIUM : String = "medium";
    public static inline var LOW : String = "low";
    
    private var _level : String = "high";
    
    public function new(type : String, fpsLevel : String = "high", bubbles : Bool = false, cancelable : Bool = false)
    {
        _level = fpsLevel;
        
        super(type, bubbles, cancelable);
    }
    
    private function get_Level() : String
    {
        return _level;
    }
    
    override public function clone() : Event
    {
        return new SystemProfilerEvent(type, level, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("SystemProfilerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

