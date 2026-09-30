package com.chaos.ui.event;


import openfl.events.Event;

/**
 * Event for The GridPane class
 * @author Erick Feiling
 */

class GridPaneEvent extends Event
{
    /** Grid cell change event type. */
    public static inline var CHANGE : String = "change";
    /** Grid cell selection event type. */
    public static inline var SELECT : String = "select";
    
    /** Index of the affected row. */
    public var row : Int;
    /** Index of the affected column. */
    public var column : Int;
    
    /** Creates a grid event with its row and column indices. */
    public function new(type : String, bubbles : Bool = false, cancelable : Bool = false, rowSelected : Int = 0, colSelect : Int = 0)
    {
        row = rowSelected;
        column = colSelect;
        
        super(type, bubbles, cancelable);
    }
    
    /** Returns a copy with the same row and column indices. */
    override public function clone() : Event
    {
        return new GridPaneEvent(type, bubbles, cancelable, row, column);
    }
    
    /** Formats the inherited event fields. */
    override public function toString() : String
    {
        return formatToString("GridPaneEvent", "type", "bubbles", "cancelable", "eventPhase");
    }
}

