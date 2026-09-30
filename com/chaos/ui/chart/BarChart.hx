package com.chaos.ui.chart;
/** Horizontal category chart with single, grouped, or stacked layout. */
class BarChart extends BarColumnChartBase {
    /** Type identifier for horizontal bar charts. */
    public static inline var TYPE:String = "BarChart";
    /** Creates a horizontal bar chart with optional configuration. */
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function get_orientation():String { return "horizontal"; }
}
