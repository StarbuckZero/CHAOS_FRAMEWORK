package com.chaos.ui.chart;

import com.chaos.ui.chart.ChartTypes.ChartTextureResolver;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

/** Owns one cloned texture. Resolvers lend a bitmap; ownership never transfers. */
class ChartTexture {
    public var bitmap(default, null):BitmapData;
    var generation:Int = 0;
    var destroyed:Bool = false;
    public function new() {}
    public function clear():Void {
        generation++;
        if (bitmap != null) bitmap.dispose();
        bitmap = null;
    }
    public function load(key:String, resolver:ChartTextureResolver, changed:Void->Void, failed:String->Void):Void {
        clear();
        if (destroyed || key == null || key == "") return;
        var request = generation;
        var settled = false;
        function failure(message:String):Void {
            if (destroyed || request != generation || settled) return;
            settled = true; failed(message);
        }
        try {
            resolver(key, function(source:BitmapData) {
                if (destroyed || request != generation || settled) return;
                if (source == null || source.width <= 0 || source.height <= 0) { failure("Empty texture"); return; }
                try { bitmap = source.clone(); } catch (error:Dynamic) { failure(Std.string(error)); return; }
                settled = true; changed();
            }, failure);
        } catch (error:Dynamic) { failure(Std.string(error)); }
    }
    public function destroy():Void { destroyed = true; clear(); }
    public function draw(graphics:Graphics, bounds:Rectangle, mode:String, smooth:Bool, clear:Bool = true, shape:String = "square"):Void {
        if (clear) graphics.clear();
        if (bitmap == null || bounds.width <= 0 || bounds.height <= 0) return;
        var sx = bounds.width / bitmap.width; var sy = bounds.height / bitmap.height;
        var area = bounds.clone(); var matrix = new Matrix();
        if (mode == "tile") matrix.translate(bounds.x, bounds.y);
        else {
            if (mode == "fit" || mode == "fill") {
                var scale = mode == "fit" ? Math.min(sx, sy) : Math.max(sx, sy);
                sx = scale; sy = scale;
            }
            var x = bounds.x + (bounds.width - bitmap.width * sx) / 2;
            var y = bounds.y + (bounds.height - bitmap.height * sy) / 2;
            matrix.scale(sx, sy); matrix.translate(x, y);
            if (mode == "fit") area = new Rectangle(x, y, bitmap.width * sx, bitmap.height * sy);
        }
        graphics.beginBitmapFill(bitmap, matrix, mode == "tile", smooth);
        MarkerGeometry.draw(graphics,area,shape); graphics.endFill();
    }
}
