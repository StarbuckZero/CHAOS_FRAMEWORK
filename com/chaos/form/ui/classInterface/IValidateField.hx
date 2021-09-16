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
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    function setValidBackgroundImage(value : BitmapData) : Void;
    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    function setInvalidBackgroundImage(value : BitmapData) : Void;
    
    /**
	 * Check to see if info stored is correct
	 * @return True if it's correct and false if not
	 */
    
    function isValid() : Bool;
}

