package com.chaos.ui.event;

import com.chaos.ui.chart.ChartData;
import openfl.events.Event;

/** Each listener receives a defensive payload snapshot via the getter. */
class ChartEvent extends Event {
    /** Chart mark pointer-enter event type. */
    public static inline var ROLL_OVER = "chartRollOver";
    /** Chart mark pointer-leave event type. */
    public static inline var ROLL_OUT = "chartRollOut";
    /** Chart mark pointer-down event type. */
    public static inline var MOUSE_DOWN = "chartMouseDown";
    /** Chart mark pointer-up event type. */
    public static inline var MOUSE_UP = "chartMouseUp";
    /** Chart mark click event type. */
    public static inline var CLICK = "chartClick";
    /** Chart selection change event type. */
    public static inline var CHANGE = "change";
    /** Lifecycle notification for runtime adapters; not an authorable data event. */
    public static inline var DISPOSE = "chartDispose";
    /** Copy of the chart item payload. */
    public var payload(get, never):Dynamic;
    var snapshot:Dynamic;
    /** Creates a chart event with a defensive copy of its payload. */
    public function new(type:String, payload:Dynamic) {
        super(type, false, false);
        snapshot = ChartData.copy(payload);
    }
    function get_payload():Dynamic { return ChartData.copy(snapshot); }
    /** Returns a chart event with the same type and payload. */
    override public function clone():Event { return new ChartEvent(type, snapshot); }
}
