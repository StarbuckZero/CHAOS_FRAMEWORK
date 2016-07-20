package com.chaos.ui.classInterface;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;


interface IScrollPane extends IBaseContainer
{
    /**
	 * Returns the bottom horizontal scrollbar being used
	 */
	var scrollBarH(get, never) : IScrollBar;      
	
	/**
	 * Returns the vertical scrollbar on the righ side
	 */
	
	var scrollBarV(get, never) : IScrollBar;  
    
	/**
	 * Set the track size of the scrollbar
	 */

	var trackSize(get, set) : Float;      
	/**
	 * Places a DisplayObject in the ScrollPane
	 */

	var source(get, set) : DisplayObject;      
	
	/**
	 * Change the ScrollBar settings on the ScrollPane. This changes the way the scrollbars react to content.
	 * The settings are ScrollPolicy.AUTO,ScrollPolicy.VERTICAL_ONLY,ScrollPolicy.HORIZONTAL_ONLY,ScrollPolicy.ON or ScrollPolicy.OFF.
	 *
	 * @see com.chaos.ui.ScrollPolicy
	 */
	

	var mode(get, set) : String;      
	
	/**
	 * If you want to use the scrollbar arrow buttons or not
	 */   
	
	var showArrowButton(get, set) : Bool;      
	
	/**
	 * Set the size of the button used on the ScrollPane. The width is based on the height of the ScrollPane.
	 */  

	var buttonWidth(get, set) : Int;      
	
	/**
	 * Set the size of the button used on the ScrollPane. The height is based on the height of the ScrollPane.
	 */  

	var buttonHeight(get, set) : Int;      
	
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
	 * Set the color of the track
	 */    
	
	var trackColor(get, set) : Int;      
	
	/**
	 * Set the color of the slider
	 */
	
	var sliderColor(get, set) : Int;      
	/**
	 * Set the color of the slider over state
	 */

	var sliderOverColor(get, set) : Int;      
	
	/**
	 * Set the color of the slider down state
	 */
	
	var sliderDownColor(get, set) : Int;      
	
	/**
	 * Set the color of the buttons
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
	 * Reload the content that is inside the ScrollPane
	 */
	
	function refreshPane() : Void;  
	
	/**
	 * Update the content area, this is needed for when the content loaded inside the ScrollPane size has changed
	 */
	
	function update() : Void;  
	
	/**
	 * Set the up icon
	 *
	 * @param	value A DisplayObject that you want to use
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
	 * Set the scrollbar down icon using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
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
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
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
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
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
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
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
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
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
	
	/**
	 * Set the scrollbar slider default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setSliderImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar slider default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the scrollbar slider over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setSliderOverImage(value : String) : Void;  
	
	/**
	 * Set a image to the scrollbar slider over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setSliderOverBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the scrollbar slider down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setSliderDownImage(value : String) : Void;
	
	/**
	 * Set a image to the scrollbar slider down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setSliderDownBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the scrollbar track using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setTrackImage(value : String) : Void; 
	
	/**
	 * Set a image to the scrollbar track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setTrackBitmap(value : Bitmap) : Void;
}