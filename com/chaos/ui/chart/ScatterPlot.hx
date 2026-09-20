package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
/** Numeric points in input order, with shared marker rendering and no connecting strokes. */
class ScatterPlot extends LineSeriesBase {
    public static inline var TYPE:String="ScatterPlot";
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function defaultAxisScale(axis:String):String { return "linear"; }
    override function connectsPoints():Bool { return false; }
    override function defaultSetting(field:String):Dynamic { return field=="lineWidth"?0:super.defaultSetting(field); }
    override function seriesRuns(index:Int,series:Dynamic):Array<Array<ChartPoint>> { return [points.filter(p->p.seriesIndex==index && !p.gap)]; }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        if(Reflect.hasField(patch,"xAxis") && patch.xAxis.scale!="linear") { Reflect.deleteField(patch,"xAxis"); ChartData.diagnostic(diagnostics,"axis","xAxis","Scatter requires linear X"); }
        if(Reflect.hasField(patch,"lineWidth") && patch.lineWidth!=0) { Reflect.deleteField(patch,"lineWidth"); ChartData.diagnostic(diagnostics,"setting","lineWidth","Scatter has no connecting strokes"); }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        if(!super.validateNormalizedData(result)) return false;
        result.points=result.points.filter(function(p) {
            if(p.gap) { ChartData.diagnostic(result.diagnostics,"value","series.points["+p.dataIndex+"]","Scatter requires finite X and Y"); return false; }
            return true;
        });
        return true;
    }
}
