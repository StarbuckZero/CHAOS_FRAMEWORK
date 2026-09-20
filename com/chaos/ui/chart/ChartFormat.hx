package com.chaos.ui.chart;

/** Deterministic number/percent labels; no executable formatter in saved JSON. */
class ChartFormat {
    public static function format(value:Float, kind:String = "number", decimals:Int = 2):String {
        if (!Math.isFinite(value)) return "";
        decimals = Std.int(Math.max(0,Math.min(10,decimals)));
        var percent = kind == "percent";
        var absolute = Math.abs(value);
        var exponent = absolute == 0 ? 0 : Math.floor(Math.log(absolute)/Math.log(10));
        if (percent) exponent += 2;
        var result:String;
        if (absolute != 0 && (exponent >= 15 || exponent < -6)) {
            var rawExponent = percent ? exponent-2 : exponent;
            var power = Math.pow(10,rawExponent);
            // Subnormal inputs can underflow pow(10, exponent).
            var mantissa = power == 0 ? (absolute/Math.pow(10,rawExponent+1))*10 : absolute/power;
            var factor = Math.pow(10,decimals);
            mantissa = Math.ffloor(mantissa*factor+0.5)/factor;
            if (mantissa >= 10) { mantissa /= 10; exponent++; }
            result = (value < 0 ? "-" : "") + fixed(mantissa,decimals) + "e" + (exponent >= 0 ? "+" : "") + Std.string(exponent);
        } else result = fixed(percent ? value*100 : value,decimals);
        return result + (percent ? "%" : "");
    }
    static function fixed(value:Float,decimals:Int):String {
        var factor = Math.pow(10,decimals);
        var scaled = Math.ffloor(Math.abs(value)*factor+0.5);
        var rounded = scaled/factor;
        var whole = Math.ffloor(rounded);
        var result = Std.string(whole);
        if (decimals > 0) {
            var fraction = Std.string(Math.ffloor(Math.max(0,scaled-whole*factor)));
            while (fraction.length < decimals) fraction = "0"+fraction;
            result += "."+fraction;
        }
        return (value < 0 && rounded != 0 ? "-" : "") + result;
    }
}
