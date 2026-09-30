package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.geom.Point;
import openfl.geom.Matrix;
class AreaChart extends LineSeriesBase {
    /** Type identifier for area charts. */
    public static inline var TYPE:String="AreaChart";
    /** Number of fill polygons drawn in the last render. */
    public var fillPolygonCount(default,null):Int=0;
    var fills:Sprite;
    /** Creates an area chart with optional configuration. */
    public function new(data:Dynamic=null) { super(data); }
    override function get_chartType():String { return TYPE; }
    override function includeZero(axis:String):Bool { return axis=="y"; }
    /** Creates the area fill layer and applies area chart defaults. */
    override public function initialize():Void {
        super.initialize(); if(!Reflect.hasField(config,"fillAlpha")) config.fillAlpha=0.3; config.baseline=0;
        fills=new Sprite(); fills.mouseEnabled=false; fills.mouseChildren=false; gridLayer.addChild(fills);
    }
    override function validateChartPatch(patch:Dynamic,diagnostics:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,diagnostics);
        function alpha(record:Dynamic,path:String):Void {
            if(Reflect.hasField(record,"fillAlpha") && (!ChartData.finite(record.fillAlpha) || record.fillAlpha<0 || record.fillAlpha>1)) {
                Reflect.deleteField(record,"fillAlpha"); ChartData.diagnostic(diagnostics,"setting",path,"Expected fillAlpha in [0,1]");
            }
        }
        alpha(patch,"fillAlpha");
        if(Std.isOfType(patch.series,Array)) { var series:Array<Dynamic>=patch.series; for(s in series) if(ChartData.object(s)) alpha(s,"series.fillAlpha"); }
        if(Reflect.hasField(patch,"baseline") && patch.baseline!=0) { Reflect.deleteField(patch,"baseline"); ChartData.diagnostic(diagnostics,"setting","baseline","Area baseline is fixed at zero"); }
        if(Reflect.hasField(patch,"layout") && patch.layout!="overlaid") { Reflect.deleteField(patch,"layout"); ChartData.diagnostic(diagnostics,"setting","layout","Only overlaid areas are supported"); }
    }
    override function clearPlot():Void { super.clearPlot(); fillPolygonCount=0; if(fills!=null) fills.removeChildren(); }
    override function markerTextureSpec(series:Dynamic,point:Dynamic):Dynamic { return point.texture; }
    override function pointPayload(point:ChartPoint):Dynamic { var payload=super.pointPayload(point); payload.baseline=0; return payload; }
    override function drawPlot():Void {
        var baseline=valueToY(0); var series:Array<Dynamic>=config.series;
        if(baseline!=null) for(i in 0...series.length) {
            var s=series[i]; var alpha:Float=s.fillAlpha==null?config.fillAlpha:s.fillAlpha;
            if(alpha<=0) continue;
            var polygons:Array<Array<Point>>=[];
            var runs=LineGeometry.runs(points.filter(p->p.seriesIndex==i),config.categories,xAxis.scale=="linear",setting("missingBehavior",s)=="connect");
            for(run in runs) for(j in 1...run.length) {
                var a=run[j-1]; var b=run[j]; var x1=valueToX(a.x); var x2=valueToX(b.x); var y1=valueToY(a.y); var y2=valueToY(b.y);
                if(x1==null || x2==null || y1==null || y2==null || x1==x2) continue;
                var parts:Array<Array<Point>>=[];
                if((a.y<0 && b.y>0) || (a.y>0 && b.y<0)) {
                    var scale=Math.max(Math.abs(a.y),Math.abs(b.y)); var t=(Math.abs(a.y)/scale)/(Math.abs(a.y)/scale+Math.abs(b.y)/scale); var cross=x1*(1-t)+x2*t;
                    parts.push([new Point(x1,baseline),new Point(x1,y1),new Point(cross,baseline)]);
                    parts.push([new Point(cross,baseline),new Point(x2,y2),new Point(x2,baseline)]);
                } else parts.push([new Point(x1,baseline),new Point(x1,y1),new Point(x2,y2),new Point(x2,baseline)]);
                for(part in parts) { var clipped=AreaGeometry.clip(part,0,0,bounds.width,bounds.height); if(clipped.length>=3) polygons.push(clipped); }
            }
            if(polygons.length==0) continue;
            var shape=new Shape(); shape.alpha=alpha; fills.addChild(shape); var g=shape.graphics;
            g.beginFill(seriesColor(i,s)); for(polygon in polygons) AreaGeometry.draw(g,polygon); g.endFill(); fillPolygonCount+=polygons.length;
            var spec=s.texture;
            if(spec!=null && spec.key!="") {
                var bitmap=useMarkerTexture(spec.key).bitmap;
                if(bitmap!=null) {
                    // Map one texture across the entire visible plot, so gaps do not restart it.
                    var sx=bounds.width/bitmap.width; var sy=bounds.height/bitmap.height; var matrix=new Matrix(); var tx=0.; var ty=0.;
                    if(spec.mode!="tile") {
                        if(spec.mode=="fit" || spec.mode=="fill") { var scale=spec.mode=="fit"?Math.min(sx,sy):Math.max(sx,sy); sx=scale; sy=scale; }
                        tx=(bounds.width-bitmap.width*sx)/2; ty=(bounds.height-bitmap.height*sy)/2; matrix.scale(sx,sy); matrix.translate(tx,ty);
                    }
                    g.beginBitmapFill(bitmap,matrix,spec.mode=="tile",imageSmoothing);
                    for(polygon in polygons) AreaGeometry.draw(g,spec.mode=="fit"?AreaGeometry.clip(polygon,tx,ty,tx+bitmap.width*sx,ty+bitmap.height*sy):polygon);
                    g.endFill();
                }
            }
        }
        super.drawPlot();
    }
    /** Removes fill graphics and releases inherited chart resources. */
    override public function destroy():Void { if(destroyed) return; if(fills!=null) fills.removeChildren(); super.destroy(); }
}
