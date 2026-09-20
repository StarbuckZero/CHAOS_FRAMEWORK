package com.chaos.ui.chart;
class PieChart extends RadialChartBase {
    public static inline var TYPE:String="PieChart";
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
