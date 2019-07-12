package com.chaos.ui.classInterface;


import openfl.display.BitmapData;
import openfl.display.DisplayObject;


interface ITabPane
{
    /**
	 * Switch the TabPane to the section as if the button was pressed. This will remove whatever content that is currenly being used and replace it with new data.
	 */

	var selectedIndex(get, set) : Int;      
	
	/**
	 * Set the color of the TabPane button text field color
	 */
	
	var tabButtonTextColor(get, set) : Int;      
	/**
	 * Set the color of the TabPane button text field color in it's selected state
	 */
	
	var tabButtonTextSelectedColor(get, set) : Int;      
	
	/**
	 * Set the color of the tab button
	 */
	
	var tabButtonColor(get, set) : Int;      
	/**
	 * Set the color of the tab button over state
	 */

	var tabButtonOverColor(get, set) : Int;      
	/**
	 * Set the color of the tab button selected state
	 */
	
	var tabButtonSelectedColor(get, set) : Int;      
	/**
	 * Set the color of the tab button disabled state
	 */
	
	var tabButtonDisableColor(get, set) : Int;
	
	/**
	 * Return the TabPane buton being used.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 * @return Return button being on TabPane
	 */
	
	function getTabButton(value : Int = -1) : IButton;  
	
	/**
	 * Appends an item to the end of the data provider.
	 *
	 * @param value Appends an item to the end of the data provider.
	 * @param content The DisplayObject you want to attach to the button click.
	 *
	 * @return Returns a object with the TabPane with the label,button and the content if it was attached.
	 */
	
	function addItem(value : String, content : DisplayObject) : Dynamic;  
	
	/**
	 * Removes the specified item from the
	 *
	 * @param item  Item to be removed.
	 *
	 */
	
	function removeItem(value : String) : Dynamic;  
	
	/**
	 * Removes the item at the specified index
	 *
	 * @param index  The index at which the item is to be added.
	 */
	
	function removeItemAt(value : Int) : Dynamic;  


	/**
	 * Set a image to the tab buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 

	function setTabButtonDefaultImage(value : BitmapData) : Void;  

	
	/**
	 * Set a image to the tab buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setTabButtonOverImage(value : BitmapData) : Void;
	
	
	/**
	 * Set a image to the tab up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 

	function setTabButtonDownImage(value : BitmapData) : Void; 

	
	/**
	 * Set a image to the tab up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setTabButtonDisableImage(value : BitmapData) : Void;
	
}