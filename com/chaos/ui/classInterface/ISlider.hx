package com.chaos.ui.classInterface;

import openfl.display.Bitmap;

interface ISlider extends com.chaos.ui.classInterface.IBaseUI
{
    /**
	 * This will rotate the image by 90
	 */ 
	
	var rotateImage(get, set) : Bool;     
	/**
	 * Hides or show the track for the slider bar
	 */ 
	
	var showTrack(get, set) : Bool;      
	
	/**
	 * Slider offset
	 */ 
	
	var sliderOffSet(get, set) : Float;      
	
	/**
	 * The percent is represented as a value between 0 and 1.
	 */
	
	var percent(get, set) : Float; 
	
	/**
	 * Set the direction of the slider, this use the same static class to set the direction just like the scrollbar classe. ScrollBarDirection.HORIZONTAL or ScrollBarDirection.VERTICAL
	 *
	 * @see com.chaos.ui.ScrollBarDirection;
	 */
	
	var direction(get, set) : String;      
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
	 * Set the color of the slider disabled state
	 */
	
	var sliderDisableColor(get, set) : Int;      
	
	/**
	 * Set the slider width
	 */
	
	var sliderWidth(get, set) : Float;      
	
	/**
	 * Set the slider height
	 */
	
	var sliderHeight(get, set) : Float;      
	
	/**
	 * Set the slider track width
	 */
	
	var trackWidth(get, set) : Float;      
	
	/**
	 * Set the slider track height
	 */
	
	var trackHeight(get, set) : Float;
	
	/**
	 * Set the track using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setTrackImage(value : String) : Void;  
	
	/**
	 * Set a image to the track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setTrackBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the slider default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	
	function setSliderImage(value : String) : Void;  
	
	/**
	 * Set a image to the slider default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderBitmap(value : Bitmap) : Void;  
	
	/**
	 * Set the slider over state using a file path
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
	 * Set the slider down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setSliderDownImage(value : String) : Void; 
	
	/**
	 * Set a image to the slider down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderDownBitmap(value : Bitmap) : Void; 
	
	/**
	 * Set the slider disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setSliderDisableImage(value : String) : Void;  
	
	/**
	 * Set a image to the slider disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderDisableBitmap(value : Bitmap) : Void;
	
	/**
	 * Stop the slider from moving
	 */
	
	function stop() : Void;
}