package com.chaos.ui.chart;

typedef ChartAxisConfig = {
    var scale:String;
    var title:String;
    var minimum:Null<Float>;
    var maximum:Null<Float>;
    var interval:Null<Float>;
    var showGrid:Bool;
    var showTicks:Bool;
    var showLabels:Bool;
    var showZeroLine:Bool;
    var format:{kind:String,decimals:Int};
}

class ChartAxis {
    /** Returns default axis settings for the requested scale type. */
    public static function defaults(scale:String):ChartAxisConfig {
        return {scale:scale,title:"",minimum:null,maximum:null,interval:null,showGrid:true,showTicks:true,
            showLabels:true,showZeroLine:true,format:{kind:"number",decimals:2}};
    }
    /** Entire supplied axis replaces its old object; bad settings retain the old axis. */
    public static function parse(value:Dynamic,defaultScale:String):ChartAxisConfig {
        if (value == null || Type.typeof(value) != TObject) throw "Axis must be an object";
        var result = defaults(defaultScale);
        for (field in Reflect.fields(value)) switch field {
            case "scale":
                if (value.scale != "linear" && value.scale != "categorical") throw "Unsupported axis scale";
                result.scale = value.scale;
            case "title":
                if (!Std.isOfType(value.title,String)) throw "Axis title must be a string";
                result.title = value.title;
            case "minimum", "maximum", "interval":
                var v:Dynamic = Reflect.field(value,field);
                if (v != null && !ChartScale.finite(v)) throw "Axis bound/interval must be finite or null";
                Reflect.setField(result,field,v);
            case "showGrid", "showTicks", "showLabels", "showZeroLine":
                var v:Dynamic = Reflect.field(value,field);
                if (!Std.isOfType(v,Bool)) throw "Axis visibility must be boolean";
                Reflect.setField(result,field,v);
            case "format":
                var f:Dynamic = value.format;
                if (f == null || Type.typeof(f) != TObject) throw "Format must be an object";
                var kind:Dynamic = Reflect.hasField(f,"kind") ? f.kind : "number";
                var decimals:Dynamic = Reflect.hasField(f,"decimals") ? f.decimals : 2;
                if ((kind != "number" && kind != "percent") || !ChartScale.finite(decimals) || decimals < 0 || decimals > 10 || Math.floor(decimals) != decimals)
                    throw "Invalid numeric format";
                result.format = {kind:kind,decimals:Std.int(decimals)};
            default: throw "Unknown axis property: " + field;
        }
        if (result.scale == "linear") {
            if (result.minimum != null && result.maximum != null && result.minimum >= result.maximum) throw "Axis minimum must be less than maximum";
            if ((result.minimum == ChartScale.MAX_VALUE && result.maximum == null) || (result.maximum == -ChartScale.MAX_VALUE && result.minimum == null)) throw "No representable automatic bound beyond explicit limit";
            if (result.interval != null && result.interval <= 0) throw "Axis interval must be positive";
        }
        return result;
    }
}
