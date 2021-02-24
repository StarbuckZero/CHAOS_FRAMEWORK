package com.chaos.engine.event;

import flash.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class CoreEngineEvent extends Event
{
    public static inline var READY : String = "ready";
    public static inline var LOADING : String = "loading";
    public static inline var LOADED : String = "loaded";
    public static inline var READING : String = "reading";
    public static inline var DONE : String = "done";
    
    public static inline var LOAD_FAIL : String = "load_fail";
    public static inline var PASER_FAIL : String = "parse_fail";
    
    public static inline var ITEM_LOAD_COMPLETE : String = "item_load_complete";
    public static inline var ITEM_LOAD_FAIL : String = "item_load_fail";
    public static inline var ITEM_CREATED : String = "item_created";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
}

