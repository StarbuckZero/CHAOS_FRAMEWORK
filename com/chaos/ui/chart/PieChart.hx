package com.chaos.ui.chart;
class PieChart extends RadialChartBase {
    /** Type identifier for pie charts. */
    public static inline var TYPE:String="PieChart";
    /** Creates a pie chart with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
