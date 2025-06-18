package com.chaos.ui.classInterface;

import openfl.text.TextField;
import openfl.text.Font;
import openfl.text.TextFormat;

interface ILabel extends IBaseUI
{
	/**
	 * Return the text field that is being used
	 */

	var textField(get, never) : TextField;
	
	/**
	* Set the text format
	*/

	var textFormat(get, set) : TextFormat;

	/**
	* Set the label text
	*/

	var text(get, set) : String;

	/**
	* Contains the HTML representation of the label
	*/

	var htmlText(get, set) : String;

	/**
	* The color of the label background
	*/

	var backgroundColor(get, set) : Int;

	/**
	* Set the alignment of the label text
	*/

	var align(get, set) : String;

	/**
	* Specifies whether the label has a background fill. If true, the label has a background fill. If false, the label has no background fill.
	*/

	var background(get, set) : Bool;

	/**
	* The color of the text in a label, in hexadecimal format
	*/

	var textColor(get, set) : Int;

	/**
	* The font you want to set the label to
	*/

	var font(get, set) : String;

	/**
	* The size of the text
	*/

	var size(get, set) : Dynamic;

	/**
	* Set if the label text is italic
	*/

	var italic(get, set) : Bool;	

	/**
	* Set if the label text is bold
	*/

	var bold(get, set) : Bool;

	/**
	* Set if the label text is editable
	*/

	var editable(get, set) : Bool;
	
	/**
	 * Convert label to bitmap
	 */
	
	var bitmapMode (get, set): Bool;

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

}