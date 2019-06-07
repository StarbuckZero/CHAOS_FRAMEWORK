package com.chaos.ui.classInterface;

import openfl.display.BitmapData;
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
		 * Specifies whether the label has a border. If true, the label has a border. If false, the label has no border.
		 */
		 var border(get, set) : Bool;    
		 /**
		 * The color of the label border.
		 */
		 
		 var borderColor(get, set) : Int; 
		 /**
		 * Border thinkness
		 */

		 var borderThinkness(get, set) : Float;  
		 /**
		 * Specifies whether the label has a background fill. If true, the label has a background fill. If false, the label has no background fill.
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
		 * Set the alpha between 1 to 0
		 */

		 var borderAlpha(get, set) : Float;  
		 
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
		 * Set if the label text is editable
		 */

		 var editable(get, set) : Bool;
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
		 * Set the icon to be used in the label
		 *
		 * @param	value The icon you want to use for the label
		 */ 
		function setDisplayIcon(value : BitmapData) : Void;
}