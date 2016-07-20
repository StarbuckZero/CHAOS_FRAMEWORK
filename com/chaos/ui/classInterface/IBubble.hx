package com.chaos.ui.classInterface;



/**
 * ...
 * @author Erick Feiling
 */



import openfl.display.Bitmap;
import openfl.display.Sprite;

interface IBubble extends IOverlay
{
    
    
    /**
	 * If true this will apply a mask content layer
	 */
    
    
    
    /**
	 * Return true if using mask and false if not
	 */
    
    var useMask(get, set) : Bool;    
    
    /**
	 * How rounded the edges of the bubble will be
	 */
    
    
    
    /**
	 * Toggle on and off border
	 */
    
    var border(get, set) : Bool;    
    
    /**
	 * The border color
	 */
    
    
    
    /**
	 * Returns the color
	 */
    
    var borderColor(get, set) : Int;    
    
    /**
	 * Set the alpha between 1 to 0. For example 0.4
	 */
    
    
    
    /**
	 * Returns the boarder alpha
	 */
    
    var borderAlpha(get, set) : Float;    
    
    /**
	 * The border thinkness
	 */
    
    
    
    /**
		 * Return the thinkness of the border
		 */
    
    var borderThinkness(get, set) : Float;    
    
    /**
		 * The background color of the bubble
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
		 * Show the tail of the bubble
		 */
    
    
    
    /**
		 * Return true if the tail is shown and false if not
		 */
    
    var showTail(get, set) : Bool;    
    
    /**
		 * The size of the tail
		 */
    
    
    
    /**
		 * Get the tail the size
		 */
    
    var tailSize(get, set) : Float;    
    
    /**
		 * Set the placement of the tail which could be "top", "bottom", "left" or "right"
		 */
    
    
    
    /**
		 * Get where the tail is placed
		 */
    
    var tailPlacement(get, set) : String;    
    
    /**
		 * The tail location, this only works if the tailAutoCenter is false
		 */
    
    var tailLocation(never, set) : Float;    
    
    /**
		 * Set to true if you want the tail to be auto center on the bubble
		 */
    
    
    
    /**
		 * Return true if the tail is center on the bubble and false if not
		 */
    
    var tailAutoCenter(get, set) : Bool;    
    
    /**
		 * Set the background image
		 *
		 * @param	value The bitmap that will be used
		 */
    
    var content(get, never) : Sprite;    
    
    /**
		 * How rounded the edges of the bubble will be
		 */
    
    
    
    /**
		 * Returns how rounded the bubbleis
		 */
    
    var rounded(get, set) : Int;

    
    /**
		 * Set the background image
		 *
		 * @param	value The bitmap that will be used
		 */
    
    function setBackgroundBitmap(value : Bitmap) : Void;
    
    /**
		 *
		 * Set the background image
		 *
		 * @param	value The URL of the image that will be used
		 *
		 */
    
    function setBackgroundImage(value : String) : Void;
}

