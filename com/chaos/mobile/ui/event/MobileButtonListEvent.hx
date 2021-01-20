package com.chaos.mobile.ui.event;

import openfl.events.Event;
import com.chaos.mobile.ui.MobileButton;

/**
 * ...
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

    public var button : MobileButton;
    
    public function new(type : String, button : MobileButton, bubbles : Bool = false, cancelable : Bool = false)
    {
        super(type, bubbles, cancelable);
        this.button = button;
    }
    
    override public function clone() : MobileButtonListEvent
    {
        return new MobileButtonListEvent(type, button, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("MobileButtonListEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}
