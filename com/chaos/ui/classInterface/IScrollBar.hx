package com.chaos.ui.classInterface;



interface IScrollBar extends ISlider
{
	
	/**
	 * Up Button for scroll bar
	 */
	
	var upButton(get, never) : IButton;      

	
	/**
	 * Down Button for scroll bar
	 */
	
	var downButton(get, never) : IButton;      
	

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
	 * Set the slider size based on the direction. If ScrollBarDirection.VERTICAL being used it adjust the height and if ScrollBarDirection.HORIZONTAL it adjust the width.
	 */  
	
	var sliderSize(get, set) : Float; 
	
	/**
	 * Set the track size of the scrollbar
	 */
	
	var trackSize(get, set) : Float;
	
	
	
}