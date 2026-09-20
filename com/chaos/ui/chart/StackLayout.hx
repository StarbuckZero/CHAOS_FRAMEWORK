package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes.ChartPoint;
typedef StackSegment = {
    var start:Float; var end:Float; var normalizedValue:Float;
    var positiveTotal:Float; var negativeTotal:Float; var signedTotal:Float;
}
/** Independent positive/negative accumulation in stable series order. */
class StackLayout {
    public static function key(p:ChartPoint):String { return haxe.Json.stringify([p.seriesId,p.id]); }
    public static function calculate(points:Array<ChartPoint>,percent:Bool):Map<String,StackSegment> {
        var totals=new Map<String,{positive:Float,negative:Float}>();
        for(p in points) {
            var id:String=p.source.categoryId;
            if(!totals.exists(id)) totals.set(id,{positive:0,negative:0});
            var t=totals.get(id);
            if(p.value>=0) t.positive+=p.value; else t.negative+=p.value;
            if(!Math.isFinite(t.positive) || !Math.isFinite(t.negative)) throw "Category stack total exceeds finite numeric range";
        }
        var positions=new Map<String,{positive:Float,negative:Float}>();
        var result=new Map<String,StackSegment>();
        for(p in points) {
            var id:String=p.source.categoryId; var t=totals.get(id);
            if(!positions.exists(id)) positions.set(id,{positive:0,negative:0});
            var pos=positions.get(id); var denominator=p.value>=0?t.positive:-t.negative;
            var normalized=denominator==0?0:p.value/denominator;
            var value=percent?normalized:p.value;
            var start=p.value>=0?pos.positive:pos.negative; var end=start+value;
            if(percent) end=Math.max(-1,Math.min(1,end));
            if(p.value>=0) pos.positive=end; else pos.negative=end;
            result.set(key(p),{start:start,end:end,normalizedValue:normalized,positiveTotal:t.positive,negativeTotal:t.negative,signedTotal:t.positive+t.negative});
        }
        return result;
    }
}
