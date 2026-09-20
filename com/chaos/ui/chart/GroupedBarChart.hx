package com.chaos.ui.chart;
/** Horizontal chart whose grouped semantics are fixed across updates. */
class GroupedBarChart extends BarChart {
    public static inline var TYPE:String = "GroupedBarChart";
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function defaultLayout():String { return "grouped"; }
    override function supportsLayout(value:String):Bool { return value == "grouped"; }
}
