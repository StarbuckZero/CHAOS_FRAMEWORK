package com.chaos.ui.chart;
import openfl.geom.Point;
/** Clip closed fill polygons to a rectangle without moving their zero baseline. */
class AreaGeometry {
    /** Clips a polygon to the supplied rectangular bounds. */
    public static function clip(input:Array<Point>,left:Float,top:Float,right:Float,bottom:Float):Array<Point> {
        var output=input;
        for(edge in 0...4) {
            var source=output; output=[]; if(source.length==0) break;
            var previous=source[source.length-1];
            function inside(p:Point):Bool { return switch(edge) { case 0:p.x>=left; case 1:p.x<=right; case 2:p.y>=top; default:p.y<=bottom; }; }
            for(current in source) {
                var a=inside(previous); var b=inside(current);
                if(a!=b) {
                    var vertical=edge<2; var limit=edge==0?left:edge==1?right:edge==2?top:bottom;
                    var start=vertical?previous.x:previous.y; var end=vertical?current.x:current.y;
                    var scale=Math.max(1,Math.max(Math.abs(start),Math.abs(end)));
                    var t=(limit/scale-start/scale)/(end/scale-start/scale);
                    output.push(vertical?new Point(limit,previous.y*(1-t)+current.y*t):new Point(previous.x*(1-t)+current.x*t,limit));
                }
                if(b) output.push(current); previous=current;
            }
        }
        return output;
    }
    /** Draws a closed polygon when at least three vertices are present. */
    public static function draw(g:openfl.display.Graphics,polygon:Array<Point>):Void {
        if(polygon.length<3) return;
        g.moveTo(polygon[0].x,polygon[0].y); for(i in 1...polygon.length) g.lineTo(polygon[i].x,polygon[i].y); g.lineTo(polygon[0].x,polygon[0].y);
    }
}
