package com.chaos.ui.chart;
/** Horizontal chart whose grouped semantics are fixed across updates. */
class GroupedBarChart extends BarChart {
    /** Type identifier for grouped horizontal bar charts. */
    public static inline var TYPE:String = "GroupedBarChart";
    /** Creates a grouped bar chart with optional configuration. */
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function defaultLayout():String { return "grouped"; }
    override function supportsLayout(value:String):Bool { return value == "grouped"; }
}
