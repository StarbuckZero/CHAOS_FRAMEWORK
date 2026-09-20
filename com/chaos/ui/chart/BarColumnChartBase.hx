package com.chaos.ui.chart;

import com.chaos.ui.chart.ChartTypes;
import com.chaos.ui.chart.RectangleLayout.RectangleMark;
import com.chaos.ui.UIStyleManager;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

typedef RenderedRectangle = { var point:ChartPoint; var rectangle:RectangleMark; }

/** Shared single, grouped, and stacked rectangular-series renderer. */
class BarColumnChartBase extends CartesianChartBase {
    public var orientation(get, never):String;
    public var rectangles(get, never):Array<RenderedRectangle>;
    public var markTextureCount(get, never):Int;
    var marks:Array<RenderedRectangle>;
    var stacks:Map<String,StackLayout.StackSegment>;
    var markTextures:Map<String,ChartTexture>;
    var usedTextures:Map<String,Bool>;
    var valueLabels:Array<TextField>;
    var valueLabelLayer:Sprite;

    public function new(data:Dynamic = null) { super(data); }
    function get_orientation():String { return "vertical"; }
    function defaultLayout():String { return "single"; }
    function supportsLayout(value:String):Bool { return value == "single" || value == "grouped" || value == "stacked"; }
    function get_rectangles():Array<RenderedRectangle> { return cast ChartData.copy(marks); }
    function get_markTextureCount():Int { var n = 0; for (_ in markTextures) n++; return n; }
    function ensureRenderer():Void {
        if (marks == null) marks = [];
        if (stacks == null) stacks = new Map();
        if (markTextures == null) markTextures = new Map();
        if (valueLabels == null) valueLabels = [];
    }
    override function defaultAxisScale(axis:String):String {
        return axis == (orientation == "vertical" ? "x" : "y") ? "categorical" : "linear";
    }
    override function includeZero(axis:String):Bool { return defaultAxisScale(axis) == "linear"; }
    override function axisValues(axis:String):Array<Float> {
        if(defaultAxisScale(axis)!="linear") return [];
        if(config.layout=="stacked") {
            var values:Array<Float>=[0];
            for(s in stacks) { values.push(s.start); values.push(s.end); }
            return values;
        }
        return [for(p in points) if(!p.gap && p.value!=null) p.value];
    }
    override function validateChartPatch(patch:Dynamic,validation:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,validation);
        if(Reflect.hasField(patch,"stackMode") && patch.stackMode!="raw" && patch.stackMode!="percent") {
            Reflect.deleteField(patch,"stackMode"); ChartData.diagnostic(validation,"setting","stackMode","Expected raw or percent; previous value retained");
        }
        for (field in ["groupGap","barGap"]) if (Reflect.hasField(patch,field)) {
            var value=Reflect.field(patch,field);
            if (!ChartData.finite(value) || value<0 || value>=1) {
                Reflect.deleteField(patch,field); ChartData.diagnostic(validation,"setting",field,"Expected fraction in [0,1); previous value retained");
            }
        }
        if (Reflect.hasField(patch,"layout") && !supportsLayout(patch.layout)) {
            Reflect.deleteField(patch,"layout"); ChartData.diagnostic(validation,"setting","layout","Unsupported layout; previous value retained");
        }
        if (Reflect.hasField(patch,"orientation") && patch.orientation != orientation) {
            Reflect.deleteField(patch,"orientation"); ChartData.diagnostic(validation,"setting","orientation","Orientation is fixed by component type");
        }
        for (axis in ["x","y"]) {
            var key = axis+"Axis";
            if (Reflect.hasField(patch,key) && Reflect.field(patch,key).scale != defaultAxisScale(axis)) {
                Reflect.deleteField(patch,key); ChartData.diagnostic(validation,"axis",key,"This component requires a " + defaultAxisScale(axis) + " axis");
            }
        }
        if (Reflect.hasField(patch,"series") && Std.isOfType(patch.series,Array)) {
            var series:Array<Dynamic> = patch.series;
            for (s in series) if (ChartData.object(s)) {
                validateMarkStyle(s,"series",validation);
                if (Std.isOfType(s.points,Array)) {
                    var values:Array<Dynamic> = s.points;
                    for (p in values) if (ChartData.object(p)) validateMarkStyle(p,"series.points",validation);
                }
            }
        }
    }
    function validateMarkStyle(record:Dynamic,path:String,validation:Array<ChartDiagnostic>):Void {
        if (Reflect.hasField(record,"color") && record.color != null && !ChartBase.color(record.color)) {
            Reflect.deleteField(record,"color"); ChartData.diagnostic(validation,"setting",path+".color","Invalid color; fallback used");
        }
        if (Reflect.hasField(record,"texture") && !ChartBase.validTexture(record.texture)) {
            Reflect.deleteField(record,"texture"); ChartData.diagnostic(validation,"setting",path+".texture","Invalid texture; fallback used");
        }
    }
    override function validateNormalizedData(result:ChartNormalization):Bool {
        var candidate = result.config;
        if (Reflect.hasField(candidate,"data") || Reflect.hasField(candidate,"rows") || Reflect.hasField(candidate,"columns")) {
            ChartData.diagnostic(result.diagnostics,"structure","","Column/bar input requires categories and series, not data/rows/columns"); return false;
        }
        var series:Array<Dynamic> = Reflect.hasField(candidate,"series") ? candidate.series : [];
        if (series.length > 1 && (candidate.layout == null ? defaultLayout() : candidate.layout) == "single") {
            ChartData.diagnostic(result.diagnostics,"structure","series","Single layout accepts at most one series"); return false;
        }
        for (s in series) {
            var values:Array<Dynamic> = s.points;
            for (p in values) if (Reflect.hasField(p,"x") || Reflect.hasField(p,"y") || Reflect.hasField(p,"rowId") || Reflect.hasField(p,"columnId")) {
                ChartData.diagnostic(result.diagnostics,"structure","series.points","Expected categoryId/value points, not XY or cells"); return false;
            }
        }
        var accepted:Array<ChartPoint> = [];
        for (p in result.points) {
            if (p.gap || !Std.isOfType(p.source.categoryId,String) || p.source.categoryId == "") {
                ChartData.diagnostic(result.diagnostics,"value","series.points["+p.dataIndex+"]","Column requires a finite value and categoryId"); continue;
            }
            accepted.push(p);
        }
        var layout=candidate.layout==null?defaultLayout():candidate.layout;
        var nextStacks:Map<String,StackLayout.StackSegment>=new Map();
        if(layout=="stacked") {
            try { nextStacks=StackLayout.calculate(accepted,candidate.stackMode=="percent"); }
            catch(error:Dynamic) { ChartData.diagnostic(result.diagnostics,"structure","series",Std.string(error)); return false; }
        }
        stacks=nextStacks;
        // Layout/mode changes alter domains even when the data arrays are retained.
        if(config.layout!=candidate.layout || config.stackMode!=candidate.stackMode) lastNormalization=-1;
        result.points = accepted;
        return true;
    }
    override public function initialize():Void {
        ensureRenderer(); super.initialize();
        if (!Reflect.hasField(config,"groupGap")) config.groupGap = defaultGroupGap();
        initializeRectangleData();
        if (!Reflect.hasField(config,"stackMode")) config.stackMode="raw";
        if (!Reflect.hasField(config,"barGap")) config.barGap = 0.1;
        if (!Reflect.hasField(config,"layout")) config.layout = defaultLayout(); config.orientation = orientation;
        valueLabelLayer = new Sprite(); valueLabelLayer.mouseEnabled = false; valueLabelLayer.mouseChildren = false;
        labelLayer.addChild(valueLabelLayer);
    }
    override function clearPlot():Void {
        ensureRenderer(); marks = []; usedTextures = new Map();
        for (field in valueLabels) field.visible = false;
        valueLabelLayer.x = bounds.x; valueLabelLayer.y = bounds.y;
        valueLabelLayer.scrollRect = new Rectangle(0,0,bounds.width,bounds.height);
        if (bounds.width <= 0 || bounds.height <= 0) { releaseTextures(); trimLabels(0); }
    }
    function defaultGroupGap():Float { return 0.2; }
    function initializeRectangleData():Void {
        if(!Reflect.hasField(config,"series")) config.series=[];
        if(!Reflect.hasField(config,"categories")) config.categories=[];
    }
    function rectangleBand(p:ChartPoint):Null<{center:Float,band:Float}> {
        var center=categoryScale().map(p.source.categoryId); return center==null?null:{center:center,band:categoryScale().bandWidth};
    }
    function valueScale():ChartScale { return orientation == "vertical" ? yScale : xScale; }
    function categoryScale():ChartScale { return orientation == "vertical" ? xScale : yScale; }
    override function drawPlot():Void {
        var scale = valueScale(); var categorical = categoryScale();
        var baseline = scale.map(Math.max(scale.minimum,Math.min(scale.maximum,0)));
        var hit:Array<ChartHitRegion> = []; var labelCount = 0;
        var allSeries:Array<Dynamic> = config.series==null?[]:config.series;
        for (p in points) {
            var placement=rectangleBand(p); if(placement==null) continue;
            var center = placement.center;
            if (center == null || baseline == null || p.value == null) continue;
            // Clamp in data space first, avoiding huge off-screen coordinates for explicit ranges.
            var segment=config.layout=="stacked"?stacks.get(StackLayout.key(p)):null;
            var startValue=segment==null?0:segment.start;
            var endValue=segment==null?p.value:segment.end;
            if (Math.max(startValue,endValue) < scale.minimum || Math.min(startValue,endValue) > scale.maximum) continue;
            var start=scale.map(Math.max(scale.minimum,Math.min(scale.maximum,startValue)));
            var end=scale.map(Math.max(scale.minimum,Math.min(scale.maximum,endValue)));
            if (end == null) continue;
            var band=placement.band; var gap:Float=config.groupGap;
            if (config.layout == "grouped") {
                var slot=RectangleLayout.groupSlot(center,band,allSeries.length,p.seriesIndex,config.groupGap);
                if (slot == null) continue;
                center=slot.center; band=slot.band; gap=config.barGap;
            }
            var rect = RectangleLayout.segment(center,band,start,end,gap,orientation);
            if (rect == null) continue;
            var series:Dynamic = p.seriesIndex >= 0 && p.seriesIndex < allSeries.length ? allSeries[p.seriesIndex] : null;
            var markColor = seriesColor(p.seriesIndex,series,p.source);
            if (rect.width > 0 && rect.height > 0) {
                marks.push({point:p,rectangle:rect});
                dataLayer.graphics.beginFill(markColor); dataLayer.graphics.drawRect(rect.x,rect.y,rect.width,rect.height); dataLayer.graphics.endFill();
                var clipped = new Rectangle(rect.x,rect.y,rect.width,rect.height).intersection(new Rectangle(0,0,bounds.width,bounds.height));
                if (clipped.width > 0 && clipped.height > 0) hit.push({bounds:clipped,payload:pointPayload(p)});
                var spec:Dynamic = textureFor(series,p.source);
                if (spec != null && spec.key != "") {
                    var texture = useTexture(spec.key);
                    texture.draw(dataTextureLayer.graphics,new Rectangle(rect.x,rect.y,rect.width,rect.height),spec.mode,imageSmoothing,false);
                }
            }
            if (config.showLabels && labelCount < 100 && drawValueLabel(labelCount,p,rect,center,end,markColor)) labelCount++;
        }
        setHitRegions(hit); trimLabels(labelCount);
        var obsolete = [for (key in markTextures.keys()) if (!usedTextures.exists(key)) key];
        for (key in obsolete) { markTextures.get(key).destroy(); markTextures.remove(key); }
    }
    /** A point override wins; null falls back, while an empty key suppresses the series texture. */
    function textureFor(series:Dynamic,point:Dynamic):Dynamic {
        if (point != null && point.texture != null) return point.texture;
        return series == null ? null : series.texture;
    }
    function useTexture(key:String):ChartTexture {
        usedTextures.set(key,true);
        if (!markTextures.exists(key)) {
            var entry = new ChartTexture(); markTextures.set(key,entry);
            entry.load(key,textureResolver,function() { invalidateChart(false); draw(); },function(message) {
                var path = "series.texture["+key+"]";
                issues = issues.filter(d -> d.code != "texture" || d.path != path);
                ChartData.diagnostic(issues,"texture",path,message); invalidateChart(false); draw();
            });
        }
        return markTextures.get(key);
    }
    function drawValueLabel(index:Int,p:ChartPoint,rect:RectangleMark,center:Float,end:Float,markColor:Int):Bool {
        var axis = orientation == "vertical" ? yAxis : xAxis;
        var stack=config.layout=="stacked"?stacks.get(StackLayout.key(p)):null;
        var text = stack!=null && config.stackMode=="percent" ? ChartFormat.format(stack.normalizedValue,"percent",axis.format.decimals) : ChartFormat.format(p.value,axis.format.kind,axis.format.decimals);
        measure.text = text;
        var w = measure.textWidth+6; var h = textHeight;
        var inside = false; var x:Float; var y:Float;
        if(stack!=null) {
            if(w>rect.width-4 || h>rect.height-4) return false;
            inside=true; x=rect.x+(rect.width-w)/2; y=rect.y+(rect.height-h)/2;
        } else if (orientation == "vertical") {
            if (w > rect.width-4 || h > bounds.height) return false;
            x = center-w/2;
            y = p.value >= 0 ? end-h-3 : end+3;
            if (y < 0 || y+h > bounds.height) {
                if (rect.height < h+4) return false;
                inside = true; y = p.value >= 0 ? end+2 : end-h-2;
            }
        } else {
            if (h > rect.height-2 || w > bounds.width) return false;
            y = center-h/2; x = p.value >= 0 ? end+3 : end-w-3;
            if (x < 0 || x+w > bounds.width) {
                if (rect.width < w+4) return false;
                inside = true; x = p.value >= 0 ? end-w-2 : end+2;
            }
        }
        while (valueLabels.length <= index) {
            var field = new TextField(); field.selectable = false; field.mouseEnabled = false; valueLabelLayer.addChild(field); valueLabels.push(field);
        }
        var field = valueLabels[index];
        var luminance = ((markColor >> 16) & 255)*0.299 + ((markColor >> 8) & 255)*0.587 + (markColor & 255)*0.114;
        var textColor:Int = inside ? (luminance < 150 ? 0xFFFFFF : 0x222222) : style("labelColor",UIStyleManager.CHART_LABEL_COLOR,0x333333);
        field.defaultTextFormat = new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),Std.int(style("fontSize",UIStyleManager.CHART_FONT_SIZE,12)),textColor,null,null,null,null,null,TextFormatAlign.CENTER);
        field.text = text; field.x = x; field.y = y; field.width = w; field.height = h; field.visible = true;
        return true;
    }
    override function retained(payload:Dynamic):Dynamic {
        var current=super.retained(payload);
        // Zero-height rectangles have no drawable or interactive mark.
        return current!=null && current.value!=0?current:null;
    }
    override function pointPayload(point:ChartPoint):Dynamic {
        var payload=super.pointPayload(point);
        if(config.layout=="stacked" && stacks!=null) {
            var s=stacks.get(StackLayout.key(point));
            if(s!=null) {
                payload.rawValue=point.value; payload.normalizedValue=s.normalizedValue;
                payload.positiveTotal=s.positiveTotal; payload.negativeTotal=s.negativeTotal; payload.signedTotal=s.signedTotal;
            }
        }
        return payload;
    }
    function trimLabels(count:Int):Void { while (valueLabels.length > count) valueLabelLayer.removeChild(valueLabels.pop()); }
    function releaseTextures():Void {
        ensureRenderer(); for (texture in markTextures) texture.destroy(); markTextures = new Map();
    }
    override public function reskin():Void { releaseTextures(); super.reskin(); }
    override function set_textureResolver(value:ChartTextureResolver):ChartTextureResolver {
        if (!destroyed) releaseTextures(); return super.set_textureResolver(value);
    }
    override public function destroy():Void {
        if (destroyed) return;
        releaseTextures(); marks = []; valueLabels = []; stacks = new Map();
        if (valueLabelLayer != null) valueLabelLayer.removeChildren();
        super.destroy();
    }
}
