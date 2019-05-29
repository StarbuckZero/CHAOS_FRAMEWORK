package com.chaos.drawing.icon.classInterface;



/**
 * Interface for Icons
 * @author Erick Feiling
 */


import com.chaos.ui.classInterface.IBaseUI;
import openfl.display.BitmapData;

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


    
    /**
	 * Set a image to be used for the icon
	 *
	 * @param	value The bitmap you want touse
	 */
    
    function setImage(value : BitmapData) : Void;
}

