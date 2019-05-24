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
    
    var baseColor(get, set) : Int;    
    
    /**
	 * Show or hide border
	 */

    var border(get, set) : Bool;    
    
    /**
	 *
	 * The border color
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
	 * If true then the image will be displayed and false if image is not being used
	 */
    

    
    var showImage(get, set) : Bool;


    
    function loadImage(value : String) : Void;
    
    /**
	 * Set a image to be used for the icon
	 *
	 * @param	value The bitmap you want touse
	 */
    
    function setImage(value : Bitmap) : Void;
}

