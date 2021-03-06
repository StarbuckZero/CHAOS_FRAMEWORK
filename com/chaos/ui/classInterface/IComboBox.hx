package com.chaos.ui.classInterface;

import com.chaos.data.DataProvider;
import com.chaos.ui.data.ComboBoxObjectData;
import openfl.display.BitmapData;
import openfl.text.Font;
import openfl.text.TextFormat;


interface IComboBox extends IBaseUI
{
	/**
	 * Drop Down Button
	 */

	var dropButton(get, never) : IButton;

	/**
	 * ScrollBar
	 */

	var scrollbar(get, never) : IScrollBar;

	/**
	 * Current selected item
	 */
	var selectedIndex(get, never) : Int;


	/**
	 * Set the track size of the scrollbar
	 */

	var trackSize(get, set) : Int;
	
	/**
	 * Set the size of the button used on the combo box. The width is based on the height of the combox box.
	 */

	var buttonWidth(get, set) : Int;

	/**
	 * Make it so the label can be clicked to show items much like dropdown
	 */

	var clickLabelArea(get, set) : Bool;
	
	/**
	 * Replace the current data provider
	 */

	var dataProvider(get, set) : DataProvider<ComboBoxObjectData>;	

	/**
	 * Set the text for the main label on the combo box. This will be replace
	 */

	var text(get, set) : String;

	/**
	 * Returns text label used on the combo box selected item area
	 */

	var label(get, never) : ILabel;

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
	 * The combo box border thinkness
	 */

	var borderThinkness(get, set) : Float;

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
	 * Set spacing for
	 */

	var dropDownPadding(get, set) : Int;

	/**
	 * Set the alignment of the drop down labels
	 */

	var align(get, set) : String;	

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
	 * This is for setting an image to the combox box. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	function setBackgroundImage(value : BitmapData) : Void;

	/**
	 * This is for setting an image to the combox box once using click the drop down button. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */

	function setDropDownBackgroundImage(value : BitmapData) : Void;
	
	/**
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index. Returns null if nothing was selected
	 *
	 */

	function getSelected() : ComboBoxObjectData;


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