package com.chaos.ui.classInterface;


import openfl.display.Bitmap;
import openfl.display.DisplayObject;

interface IScrollBar extends ISlider
{

	/**
	 * The amount in percent wise to when it comes to scroll amount
	 */
	
	var scrollAmount(get, set) : Float;      
	
	/**
	 * Set if the slider will resize itself based on the content size
	 */
	
	var sliderActiveResize(get, set) : Bool;      
	
	/**
	 * If you want to use the scrollbar arrow buttons or not
	 */
	
	var showArrowButton(get, set) : Bool;     
	
	/**
	 * Set the size of the button used on the scrollbar
	 */
	
	var buttonWidth(get, set) : Int;      
	/**
	 * Set the size of the button used on the scrollbar
	 */

	var buttonHeight(get, set) : Int;      
	/**
	 * Set the color of the button
	 */  
	
	var buttonColor(get, set) : Int;      
	
	/**
	 * Set the color of the button over state
	 */
	
	var buttonOverColor(get, set) : Int;      
	
	/**
	 * Set the color of the button down state
	 */
	
	var buttonDownColor(get, set) : Int;      
	
	/**
	 * Set the color of the button disabled state
	 */
	
	
	var buttonDisableColor(get, set) : Int;      
	
	/**
	 * Set the slider size based on the direction. If ScrollBarDirection.VERTICAL being used it adjust the height and if ScrollBarDirection.HORIZONTAL it adjust the width.
	 */  
	
	var sliderSize(get, set) : Float; 
	
	/**
	 * Set the track size of the scrollbar
	 */
	
	var trackSize(get, set) : Float;
	
	/**
	 * Set the icon to be used inside the button based on a DisplayObject
	 *
	 * @param value The display object that will be used
	 */
	
	function setUpIcon(value : DisplayObject) : Void; 
	
	/**
	 * Set the icon used on the button based on a URL location
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setUpIconImage(value : String) : Void;  
	
	/**
	 * Set the icon used on the button based on a Bitmap image
	 *
	 * @param value Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setUpIconBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the icon to be used inside the button based on a DisplayObject
	 *
	 * @param value The display object that will be used
	 */ 
	
	function setDownIcon(value : DisplayObject) : Void;  
	
	/**
	 * Set the scrollbar down icon using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the OpenFL your using supports.
	 *
	 */
	
	function setDownIconImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar down icon.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setDownIconBitmap(value : Bitmap) : Void;
	
	/**
	 * Set a image to the scrollbar buttons default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the OpenFL your using supports.
	 *
	 */ 
	
	function setButtonBackgroundImage(value : String) : Void; 
	
	/**
	 * Set a image to the scrollbar buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setButtonBackgroundBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set a image to the scrollbar buttons over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the OpenFL your using supports.
	 *
	 */
	
	function setButtonOverBackgroundImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setButtonOverBackgroundBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set a image to the scrollbar up button down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the OpenFL your using supports.
	 *
	 */
	
	function setButtonDownBackgroundImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	function setButtonDownBackgroundBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set a image to the scrollbar up button disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the OpenFL your using supports.
	 *
	 */
	
	function setButtonDisableBackgroundImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setButtonDisableBackgroundBitmap(value : Bitmap) : Void;
	
}