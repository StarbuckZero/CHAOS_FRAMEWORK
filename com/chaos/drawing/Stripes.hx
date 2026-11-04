package com.chaos.drawing;


import com.chaos.ui.BaseUI;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import openfl.display.Shape;


/**
 * Draws a repeated stripe pattern into a bitmap.
 */

class Stripes extends BaseUI
{

    private var stripeMatrix : Matrix = new Matrix();
    private var stripeShape : Shape = new Shape();
    private var stripeBMD : BitmapData;
    private var stripeBM : Bitmap;
    private var stripeDirection:String = "forward";
    private var stripeSeparation:Int = 10;
    private var stripeLineWidth:Int = 2;
    private var stripeColor:Int = 0xffffff;
    private var stripeAlpha:Float = 1;
    
    /** Creates a stripe-pattern display object. */
    public function new(data:Dynamic = null )
    {
        super(data);
		
    }
	
	/** Creates the bitmap used to display the stripe pattern. */
	override public function initialize():Void 
	{
		super.initialize();
		
        stripeBMD = new BitmapData(Std.int(Math.max(1, _width)), Std.int(Math.max(1, _height)), true, 0);
        stripeBM = new Bitmap(stripeBMD);
		
        addChild(stripeBM);
		
	}
	
    override public function setComponentData(data:Dynamic):Void
    {
        super.setComponentData(data);
        if (data != null && Reflect.hasField(data, "drawStripes")) {
            var values:Dynamic = Reflect.field(data, "drawStripes");
            if (values != null) {
                if (Reflect.hasField(values, "direction")) stripeDirection = values.direction;
                if (Reflect.hasField(values, "separation")) stripeSeparation = values.separation;
                if (Reflect.hasField(values, "lineWidth")) stripeLineWidth = values.lineWidth;
                if (Reflect.hasField(values, "color")) stripeColor = values.color;
                if (Reflect.hasField(values, "alpha")) stripeAlpha = values.alpha;
            }
        }
        if (stripeBM != null) draw();
    }

    override public function draw():Void
    {
        if (stripeBM == null) return;
        drawStripes(stripeDirection, stripeSeparation, stripeLineWidth, stripeColor, stripeAlpha);
    }

	/** Clears graphics, disposes the bitmap, and removes it from display. */
	override public function destroy():Void 
	{
		super.destroy();
		
		stripeShape.graphics.clear();
		stripeBMD.dispose();
		removeChild(stripeBM);
	}
    
    /** Draws repeated stripes in the requested direction, width, color, and spacing. */
    public function drawStripes(direction : String, separation : Int, lineWidth : Int = 1, color : Int = 0xffffff, alpha : Float = 1) : Void
    {
        if (["up", "left", "forward", "down", "right", "back", "vertical", "horizontal"].indexOf(direction) < 0
            || separation < 0 || lineWidth < 1 || !Math.isFinite(alpha) || alpha < 0 || alpha > 1)
            throw "Invalid drawStripes values";
        stripeDirection = direction;
        stripeSeparation = separation;
        stripeLineWidth = lineWidth;
        stripeColor = color;
        stripeAlpha = alpha;
        clear();
        stripeMatrix.identity();
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
		
        var step:Float = separation + (lineWidth : Float);
        var offset:Float = i;
        while (offset < stripeBMD.width + stripeBMD.height)
		{
            if (direction == "horizontal") 
                stripeMatrix.ty = offset;
            else 
                stripeMatrix.tx = offset;
				
            stripeBMD.draw(stripeShape, stripeMatrix);
            offset += step;
        }
		
        stripeBMD.unlock();
    }
    
    /** Replaces the current stripe bitmap with a blank one. */
    public function clear() : Void
    {
        if (stripeBM == null) return;
        if (stripeBMD != null) stripeBMD.dispose();
        stripeBMD = new BitmapData(Std.int(Math.max(1, _width)), Std.int(Math.max(1, _height)), true, 0);
        stripeBM.bitmapData = stripeBMD;
    }
	
	
	//@:setter(width)
	override function set_width(value:Float):Float 
	{
		super.set_width(value);
		draw();
		
		return value;
	}
	
	
	//@:setter(height)
	override function set_height(value:Float):Float 
	{
		super.set_height(value);
		draw();
		
		return value;
	}	
    
	
}
