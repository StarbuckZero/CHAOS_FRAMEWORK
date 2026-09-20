package com.chaos.ui.chart;

import com.chaos.ui.chart.ChartTypes;

/** Shared input handling; axes and family-specific geometry live in later phases. */
class ChartData {
    public static function finite(value:Dynamic):Bool {
        return (Std.isOfType(value, Int) || Std.isOfType(value, Float)) && Math.isFinite(value);
    }
    public static function object(value:Dynamic):Bool {
        return value != null && Type.typeof(value) == TObject;
    }
    public static function diagnostic(list:Array<ChartDiagnostic>, code:String, path:String, message:String):Void {
        list.push({code:code, path:path, message:message});
    }
    /** Defensive JSON-only copy, with cycle/depth and native-object protection. */
    public static function copy(value:Dynamic, diagnostics:Array<ChartDiagnostic> = null, path:String = "", stack:Array<Dynamic> = null):Dynamic {
        if (value == null || Std.isOfType(value, String) || Std.isOfType(value, Bool)) return value;
        if (Std.isOfType(value, Int) || Std.isOfType(value, Float)) {
            if (finite(value)) return value;
            if (diagnostics != null) diagnostic(diagnostics, "number", path, "Nonfinite input exported as null");
            return null;
        }
        if (stack == null) stack = [];
        if ((!object(value) && !Std.isOfType(value, Array)) || stack.indexOf(value) >= 0 || stack.length >= 64)
            throw "Only acyclic JSON data is supported at " + path;
        stack.push(value);
        var result:Dynamic;
        if (Std.isOfType(value, Array)) {
            var values:Array<Dynamic> = cast value;
            var output:Array<Dynamic> = [];
            for (i in 0...values.length) output.push(copy(values[i], diagnostics, path + "[" + i + "]", stack));
            result = output;
        } else {
            result = {};
            for (field in Reflect.fields(value)) Reflect.setField(result, field, copy(Reflect.field(value, field), diagnostics, path + "." + field, stack));
        }
        stack.pop();
        return result;
    }
    static function identify(items:Array<Dynamic>, path:String):Void {
        var used = new Map<String, Bool>();
        for (item in items) {
            if (!object(item)) throw "Expected record at " + path;
            if (Reflect.hasField(item, "id")) {
                var id:Dynamic = item.id;
                if (!Std.isOfType(id, String) || id == "" || used.exists(id)) throw "Invalid/duplicate ID at " + path;
                used.set(id, true);
            }
        }
        for (i in 0...items.length) if (!Reflect.hasField(items[i], "id")) {
            var id = "__chart_" + i;
            while (used.exists(id)) id += "_";
            items[i].id = id; used.set(id, true);
        }
    }
    static function records(config:Dynamic, field:String):Array<Dynamic> {
        if (!Reflect.hasField(config, field)) return [];
        var value:Dynamic = Reflect.field(config, field);
        if (!Std.isOfType(value, Array)) throw "Expected array at " + field;
        return cast value;
    }
    public static function normalize(previous:Dynamic, patch:Dynamic, cachedPoints:Array<ChartPoint> = null):ChartNormalization {
        var diagnostics:Array<ChartDiagnostic> = [];
        var result:ChartNormalization = {config:previous, points:[], diagnostics:diagnostics, accepted:false};
        try {
            if (!object(patch)) throw "Chart update must be an object";
            var next:Dynamic = {};
            for (field in Reflect.fields(previous)) Reflect.setField(next, field, Reflect.field(previous, field));
            var safe:Dynamic = copy(patch, diagnostics);
            for (field in Reflect.fields(safe)) {
                var value = Reflect.field(safe, field);
                if (["series", "data", "categories", "rows", "columns"].indexOf(field) >= 0 && value == null) {
                    diagnostic(diagnostics, "setting", field, "Use [] to clear an array");
                    continue;
                }
                Reflect.setField(next, field, value);
            }
            if (next.schemaVersion != 1) throw "Unsupported chart schemaVersion";
            if (Reflect.hasField(next, "series") && Reflect.hasField(next, "data")) throw "Choose series or data, not both";
            if (cachedPoints != null) {
                result.config = next; result.points = cachedPoints; result.accepted = true; return result;
            }
            // Full validation may generate IDs; copy before touching retained arrays.
            next = copy(next);
            for (field in ["categories", "rows", "columns"]) identify(records(next, field), field);
            var series = records(next, "series"); identify(series, "series");
            for (s in series) {
                if (!Reflect.hasField(s, "points")) s.points = [];
                if (!Std.isOfType(s.points, Array)) throw "Expected series.points array";
                identify(s.points, "series.points");
            }
            var data = records(next, "data");
            // Record-based data and raw observations are distinct, never mixed.
            if (data.length > 0 && object(data[0])) identify(data, "data");
            else for (item in data) if (object(item) || Std.isOfType(item, Array)) throw "Mixed raw/record data";
            result.config = next;
            result.points = points(next, diagnostics);
            result.accepted = true;
        } catch (error:Dynamic) {
            diagnostic(diagnostics, "structure", "", Std.string(error));
        }
        return result;
    }
    public static function points(config:Dynamic, diagnostics:Array<ChartDiagnostic>):Array<ChartPoint> {
        var output:Array<ChartPoint> = [];
        var categories = records(config, "categories");
        var rows = records(config, "rows"); var columns = records(config, "columns");
        var series = records(config, "series");
        function add(items:Array<Dynamic>, seriesId:Null<String>, seriesIndex:Int):Void {
            var seen = new Map<String, Bool>();
            for (i in 0...items.length) {
                var item:Dynamic = items[i];
                var source:Dynamic = object(item) ? item : {id:"__observation_" + i, value:item};
                var raw:Dynamic = Reflect.hasField(source, "y") ? source.y : source.value;
                var gap = raw == null && object(item) && (Reflect.hasField(source,"y") || Reflect.hasField(source,"value"));
                var key:String = null;
                var label:String = Reflect.hasField(source,"label") ? Std.string(source.label) : source.id;
                if (Reflect.hasField(source, "categoryId")) {
                    var category:Dynamic = null;
                    for (c in categories) if (c.id == source.categoryId) { category = c; break; }
                    if (category == null) { diagnostic(diagnostics,"reference","points["+i+"]","Unknown category"); continue; }
                    key = source.categoryId; label = Std.string(category.label);
                }
                if (Reflect.hasField(source, "rowId") || Reflect.hasField(source, "columnId")) {
                    if (!Lambda.exists(rows, r -> r.id == source.rowId) || !Lambda.exists(columns, c -> c.id == source.columnId)) {
                        diagnostic(diagnostics,"reference","data["+i+"]","Unknown row/column"); continue;
                    }
                    key = haxe.Json.stringify([source.rowId, source.columnId]);
                }
                if ((!finite(raw) && !gap) || (Reflect.hasField(source, "x") && !finite(source.x))) {
                    diagnostic(diagnostics,"value","points["+i+"]","Expected finite numeric value"); continue;
                }
                if (key != null && seen.exists(key)) { diagnostic(diagnostics,"duplicate","points["+i+"]","Duplicate category/cell"); continue; }
                if (key != null && !gap) seen.set(key, true);
                output.push({id:source.id, dataIndex:i, seriesId:seriesId, seriesIndex:seriesIndex, label:label,
                    value:gap ? null : raw, x:Reflect.hasField(source,"x") ? source.x : source.categoryId,
                    y:gap ? null : raw, gap:gap, source:source});
            }
        }
        for (i in 0...series.length) add(series[i].points, series[i].id, i);
        if (Reflect.hasField(config,"data")) add(records(config,"data"), null, -1);
        return output;
    }
}
