package com.chaos.ui.chart;
import openfl.display.Graphics;
import openfl.geom.Rectangle;
class MarkerGeometry {
    public static function draw(g:Graphics,r:Rectangle,shape:String):Void {
        switch(shape) {
            case "circle": g.drawEllipse(r.x,r.y,r.width,r.height);
            case "diamond": g.moveTo(r.x+r.width/2,r.y); g.lineTo(r.right,r.y+r.height/2); g.lineTo(r.x+r.width/2,r.bottom); g.lineTo(r.x,r.y+r.height/2); g.lineTo(r.x+r.width/2,r.y);
            default: g.drawRect(r.x,r.y,r.width,r.height);
        }
    }
    public static function contains(dx:Float,dy:Float,radius:Float,shape:String):Bool {
        return shape=="circle"?dx*dx+dy*dy<=radius*radius:shape=="diamond"?Math.abs(dx)+Math.abs(dy)<=radius:Math.abs(dx)<=radius && Math.abs(dy)<=radius;
    }
}
