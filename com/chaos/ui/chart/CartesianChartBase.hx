package com.chaos.ui.chart;

import com.chaos.ui.chart.ChartAxis.ChartAxisConfig;
import com.chaos.ui.chart.ChartScale.ChartTick;
import com.chaos.ui.chart.ChartTypes.ChartDiagnostic;
import com.chaos.ui.UIStyleManager;
import openfl.display.Shape;
import openfl.geom.Rectangle;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/** Shared Cartesian axes only. Concrete charts supply mark geometry and domain policies. */
class CartesianChartBase extends ChartBase {
    public var xScale(get, never):ChartScale;
    public var yScale(get, never):ChartScale;
    public var xAxis(get, never):ChartAxisConfig;
    public var yAxis(get, never):ChartAxisConfig;
    public var scaleBuildCount(default, null):Int = 0;
    var horizontal:ChartScale;
    var vertical:ChartScale;
    var lastNormalization:Int = -1;
    var xTicks:Array<ChartTick>;
    var yTicks:Array<ChartTick>;
    var axisShape:Shape;
    var axisLabels:Array<TextField>;
    var measure:TextField;
    var textHeight:Float;
    var yLabelWidth:Float;
    var xLabelHeight:Float;
    var leftTitleWidth:Float;
    var bottomTitleHeight:Float;

    public function new(data:Dynamic = null) { super(data); }
    override function get_chartType():String { return "CartesianChartBase"; }
    function get_xScale():ChartScale { return horizontal; }
    function get_yScale():ChartScale { return vertical; }
    function get_xAxis():ChartAxisConfig { return cast ChartData.copy(config.xAxis); }
    function get_yAxis():ChartAxisConfig { return cast ChartData.copy(config.yAxis); }
    /** Call when a subclass changes a domain policy such as stacking mode. */
    public function invalidateScales():Void { if (destroyed) return; lastNormalization = -1; invalidateChart(true); }
    function defaultAxisScale(axis:String):String { return axis == "x" ? "categorical" : "linear"; }
    function includeZero(axis:String):Bool { return false; }
    function axisValues(axis:String):Array<Float> {
        var values:Array<Float> = [];
        for (p in points) if (axis == "x" || !p.gap) {
            var value:Dynamic = axis == "x" ? p.x : p.y;
            if (ChartScale.finite(value)) values.push(value);
        }
        return values;
    }
    function axisCategories(axis:String):Array<{id:String,label:String}> {
        var key = axis == "x" && Reflect.hasField(config,"columns") ? "columns" : axis == "y" && Reflect.hasField(config,"rows") ? "rows" : "categories";
        var result:Array<{id:String,label:String}> = [];
        if (Reflect.hasField(config,key)) {
            var values:Array<Dynamic> = Reflect.field(config,key);
            for (value in values) result.push({id:value.id,label:Reflect.hasField(value,"label") ? Std.string(value.label) : value.id});
        }
        return result;
    }
    override function validateChartPatch(patch:Dynamic,validation:Array<ChartDiagnostic>):Void {
        super.validateChartPatch(patch,validation);
        for (axis in ["x","y"]) {
            var key = axis+"Axis";
            if (!Reflect.hasField(patch,key)) continue;
            try {
                if (Lambda.exists(validation,d -> d.code == "number" && StringTools.startsWith(d.path,"."+key+"."))) throw "Axis values must be finite";
                var parsed = ChartAxis.parse(Reflect.field(patch,key),defaultAxisScale(axis));
                if (parsed.scale == "categorical" && (parsed.minimum != null || parsed.maximum != null || parsed.interval != null)) {
                    parsed.minimum = null; parsed.maximum = null; parsed.interval = null;
                    ChartData.diagnostic(validation,"axis",key,"Numeric bounds/interval ignored for categorical axis");
                }
                Reflect.setField(patch,key,parsed);
            } catch (error:Dynamic) {
                Reflect.deleteField(patch,key);
                ChartData.diagnostic(validation,"axis",key,Std.string(error)+"; previous axis retained");
            }
        }
    }
    override public function initialize():Void {
        super.initialize();
        axisShape = new Shape(); labelLayer.addChild(axisShape);
        axisLabels = []; measure = new TextField(); measure.selectable = false;
    }
    function buildScale(axis:String):ChartScale {
        var key = axis+"Axis";
        if (!Reflect.hasField(config,key)) Reflect.setField(config,key,ChartAxis.defaults(defaultAxisScale(axis)));
        var cfg:ChartAxisConfig = Reflect.field(config,key);
        if (cfg.scale == "categorical") return ChartScale.categorical(axisCategories(axis));
        return ChartScale.linear(axisValues(axis),cfg.minimum,cfg.maximum,includeZero(axis),cfg.interval);
    }
    override function calculateLayout():Void {
        super.calculateLayout();
        if (horizontal == null || vertical == null || lastNormalization != normalizationCount) {
            for (axis in ["x","y"]) {
                var scale:ChartScale;
                try { scale = buildScale(axis); }
                catch (error:Dynamic) {
                    ChartData.diagnostic(issues,"axis",axis+"Axis",Std.string(error));
                    // Recover to a finite automatic domain; never hand Infinity to Graphics.
                    Reflect.setField(config,axis+"Axis",ChartAxis.defaults(defaultAxisScale(axis)));
                    scale = buildScale(axis);
                }
                if (axis == "x") horizontal = scale; else vertical = scale;
            }
            lastNormalization = normalizationCount; scaleBuildCount++;
        }
        xTicks = horizontal.ticks(); yTicks = vertical.ticks();
        var xa:ChartAxisConfig = config.xAxis; var ya:ChartAxisConfig = config.yAxis;
        var fontSize:Float = style("fontSize",UIStyleManager.CHART_FONT_SIZE,12);
        measure.defaultTextFormat = new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),Std.int(Math.max(1,fontSize)),0);
        measure.text = "Mg"; textHeight = Math.ceil(measure.textHeight+4);
        yLabelWidth = 0;
        if (ya.showLabels) for (tick in yTicks) { measure.text = tickLabel(tick,ya); yLabelWidth = Math.max(yLabelWidth,measure.textWidth+5); }
        if (ya.showLabels && yTicks.length>0) yLabelWidth=Math.max(12,yLabelWidth);
        yLabelWidth = Math.min(yLabelWidth,Math.min(180,chromeBounds.width*0.3));
        xLabelHeight = xa.showLabels && xTicks.length > 0 ? textHeight : 0;
        leftTitleWidth = ya.title == "" ? 0 : textHeight+4;
        bottomTitleHeight = xa.title == "" ? 0 : textHeight+4;
        var left = Math.min(chromeBounds.width*0.45,yLabelWidth+leftTitleWidth+(ya.showTicks ? 8 : 4));
        var bottom = Math.min(chromeBounds.height*0.45,xLabelHeight+bottomTitleHeight+(xa.showTicks ? 8 : 4));
        // Hide decorations that cannot fit rather than letting titles escape tiny charts.
        if (leftTitleWidth+7 > left) leftTitleWidth = 0;
        yLabelWidth = Math.min(yLabelWidth,Math.max(0,left-leftTitleWidth-7));
        var availableBottom = Math.max(0,bottom-8);
        if (xLabelHeight > availableBottom) xLabelHeight = 0;
        availableBottom -= xLabelHeight;
        if (bottomTitleHeight > availableBottom) bottomTitleHeight = 0;
        var top = Math.min(chromeBounds.height*0.1,ya.showLabels ? textHeight/2 : 0);
        var right = Math.min(chromeBounds.width*0.1,xa.showLabels ? 8 : 0);
        bounds.setTo(chromeBounds.x+left,chromeBounds.y+top,Math.max(0,chromeBounds.width-left-right),Math.max(0,chromeBounds.height-top-bottom));
        horizontal = horizontal.withRange(0,bounds.width);
        vertical = vertical.withRange(ya.scale == "linear" ? bounds.height : 0,ya.scale == "linear" ? 0 : bounds.height);
        updatePlotLayers();
    }
    /** Plot-local coordinates. Unknown categories/nonfinite values return null. */
    public function valueToX(value:Dynamic):Null<Float> { return horizontal.map(value); }
    public function valueToY(value:Dynamic):Null<Float> { return vertical.map(value); }
    public function xToValue(pixel:Float):Dynamic { return horizontal.invert(pixel); }
    public function yToValue(pixel:Float):Dynamic { return vertical.invert(pixel); }
    function tickLabel(tick:ChartTick,axis:ChartAxisConfig):String {
        return axis.scale == "categorical" ? tick.label : ChartFormat.format(tick.value,axis.format.kind,axis.format.decimals);
    }
    override function drawGrid():Void {
        var xa:ChartAxisConfig = config.xAxis; var ya:ChartAxisConfig = config.yAxis;
        var color:Int = style("gridColor",UIStyleManager.CHART_GRID_COLOR,0xDDDDDD);
        var alpha:Float = style("gridAlpha",UIStyleManager.CHART_GRID_ALPHA,0.6);
        var g = gridLayer.graphics; g.lineStyle(1,color,alpha);
        if (xa.showGrid) for (tick in xTicks) { var p = valueToX(tick.value); if (p != null) { g.moveTo(p,0); g.lineTo(p,bounds.height); } }
        if (ya.showGrid) for (tick in yTicks) { var p = valueToY(tick.value); if (p != null) { g.moveTo(0,p); g.lineTo(bounds.width,p); } }
        g.lineStyle(1,style("axisColor",UIStyleManager.CHART_AXIS_COLOR,0x666666));
        if (xa.scale == "linear" && xa.showZeroLine && horizontal.minimum <= 0 && horizontal.maximum >= 0) {
            var p = valueToX(0); if (p != null) { g.moveTo(p,0); g.lineTo(p,bounds.height); }
        }
        if (ya.scale == "linear" && ya.showZeroLine && vertical.minimum <= 0 && vertical.maximum >= 0) {
            var p = valueToY(0); if (p != null) { g.moveTo(0,p); g.lineTo(bounds.width,p); }
        }
    }
    function clippedLabel(text:String,width:Float):String {
        measure.text = text;
        if (measure.textWidth+4 <= width) return text;
        var low = 0; var high = text.length;
        while (low < high) {
            var mid = Std.int(Math.ceil((low+high)/2)); measure.text = text.substr(0,mid)+"...";
            if (measure.textWidth+4 <= width) low = mid; else high = mid-1;
        }
        measure.text = "...";
        return measure.textWidth+4 <= width ? text.substr(0,low)+"..." : "";
    }
    function useLabel(index:Int,text:String,x:Float,y:Float,width:Float,height:Float,align:String = "left",rotation:Float = 0):Void {
        while (axisLabels.length <= index) axisLabels.push(textField());
        var field = axisLabels[index]; field.rotation = 0; field.visible = true;
        field.defaultTextFormat = new TextFormat(style("font",UIStyleManager.CHART_FONT,"_sans"),Std.int(style("fontSize",UIStyleManager.CHART_FONT_SIZE,12)),style("labelColor",UIStyleManager.CHART_LABEL_COLOR,0x333333),null,null,null,null,null,align);
        field.text = clippedLabel(text,Math.max(0,width));
        field.width = Math.max(0,width); field.height = Math.max(0,height); field.x = x; field.y = y; field.rotation = rotation;
    }
    override function drawLabels():Void {
        super.drawLabels();
        axisShape.graphics.clear(); var used = 0;
        if (bounds.width >= 16 && bounds.height >= 16) {
            var xa:ChartAxisConfig = config.xAxis; var ya:ChartAxisConfig = config.yAxis;
            var g = axisShape.graphics;
            g.lineStyle(1,style("axisColor",UIStyleManager.CHART_AXIS_COLOR,0x666666));
            g.moveTo(bounds.x,bounds.y); g.lineTo(bounds.x,bounds.bottom); g.lineTo(bounds.right,bounds.bottom);
            var previousRight = Math.NEGATIVE_INFINITY;
            for (tick in xTicks) {
                var pixel = valueToX(tick.value); if (pixel == null) continue;
                var x = bounds.x+pixel;
                if (xa.showTicks) { g.moveTo(x,bounds.bottom); g.lineTo(x,bounds.bottom+4); }
                if (!xa.showLabels || xLabelHeight < textHeight) continue;
                var slot = xa.scale == "categorical" ? horizontal.bandWidth : Math.max(20,bounds.width/Math.max(1,xTicks.length-1));
                var label = tickLabel(tick,xa); measure.text = label;
                var w = Math.min(measure.textWidth+6,Math.max(0,slot-5));
                var start = Math.max(chromeBounds.x,Math.min(x-w/2,chromeBounds.right-w));
                if (start < previousRight+4 || w < 12) continue;
                useLabel(used++,label,start,bounds.bottom+6,w,Math.min(textHeight,chromeBounds.bottom-bounds.bottom-6),TextFormatAlign.CENTER);
                previousRight = start+w;
            }
            var previousBottom = Math.NEGATIVE_INFINITY;
            // Linear Y ticks are bottom-to-top; reverse them to cull in screen order.
            var ordered = yTicks.copy(); if (ya.scale == "linear") ordered.reverse();
            for (tick in ordered) {
                var pixel = valueToY(tick.value); if (pixel == null) continue;
                var y = bounds.y+pixel;
                if (ya.showTicks) { g.moveTo(bounds.x-4,y); g.lineTo(bounds.x,y); }
                if (!ya.showLabels || yLabelWidth < 12) continue;
                var top = Math.max(chromeBounds.y,Math.min(y-textHeight/2,chromeBounds.bottom-textHeight));
                if (top < previousBottom+2) continue;
                useLabel(used++,tickLabel(tick,ya),bounds.x-yLabelWidth-7,top,yLabelWidth,textHeight,TextFormatAlign.RIGHT);
                previousBottom = top+textHeight;
            }
            if (xa.title != "" && bottomTitleHeight > 0)
                useLabel(used++,xa.title,bounds.x,bounds.bottom+xLabelHeight+8,bounds.width,Math.min(textHeight,bottomTitleHeight),TextFormatAlign.CENTER);
            if (ya.title != "" && leftTitleWidth > 0)
                useLabel(used++,ya.title,chromeBounds.x,bounds.bottom,bounds.height,textHeight,TextFormatAlign.CENTER,-90);
        }
        while (axisLabels.length > used) labelLayer.removeChild(axisLabels.pop());
    }
    override public function destroy():Void {
        if (destroyed) return;
        if (axisShape != null) axisShape.graphics.clear();
        axisLabels = []; measure = null; xTicks = []; yTicks = []; horizontal = null; vertical = null;
        super.destroy();
    }
}
