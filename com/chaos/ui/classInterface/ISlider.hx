package com.chaos.ui.classInterface;


import openfl.display.BitmapData;
import openfl.display.Shape;

interface ISlider extends IBaseUI
{
	
	
    /**
	 * This will rotate the image by 90
	 */ 
	
	var track(get, never) : Shape;     
	
	
    /**
	 * This will rotate the image by 90
	 */ 
	
	var marker(get, never) : IButton;     
	
	
	
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
	 * Set a image to the track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	
	function setTrackImage(value : BitmapData) : Void;  
	
	
	/**
	 * Set a image to the slider default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderImage(value : BitmapData) : Void;  
	

	
	/**
	 * Set a image to the scrollbar slider over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderOverImage(value : BitmapData) : Void; 
	

	/**
	 * Set a image to the slider down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderDownImage(value : BitmapData) : Void; 
	
 
	
	/**
	 * Set a image to the slider disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setSliderDisableImage(value : BitmapData) : Void;
	
	/**
	 * Stop the slider from moving
	 */
	
	function stop() : Void;
}