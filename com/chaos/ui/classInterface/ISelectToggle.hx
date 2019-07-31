package com.chaos.ui.classInterface;
import openfl.display.BitmapData;

/**
 * @author Erick Feiling
 */
interface ISelectToggle extends IToggleButton
{
  
	/**
	 * Return the label
	 */
	
	var label(get, never) : ILabel;   	
	
	
	/**
	 * Can toggle state by clicking text as well
	 */
	
	var textSelectable(get, set) : Bool;
	
	/**
	 * Button size
	 */
	var buttonSize(get, set) : Int;	
	
	/**
	 * Line alpha
	 */
	var lineAlpha(get, set) : Float;
	
	/**
	 * Line size
	 */
	public var lineSize(get, set) : Float;
	
	
	/**
	 * Set default state
	 * @param	value the bitmap data for default state
	 */
	
	function setSelectedDefaultStateImage( value:BitmapData ) : Void;
	/**
	 * Set over state
	 * @param	value the bitmap data for over state
	 */
	
	function setSelectedOverStateImage( value:BitmapData ) : Void;
	
	/**
	 * Set selected state
	 * @param	value the bitmap data for selected state
	 */
	
	function setSelectedDownStateImage( value:BitmapData ) : Void;
	
	/**
	 * Set disable state
	 * @param	value the bitmap data for disable state
	 */
	
	function setSelectedDisableStateImage( value:BitmapData) : Void;
	
}