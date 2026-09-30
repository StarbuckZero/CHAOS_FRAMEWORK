package com.chaos.ui.classInterface;

import openfl.display.Bitmap;
import openfl.display.BitmapData;

interface ITextInput extends ILabel
{
    /**
	 * Will upper case first letter on FOCUS_OUT event
	 */
	
	var upperCaseFirst(get, set) : Bool;      
	
	/**
	 * The alpha of the text input roll over and down state. Use this if you only set the default bitmap image, this will tint the text input.
	 */
	
	var bitmapAlpha(get, set) : Float;     
	
	/**
	 * The color that will be used for the text input in this state
	 */
	
	var textOverColor(get, set) : Int;      
	
	/**
	 * The color that will be used for the text input in this state
	 */
	
	var textSelectedColor(get, set) : Int;    
	
	/**
	 * The color that will be used for the text input in this state
	 */

	var textDisableColor(get, set) : Int;      
	
	/**
	 * The color of the text input background over state
	 */  
	
	var backgroundOverColor(get, set) : Int;     
	
	/**
	 * The color of the text input background down state
	 */
	
	var backgroundSelectedColor(get, set) : Int;     
	
	/**
	 * The color of the text input background disabled state
	 */
	
	var backgroundDisableColor(get, set) : Int;
	

	
	/**
	 * Sets an image for the text input default state. It is best to set an image that can be tiled.
	 */
	
	function setBackgroundImage(value : BitmapData) : Void;  
	

	
	/**
	 * Sets an image for the text input hover state. It is best to set an image that can be tiled.
	 */
	
	function setOverBackgroundImage(value : BitmapData) : Void;  
	
	
	/**
	 * Sets an image for the text input selected state. It is best to set an image that can be tiled.
	 */
	
	function setSelectedBackgroundImage(value : BitmapData) : Void;  
	
	
	/**
	 * Sets an image for the text input disabled state. It is best to set an image that can be tiled.
	 */
	
	function setDisableBackgroundImage(value : BitmapData) : Void;  
	
	/**
	 * Display default text when string is empty
	 *
	 * @param	value The text that will be used
	 */
	
	function defaultString(value : String) : Void; 
	
	/**
	 * This will check to see if TextInput is empty
	 *
	 * @return True if there is nothing in the TextInput and False if not
	 */
	
	function isEmpty() : Bool;
}