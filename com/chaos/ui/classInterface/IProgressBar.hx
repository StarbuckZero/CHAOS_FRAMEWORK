package com.chaos.ui.classInterface;

import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.text.Font;
import com.chaos.ui.Label;

interface IProgressBar extends com.chaos.ui.classInterface.IBaseUI
{
    /**
	 * Returns the label being used in the ProgressBar
	 */
	var label(get, never) : Label;      
	
	/**
	 * Returns the loaded label being used in the ProgressBar
	 */
	var loadedLabel(get, never) : Label;      
	
	/**
	 * Toggle on and off border
	 */

	var border(get, set) : Bool;      
	/**
	 * The ProgressBar border color
	 */

	var borderColor(get, set) : Int;      
	/**
	 * Specifies the border thinkness
	 */
	var borderThinkness(get, set) : Float;      
	/**
	 * Specifies the border alpha
	 */   
	var borderAlpha(get, set) : Float;     
	/**
	 * Set the color of the ProgressBar background
	 */
	var backgroundColor(get, set) : Int;      
	/**
	 * Set this if you want to show the ProgressBar label used to show the amount of data loaded
	 */  
	var showLabel(get, set) : Bool;      
	/**
	 * The color that is used once progress has been made
	 */ 
	var loadColor(get, set) : Int;      
	/**
	 * The color of the text in a label, in hexadecimal format.
	 */
	var textColor(get, set) : Int;     
	/**
	 * The color of the text in a loaded label, in hexadecimal format.
	 */
	var textLoadColor(get, set) : Int;      
	/**
	 * Set the alignment of the label text
	 *
	 * @param value The text that you want to set on the label
	 */
	var align(get, set) : String;   
	/**
	 * Set how much of the ProgressBar is loaded or complete. This is another way of showing how much data is loaded without using the watchURL method.
	 */ 
	var percent(get, set) : Int;   
	/**
	 * Enable or Disable filters
	 */  
	var filterMode(get, set) : Bool;
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
	 * This is for setting an image to the ProgressBar background.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
		
	function setBackgroundImage(value : String) : Void; 
	
	/**
	 * This is for setting an image to the ProgressBar. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	function setBackgroundBitmap(value : Bitmap) : Void;
	
	/**
	 * This is for setting an image to the ProgressBar loaded background.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	
	function setLoadBarImage(value : String) : Void;
	
	/**
	 * This is for setting an image to the ProgressBar loaded background. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setLoadBarBitmap(value : Bitmap) : Void;  
	/**
	 * The object you want the ProgressBar to use when it comes to showing how much of the file is loaded.
	 * This value goes from 0 to 100 and can only be linked to one file.
	 *
	 * Support Types are: Sound, URLLoader, Loader and XML
	 *
	 * @param value The object you want to apply the watcher for updated the ProgressBar
	 *
	 */ 
	
	function watchObject(value : Dynamic) : Void;  
	/**
	 * Stop ProgressBar from keeping track of how much of a file is loaded
	 */ 
	
	function stopWatchObject() : Void;
}