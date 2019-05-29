package com.chaos.utils;


/**
 * Take DisplayObjects and convert them to bitmaps to use in the framework
 *
 * @author Erick Feiling
 */

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
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
        
		
        // Create a bitmap based on the image the was
       // var testBitmap : Bitmap = new Bitmap(testBitmapData, "auto", smoothing);
        
        return testBitmapData;
    }
}

