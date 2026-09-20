package com.chaos.ui.event;

import com.chaos.ui.chart.ChartData;
import openfl.events.Event;

/** Each listener receives a defensive payload snapshot via the getter. */
class ChartEvent extends Event {
    public static inline var ROLL_OVER = "chartRollOver";
    public static inline var ROLL_OUT = "chartRollOut";
    public static inline var MOUSE_DOWN = "chartMouseDown";
    public static inline var MOUSE_UP = "chartMouseUp";
    public static inline var CLICK = "chartClick";
    public static inline var CHANGE = "change";
    /** Lifecycle notification for runtime adapters; not an authorable data event. */
    public static inline var DISPOSE = "chartDispose";
    public var payload(get, never):Dynamic;
    var snapshot:Dynamic;
    public function new(type:String, payload:Dynamic) {
        super(type, false, false);
        snapshot = ChartData.copy(payload);
    }
    function get_payload():Dynamic { return ChartData.copy(snapshot); }
    override public function clone():Event { return new ChartEvent(type, snapshot); }
}
