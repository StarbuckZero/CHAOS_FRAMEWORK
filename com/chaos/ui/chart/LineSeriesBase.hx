package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
import openfl.geom.Rectangle;
typedef LineMark={var point:ChartPoint; var x:Float; var y:Float; var radius:Float; var shape:String;}
/** Shared straight-series renderer for line and future area charts. */
class LineSeriesBase extends CartesianChartBase {
    public var lineSegmentCount(default,null):Int=0;
    public var renderedPoints(get,never):Array<LineMark>;
    public var markerTextureCount(get,never):Int;
    var lineMarks:Array<LineMark>;
    var markerTextures:Map<String,ChartTexture>;
    var usedTextures:Map<String,Bool>;
    public function new(data:Dynamic=null) { super(data); }
    function get_renderedPoints():Array<LineMark> { return cast ChartData.copy(lineMarks); }
    function get_markerTextureCount():Int { var n=0; for(_ in markerTextures) n++; return n; }
    function ensureLine():Void { if(lineMarks==null) lineMarks=[]; if(markerTextures==null) markerTextures=new Map(); }
    override public function initialize():Void {
        ensureLine(); super.initialize();
        for(field in ["series","categories"]) if(!Reflect.hasField(config,field)) Reflect.setField(config,field,[]);
        for(field in ["lineWidth","markerSize","markerShape","missingBehavior"]) if(!Reflect.hasField(config,field)) Reflect.setField(config,field,defaultSetting(field));
    }
    function defaultSetting(field:String):Dynamic { return switch(field) { case "lineWidth":2; case "markerSize":6; case "markerShape":"circle"; default:"gap"; }; }
    function setting(field:String,series:Dynamic,point:Dynamic=null):Dynamic {
        if(point!=null && Reflect.hasField(point,field)) return Reflect.field(point,field);
        return Reflect.hasField(series,field)?Reflect.field(series,field):Reflect.field(config,field);
    }
    function validateSettings(record:Dynamic,path:String,validation:Array<ChartDiagnostic>):Void {
        for(field in ["lineWidth","markerSize","markerShape","missingBehavior","color","texture"]) if(Reflect.hasField(record,field)) {
            var value:Dynamic=Reflect.field(record,field);
            var valid=switch(field) {
                case "lineWidth","markerSize":ChartData.finite(value) && value>=0 && value<=1024;
                case "markerShape":["circle","square","diamond"].indexOf(value)>=0;
                case "missingBehavior":value=="gap" || value=="connect";
                case "color":value==null || ChartBase.color(value);
                default:ChartBase.validTexture(value);
            };
            if(!valid) { Reflect.deleteField(record,field); ChartData.diagnostic(validation,"setting",path+field,"Invalid line/marker setting; fallback retained"); }
        }
    }
    override function validateChartPatch(patch:Dynamic,validation:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,validation); validateSettings(patch,"",validation);
        if(Reflect.hasField(patch,"yAxis") && patch.yAxis.scale!="linear") { Reflect.deleteField(patch,"yAxis"); ChartData.diagnostic(validation,"axis","yAxis","Line values require linear Y"); }
        if(Std.isOfType(patch.series,Array)) {
            var series:Array<Dynamic>=patch.series;
            for(s in series) if(ChartData.object(s)) {
                validateSettings(s,"series.",validation);
                if(Std.isOfType(s.points,Array)) { var values:Array<Dynamic>=s.points; for(p in values) if(ChartData.object(p)) validateSettings(p,"points.",validation); }
            }
        }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        var c=result.config;
        if(Reflect.hasField(c,"data") || Reflect.hasField(c,"rows") || Reflect.hasField(c,"columns")) { ChartData.diagnostic(result.diagnostics,"structure","","Line input requires series"); return false; }
        var numeric=c.xAxis==null?defaultAxisScale("x")=="linear":c.xAxis.scale=="linear";
        var series:Array<Dynamic>=c.series==null?[]:c.series;
        for(s in series) { var values:Array<Dynamic>=s.points; for(p in values) {
            var valid=numeric?Reflect.hasField(p,"x") && Reflect.hasField(p,"y") && !Reflect.hasField(p,"categoryId"):Reflect.hasField(p,"categoryId") && Reflect.hasField(p,"value") && !Reflect.hasField(p,"x") && !Reflect.hasField(p,"y");
            if(!valid || Reflect.hasField(p,"rowId") || Reflect.hasField(p,"columnId")) { ChartData.diagnostic(result.diagnostics,"structure","series.points","Point shape must match the X axis scale"); return false; }
        } }
        return true;
    }
    override function clearPlot():Void {
        ensureLine(); lineMarks=[]; lineSegmentCount=0; usedTextures=new Map();
        if(bounds.width<=0 || bounds.height<=0) releaseMarkerTextures();
    }
    function connectsPoints():Bool { return true; }
    function seriesRuns(index:Int,series:Dynamic):Array<Array<ChartPoint>> { return LineGeometry.runs(points.filter(p->p.seriesIndex==index),config.categories,xAxis.scale=="linear",setting("missingBehavior",series)=="connect"); }
    override function drawPlot():Void {
        var series:Array<Dynamic>=config.series; var hit:Array<ChartHitRegion>=[];
        for(i in 0...series.length) {
            var s=series[i]; var runs=seriesRuns(i,s);
            for(run in runs) {
                var previous:LineMark=null;
                for(p in run) {
                    var x=valueToX(p.x); var y=valueToY(p.y);
                    if(x==null || y==null) { previous=null; continue; }
                    var radius:Float=setting("markerSize",s,p.source)/2; var shape:String=setting("markerShape",s,p.source);
                    var mark:LineMark={point:p,x:x,y:y,radius:radius,shape:shape};
                    var width:Float=setting("lineWidth",s);
                    if(connectsPoints() && previous!=null && width>0) {
                        var segment=LineGeometry.clip(previous.x,previous.y,x,y,bounds.width,bounds.height);
                        if(segment!=null) { dataLayer.graphics.lineStyle(width,seriesColor(i,s)); dataLayer.graphics.moveTo(segment[0],segment[1]); dataLayer.graphics.lineTo(segment[2],segment[3]); lineSegmentCount++; }
                    }
                    previous=mark;
                    if(x<0 || y<0 || x>bounds.width || y>bounds.height) continue;
                    lineMarks.push(mark);
                    var target=Math.max(4,radius);
                    hit.push({bounds:new Rectangle(x-target,y-target,target*2,target*2),payload:pointPayload(p)});
                }
            }
        }
        // Draw all markers after all strokes so joins never cover point overrides.
        for(mark in lineMarks) if(mark.radius>0) {
            var p=mark.point; var s=series[p.seriesIndex];
            var box=new Rectangle(mark.x-mark.radius,mark.y-mark.radius,mark.radius*2,mark.radius*2);
            dataTextureLayer.graphics.lineStyle(); dataTextureLayer.graphics.beginFill(seriesColor(p.seriesIndex,s,p.source)); MarkerGeometry.draw(dataTextureLayer.graphics,box,mark.shape); dataTextureLayer.graphics.endFill();
            var spec=markerTextureSpec(s,p.source);
            if(spec!=null && spec.key!="") useMarkerTexture(spec.key).draw(dataTextureLayer.graphics,box,spec.mode,imageSmoothing,false,mark.shape);
        }
        setHitRegions(hit);
        var obsolete=[for(key in markerTextures.keys()) if(!usedTextures.exists(key)) key];
        for(key in obsolete) { markerTextures.get(key).destroy(); markerTextures.remove(key); }
    }
    override function hitTestMark(x:Float,y:Float):Dynamic {
        var i=lineMarks.length;
        while(i-->0) { var mark=lineMarks[i]; if(MarkerGeometry.contains(x-mark.x,y-mark.y,Math.max(4,mark.radius),mark.shape)) return pointPayload(mark.point); }
        return null;
    }
    function markerTextureSpec(series:Dynamic,point:Dynamic):Dynamic { return point.texture!=null?point.texture:series.texture; }
    function useMarkerTexture(key:String):ChartTexture {
        usedTextures.set(key,true);
        if(!markerTextures.exists(key)) {
            var texture=new ChartTexture(); markerTextures.set(key,texture);
            texture.load(key,textureResolver,function(){invalidateChart(false);draw();},function(message){
                issues=issues.filter(d->d.path!="marker.texture["+key+"]"); ChartData.diagnostic(issues,"texture","marker.texture["+key+"]",message); invalidateChart(false);draw();
            });
        }
        return markerTextures.get(key);
    }
    function releaseMarkerTextures():Void { ensureLine(); for(t in markerTextures) t.destroy(); markerTextures=new Map(); }
    override public function reskin():Void { releaseMarkerTextures(); super.reskin(); }
    override function set_textureResolver(value:ChartTextureResolver):ChartTextureResolver { if(!destroyed) releaseMarkerTextures(); return super.set_textureResolver(value); }
    override public function destroy():Void { if(destroyed) return; releaseMarkerTextures(); lineMarks=[]; super.destroy(); }
}
