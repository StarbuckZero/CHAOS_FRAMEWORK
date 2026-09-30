package com.chaos.form.ui.classInterface;


import com.chaos.ui.classInterface.ITextInput;
import openfl.display.BitmapData;


/**
 * Interface for ValidateField
 * @author Erick Feiling
 */

interface IValidateField extends ITextInput
{

	
    /**
	 * Sets an image for the text input default state. It is best to set an image that can be tiled.
	 */
    
    function setValidBackgroundImage(value : BitmapData) : Void;
    
    /**
	 * Sets an image for the text input default state. It is best to set an image that can be tiled.
	 */
    
    function setInvalidBackgroundImage(value : BitmapData) : Void;
    
    /**
	 * Check to see if info stored is correct
	 * @return True if it's correct and false if not
	 */
    
    function isValid() : Bool;
}

