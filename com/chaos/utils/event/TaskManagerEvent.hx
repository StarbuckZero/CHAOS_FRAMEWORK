package com.chaos.utils.event;


import flash.events.Event;

/**
	 * ...
	 * @author Erick Feiling
	 */
class TaskManagerEvent extends Event
{
    
    public static inline var TASK_WAKE : String = "task_wake";
    public static inline var TASK_SLEEP : String = "task_sleep";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new TaskManagerEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("TaskManagerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

