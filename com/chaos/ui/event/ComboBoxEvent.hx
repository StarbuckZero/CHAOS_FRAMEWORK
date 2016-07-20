package com.chaos.ui.event;


import openfl.events.Event;

/**
 * ...
 * @author Erick Feiling
 */

class ComboBoxEvent extends Event
{
    
    /**
	 * When open
	 * @eventType com.chaos.ui.Event.ComboBoxEvent.OPEN
	 */
	
    public static inline var OPEN : String = "open";
	
    /**
	 * When closed
	 * @eventType com.chaos.ui.Event.ComboBoxEvent.CLOSE
	 */
	
    public static inline var CLOSE : String = "close";
    
    /**
	 * when item is selected
	 * @eventType com.chaos.ui.Event.ComboBoxEvent.CHANGE
	 */
	
    public static inline var CHANGE : String = "change";
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new ComboBoxEvent(type, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("ComboBoxEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

