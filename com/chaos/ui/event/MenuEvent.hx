package com.chaos.ui.event;


//import com.chaos.ui.interface.IMenuItem;
import com.chaos.ui.classInterface.IMenuItem;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * Carries the menu item and holder associated with a menu event.
 * @author Erick Feiling
 */
class MenuEvent extends Event
{
    /**
	 * @eventType menu_open
	 */
    public static inline var MENU_OPEN : String = "menu_open";
    
    /**
	 * @eventType menu_close
	 */
    
    public static inline var MENU_CLOSE : String = "menu_close";
    
    /**
	 * @eventType menu_button_click
	 */
    
    public static inline var MENU_BUTTON_CLICK : String = "menu_button_click";
    
    /** Menu item associated with this event. */
    public var menuItem : IMenuItem;
    /** Sprite containing the associated menu item. */
    public var holder : Sprite;
    
    /** Creates a menu event for an item and its optional holder. */
    public function new(type : String, menuItem : IMenuItem, holder : Sprite = null, bubbles : Bool = false, cancelable : Bool = false)
    {
        this.menuItem = menuItem;
        this.holder = holder;
        
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy with the same item and holder. */
    override public function clone() : Event
    {
        return new MenuEvent(type, menuItem, holder, bubbles, cancelable);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("MenuEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

