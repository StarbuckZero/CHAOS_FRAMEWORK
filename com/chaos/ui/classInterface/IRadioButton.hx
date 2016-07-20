package com.chaos.ui.classInterface;

import openfl.display.Bitmap;
import openfl.text.Font;
import openfl.text.TextFormat;
import com.chaos.media.DisplayImage;
import com.chaos.ui.Label;
import com.chaos.ui.classInterface.IToggleButton;

interface IRadioButton extends IToggleButton
{
    /**
	 * Set the textformat to label
	 */

	var textFormat(get, set) : TextFormat;      
	/**
	 * Set what group this radio button belong to
	 */
	
	
	var groupName(get, set) : String;      
	
	/**
	 * Return the text field that is being used
	 */
	var textField(get, never) : Label;     
	
	/**
	 * Set the label text
	 */
	
	var text(get, set) : String; 
	
	/**
	 * Set the label width
	 */
	
	var textWidth(get, set) : Float;     
	
	/**
	 * Change the font size of the text field
	 */
	
	var textSize(get, set) : Int;  
    
	/**
	 * Indicates whether text in this text format is italicized. The default value is false, which means no italics are used
	 */
	
	var textItalic(get, set) : Bool;   
	
	/**
	 * Specifies whether the text is boldface. The default value is false, which means no boldface is used. If the value is true, then the text is boldface.
	 */
	
	var textBold(get, set) : Bool;   
	
	/**
	 * The color of the text in a text field, in hexadecimal format.
	 */  
	
	var textColor(get, set) : Int;   
	
	/**
	 * Set the alignment of the label text
	 */
	
	var textAlign(get, set) : String;  
    
	/**
	 * Show or hide the label on checkbox
	 */
	
	var showLabel(get, set) : Bool;
	
	/**
	 * Configure and setup the label to handle embedded fonts
	 *
	 * @param value The font you want to use.
	 *
	 */
	
	function setEmbedFont(value : Font) : Void;  
	
	/**
	 * Unload the font that was set by using the setEmbedFont
	 */ 
	
	function unloadEmbedFont() : Void; 
	/**
	 * This is for setting an image to the radio button default state.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setNormalImage(value : String) : Void;  
	
	/**
	 * This is for setting an image to the radio button default state.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setNormalBitmap(value : Bitmap) : Void; 
	
	/**
	 * This is for setting an image to the radio button roll over state.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setOverImage(value : String) : Void;  
	
	/**
	 * This is for setting an image to the radio button roll over state.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setOverBitmap(value : Bitmap) : Void;  
	
	/**
	 * This is for setting an image to the radio button roll down state.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setDownImage(value : String) : Void;  
	
	/**
	 * This is for setting an image to the radio button press down state.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setDownBitmap(value : Bitmap) : Void;  
	
	/**
	 * This is for setting an image to the radio button disable state.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	
	function setDisableImage(value : String) : Void;  
	
	/**
	 * This is for setting an image to the radio button disable state.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setDisableBitmap(value : Bitmap) : Void;
	
}