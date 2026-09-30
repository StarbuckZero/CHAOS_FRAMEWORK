package com.chaos.ui.chart;
import com.chaos.ui.chart.ChartTypes.ChartPoint;
/** Ordered series runs; null values and absent categories break paths unless connect is explicit. */
class LineGeometry {
    /** Groups ordered points into connected runs, handling missing values. */
    public static function runs(points:Array<ChartPoint>,categories:Array<Dynamic>,numeric:Bool,connect:Bool):Array<Array<ChartPoint>> {
        var ordered=points.copy();
        if(numeric) ordered.sort(function(a,b) { return a.x<b.x?-1:a.x>b.x?1:a.dataIndex-b.dataIndex; });
        else {
            var order=new Map<String,Int>(); for(i in 0...categories.length) order.set(categories[i].id,i);
            ordered.sort((a,b)->order.get(a.source.categoryId)-order.get(b.source.categoryId));
        }
        var result:Array<Array<ChartPoint>>=[]; var current:Array<ChartPoint>=[]; var last=-1;
        var indices=new Map<String,Int>(); for(i in 0...categories.length) indices.set(categories[i].id,i);
        for(p in ordered) {
            var index=numeric?0:indices.get(p.source.categoryId);
            if(!connect && (p.gap || (!numeric && last>=0 && index>last+1))) {
                if(current.length>0) result.push(current); current=[];
            }
            if(!p.gap) current.push(p);
            last=index;
        }
        if(current.length>0) result.push(current);
        return result;
    }
    /** Liang-Barsky clipping, normalized first to avoid overflowing coordinate differences. */
    public static function clip(x1:Float,y1:Float,x2:Float,y2:Float,width:Float,height:Float):Null<Array<Float>> {
        var scale=Math.max(1,Math.max(Math.max(Math.abs(x1),Math.abs(x2)),Math.max(Math.abs(y1),Math.abs(y2))));
        for(v in [x1,y1,x2,y2,width,height]) if(!Math.isFinite(v)) return null;
        x1/=scale; x2/=scale; y1/=scale; y2/=scale; var w=width/scale; var h=height/scale;
        var dx=x2-x1; var dy=y2-y1; var low=0.; var high=1.;
        var ps=[-dx,dx,-dy,dy]; var qs=[x1,w-x1,y1,h-y1];
        for(i in 0...4) {
            if(ps[i]==0) { if(qs[i]<0) return null; }
            else { var t=qs[i]/ps[i]; if(ps[i]<0) low=Math.max(low,t); else high=Math.min(high,t); }
        }
        if(low>high) return null;
        return [Math.max(0,Math.min(width,(x1+low*dx)*scale)),Math.max(0,Math.min(height,(y1+low*dy)*scale)),Math.max(0,Math.min(width,(x1+high*dx)*scale)),Math.max(0,Math.min(height,(y1+high*dy)*scale))];
    }
}
