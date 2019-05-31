package com.chaos.ui.classInterface;

/**
 * ...
 * @author Erick Feiling
 */


import openfl.display.BitmapData;
import openfl.display.Sprite;

interface IBubble extends IOverlay
{

	/**
	 * If true this will apply a mask content layer
	 */


	var useMask(get, set) : Bool;


	/**
	 * Toggle on and off border
	 */

	var border(get, set) : Bool;

	/**
	 * The border color
	 */


	var borderColor(get, set) : Int;

	/**
	 * Set the alpha between 1 to 0. For example 0.4
	 */


	var borderAlpha(get, set) : Float;

	/**
	 * The border thinkness
	 */


	var borderThinkness(get, set) : Float;

	/**
	 * The background color of the bubble
	 */

	var backgroundColor(get, set) : Int;

	/**
	 * The background alpha
	 */

	var backgroundAlpha(get, set) : Float;

	/**
	 * Show the tail of the bubble
	 */

	var showTail(get, set) : Bool;

	/**
	 * The size of the tail
	 */


	var tailSize(get, set) : Float;

	/**
	 * Set the placement of the tail which could be "top", "bottom", "left" or "right"
	 */

	var tailPlacement(get, set) : String;

	/**
	 * The tail location, this only works if the tailAutoCenter is false
	 */

	var tailLocation(never, set) : Float;

	/**
	 * Set to true if you want the tail to be auto center on the bubble
	 */


	var tailAutoCenter(get, set) : Bool;

	/**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */

	var content(get, never) : Sprite;

	/**
	 * How rounded the edges of the bubble will be
	 */


	var rounded(get, set) : Int;

	/**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */

	function setBackgroundImage(value : BitmapData) : Void;

}

