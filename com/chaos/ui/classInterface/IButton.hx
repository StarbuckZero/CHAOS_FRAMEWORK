package com.chaos.ui.classInterface;

import openfl.display.BitmapData;
import openfl.display.Shape;


interface IButton extends IToggleButton
{
    /**
	 * The offset of the image icon location on the X axis
	 */ 
	
	var imageOffSetX(get, set) : Int;      
	/**
	 * The offset of the image icon location on the Y axis
	 */
	var imageOffSetY(get, set) : Int;     

	/**
	 * Set the text on the button
	 */
	
	var text(get, set) : String;     
	
	/**
	 * Change button to "press" or "toggle" state. Set to press by default.
	 */
	
	var mode(get, set) : String;     
	
	/**
	 * Show or hide the label on button
	 */
	
	 var showLabel(never, set) : Bool;      
	 
	 /**
	 * Return the label that is being used in the button
	 */
	 
	 var label(get, never) : ILabel;     
	 
	 /**
	 * Set or return the font being used
	 */
	 
	 var textFont(get, set) : String;     
	 
	 /**
	 * Set to true if you want to boldface the text and false if not.
	 */ 
	 
	 var textBold(get, set) : Bool;     
	 
	 /**
	 * Set to true if you want to italicize  the text and false if not.
	 */ 
	 
	 var textItalic(get, set) : Bool;     
	 
	 /**
	 * Set the font size of the button
	 */
	 
	 var textSize(get, set) : Int;   
	 
	 /**
	 * Set the label color
	 */
	 
	 var textColor(get, set) : Int;   
	 
	 /**
	 * Set the label text alignment, use the Adobe TextFormatAlign class to set the label.
	 *
	 * @see openfl.text.TextFormatAlign
	 */
	 
	 var textAlign(get, set) : String;  
	 
	 
	 /**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
	 
	 var bitmapAlpha(get, set) : Float;   
	 
	 /**
	 * Set this if you want to display the icon
	 */    
	 
	 var iconDisplay(get, set) : Bool;  
	 
	/**
	 * Set the icon that will be used on the button
	 *
	 * @param	displayObj The display object that will be used for an icon
	 */
	
	function setIcon(image : BitmapData) : Void;  
	
	/**
	 * The DisplayObject being used as the icon for the button
	 *
	 * @return A DisplayObject if there is one if not then return null
	 */
	
	function getIcon() : Shape;
	

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