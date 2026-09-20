package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
class Histogram extends BarColumnChartBase {
    public static inline var TYPE:String="Histogram";
    public var bins(get,never):Array<Dynamic>;
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
    function get_bins():Array<Dynamic> { return [for(p in points) ChartData.copy(p.source)]; }
    override function defaultAxisScale(axis:String):String { return "linear"; }
    override function includeZero(axis:String):Bool { return axis=="y"; }
    override function defaultGroupGap():Float { return 0; }
    override function supportsLayout(value:String):Bool { return value=="single"; }
    override function initializeRectangleData():Void { if(!Reflect.hasField(config,"data")) config.data=[]; }
    override function legendItems():Array<Dynamic> { return []; }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        for(field in ["binCount","binWidth"]) if(Reflect.hasField(patch,field)) {
            var v:Dynamic=Reflect.field(patch,field); var valid=v==null || (ChartData.finite(v) && v>0 && (field!="binCount" || (Math.floor(v)==v && v<=10000)));
            if(!valid) { Reflect.deleteField(patch,field); ChartData.diagnostic(diagnostics,"setting",field,"Invalid bin setting; previous retained"); }
        }
        if(Reflect.hasField(patch,"texture") && !ChartBase.validTexture(patch.texture)) { Reflect.deleteField(patch,"texture"); ChartData.diagnostic(diagnostics,"setting","texture","Invalid bin texture"); }
        if(Reflect.hasField(patch,"color") && !ChartBase.color(patch.color)) { Reflect.deleteField(patch,"color"); ChartData.diagnostic(diagnostics,"setting","color","Invalid bin color"); }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        var c=result.config;
        for(field in ["series","categories","rows","columns"]) if(Reflect.hasField(c,field)) { ChartData.diagnostic(result.diagnostics,"structure",field,"Histogram requires raw data"); return false; }
        if(c.binCount!=null && c.binWidth!=null) { ChartData.diagnostic(result.diagnostics,"structure","","Choose binCount or binWidth"); return false; }
        var data:Array<Dynamic>=c.data==null?[]:c.data;
        for(v in data) if(ChartData.object(v) || Std.isOfType(v,Array)) { ChartData.diagnostic(result.diagnostics,"structure","data","Expected raw observations"); return false; }
        try { result.points=HistogramBins.calculate(data,c.binCount,c.binWidth); }
        catch(error:Dynamic) { ChartData.diagnostic(result.diagnostics,"structure","data",Std.string(error)); return false; }
        if(config.binCount!=c.binCount || config.binWidth!=c.binWidth) lastNormalization=-1;
        return true;
    }
    override function axisValues(axis:String):Array<Float> { return axis=="x"?[for(p in points) p.source.lowerBound].concat(points.length==0?[]:[points[points.length-1].source.upperBound]):[for(p in points) p.value]; }
    override function rectangleBand(p:ChartPoint):Null<{center:Float,band:Float}> {
        var lower:Float=Math.max(xScale.minimum,p.source.lowerBound); var upper:Float=Math.min(xScale.maximum,p.source.upperBound);
        if(lower>=upper) return null; var a=valueToX(lower); var b=valueToX(upper); if(a==null || b==null) return null;
        return {center:a/2+b/2,band:b-a};
    }
    override public function seriesColor(index:Int,series:Dynamic=null,point:Dynamic=null):Int { return config.color==null?super.seriesColor(0):config.color; }
    override function textureFor(series:Dynamic,point:Dynamic):Dynamic { return config.texture; }
    override function pointPayload(point:ChartPoint):Dynamic {
        var payload=super.pointPayload(point); payload.lowerBound=point.source.lowerBound; payload.upperBound=point.source.upperBound; payload.count=point.value; payload.observationIndices=ChartData.copy(point.source.observationIndices); return payload;
    }
}
