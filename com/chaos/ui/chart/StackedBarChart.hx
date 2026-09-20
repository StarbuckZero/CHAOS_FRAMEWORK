package com.chaos.ui.chart;
/** Horizontal chart with fixed stacked layout and raw/percent values. */
class StackedBarChart extends BarChart {
    public static inline var TYPE:String = "StackedBarChart";
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function defaultLayout():String { return "stacked"; }
    override function supportsLayout(value:String):Bool { return value == "stacked"; }
}
