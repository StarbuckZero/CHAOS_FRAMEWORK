package com.chaos.ui.chart;

/** Vertical category chart supporting single, grouped, and stacked layouts. */
class ColumnChart extends BarColumnChartBase {
    /** Type identifier for vertical column charts. */
    public static inline var TYPE:String = "ColumnChart";
    /** Creates a vertical column chart with optional configuration. */
    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
