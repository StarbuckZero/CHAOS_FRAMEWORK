package com.chaos.utils;


import openfl.display.DisplayObjectContainer;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.utils.Object;

import openfl.events.MouseEvent;

import openfl.system.Capabilities;

import openfl.geom.Rectangle;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;

import openfl.net.URLRequest;

/**
 *
 * @author Erick Feiling
 */

class Utils
{
    private static inline var HEX : String = "0123456789ABCDEF";
    
    @:final public function new()
    {
        
    }
    
    /**
	 *
	 * Get a DisplayObject out of Sprite or MovieClip
	 *
	 * @param	displayObj The MovieClip you want to search
	 * @param	childName The name of the DisplayObject
	 * @return Returns a DisplayObject
	 */
    
    public static function getNestedChild(displayObj : DisplayObject, childName : String) : DisplayObject
    {
        
        var foundChild : DisplayObject = null;
        
        if (Std.is(displayObj, MovieClip)) 
            foundChild = (try cast(displayObj, MovieClip) catch(e:Dynamic) null).getChildByName(childName);
        
        if (Std.is(displayObj, Sprite)) 
            foundChild = (try cast(displayObj, Sprite) catch (e:Dynamic) null).getChildByName(childName);  // If not found then search children
        
        if (foundChild == null) 
        {
            
            var i : Int;
            var childObject : DisplayObject;
            var childsChild : DisplayObject;
            
            if (Std.is(displayObj, MovieClip)) 
            {
                
                for (i in 0... cast(displayObj, MovieClip).numChildren )
				{
                    childObject = cast(displayObj, MovieClip).getChildAt(i);
                    
                    // If it is a movieclip then pass to method again
                    if (Std.is(childObject, MovieClip)) 
                    {
                        childsChild = getNestedChild(cast(childObject, MovieClip), childName);
                        
                        // If is movieclip return
                        if (childsChild != null) 
                            return childsChild;
                    }
                    else if (Std.is(childObject, Sprite)) 
                    {
                        childsChild = getNestedChild(cast(childObject, Sprite), childName);
                        
                        // If is sprite return
                        if (childsChild != null) 
                            return childsChild;
                    }
                }
            }
            else 
            {
                // Should return child movieclip if found else once loop is done it will hit null
                for (i in 0...cast(displayObj, Sprite).numChildren ) 
				{
                    childObject = cast(displayObj, Sprite).getChildAt(i);
                    
                    // If it is a movieclip then pass to method again
                    if (Std.is(childObject, MovieClip)) 
                    {
                        childsChild = getNestedChild(cast(childObject, MovieClip), childName);
                        
                        // If is movieclip return
                        if (childsChild != null) 
                            return childsChild;
                    }
                    else if (Std.is(childObject, Sprite)) 
                    {
                        childsChild = getNestedChild(cast(childObject, Sprite), childName);
                        
                        // If is sprite return
                        if (childsChild != null) 
                            return childsChild;
                    }
                }
            }
            
            return null;
        }
        else 
        {
			// Return found clip
            return foundChild;
        }
    }
    
    
    /**
	 *
	 * Send in a hex value and return the RBG values
	 *
	 * @param	value The hex value
	 *
	 * @return Return an object with alpha the RGB values on it.
	 */
    
    public static function getColor(value : Int) : Object
    {
        
        var obj : Object = new Object();
        
        obj.r = ((value >> 16) & 255) / 255;
        obj.g = ((value >> 8) & 255) / 255;
        obj.b = (value & 255) / 255;
			
        obj.a = (value >> 24) / 255;
        
        return obj;
    }
    
    
    /**
	 *
	 * Take int value and turn it into hex
	 *
	 * @param	num
	 * @return
	 */
    
    public static function toHex(num : Int) : String
    {
        
        var col : Object = getColor(num);
        
        var a : String = getHex(col.a);
        var r : String = getHex(col.r);
        var g : String = getHex(col.g);
        var b : String = getHex(col.b);
        
		
        return a + r + g + b;
    }
    
    /**
	 * Take number and turn it into hex value as a string
	 *
	 * @param	n The number
	 * @return Returns the string
	 */
    public static function getHex(n : Int) : String
    {
        return HEX.charAt((n >> 4) & 0xf) + HEX.charAt(n & 0xf);
    }
    
    /**
	 * Apply color to an DisplayObject
	 *
	 * @param	object The diplay object you want to colorize
	 * @param	color The color
	 * @param	alpha The amount of alpha
	 */
    
    public static function Colorize(object : DisplayObject, color : Int, alpha : Float = 1) : Void
    {
        
        var trans : ColorTransform = new ColorTransform();
        
        trans.color = color;
        trans.alphaMultiplier = alpha;
        
        object.transform.colorTransform = trans;
    }
    
    /**
	 *
	 * Flip the display object on a x-axis
	 *
	 * @param	dsp The DisplayObject
	 */
    
    public static function flipHorizontal(dsp : DisplayObject) : Void
    {
        var matrix : Matrix = dsp.transform.matrix;
        matrix.a = -1;
        matrix.tx = dsp.width + dsp.x;
        dsp.transform.matrix = matrix;
    }
    
    /**
	 * Flip the display object on a y-axis
	 *
	 * @param	dsp The DisplayObject
	 */
    
    public static function flipVertical(dsp : DisplayObject) : Void
    {
        var matrix : Matrix = dsp.transform.matrix;
        matrix.d = -1;
        matrix.ty = dsp.height + dsp.y;
        dsp.transform.matrix = matrix;
    }
    
    /**
	 *
	 * Takes the DisplayObject and return the matrix. This can be used for bitmapFill and turning the bitmap data
	 *
	 * @param	object The displayObject
	 * @param	degrees The amount you want to turn the object
	 *
	 * @return A matrix object that can be used for BitmapData objects when using bitmapFill
	 *
	 * @example dispObj.transform.matrix = Utils.matrixRotate(disObj,90);
	 */
    
    public static function matrixRotate(object : DisplayObject, degrees : Float) : Matrix
    {
        
        var rotationMatrix : Matrix = new Matrix();
        
        rotationMatrix.translate( -object.width / 2, -object.height / 2);
        rotationMatrix.rotate(degrees * (Math.PI / 180));
        rotationMatrix.translate( -object.width / 2, -object.height / 2);
        
        return rotationMatrix;
    }
    
    /**
	 * Updates the registration on a given display object much like the old ActionScript 2.0
	 *
	 * @param	displayObj The DisplayObject type you want to update
	 * @param	regX The X location of the point
	 * @param	regY The Y location of the point
	 *
	 * @example Utils.setRegistrationPoint( mc, mc.width >> 1, mc.height >> 1, true);
	 */
    
    public static function setRegistrationPoint(displayObj : DisplayObject, regX : Float, regY : Float) : Void
    {
        displayObj.transform.matrix = new Matrix(1, 0, 0, 1, -regX, -regY);
    }
}

