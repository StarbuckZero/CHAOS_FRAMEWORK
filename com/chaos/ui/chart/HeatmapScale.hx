package com.chaos.ui.chart;
class HeatmapScale {
    public static function color(value:Float,min:Float,mid:Float,max:Float,low:Int,center:Int,high:Int):Int {
        if(min==max) return center;
        if(value<=min) return low; if(value>=max) return high;
        var a=value<=mid?min:mid; var b=value<=mid?mid:max;
        var from=value<=mid?low:center; var to=value<=mid?center:high;
        var span=b-a; var ratio=Math.isFinite(span)?(value-a)/span:(value/2-a/2)/(b/2-a/2);
        var result=0; for(shift in [0,8,16]) { var x=(from>>shift)&255; var y=(to>>shift)&255; result|=Math.round(x*(1-ratio)+y*ratio)<<shift; } return result;
    }
}

