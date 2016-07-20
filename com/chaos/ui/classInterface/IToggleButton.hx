package com.chaos.ui.classInterface;

import openfl.display.Sprite;
import openfl.display.Shape;

interface IToggleButton extends IBaseUI
{
    /**
	 * Set if you want the button to be selected or not
	 */
	
	var selected(get, set) : Bool;     
	
	/**
	 * Return the toggle button
	 */
	
	var toggleButton(get, never) : Sprite;
	
	/**
	 * This is for setting an shape for the button over stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	
	function setOverState(value : Shape) : Void;  
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	
	function setDownState(value : Shape) : Void; 
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	
	function setDisableState(value : Shape) : Void;
}