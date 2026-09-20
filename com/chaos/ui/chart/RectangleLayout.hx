package com.chaos.ui.chart;

typedef RectangleMark = { var x:Float; var y:Float; var width:Float; var height:Float; }

/** Orientation-independent rectangle calculation, separate from drawing and data contracts. */
class RectangleLayout {
    /** Reserve a stable slot for every series, including missing values. */
    public static function groupSlot(center:Float,band:Float,count:Int,index:Int,gap:Float):Null<{center:Float,band:Float}> {
        if (!Math.isFinite(center) || !Math.isFinite(band) || !Math.isFinite(gap) || band<=0 || count<=0 || index<0 || index>=count || gap<0 || gap>=1) return null;
        var width=band*(1-gap); var slot=width/count;
        return {center:center-width/2+slot*(index+0.5),band:slot};
    }
    public static function segment(center:Float,band:Float,start:Float,end:Float,gap:Float = 0.2,orientation:String = "vertical"):Null<RectangleMark> {
        for (value in [center,band,start,end,gap]) if (!Math.isFinite(value)) return null;
        if (band <= 0 || gap < 0 || gap >= 1 || (orientation != "vertical" && orientation != "horizontal")) return null;
        var thickness = band*(1-gap); var length = Math.abs(end-start);
        if (!Math.isFinite(thickness) || !Math.isFinite(length)) return null;
        return orientation == "vertical"
            ? {x:center-thickness/2,y:Math.min(start,end),width:thickness,height:length}
            : {x:Math.min(start,end),y:center-thickness/2,width:length,height:thickness};
    }
}

