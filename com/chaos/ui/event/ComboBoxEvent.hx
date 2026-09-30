package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Event emitted by a combo box interaction.
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
    
    /** Creates a combo box event with the requested bubbling flags. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy of this combo box event. */
    override public function clone() : Event
    {
        return new ComboBoxEvent(type, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("ComboBoxEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

