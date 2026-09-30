package com.chaos.ui.chart;
class LineChart extends LineSeriesBase {
    /** Type identifier for line charts. */
    public static inline var TYPE:String="LineChart";
    /** Creates a line chart with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
