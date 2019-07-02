package com.chaos.ui.classInterface;

import com.chaos.ui.data.ListObjectData;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.text.Font;

import com.chaos.data.DataProvider;

interface IList extends IScrollPane
{
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
	 * Appends an item to the end of the data provider.
	 *
	 * @param item Appends an item to the end of the data provider.
	 *
	 */ 
	
	function addItem(item : ListObjectData) : Void;
	
	/**
	 * Removes the specified item from the
	 *
	 * @param item  Item to be removed.
	 *
	 */
	
	function removeItem(item : ListObjectData) : ListObjectData;  
	/**
	 * Remove all items out of the list
	 */
	
	function removeAll() : Void;  
	
	/**
	 * Replaces an existing item with a new item
	 *
	 * @param newItem The item to be replaced.
	 * @param oldItem The replacement item.
	 */
		
	function replaceItem(newItem : ListObjectData, oldItem : ListObjectData) : Void;  
	
	/**
	 * Replaces the item at the specified index
	 *
	 * @param newItem The replacement item.
	 * @param index The replacement item.
	 */
	
	function replaceItemAt(newItem : ListObjectData, index : Int) : ListObjectData;  
	
	/**
	 * Returns the item at the specified index.
	 *
	 * @param value Location of the item to be returned.
	 * @return The item at the specified index.
	 *
	 */
	
	function getItemAt(value : Int) : ListObjectData;  
	
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
	/**
	 * Returns the listed item in the list
	 */ 
	
	function selectText() : String;
}