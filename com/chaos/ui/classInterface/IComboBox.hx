package com.chaos.ui.classInterface;


import com.chaos.data.DataProvider;
import com.chaos.ui.data.ComboBoxObjectData;
import openfl.display.Bitmap;
import openfl.text.Font;
import openfl.text.TextFormat;
import openfl.display.DisplayObject;
import com.chaos.ui.Label;

interface IComboBox extends IBaseUI
{
    /**
	 * Return a int value of the current selected item
	 */
	var selectedIndex(get, never) : Int;      
	/**
	 * Replace the current data provider
	 */

	var dataProvider(get, set) : DataProvider;
	/**
	 * Set the track size of the scrollbar
	 */

	var trackSize(get, set) : Int;     
	/**
	 * If you want to use the scrollbar arrow buttons or not, pass  ScrollBarDirection.HORIZONTAL or ScrollBarDirection.VERTICAL.
	 */

	var showArrowButton(get, set) : Bool;      
	/**
	 * Set the size of the button used on the combo box. The width is based on the height of the combox box.
	 */

	var buttonWidth(get, set) : Int;      
	/**
	 * Set the color of the button
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
	 * Make it so the label can be clicked to show items much like dropdown
	 */

	var clickLabelArea(get, set) : Bool;      
	
	/**
	 * Set the text for the main label on the combo box. This will be replace
	 */

	var text(get, set) : String;      
	/**
	 * Returns text label used on the combo box selected item area
	 */ 
	var label(get, never) : Label;      
	/**
	 * The color of the text in a label, in hexadecimal format.
	 */

	var textColor(get, set) : Int;      
	/**
	 * The color of the text in a label for it's roll over state
	 */ 

	var textOverColor(get, set) : Int;      
	/**
	 * The color of the text in a label for it's down state
	 */

	var textDownColor(get, set) : Int;     
	/**
	 * The color of the text roll over background
	 */

	var backgroundColor(get, set) : Int;      
	/**
	 * The color of the text roll over background
	 */

	var textOverBackground(get, set) : Int;      
	
	/**
	 * The color of the combo box border
	 */
	var borderColor(get, set) : Int;      
	
	/**
	 * The border alpha being used around the combo box
	 */ 
	var borderAlpha(get, set) : Float;      
	
	/**
	 * Returns the number of objects being used in combox box
	 */
	var length(get, never) : Int;      
	/**
	 * The number of items that will be display once the user click the drop down button
	 */
	var rowCount(get, set) : Int;      
	/**
	 * Set the color of the track
	 */
	var scrollBarTrackColor(get, set) : Int;
	/**
	 * This is for setting an image to the drop down button default state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	function setButtonBackgroundImage(value : String) : Void;  
	/**
	 * This is for setting an image to the drop down button default state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 

	function setButtonBackgroundBitmap(value : Bitmap) : Void;  
	/**
	 * This is for setting an image to the drop down button roll over state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	function setButtonOverBackgroundImage(value : String) : Void;  
	/**
	 * This is for setting an image to the drop down button roll over state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	function setButtonOverBackgroundBitmap(value : Bitmap) : Void;  
	/**
	 * This is for setting an image to the drop down button roll down state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	function setButtonDownBackgroundImage(value : String) : Void;  
	/**
	 * This is for setting an image to the drop down button roll down state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	function setButtonDownBackgroundBitmap(value : Bitmap) : Void;  
	/**
	 * This is for setting an image to the drop down button disable state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	function setButtonDisableBackgroundImage(value : String) : Void;  
	/**
	 * This is for setting an image to the drop down button disable state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	function setButtonDisableBackgroundBitmap(value : Bitmap) : Void;  
	
	/**
	 * Configure and setup the label to handle embedded fonts
	 *
	 * @param value The font you want to use.
	 *
	 */
	
	function setEmbedFont(value : Font) : Void;  
	/**
	 * Unload the font that was set by using the setEmbedFont
	 *
	 */ 
	
	function unloadEmbedFont() : Void;  
	/**
	 * Applies the text formatting that the format parameter specifies to the specified text in a label.
	 *
	 * @param format A TextFormat object that contains character and paragraph formatting information.
	 */
	
	function setTextFormat(value : TextFormat) : Void;  
	/**
	 * Set the icon being used on the button based on the DisplayObject passed in
	 *
	 * @param	value A DisplayObject that will be used as an icon
	 */
	
	function setDropIcon(value : DisplayObject) : Void;  
	
	/**
	 * Set the icon used on the button based on a URL location
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	function setDropIconImage(value : String) : Void;  
	
	/**
	 * Set the icon used on the drop down button
	 *
	 * @param value The icon you want to use for
	 *
	 */  
	function setDropIconBitmap(value : Bitmap) : Void;  
	
	/**
	 * This is for setting an image to the combo box.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	function setBackgroundImage(value : String) : Void;  
	/**
	 * This is for setting an image to the combox box. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	function setBackgroundBitmap(value : Bitmap) : Void;  
	/**
	 * This is for setting an image to the combo box once using click the drop down button.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */  
	
	function setDropDownBackgroundImage(value : String) : Void;  
	
	/**
	 * This is for setting an image to the combox box once using click the drop down button. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	

	function setDropDownBackgroundBitmap(value : Bitmap) : Void;
	
	/**
	 * Appends an item to the end of the data provider.
	 *
	 * @param item Appends an item to the end of the data provider.
	 *
	 */ 
	
	function addItem(item : ComboBoxObjectData) : Void;  
	
	/**
	 * Removes the specified item from the
	 *
	 * @param item  Item to be removed.
	 *
	 */ 
	
	function removeItem(item : ComboBoxObjectData) : ComboBoxObjectData; 
	
	/**
	 * Removes the item at the specified index
	 *
	 * @param index  The index at which the item is to be added.
	 */
	
	function removeItemAt(index : Int) : ComboBoxObjectData;  
	
	/**
	 * Replaces an existing item with a new item
	 *
	 * @param newItem The item to be replaced.
	 * @param oldItem The replacement item.
	 */
	
	function replaceItem(newItem : ComboBoxObjectData, oldItem : ComboBoxObjectData) : Void;  
	
	/**
	 * Replaces the item at the specified index
	 *
	 * @param newItem The replacement item.
	 * @param index The replacement item.
	 */ 
	
	function replaceItemAt(newItem : ComboBoxObjectData, index : Int) : ComboBoxObjectData;  
	/**
	 * Returns the item at the specified index.
	 *
	 * @param value Location of the item to be returned.
	 * @return The item at the specified index.
	 *
	 */
	
	function getItemAt(value : Int) : ComboBoxObjectData;  
	/**
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index. Returns null if nothing was selected
	 *
	 */
	
	function getSelected() : ComboBoxObjectData;  
	/**
	 * Sorts the items that the data
	 *
	 * @param sortOpt The arguments to use for sorting.
	 * @return The return value depends on whether the method receives any arguments.
	 *
	 */
	function sort(sortOpt : Dynamic) : Void;  
	/**
	 * Set the scrollbar up icon using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	
	function setScrollBarUpIconImage(value : String) : Void;  
	/**
	 * Set a image to the scrollbar up icon.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	function setScrollBarUpIconBitmap(value : Bitmap) : Void; 
	/**
	 * Set the scrollbar down icon using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	function setScrollBarDownIconImage(value : String) : Void; 
	/**
	 * Set a image to the scrollbar down icon.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	function setScrollBarDownIconBitmap(value : Bitmap) : Void;  
	/**
	 * Set a image to the scrollbar buttons default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	function setScrollButtonBackgroundImage(value : String) : Void; 
	/**
	 * Set a image to the scrollbar buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	function setScrollButtonBackgroundBitmap(value : Bitmap) : Void; 
	/**
	 * Set a image to the scrollbar buttons over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	function setScrollButtonOverBackgroundImage(value : String) : Void;
	/**
	 * Set a image to the scrollbar buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	function setScrollButtonOverBackgroundBitmap(value : Bitmap) : Void;
	/**
	 * Set a image to the scrollbar up button down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	function setScrollButtonDownBackgroundImage(value : String) : Void; 
	/**
	 * Set a image to the scrollbar up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	function setScrollButtonDownBackgroundBitmap(value : Bitmap) : Void; 
	/**
	 * Set a image to the scrollbar up button disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */  
	function setScrollButtonDisableBackgroundImage(value : String) : Void; 
	/**
	 * Set a image to the scrollbar up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	function setScrollButtonDisableBackgroundBitmap(value : Bitmap) : Void;
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
	function setScrollBarTrackImage(value : String) : Void;  
	/**
	 * Set a image to the scrollbar track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	function setScrollBarTrackBitmap(value : Bitmap) : Void;  
	/**
	 * Return the scrollbar used in combo box
	 * @return A scroll bar interface
	 */ 
	function getScrollBar() : IScrollBar; 
	/**
	 * Opens the combo box so the user can select an item
	 *
	 */ 
	function open() : Void; 
	/**
	 * Close the combo box
	 *
	 */ 
	function close() : Void;
}