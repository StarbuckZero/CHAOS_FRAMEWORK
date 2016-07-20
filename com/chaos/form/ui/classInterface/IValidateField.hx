package com.chaos.form.ui.classInterface;


import com.chaos.ui.interface.ITextInput;
import openfl.display.Bitmap;

/**
 * Interface for ValidateField
 * @author Erick Feiling
 */

interface IValidateField extends com.chaos.ui.classInterface.ITextInput
{

    /**
	 * Set the background of the text input default state using an image file.
	 */
    
    function setValidBackground(value : String) : Void;
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    function setValidBackgroundImage(value : Bitmap) : Void;
    
    /**
	 * Set the background of the text input default state using an image file.
	 */
    
    function setInvalidBackground(value : String) : Void;
    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    function setInvalidBackgroundImage(value : Bitmap) : Void;
    
    /**
	 * Check to see if info stored is correct
	 * @return True if it's correct and false if not
	 */
    
    function isValid() : Bool;
}

