package com.chaos.utils.event;


import flash.events.Event;

/**
	 * Reports when task processing wakes or sleeps.
	 * @author Erick Feiling
	 */
class TaskManagerEvent extends Event
{
    
    /** Event type dispatched when task processing wakes. */
    public static inline var TASK_WAKE : String = "task_wake";
    /** Event type dispatched when task processing sleeps. */
    public static inline var TASK_SLEEP : String = "task_sleep";
    
    /** Creates a task manager lifecycle event. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy of this task manager event. */
    override public function clone() : Event
    {
        return new TaskManagerEvent(type, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("TaskManagerEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

