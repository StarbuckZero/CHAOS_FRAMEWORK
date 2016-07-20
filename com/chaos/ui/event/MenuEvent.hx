package com.chaos.ui.event;


//import com.chaos.ui.interface.IMenuItem;
import com.chaos.ui.classInterface.IMenuItem;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
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
    
    public var menuItem : com.chaos.ui.classInterface.IMenuItem;
    public var holder : Sprite;
    
    public function new(type : String, menuItem : com.chaos.ui.classInterface.IMenuItem, holder : Sprite = null, bubbles : Bool = false, cancelable : Bool = false)
    {
        this.menuItem = menuItem;
        this.holder = holder;
        
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new MenuEvent(type, menuItem, holder, bubbles, cancelable);
    }
    
    override public function toString() : String
    {
        return formatToString("MenuEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

