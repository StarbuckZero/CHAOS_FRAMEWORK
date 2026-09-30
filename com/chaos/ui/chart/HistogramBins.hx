package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes;
class HistogramBins {
    /** Groups finite observations into bins using a count or width. */
    public static function calculate(data:Array<Dynamic>,count:Null<Int>,width:Null<Float>):Array<ChartPoint> {
        var values:Array<{value:Float,index:Int}>=[];
        for(i in 0...data.length) if(ChartData.finite(data[i])) values.push({value:data[i],index:i});
        if(values.length==0) return [];
        var min=values[0].value; var max=min; for(v in values) { min=Math.min(min,v.value); max=Math.max(max,v.value); }
        var edges:Array<Float>=[];
        if(min==max) { if(min-0.5==min || max+0.5==max) throw "Equal-value bin bounds cannot be represented"; edges=[min-0.5,max+0.5]; }
        else {
            var n:Int;
            if(width!=null) { var span=max-min; if(!Math.isFinite(span)) throw "Bin width range exceeds finite precision"; var needed=Math.ceil(span/width); if(!Math.isFinite(needed) || needed>10000) throw "Bin count exceeds 10000"; n=Std.int(needed); }
            else n=count==null?Std.int(Math.ceil(Math.sqrt(values.length))):count;
            if(n<1 || n>10000) throw "Bin count must be in 1..10000";
            for(i in 0...n+1) { var edge=width==null?min*(1-i/n)+max*(i/n):min+i*width;
                if(!Math.isFinite(edge) || (edges.length>0 && edge<=edges[edges.length-1])) throw "Bin edges cannot be represented distinctly";
                edges.push(edge);
            }
            if(edges[n]<max) { if(width==null) edges[n]=max; else { if(n>=10000) throw "Bin count exceeds 10000"; var edge=min+(n+1)*width; if(!Math.isFinite(edge) || edge<=edges[n]) throw "Bin edge overflow"; edges.push(edge); } }
        }
        var result:Array<ChartPoint>=[];
        for(i in 0...edges.length-1) {
            var lower=edges[i]; var upper=edges[i+1]; var id=haxe.Json.stringify([lower,upper,i==edges.length-2]);
            var source:Dynamic={id:id,lowerBound:lower,upperBound:upper,count:0,observationIndices:[],value:0};
            result.push({id:id,dataIndex:i,seriesId:null,seriesIndex:-1,label:Std.string(lower)+"–"+Std.string(upper),value:0,x:lower/2+upper/2,y:0,gap:false,source:source});
        }
        for(v in values) {
            var low=0; var high=edges.length-1;
            while(low+1<high) { var middle=(low+high)>>1; if(v.value<edges[middle]) high=middle; else low=middle; }
            var index=Std.int(Math.min(result.length-1,low)); var p=result[index]; p.value++; p.y=p.value; p.source.count=p.value; p.source.value=p.value; p.source.observationIndices.push(v.index);
        }
        return result;
    }
}
