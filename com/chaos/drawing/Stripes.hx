package com.chaos.drawing;


import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.display.Shape;
import openfl.display.Sprite;

class Stripes extends Sprite
{
    public var sHeight(never, set) : Float;
    public var sWidth(never, set) : Float;

    private var stripeMatrix : Matrix;
    private var stripeShape : Shape;
    private var stripeBMD : BitmapData;
    private var stripeBM : Bitmap;
    private var _sWidth : Float;
    private var _sHeight : Float;
    
    public function new(f_width : Float, f_height : Float)
    {
        super();
        _sWidth = f_width;
        _sHeight = f_height;
        stripeMatrix = new Matrix();
        stripeShape = new Shape();
        stripeBMD = new BitmapData(f_width, f_height, true, 0);
        stripeBM = new Bitmap(stripeBMD);
        addChild(stripeBM);
    }
    
    public function drawStripes(f_direction : String, f_separation : Float, f_width : Float = 1, f_color : Float = 0xffffff, f_alpha : Float = 1) : Void
    {
        stripeShape.graphics.clear();
        var f_height : Float = stripeBM.height;
        switch (f_direction)
        {
            case "up", "left", "forward":
                stripeShape.graphics.beginFill(f_color, f_alpha);
                stripeShape.graphics.moveTo(0, f_height);
                stripeShape.graphics.lineTo(f_width, f_height);
                stripeShape.graphics.lineTo(f_height + f_width, 0);
                stripeShape.graphics.lineTo(f_height, 0);
                stripeShape.graphics.lineTo(0, f_height);
                stripeShape.graphics.endFill();
            case "down", "right", "back":
                stripeShape.graphics.beginFill(f_color, f_alpha);
                stripeShape.graphics.moveTo(f_width, 0);
                stripeShape.graphics.lineTo(0, 0);
                stripeShape.graphics.lineTo(f_height, f_height);
                stripeShape.graphics.lineTo(f_height + f_width, f_height);
                stripeShape.graphics.lineTo(f_width, 0);
                stripeShape.graphics.endFill();
            case "vertical":
                stripeShape.graphics.beginFill(f_color, f_alpha);
                stripeShape.graphics.drawRect(0, 0, f_width, f_height);
                stripeShape.graphics.endFill();
            case "horizontal":
                stripeShape.graphics.beginFill(f_color, f_alpha);
                stripeShape.graphics.drawRect(0, 0, stripeBM.width, f_width);
                stripeShape.graphics.endFill();
        }
        stripeBMD.lock();
        var i : Int = -stripeBMD.height;
        while (i < stripeBMD.width + stripeBMD.height){
            if (f_direction == "horizontal") 
            {
                stripeMatrix.ty = i;
            }
            else 
            {
                stripeMatrix.tx = i;
            }
            stripeBMD.draw(stripeShape, stripeMatrix);
            i += f_separation + f_width;
        }
        stripeBMD.unlock();
    }
    
    public function clear() : Void
    {
        stripeBMD.dispose();
        stripeBMD = new BitmapData(_sWidth, _sHeight, true, 0);
        stripeBM.bitmapData = stripeBMD;
    }
    
    private function set_SHeight(value : Float) : Float
    {
        _sHeight = value;
        clear();
        return value;
    }
    
    private function set_SWidth(value : Float) : Float
    {
        _sWidth = value;
        clear();
        return value;
    }
}
