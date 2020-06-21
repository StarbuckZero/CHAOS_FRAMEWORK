package com.chaos.ui.layout.classInterface;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;
import openfl.display.BitmapData;

import com.chaos.ui.classInterface.IBaseUI;

interface IBaseContainer extends IBaseUI
{
    
    
    /**
	 * The content layer
	 */
    
    var content(get, never) : DisplayObject;    
    
    /**
	 * Hide or show the background
	 */

    
    var background(get, set) : Bool;    
    /**
	 * The background color
	 */

    
    var backgroundColor(get, set) : Int;    
    
    /**
	 * The background alpha
	 */
    

    var backgroundAlpha(get, set) : Float;    
    
    /**
	 * Toggle on and off images, if false then will use default render
	 */

	var showImage(get, set) : Bool;
	
	/**
	 * Toggle on and off border
	 */   
	
	 var border(get, set) : Bool;      
	
	 /**
	  * The ScrollPane border color
	  */
	 
	 var borderColor(get, set) : Int;      
	 
	 /**
	  * Specifies the border alpha. Set the alpha between 1 to 0.
	  */
	 
	 var borderAlpha(get, set) : Float;      
	 
	 /**
	  * Border thinkness
	  */ 
	 
	 var borderThinkness(get, set) : Float;      	

    /**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */
    
    function setBackgroundImage(value : BitmapData) : Void;
    

}

