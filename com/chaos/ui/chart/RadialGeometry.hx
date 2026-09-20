package com.chaos.ui.chart;
import openfl.geom.Point;
class RadialGeometry {
    public static inline var TAU:Float=6.283185307179586;
    public static function normalize(angle:Float):Float { return (angle%TAU+TAU)%TAU; }
    public static function contains(x:Float,y:Float,radius:Float,inner:Float,start:Float,sweep:Float):Bool {
        var distance=x*x+y*y;
        if(distance>radius*radius || distance<inner*inner || sweep==0) return false;
        var angle=Math.atan2(y,x); var relative=normalize(sweep>0?angle-start:start-angle);
        return relative<Math.abs(sweep) || Math.abs(sweep)>=TAU-1e-12;
    }
    public static function polygon(cx:Float,cy:Float,radius:Float,inner:Float,start:Float,sweep:Float):Array<Point> {
        var steps=Std.int(Math.max(1,Math.ceil(Math.abs(sweep)/Math.min(Math.PI/90,2*Math.acos(Math.max(-1,1-0.25/Math.max(1,radius)))))));
        steps=Std.int(Math.min(4096,steps)); var points:Array<Point>=[];
        for(i in 0...steps+1) { var a=start+sweep*i/steps; points.push(new Point(cx+Math.cos(a)*radius,cy+Math.sin(a)*radius)); }
        if(inner==0) points.push(new Point(cx,cy));
        else for(i in 0...steps+1) { var a=start+sweep*(steps-i)/steps; points.push(new Point(cx+Math.cos(a)*inner,cy+Math.sin(a)*inner)); }
        return points;
    }
}
