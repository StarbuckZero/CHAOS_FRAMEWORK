package com.chaos.ui.chart;

typedef ChartTick = { var value:Dynamic; var label:String; }

/** Immutable domain/range calculation. No OpenFL dependency. */
class ChartScale {
    public static inline var MAX_VALUE:Float = 1.7976931348623157e308;
    public var kind(default, null):String;
    public var minimum(default, null):Float;
    public var maximum(default, null):Float;
    public var rangeStart(default, null):Float;
    public var rangeEnd(default, null):Float;
    public var interval(default, null):Null<Float>;
    public var bandWidth(get, never):Float;
    var entries:Array<{id:String,label:String}>;
    var indices:Map<String,Int>;
    function new() {}
    public static function finite(value:Dynamic):Bool {
        return (Std.isOfType(value,Int) || Std.isOfType(value,Float)) && Math.isFinite(value);
    }
    public static function linear(values:Array<Float>, low:Null<Float> = null, high:Null<Float> = null,
        includeZero:Bool = false, interval:Null<Float> = null):ChartScale {
        if ((low != null && !finite(low)) || (high != null && !finite(high)) || (low != null && high != null && low >= high))
            throw "Invalid explicit axis bounds";
        if (interval != null && (!finite(interval) || interval <= 0)) throw "Invalid tick interval";
        var min = Math.POSITIVE_INFINITY; var max = Math.NEGATIVE_INFINITY;
        for (v in values) if (finite(v)) { min = Math.min(min,v); max = Math.max(max,v); }
        if (!Math.isFinite(min)) { min = 0; max = 1; }
        if (includeZero) { min = Math.min(0,min); max = Math.max(0,max); }
        if (low != null) min = low;
        if (high != null) max = high;
        if (min >= max) {
            if (low != null && high == null) max = Math.min(MAX_VALUE,min + Math.max(Math.abs(min)*0.05,1));
            else if (high != null && low == null) min = Math.max(-MAX_VALUE,max - Math.max(Math.abs(max)*0.05,1));
            else {
                var delta = Math.max(Math.abs(min)*0.05,1);
                var lower = min-delta; var upper = max+delta;
                if (Math.isFinite(lower)) min = lower;
                if (Math.isFinite(upper)) max = upper;
            }
        }
        if (!Math.isFinite(min) || !Math.isFinite(max) || min >= max) throw "Axis range cannot be represented";
        var scale = new ChartScale(); scale.kind = "linear"; scale.minimum = min; scale.maximum = max;
        scale.interval = interval; scale.rangeStart = 0; scale.rangeEnd = 1; scale.entries = []; scale.indices = new Map();
        return scale;
    }
    public static function categorical(categories:Array<{id:String,label:String}>):ChartScale {
        var scale = new ChartScale(); scale.kind = "categorical"; scale.entries = []; scale.indices = new Map();
        for (c in categories) {
            if (c.id == null || c.id == "" || scale.indices.exists(c.id)) throw "Category IDs must be unique";
            scale.indices.set(c.id,scale.entries.length); scale.entries.push({id:c.id,label:c.label});
        }
        scale.minimum = 0; scale.maximum = categories.length; scale.rangeStart = 0; scale.rangeEnd = 1;
        return scale;
    }
    public function withRange(start:Float,end:Float):ChartScale {
        if (!finite(start) || !finite(end)) throw "Invalid pixel range";
        var scale = new ChartScale(); scale.kind = kind; scale.minimum = minimum; scale.maximum = maximum;
        scale.interval = interval; scale.entries = entries; scale.indices = indices;
        scale.rangeStart = start; scale.rangeEnd = end; return scale;
    }
    function get_bandWidth():Float { return kind == "categorical" && entries.length > 0 ? Math.abs(rangeEnd-rangeStart)/entries.length : 0; }
    public function map(value:Dynamic):Null<Float> {
        var ratio:Float;
        if (kind == "categorical") {
            if (!Std.isOfType(value,String) || !indices.exists(value) || entries.length == 0) return null;
            ratio = (indices.get(value)+0.5)/entries.length;
        } else {
            if (!finite(value)) return null;
            var span = maximum-minimum;
            ratio = Math.isFinite(span) ? (value-minimum)/span : (value/2-minimum/2)/(maximum/2-minimum/2);
        }
        var pixel = rangeStart*(1-ratio)+rangeEnd*ratio;
        return Math.isFinite(pixel) ? pixel : null;
    }
    public function invert(pixel:Float):Dynamic {
        if (!finite(pixel) || rangeStart == rangeEnd) return null;
        var span = rangeEnd-rangeStart;
        var ratio = Math.isFinite(span) ? (pixel-rangeStart)/span : (pixel/2-rangeStart/2)/(rangeEnd/2-rangeStart/2);
        if (kind == "categorical") {
            if (ratio < 0 || ratio >= 1 || entries.length == 0) return null;
            return entries[Std.int(Math.floor(ratio*entries.length))].id;
        }
        var value = minimum*(1-ratio)+maximum*ratio;
        return Math.isFinite(value) ? value : null;
    }
    /** Returns at most limit ticks. Dense explicit intervals are sampled at whole multiples. */
    public function ticks(limit:Int = 200):Array<ChartTick> {
        limit = Std.int(Math.max(2,Math.min(200,limit)));
        var result:Array<ChartTick> = [];
        if (kind == "categorical") {
            var stride = Std.int(Math.max(1,Math.ceil(entries.length/limit)));
            var index = 0;
            while (index < entries.length && result.length < limit) {
                var c = entries[index]; result.push({value:c.id,label:c.label}); index += stride;
            }
            return result;
        }
        var target = maximum/5-minimum/5;
        var step = interval == null ? niceStep(target) : interval;
        var minimumStep = maximum/(limit-1)-minimum/(limit-1);
        if (step < minimumStep) {
            var multiplier = Math.ceil(minimumStep/step);
            step = Math.isFinite(multiplier) ? step*multiplier : niceStep(minimumStep);
        }
        if (!finite(step) || step <= 0) return [{value:minimum,label:""},{value:maximum,label:""}];
        var quotient = minimum/step;
        if (!Math.isFinite(quotient) || Math.abs(quotient) > 9007199254740991.)
            return [{value:minimum,label:""},{value:maximum,label:""}];
        var first = Math.ceil(quotient-1e-12)*step;
        var tolerance = step*1e-9;
        for (i in 0...limit) {
            var value = step/2 == 0 ? first+i*step : (first/2+i*(step/2))*2;
            if (!Math.isFinite(value) || value > maximum+tolerance) break;
            if (value < minimum-tolerance) continue;
            if (Math.abs(value) < tolerance && minimum <= 0 && maximum >= 0) value = 0;
            value = Math.max(minimum,Math.min(maximum,value));
            if (result.length == 0 || value > result[result.length-1].value) result.push({value:value,label:""});
        }
        if (result.length == 0) return [{value:minimum,label:""},{value:maximum,label:""}];
        return result;
    }
    static function niceStep(raw:Float):Float {
        if (!finite(raw) || raw <= 0) return 1;
        var power = Math.pow(10,Math.floor(Math.log(raw)/Math.log(10)));
        if (power == 0) return raw;
        var fraction = raw/power;
        var factor = fraction <= 1 ? 1 : fraction <= 2 ? 2 : fraction <= 5 ? 5 : 10;
        var step = factor*power;
        return Math.isFinite(step) ? step : raw;
    }
}
