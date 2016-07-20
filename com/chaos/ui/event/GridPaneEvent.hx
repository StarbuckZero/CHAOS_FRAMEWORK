package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Event for The GridPane class
 * @author Erick Feiling
 */

class GridPaneEvent extends Event
{
    public static inline var CHANGE : String = "change";
    public static inline var SELECT : String = "select";
    
    public var row : Int;
    public var column : Int;
    
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false, rowSelected : Int = 0, colSelect : Int = 0)
    {
        row = rowSelected;
        column = colSelect;
        
        super(type, bubbles, cancelable);
    }
    
    override public function clone() : Event
    {
        return new GridPaneEvent(type, bubbles, cancelable, row, column);
    }
    
    override public function toString() : String
    {
        return formatToString("GridPaneEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

