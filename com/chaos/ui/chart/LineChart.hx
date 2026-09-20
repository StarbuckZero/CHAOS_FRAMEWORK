package com.chaos.ui.chart;
class LineChart extends LineSeriesBase {
    public static inline var TYPE:String="LineChart";
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
}
