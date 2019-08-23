package com.chaos.utils;


/**
 * Take DisplayObjects and convert them to bitmaps to use in the framework
 *
 * @author Erick Feiling
 */

import openfl.geom.Point;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.PixelSnapping;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;

class CompositeManager
{
    
    public function new()
    {
        
    }
    
    /**
	 * Takes the any display object and turn it into a bitmap
	 *
	 * @param	currentDisplayObject The MovieClip, Spirte, Loader or etc you want to change
	 * @param	smoothing Turn on and offing bitmap smoothing
	 * @param	widthOffSet A little extra space to on the width
	 * @param	heightOffSet A little extra space on the height
	 *
	 * @return A bitmap based on the size of the display object pasted in
	 */
    
    public static function displayObjectToBitmap(currentDisplayObject : DisplayObject, smoothing : Bool = true, widthOffSet : Float = 0, heightOffSet : Float = 0) : BitmapData
    {
        return cropToSize(currentDisplayObject, smoothing, currentDisplayObject.width + widthOffSet, currentDisplayObject.height + heightOffSet);
    }
    
    /**
	 * Takes the any display object and return a crop image
	 *
	 * @param	currentDisplayObject The MovieClip, Spirte, Loader or etc you want to change
	 * @param	smoothing Turn on and offing bitmap smoothing
	 * @param	newWidth The width you want the bitmap to be
	 * @param	newHeight The hbeight you want the bitmap to be
	 *
	 * @return A bitmap at the size requested
	 */
    
    public static function cropToSize(currentDisplayObject : DisplayObject, smoothing : Bool = true, newWidth : Float = 20, newHeight : Float = 20) : BitmapData
    {
        
        // Create the size of the image and draw the bitmap
        var testBitmapData : BitmapData = new BitmapData(Std.int(newWidth), Std.int(newHeight), true, 0xFF);
        
        // Turn display object into bitmap
        testBitmapData.draw(currentDisplayObject, null, null, null, null, smoothing);
        
        return testBitmapData;
    }
	
	/**
	 * Takes a image that is in the spritesheet format and return an array of bitmaps that can be used
	 * 
	 * @param	bitmapData The image that is cut up into smaller bitmaps
	 * @param	columns The amount in a column
	 * @param	rows The amount in a row
	 * @param	tileWidth The width of each tile
	 * @param	tileHeight The height of each tile
	 * @param	adjustLength Add or take way the amount of blocks from the sprite sheet title count
	 * 
	 * @return an array of all the tiles
	 */
	
	public static function createFramesFromSpritesheet (bitmapData:BitmapData, columns:Int, rows:Int, tileWidth:Int, tileHeight:Int, adjustLength:Int = 0):Array<BitmapData>
	{
		
		var frames:Array<BitmapData> = new Array<BitmapData>();
		var totalLength:Int = rows * columns + adjustLength;
		
		for (row in 0 ... rows) 
		{
			
			for (column in 0 ... columns) 
			{
				
				if (frames.length < totalLength) 
				{
					
					var x:Int = tileWidth  * column;
					var y:Int = tileHeight * row;
					
					var frame:BitmapData = new BitmapData (tileWidth, tileHeight, true, 0xFF);
					frame.copyPixels(bitmapData, new Rectangle(x, y, tileWidth, tileHeight), new Point(0, 0));
					
					frames.push (frame);
				}
			}
			
		}
		
		return frames;
		
	}	
	


}

