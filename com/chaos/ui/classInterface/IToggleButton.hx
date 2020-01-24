package com.chaos.ui.classInterface;


import openfl.display.BitmapData;


interface IToggleButton extends IBaseUI
{
	 /**
	 * The button normal state color
	 */ 
	 
	 var defaultColor(get, set) : Int;  
	 
	 /**
	 * The button over state color
	 */   
	 
	 var overColor(get, set) : Int;    
	 
	 /**
	 * The button down state color
	 */ 
	 
	 var downColor(get, set) : Int;   
	 
	 /**
	 * The button disable state color
	 */   
	 
	 var disableColor(get, set) : Int; 

	/**
	 * Border color for normal button state
	 */
	 var normalBorderColor(get, set):Int;

	 /**
	  * Border color for over button state
	  */
	 var overBorderColor(get, set):Int;
 
	 /**
	  * Border color for down button state
	  */
	 var downBorderColor(get, set):Int;
 
	 /**
	  * Border color for disable button state
	  */
	 var disableBorderColor(get, set):Int;
 
	 /**
	  * Set the border menu button alpha
	  */
	 var borderAlpha(get, set):Float;
 
	 /**
	  * Border thinkness
	  */
	 var borderThinkness(get, set):Float;	 
	 
	 /**
	 * Set how rounded the button is
	 */ 
	 
	 var roundEdge(get, set) : Int;     
	 
	 /**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
	 
	 var bitmapAlpha(get, set) : Float;   
	 
	 /**
	  * Title the image that is being used
	  */
	 var tileImage(get, set) : Bool;
	 
    /**
	 * Set if you want the button to be selected or not
	 */
	
	var selected(get, set) : Bool;     
	
	/**
	 * This is for setting an image to the button default state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setDefaultStateImage(value : BitmapData) : Void;  

	
	/**
	 * This is for setting an image to the button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setOverStateImage(value : BitmapData) : Void;  
 
	
	 /**
	 * This is for setting an image to the button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	 
	function setDownStateImage(value : BitmapData) : Void;  
	
	 /**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	 function setDisableStateImage(value : BitmapData) : Void;
}