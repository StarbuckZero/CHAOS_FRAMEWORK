package com.chaos.ui.chart;
/** Horizontal chart with fixed stacked layout and raw/percent values. */
class StackedBarChart extends BarChart {
    /** Type identifier for stacked horizontal bar charts. */
    public static inline var TYPE:String = "StackedBarChart";
    /** Creates a stacked bar chart with optional configuration. */
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function defaultLayout():String { return "stacked"; }
    override function supportsLayout(value:String):Bool { return value == "stacked"; }
}
