package com.chaos.ui.layout.classInterface;



/**
	 * ...
	 * @author Erick Feiling
	 */

import flash.display.DisplayObject;
import flash.display.Bitmap;

import com.chaos.ui.classInterface.IBaseUI;

interface IBaseContainer extends IBaseUI
{
    
    /**
		 * Turns on or off image smoothing
		 */
    
    
    
    /**
		 * Return the image being used
		 */
    
    var imageSmoothing(get, set) : Bool;    
    
    /**
		 * The content layer
		 */
    
    var content(get, never) : DisplayObject;    
    
    /**
		 * Hide or show the background
		 */
    
    
    /**
		 * Return true if the being displayed
		 */
    
    var background(get, set) : Bool;    
    /**
		 * The background color
		 */
    
    
    
    /**
		 * Return the color
		 */
    
    var backgroundColor(get, set) : Int;    
    
    /**
		 * The background alpha
		 */
    
    
    
    /**
		 * Return background alpha
		 */
    
    var backgroundAlpha(get, set) : Float;    
    
    /**
		 * Toggle on and off images, if false then will use default render
		 */
    
    
    
    /**
		 * Return true if showing images and false if not
		 */
    
    var showImage(get, set) : Bool;

    /**
		 * Set the background image
		 *
		 * @param	value The bitmap that will be used
		 */
    
    function setBackgroundBitmap(value : Bitmap) : Void;
    
    /**
		 * Set the background image
		 *
		 * @param	value The URL of the image that will be used
		 *
		 */
    
    function setBackgroundImage(value : String) : Void;
}

