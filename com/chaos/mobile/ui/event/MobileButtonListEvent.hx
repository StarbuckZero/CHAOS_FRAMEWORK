package com.chaos.mobile.ui.event;

import openfl.events.Event;
import com.chaos.mobile.ui.MobileButton;

/**
 * Reports an interaction with a mobile button.
 * @author Erick Feiling
 */

class MobileButtonListEvent extends Event
{
    
    /**
	 * When open
	 * @eventType com.chaos.ui.Event.MobileButtonListEvent.OPEN
	 */
	
    public static inline var OPEN : String = "open";
	
     /**
      * When closed
      * @eventType com.chaos.ui.Event.MobileButtonListEvent.CLOSE
      */
     
    public static inline var CLOSE : String = "close";
     
     /**
      * when item is selected
      * @eventType com.chaos.ui.Event.MobileButtonListEvent.CHANGE
      */
     
    public static inline var CHANGE : String = "change";

    /** Mobile button associated with the event. */
    public var button : MobileButton;
    
    /** Creates an event for a mobile button. */
    public function new(type : String, button : MobileButton, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
        this.button = button;
    }
    
    /** Returns a copy with the same mobile button. */
    override public function clone() : MobileButtonListEvent
    {
        return new MobileButtonListEvent(type, button, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("MobileButtonListEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
