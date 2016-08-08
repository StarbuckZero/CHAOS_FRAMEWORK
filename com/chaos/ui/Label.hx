package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.text.Font;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;
import com.chaos.ui.BaseUI;
import com.chaos.ui.UIDetailLevel;
//import com.chaos.ui.interface.ILabel;
//import com.chaos.ui.interface.IBaseUI;  

/**
 *  Creates a Label for develop to place text on the stage or in another display object.
 *  This is a nice wrapper around Text Field which handles a lot of things.
 *
 *  @author Erick Feiling
 *  @date 11-5-09
 */

class Label extends BaseUI implements ILabel implements IBaseUI
{
	
    public var showIcon(get, set) : Bool;
    public var textField(get, never) : TextField;
    public var textFormat(get, set) : TextFormat;
    public var text(get, set) : String;
    public var align(get, set) : String;
    public var htmlText(get, set) : String;
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderAlpha(get, set) : Float;
    public var backgroundColor(get, set) : Int;
    public var borderThinkness(get, set) : Float;
    public var background(get, set) : Bool;
    public var textColor(get, set) : Int;
    public var size(get, set) : Dynamic;
    public var font(get, set) : String;
    public var editable(get, set) : Bool;
	
  /** The type of UI Element */
  public static inline var TYPE : String = "Label";
  private var _textField : TextField;
  private var _textFormat : TextFormat;
  private var _text : String = "";
  private var _align : String = "center";
  //private var _enabled : Bool = true;
  private var _editable : Bool = false;
  private var _embedFonts : Bool = false;
  private var _textColor : Int = 0x000000;
  private var _font : Font; private var _beginIndex : Int = -1;
  private var _endIndex : Int = -1;
  private var _background : Bool = false;
  private var _backgroundColor : Int = 0xFFFFFF;
  private var _border : Bool = false;
  private var _borderColor : Int = 0x000000;
  private var _width : Float; private var _height : Float;
  private var _thinkness : Float = 1;
  private var _outlineColor : Int = 0x000000;
  private var _outlineAlpha : Float = 1;
  private var _bgAlpha : Float = .2;
  private var _showIcon : Bool = false;
  private var _displayIcon : DisplayObject = null;
  private var _outline : Shape;
  
	public function new(labelText : String = "", labelWidth : Int = 100, labelHeight : Int = 20)
	{
		_width = labelWidth;
		_height = labelHeight;

		super();

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);

		init();
		
		
		textField.text = labelText;
		draw();
	}
	
	

	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	public function init() : Void
	{
		// Setup core fonts
		_textField = new TextField();
		_textFormat = new TextFormat();
		_font = new Font();
		
		// Add if offset & align
		_textField.multiline = true;
		_textField.wordWrap = true;
		_textField.background = _background;
		_textField.backgroundColor = _backgroundColor;
		_textField.type = TextFieldType.DYNAMIC;
		_textField.border = false;
		_textFormat.indent = UIStyleManager.LABEL_INDENT;
		_textFormat.color = _textColor;
		_textFormat.align = _align; 
		
		// Draw border  
		_outline = new Shape(); 
		
		// Setup height
		_textField.width = _width;
		_textField.height = _height;
		
		// Add to display
		addChild(_outline);
		addChild(_textField); 
		
		// Setup style and skinning 
		reskin();
    }
	
	private function initStyle() : Void
	{
		if ( -1 != UIStyleManager.LABEL_BORDER_THINKNESS)
		_thinkness = UIStyleManager.LABEL_BORDER_THINKNESS;
		
		if ( -1 != UIStyleManager.LABEL_BORDER_COLOR)
		_outlineColor = UIStyleManager.LABEL_BORDER_COLOR;
		
		if ( -1 != UIStyleManager.LABEL_BORDER_ALPHA)
		_outlineAlpha = UIStyleManager.LABEL_BORDER_ALPHA;
		
		if ( -1 != UIStyleManager.LABEL_TEXT_COLOR)
		_textFormat.color = UIStyleManager.LABEL_TEXT_COLOR;
		
		if ( -1 != UIStyleManager.LABEL_BACKGROUND_COLOR)
		backgroundColor = UIStyleManager.LABEL_BACKGROUND_COLOR;
		
		if ("" != UIStyleManager.LABEL_TEXT_ALIGN)
		_textFormat.align = UIStyleManager.LABEL_TEXT_ALIGN;
		
		if ( -1 != UIStyleManager.LABEL_TEXT_SIZE)
		_textFormat.size = UIStyleManager.LABEL_TEXT_SIZE;
		
		if (null != UIStyleManager.LABEL_TEXT_EMBED)
		setEmbedFont(UIStyleManager.LABEL_TEXT_EMBED);
		
		_background = UIStyleManager.LABEL_BACKGROUND;
		_border = UIStyleManager.LABEL_BORDER;
		
		if ("" != UIStyleManager.LABEL_TEXT_FONT)
		_textFormat.font = UIStyleManager.LABEL_TEXT_FONT;
		
		_textFormat.bold = UIStyleManager.LABEL_TEXT_BOLD;
		_textFormat.italic = UIStyleManager.LABEL_TEXT_ITALIC;
		
		_textField.setTextFormat(_textFormat);
    }
	
		/**
		 * @inheritDoc
		 */
		override public function reskin() : Void 
		{ 
			initStyle();
			draw();
			
		} 
		 
		 /**
		 * Show the icon if there is one
		 */
		 
		 private function set_showIcon(value : Bool) : Bool
		 {
			_showIcon = value;
			draw();
			
			return value;
		 }
		 
		/**
		 * Return true if the icon is being shown and false if not
		 */  
		
		private function get_showIcon() : Bool { return _showIcon; }
		
		/**
		 * Return the text field that is being used
		 */
		private function get_textField() : TextField { return _textField; }
		
		/**
		 * Set the text format
		 */
		
		private function set_textFormat(value : TextFormat) : TextFormat 
		{ 
			_textFormat = value; 
			
			return value; 
		}  
		
		/**
		 * Return the text format that is being used
		 */
		
		private function get_textFormat() : TextFormat { return _textFormat; }
		
		/**
		 * Set the label text
		 *
		 * @param value The text that you want to set on the label
		 */
		
		private function set_text(value : String) : String 
		{
			_textField.text = value;
			draw();
			
			return value;
		}
		
		/**
		 * Return the text that is currenly being used in the label
		 */
		
		private function get_text() : String { return _textField.text; }
		
		/**
		 * Set the alignment of the label text
		 */
		
		private function set_align(value : String) : String 
		{ 
			
			if (value.toLowerCase() == "left")
				_textFormat.align = TextFormatAlign.LEFT;
			else if(value.toLowerCase() == "right")
				_textFormat.align = TextFormatAlign.RIGHT;
			else if(value.toLowerCase() == "center")
				_textFormat.align = TextFormatAlign.CENTER;
			else if(value.toLowerCase() == "justify")
				_textFormat.align = TextFormatAlign.JUSTIFY;
			else if (value.toLowerCase() == "end")
				 _textFormat.align = TextFormatAlign.END;
			else if (value.toLowerCase() == "start")
				_textFormat.align = TextFormatAlign.START;
				
			value = value.toLowerCase();
			
			draw();
			
			return value;
		} 
		
		/**
		 * Return the alignment that is being used
		 */
		
		private function get_align() : String { return _align; }
		
		/**
		 * Contains the HTML representation of the label
		 */
		
		private function set_htmlText(value : String) : String 
		{
			_textField.htmlText = value;
			return value;
		}
		
		/**
		 * Return the HTML text
		 */
		
		private function get_htmlText() : String { return _textField.htmlText; }
		
	
		/**
		 * Set the label width
		 *
		 * @param value The new width you want to set the label to
		 */  
		
		#if flash @:setter(width)
		private function set_width(value : Float) : Void 
		{
			trace("set_width");
			textField.width = _width = value;
			
			draw();
		}  
		#else
		override private function set_width(value : Float) : Float 
		{
			textField.width = _width = value;
			draw();
			
			return value; 
		}
  		#end
		
		/**
		 *
		 * @return Return the width of the label
		 */
		#if flash @:getter(width) #else override #end
		private function get_width() : Float { return textField.width; } 
		 
		/**
		 * Set the label height
		 *
		 * @param value The new height you want to set the label to
		 */
		#if flash @:setter(width)
		private function set_height(value : Float) : Void 
		 {
			 textField.height = _height = value; 
			 draw();
		 }
		 #else
		 override private function set_height(value : Float) : Float
		 {
			 textField.height = _height = value; 
			 draw();
			 
			 return value;
		 }		  
		 #end
		 
	
		/**
		 *
		 * @return Return the label height
		 */
		#if flash @:getter(height) #else override #end
		private function get_height() : Float { return textField.height; }
	
		/**
		 * Specifies whether the label has a border. If true, the label has a border. If false, the label has no border.
		 */
		
		private function set_border(value : Bool) : Bool 
		{
			_border = value;
			draw(); 
			
			return value;
		}  
		 
		/**
		 * Return if the label is using a border, true if it is and false if not
		 */
		
		private function get_border() : Bool { return _border; } 
		 
		/**
		 * The color of the label border.
		 */
		
		private function set_borderColor(value : Int) : Int 
		{ 
			_outlineColor = value;
			
			draw();
			return value;
		}
		
		
		/**
		 * Resturns If the button is enabled or disable
		 */ 
		
		private function get_borderColor() : Int { return _outlineColor; } 
		
		/**
		 * Set the alpha between 1 to 0
		 */
		
		private function set_borderAlpha(value : Float) : Float 
		{
			_outlineAlpha = value;
			draw();
			
			return value; 
			
		} 
		 
		/**
		 * Returns the border alpha
		 */
		
		private function get_borderAlpha() : Float { return _outlineAlpha; }
		
	
		/**
		 * The color of the label background.
		 */
		
		 private function set_backgroundColor(value : Int) : Int 
		 { 
			_textField.backgroundColor = value;
			return value;
		 }
		 	
		/**
		 *
		 * Returns the color the label background is using
		 */
		
		private function get_backgroundColor() : Int { return _textField.backgroundColor; }
		
	
		/**
		 * Border thinkness
		 */
		
		private function set_borderThinkness(value : Float) : Float 
		{
			_thinkness = value;
			return value; 
		} 
		 
	
		/**
		 * Return the size of the border
		 */
		
		private function get_borderThinkness() : Float 
		{ 
			return _thinkness;
		}
		
	
		/**
		 * Specifies whether the label has a background fill. If true, the label has a background fill. If false, the label has no background fill.
		 */
		
		private function set_background(value : Bool) : Bool 
		{
			_textField.background = _background = value;
			
			return value;
		}
	
		/**
		 * Returns true if the background is being filled with a color and false if not.
		 */
		
		private function get_background() : Bool 
		{ 
			return _background; 
		} 
		
		/**
		 * Configure and setup the label to handle embedded fonts
		 *
		 * @param value The font you want to use.
		 *
		 */
		
		public function setEmbedFont(value : Font) : Void { _font = value; _textFormat.font = _font.fontName; _embedFonts = true; draw(); }
		 
		/**
		 * Unload the font that was set by using the setEmbedFont
		 *
		 */
		
		public function unloadEmbedFont() : Void { _font = new Font(); _textFormat.font = null; _embedFonts = false; draw(); } 
		
	
		/**
		 * The color of the text in a label, in hexadecimal format
		 */ 
		
		 private function set_textColor(value : Int) : Int 
		 { 
			 _textFormat.color = _textColor = value;
			 
			 draw();
			 
			 return value; 
		 }
		 
		/**
		 * Return the label color
		 */
		
		private function get_textColor() : Int { return _textColor; }
		
	
		/**
		 * The size of the text
		 */
		
		private function set_size(value : Dynamic) : Dynamic 
		{ 
			_textFormat.size = value; 
			draw();
			return value;
			
		}
		 
		/**
		 *  Return the size
		 */
		
		private function get_size() : Dynamic { return _textFormat.size; }
		
	
		/**
		 * The font you want to set the label to
		 */ 
		
		private function set_font(value : String) : String 
		{ 
			_textFormat.font = value;
			draw(); 
			return value; 
			
		} 
		 
	
		/**
		 * Return the current font being used
		 */
		
		private function get_font() : String { return _textFormat.font; }
		
		/**
		 * Set if the label text is editable
		 */
		
		private function set_editable(value : Bool) : Bool 
		{
			_editable = value;
			_textField.selectable = (_enabled && _editable) ? true : false;
			
			return value;
		}  
		 
		/**
		 *Returns if the label is editable or not.
		 */
		
		private function get_editable() : Bool { return _editable; } 
		
		/**
		 * Set if the label text is enabled
		 *
		 * @param value Set to true if you want the text to be enabled and false if not
		 */
		
		 override private function set_enabled(value : Bool) : Bool 
		 { 
			_enabled = value;
			_textField.selectable = (_enabled && _editable) ? true : false;
			
			return value;
			
		 }
		 
	
		/**
		 *
		 * @return Return if the label is enabled or disable
		 */
		
		override private function get_enabled() : Bool { return _enabled; }
		
	
		/**
		 * Set the icon to be used in the label
		 *
		 * @param	value The icon you want to use for the label
		 */
		
		public function setDisplayIcon(value : DisplayObject) : Void 
		{  
			// If in display then remove them 
			
			if (null != value.parent)
			removeChild(value);_displayIcon = value;
			
			// If icon is null then don't add it to display
			if (null != value)
			addChild(value);
		}
	
		/**
		 * This setup and draw the label on the screen
		 *
		 */ 
		override public function draw() : Void
		{
			// First turn off all the stuff that would be turned on if nomral TextField  
			_textField.selectable = ((_enabled && _editable)) ? true : false;
			//_textField.text = _text; 
			_textField.setTextFormat(_textFormat, _beginIndex, _endIndex);
			_textField.embedFonts = _embedFonts;
			_textField.border = false;
			
			// Get ready to draw background and border
			_outline.graphics.clear(); 
			
			// First figure out if auto resize is being used 
			if (_textField.autoSize == TextFieldAutoSize.NONE) 
			{
				_textField.height = _height;
			}
			else 
			{
				_height = _textField.height;
			}
			
			// Adjust if icon  
			if (null != _displayIcon) 
			{
				_textField.width = _width - _displayIcon.width;
				_textField.x = _displayIcon.width;
				_displayIcon.y = (_textField.height / 2) - (_displayIcon.height / 2);
			}
			else 
			{
				_textField.width = _width;
				_textField.x = 0;
				_textField.y = 0;
			}
			
			// Setup for border if need be  
			if (_border) 
			{
				_outline.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
				_outline.graphics.drawRect(0, 0, _width, _height);
			}
			
			super.draw();
    }
}