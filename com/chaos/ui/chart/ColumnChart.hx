package com.chaos.ui.chart;

/** Vertical category chart supporting single, grouped, and stacked layouts. */
class ColumnChart extends BarColumnChartBase {
    public static inline var TYPE:String = "ColumnChart";
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
