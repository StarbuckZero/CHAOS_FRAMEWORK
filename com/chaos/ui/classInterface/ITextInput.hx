package com.chaos.ui.classInterface;

import openfl.display.Bitmap;

interface ITextInput extends com.chaos.ui.classInterface.ILabel
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
	 * The color of the text input background disable state
	 */
	
	var backgroundDisableColor(get, set) : Int;
	
	/**
	 * Set the background of the text input default state using an image file
	 */
	
	function setBackground(value : String) : Void; 
	
	/**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tiled.
	 */
	
	function setBackgroundImage(value : Bitmap) : Void;  
	
	/**
	 * Set the background of the text input roll over state using an image file
	 */
	
	function setOverBackground(value : String) : Void;  
	
	/**
	 * This is for setting an image to the text input roll over state. It is best to set an image that can be tiled.
	 */
	
	function setOverBackgroundImage(value : Bitmap) : Void;  
	
	/**
	 * Set the background of the text input selected state using an image file
	 */
	function setSelectedBackground(value : String) : Void;  
	
	/**
	 * This is for setting an image to the text input selected state. It is best to set an image that can be tiled.
	 */
	
	function setSelectedBackgroundImage(value : Bitmap) : Void;  
	/**
	 * Set the background of the text input disable state using an image file
	 */
	
	function setDisableBackground(value : String) : Void;  
	
	/**
	 * This is for setting an image to the text input disable state. It is best to set an image that can be tiled.
	 */
	
	function setDisableBackgroundImage(value : Bitmap) : Void;  
	
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