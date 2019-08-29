package com.chaos.drawing;


import com.chaos.ui.BaseUI;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.display.Shape;


/**
 * Create a image with stripe pattern
 */

class Stripes extends BaseUI
{

    private var stripeMatrix : Matrix = new Matrix();
    private var stripeShape : Shape = new Shape();
    private var stripeBMD : BitmapData;
    private var stripeBM : Bitmap;
    
    public function new(data:Dynamic = null )
    {
        super(data);
		
    }
	
	override public function initialize():Void 
	{
		super.initialize();
		
        stripeBMD = new BitmapData(Std.int(_width), Std.int(_height), true, 0);
        stripeBM = new Bitmap(stripeBMD);
		
        addChild(stripeBM);
		
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		stripeShape.graphics.clear();
		stripeBMD.dispose();
		removeChild(stripeBM);
	}
    
    public function drawStripes(direction : String, separation : Int, lineWidth : Int = 1, color : Int = 0xffffff, alpha : Float = 1) : Void
    {
        stripeShape.graphics.clear();
		
        var lineHeight : Float = stripeBM.height;
		
        switch (direction)
        {
            case "up", "left", "forward":
                stripeShape.graphics.beginFill(color, alpha);
                stripeShape.graphics.moveTo(0, lineHeight);
                stripeShape.graphics.lineTo(lineWidth, lineHeight);
                stripeShape.graphics.lineTo(lineHeight + lineWidth, 0);
                stripeShape.graphics.lineTo(lineHeight, 0);
                stripeShape.graphics.lineTo(0, lineHeight);
                stripeShape.graphics.endFill();
            case "down", "right", "back":
                stripeShape.graphics.beginFill(color, alpha);
                stripeShape.graphics.moveTo(lineWidth, 0);
                stripeShape.graphics.lineTo(0, 0);
                stripeShape.graphics.lineTo(lineHeight, lineHeight);
                stripeShape.graphics.lineTo(lineHeight + lineWidth, lineHeight);
                stripeShape.graphics.lineTo(lineWidth, 0);
                stripeShape.graphics.endFill();
            case "vertical":
                stripeShape.graphics.beginFill(color, alpha);
                stripeShape.graphics.drawRect(0, 0, lineWidth, lineHeight);
                stripeShape.graphics.endFill();
            case "horizontal":
                stripeShape.graphics.beginFill(color, alpha);
                stripeShape.graphics.drawRect(0, 0, stripeBM.width, lineWidth);
                stripeShape.graphics.endFill();
        }
		
        stripeBMD.lock();
		
		var i : Int = -stripeBMD.height;
		
        while (i < stripeBMD.width + stripeBMD.height)
		{
            if (direction == "horizontal") 
                stripeMatrix.ty = i;
            else 
                stripeMatrix.tx = i;
				
            stripeBMD.draw(stripeShape, stripeMatrix);
            i += separation + lineWidth;
        }
		
        stripeBMD.unlock();
    }
    
    public function clear() : Void
    {
        stripeBMD.dispose();
        stripeBMD = new BitmapData(Std.int(_width), Std.int(_height), true, 0);
        stripeBM.bitmapData = stripeBMD;
    }
	
	
	//@:setter(width)
	override function set_width(value:Float):Float 
	{
		clear();
		
		super.set_width(value);
		
		return value;
	}
	
	
	//@:setter(height)
	override function set_height(value:Float):Float 
	{
		clear();
		
		super.set_height(value);
		
		return value;
	}	
    
	
}
