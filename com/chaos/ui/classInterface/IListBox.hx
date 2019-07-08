package com.chaos.ui.classInterface;

import com.chaos.ui.data.ListObjectData;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.text.Font;

import com.chaos.data.DataProvider;

interface IListBox extends IScrollPane
{
    /**
	 * Outline color
	 */

	var outlineColor(get, set) : Int;

    /**
	 * Outline alpha
	 */


	var outlineAlpha(get, set) : Float;

    /**
	 * Set the align on all the labels
	 */
	
	var textAlign(get, set) : String;    
	
	/**
	 * The default label color
	 */

	var textColor(get, set) : Int;      
	
	/**
	 * Set the roll over state
	 */
	
	var textOverColor(get, set) : Int;   
	
	/**
	 * Set the selected of the label
	 */
	
	var textSelectedColor(get, set) : Int;      
	
	/**
	 * The selected text background
	 */
	var textSelectedBackground(get, set) : Int;  
	
	/**
	 * The user can select more then one item on the list
	 */
	
	var allowMultipleSelection(get, set) : Bool;      
	
	/**
	 * Replace the current data provider
	 */ 
	
	var dataProvider(get, set) : DataProvider<ListObjectData>;
	
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
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index.
	 *
	 */
	
	function getSelected() : ListObjectData;  
	/**
	 * A list of selected items
	 * @return An array with selected list items
	 */
	
	function getSelectedList() : Array<Dynamic>;  
	
	/**
	 * Return the index number of the item that was selected
	 */
	
	function selectIndex() : Int;  

}