package com.chaos.drawing;


import com.chaos.utils.CompositeManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Shape;

/**
 * Draws a shapes in either as bitmap or vector
 * @author Erick Feiling
 */

class Draw
{
    
    public function new()
    {
        
    }
    
    /**
	 * Draw a square
	 *
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	color The color
	 * @param	alpha The alpha from 0 to 1
	 * @param	bitmapMode If true will return a bitmap
	 * @param	bitmapSmoothing Turn of smoothing for image only apply if in bitmap mode
	 * @param	image An image to fill the object with
	 * @param	tile the image that is being used
	 *
	 * @return A new DisplayObject
	 */
    
    public static function Square(shapeWidth : Int, shapeHeight : Int, color : Int, alpha : Float = 1, bitmapMode : Bool = false, bitmapSmoothing : Bool = false, image : BitmapData = null, tileImage : Bool = true) : DisplayObject
    {
        var square : Shape = new Shape();
        
        if (null != image) 
        {
            square.graphics.beginBitmapFill(image, null, tileImage, bitmapSmoothing);
        }
        else 
        {
            square.graphics.beginFill(color, alpha);
        }
        
        square.graphics.drawRect(0, 0, shapeWidth, shapeHeight);
        square.graphics.endFill();
        
        return ((bitmapMode)) ? new Bitmap(CompositeManager.displayObjectToBitmap(square, bitmapSmoothing)) : square;
    }
    
    /**
	 * Draw a rounded square
	 *
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	color The color
	 * @param	how arounded you want the square
	 * @param	alpha The alpha from 0 to 1
	 * @param	bitmapMode If true will return a bitmap
	 * @param	bitmapSmoothing Turn of smoothing for image only apply if in bitmap mode
	 * @param	image An image to fill the object with
	 * @param	tile the image that is being used
	 *
	 * @return A new DisplayObject
	 */
    
    public static function SquareRound(shapeWidth : Int, shapeHeight : Int, color : Int, roundEdge : Int = 0, alpha : Float = 1, bitmapMode : Bool = false, bitmapSmoothing : Bool = false, image : BitmapData = null, tileImage : Bool = true) : DisplayObject
    {
        var square : Shape = new Shape();
        
        if (null != image) 
        {
            square.graphics.beginBitmapFill(image, null, tileImage, bitmapSmoothing);
        }
        else 
        {
            square.graphics.beginFill(color, alpha);
        }
        
        square.graphics.drawRoundRect(0, 0, shapeWidth, shapeHeight, roundEdge);
        square.graphics.endFill();
        return ((bitmapMode)) ? new Bitmap(CompositeManager.displayObjectToBitmap(square, bitmapSmoothing)) : square;
    }
    
    /**
	 * Draw a square will not fill color
	 *
	 * @param	shapeWidth The width of the object
	 * @param	shapeHeight The height of the object
	 * @param	outlineColor The color of the lines
	 * @param	thickness The thinkess of the lines
	 * @param	alpha The alpha from 0 to 1
	 * @param	bitmapMode If true will return a bitmap
	 * @param	bitmapSmoothing Turn of smoothing for image only apply if in bitmap mode
	 *
	 * @return A new DisplayObject
	 */
    
    public static function SquareOutline(shapeWidth : Int, shapeHeight : Int, outlineColor : Int, thickness : Int, alpha : Float = 1, bitmapMode : Bool = false, bitmapSmoothing : Bool = false) : DisplayObject
    {
        var square : Shape = new Shape();
        
        square.graphics.lineStyle(thickness, outlineColor, alpha);
        square.graphics.drawRect(0, 0, shapeWidth, shapeHeight);
        square.graphics.endFill();
        
        return ((bitmapMode)) ? new Bitmap( CompositeManager.displayObjectToBitmap(square, bitmapSmoothing)) : square;
		
    }
    
    /**
	 * Draws a line
	 *
	 * @param	startX Starting point X
	 * @param	startY Starting point Y
	 * @param	endX End point X
	 * @param	endY End point Y
	 * @param	color The color of the line
	 * @param	thickness The thinkess of the lines
	 * @param	alpha The alpha from 0 to 1
	 * @param	bitmapMode If true will return a bitmap
	 * @param	bitmapSmoothing Turn of smoothing for image only apply if in bitmap mode
	 *
	 * @return A new DisplayObject
	 */
    
    public static function Line(startX : Int, startY : Int, endX : Int, endY : Int, color : Int, thickness : Int, alpha : Float = 1, bitmapMode : Bool = false, bitmapSmoothing : Bool = false) : DisplayObject
    {
        var line : Shape = new Shape();
        
        line.graphics.lineStyle(thickness, color, alpha);
        line.graphics.moveTo(startX, startY);
        line.graphics.lineTo(endX, endY);
        line.graphics.endFill();
        
        return ((bitmapMode)) ? new Bitmap( CompositeManager.displayObjectToBitmap(line, bitmapSmoothing) ): line;
    }
}

