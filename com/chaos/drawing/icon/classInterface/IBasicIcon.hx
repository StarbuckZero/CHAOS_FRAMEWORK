package com.chaos.drawing.icon.classInterface;



/**
 * Interface for Icons
 * @author Erick Feiling
 */

import com.chaos.media.DisplayImage;
import com.chaos.ui.classInterface.IBaseUI;
import flash.display.Bitmap;

interface IBasicIcon extends IBaseUI
{
    
    
    /**
		 * Set the base color for the icon
		 */
    
    
    
    /**
		 * Return the color
		 */
    
    var baseColor(get, set) : Int;    
    
    /**
		 * Show or hide border
		 */
    
    
    
    /**
		 * Return true if border is being used and false if not
		 */
    
    var border(get, set) : Bool;    
    
    /**
		 *
		 * The border color
		 */
    
    
    
    /**
		 * Returns the color
		 */
    
    var borderColor(get, set) : Int;    
    
    /**
	 * Border thinkness
	 */

    var borderThinkness(get, set) : Float;    
	
    /**
	 * Specifies the border alpha. Set the alpha between 1 to 0.
	 */
    
    
    var borderAlpha(get, set) : Float;    
    
    /**
	 * Set if filter mode
	 */
    
    
    var filterMode(get, set) : Bool;    
    
    /**
	 * If true then the image will be displayed and false if image is not being used
	 */
    

    
    var showImage(get, set) : Bool;

    
    /**
		 * Set a DisplayImage to be used for drawing a bitmap texture.
		 *
		 * @param	displayImage The display image that will be used
		 */
    
    function setDisplayImage(displayImage : DisplayImage) : Void;
    
    /**
		 * Loads an image from a location
		 *
		 * @param	value The path to the image
		 */
    
    function loadImage(value : String) : Void;
    
    /**
		 * Set a bitmap image to be used for the icon
		 *
		 * @param	value The bitmap you want touse
		 */
    
    function setBitmap(value : Bitmap) : Void;
}

