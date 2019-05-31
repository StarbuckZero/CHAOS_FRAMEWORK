package com.chaos.ui.classInterface;


import openfl.text.Font;
import openfl.text.TextFormat;

import com.chaos.ui.Label;
import com.chaos.ui.classInterface.IToggleButton;

interface ICheckBox extends IToggleButton
{
    /**
	 * Set the textformat to label
	 *
	 * @param value The text format object that you want to use on the label
	 */ 

	var textFormat(get, set) : TextFormat;     
	/**
	 * Return the text field that is being used
	 */
	var textField(get, never) : Label;      
	/**
	 * Set the label text
	 */

	var text(get, set) : String;      
	/**
	 * Set the label widtht the label to
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
	 * The color of the text in a text field, in hexadecimal format
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
	
}