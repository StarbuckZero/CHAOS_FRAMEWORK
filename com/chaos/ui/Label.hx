package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.utils.CompositeManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
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

/**
 *  Creates a Label for develop to place text on the stage or in another display object.
 *  This is a nice wrapper around Text Field which handles a lot of things.
 *	<br><br>
 *  @author Erick Feiling<br>
 *  @date 11-5-09
 */
class Label extends BaseUI implements ILabel implements IBaseUI {
	/** The type of UI Element */
	public static inline var TYPE:String = "Label";

	/**
	 * Return the text field that is being used
	 */
	public var textField(get, never):TextField;

	/**
	 * Set the text format
	 */
	public var textFormat(get, set):TextFormat;

	/**
	 * Set the label text
	 */
	public var text(get, set):String;

	/**
	 * Set the alignment of the label text
	 */
	public var align(get, set):String;

	/**
	 * Contains the HTML representation of the label
	 */
	public var htmlText(get, set):String;

	/**
	 * The color of the label background
	 */
	public var backgroundColor(get, set):Int;

	/**
	 * Border thinkness
	 */
	// public var borderThinkness(get, set):Float;

	/**
	 * Specifies whether the label has a background fill. If true, the label has a background fill. If false, the label has no background fill.
	 */
	public var background(get, set):Bool;

	/**
	 * The color of the text in a label, in hexadecimal format
	 */
	public var textColor(get, set):Int;

	/**
	 * The size of the text
	 */
	public var size(get, set):Dynamic;

	/**
	 * The font you want to set the label to
	 */
	public var font(get, set):String;

	/**
	 * Set if the label text is editable
	 */
	public var editable(get, set):Bool;

	/**
	 * Convert label to bitmap
	 */
	public var bitmapMode(get, set):Bool;

	private var _textImage:Shape = new Shape();
	private var _textField:TextField = new TextField();
	private var _textFormat:TextFormat = new TextFormat();
	private var _text:String = "";
	private var _align:String = "center";

	private var _editable:Bool = false;
	private var _embedFonts:Bool = false;
	private var _textColor:Int = 0x000000;
	private var _font:Font = new Font();
	private var _beginIndex:Int = -1;
	private var _endIndex:Int = -1;
	private var _background:Bool = false;
	private var _backgroundColor:Int = 0xFFFFFF;
	private var _border:Bool = false;
	private var _borderColor:Int = 0x000000;
	private var _thinkness:Float = 1;
	private var _outlineColor:Int = 0x000000;
	private var _outlineAlpha:Float = 1;
	private var _bgAlpha:Float = .2;

	private var _outline:Border;
	private var _bitmapMode:Bool = false;
	private var _size:Int = 11;
	private var _bold:Bool = false;
	private var _italic:Bool = false;
	private var _fontName:String = "";

	/**
	 * UI Label
	 * @param	data The proprieties that you want to set on component.
	 */
	public function new(data:Dynamic = null) {
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	override public function setComponentData(data:Dynamic):Void {
		super.setComponentData(data);

		if (Reflect.hasField(data, "text"))
			_text = Reflect.field(data, "text");

		if (Reflect.hasField(data, "font"))
			_fontName = Reflect.field(data, "font");

		if (Reflect.hasField(data, "size"))
			_size = Reflect.field(data, "size");

		if (Reflect.hasField(data, "bold"))
			_bold = Reflect.field(data, "bold");

		if (Reflect.hasField(data, "italic"))
			_italic = Reflect.field(data, "italic");

		if (Reflect.hasField(data, "editable"))
			_editable = Reflect.field(data, "editable");

		if (Reflect.hasField(data, "background"))
			_background = Reflect.field(data, "background");

		if (Reflect.hasField(data, "textColor"))
			_textColor = Reflect.field(data, "textColor");

		if (Reflect.hasField(data, "align"))
			_align = Reflect.field(data, "align");

		if (Reflect.hasField(data, "border"))
			_border = Reflect.field(data, "border");

		if (Reflect.hasField(data, "thinkness"))
			_thinkness = Reflect.field(data, "thinkness");

		if (Reflect.hasField(data, "outlineColor"))
			_outlineColor = Reflect.field(data, "outlineColor");

		if (Reflect.hasField(data, "outlineAlpha"))
			_outlineAlpha = Reflect.field(data, "outlineAlpha");

		if (Reflect.hasField(data, "backgroundAlpha"))
			_bgAlpha = Reflect.field(data, "backgroundAlpha");

		if (Reflect.hasField(data, "backgroundColor"))
			_backgroundColor = Reflect.field(data, "backgroundColor");

		if (Reflect.hasField(data, "bitmapMode"))
			_bitmapMode = Reflect.field(data, "bitmapMode");
	}

	/**
	 * initialize all importain objects
	 */
	override public function initialize():Void {
		super.initialize();

		// Add if offset & align
		_textField.multiline = true;
		_textField.wordWrap = true;
		_textField.background = _background;
		_textField.backgroundColor = _backgroundColor;
		_textField.type = TextFieldType.DYNAMIC;
		_textField.border = false;
		_textFormat.color = _textColor;
		_textFormat.align = _align;
		_textFormat.bold = _bold;
		_textFormat.italic = _italic;
		_textFormat.size = _size;

		if (_fontName != "")
			_textFormat.font = _fontName;

		// Setup width
		_textField.width = _width;

		// First figure out if auto resize is being used
		if (_textField.autoSize == TextFieldAutoSize.NONE)
			_textField.height = _height;
		else
			_height = _textField.height;

		_outline = new Border({"lineColor":_borderColor,"lineThinkness":_thinkness,"lineAlpha":_outlineAlpha,"width":_width,"height":_height});
		
		// Add to display
		addChild(_outline);

		// Create as bitmap image or display the label for real
		if (_bitmapMode)
			addChild(_textImage);
		else
			addChild(_textField);
	}

	/**
	 * Unload Component
	 */
	override public function destroy():Void {
		super.destroy();

		// Clear out lines
		_outline.graphics.clear();
		_textImage.graphics.clear();

		// Remove items
		removeChild(_outline);

		if (_textField.parent != null)
			removeChild(_textField);

		if (_textImage.parent != null)
			removeChild(_textImage);

		_textFormat = null;
		_textField = null;
	}

	private function onStageAdd(event:Event):Void {
		UIBitmapManager.watchElement(TYPE, this);
	}

	private function onStageRemove(event:Event):Void {
		UIBitmapManager.stopWatchElement(TYPE, this);
	}

	private function initStyle():Void {

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BORDER_THINKNESS))
			_thinkness = UIStyleManager.getStyle(UIStyleManager.LABEL_BORDER_THINKNESS);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BORDER_COLOR))
			_outlineColor = UIStyleManager.getStyle(UIStyleManager.LABEL_BORDER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BORDER_ALPHA))
			_outlineAlpha = UIStyleManager.getStyle(UIStyleManager.LABEL_BORDER_ALPHA);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BACKGROUND_COLOR))
			_backgroundColor = UIStyleManager.getStyle(UIStyleManager.LABEL_BACKGROUND_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_COLOR))
			_textColor = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_ALIGN))
			_align = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_ALIGN);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_SIZE))
			_size = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_SIZE);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_EMBED))
			setEmbedFont(UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_EMBED));

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BACKGROUND))
		 	_background = UIStyleManager.getStyle(UIStyleManager.LABEL_BACKGROUND);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_FONT))
			_fontName = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_FONT);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_BORDER))
			_border = UIStyleManager.getStyle(UIStyleManager.LABEL_BORDER);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_BOLD))
			_bold = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_BOLD);
		
		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_TEXT_ITALIC))
			_italic = UIStyleManager.getStyle(UIStyleManager.LABEL_TEXT_ITALIC);

		if (UIStyleManager.hasStyle(UIStyleManager.LABEL_INDENT))
			_textFormat.indent = UIStyleManager.getStyle(UIStyleManager.LABEL_INDENT);

	}

	private function set_bitmapMode(value:Bool):Bool {
		_bitmapMode = value;

		// Create as bitmap image or display the label for real
		if (_bitmapMode) {
			if (_textField.parent != null)
				_textField.parent.removeChild(_textField);

			addChild(_textImage);
		} else {
			if (_textImage.parent != null)
				_textImage.parent.removeChild(_textImage);

			addChild(_textField);
		}

		return value;
	}

	private function get_bitmapMode():Bool {
		return _bitmapMode;
	}

	/**
	 * Reload all bitmap images and UI Styles
	 */
	override public function reskin():Void {
		super.reskin();

		initStyle();
	}

	/**
	 * Return the text field that is being used
	 */
	private function get_textField():TextField {
		return _textField;
	}

	/**
	 * Set the text format
	 */
	private function set_textFormat(value:TextFormat):TextFormat {
		_textFormat = value;

		return value;
	}

	/**
	 * Return the text format that is being used
	 */
	private function get_textFormat():TextFormat {
		return _textFormat;
	}

	/**
	 * Set the label text
	 *
	 * @param value The text that you want to set on the label
	 */
	private function set_text(value:String):String {
		_text = value;

		return value;
	}

	/**
	 * Return the text that is currenly being used in the label
	 */
	private function get_text():String {
		return _textField.text;
	}

	/**
	 * Set the alignment of the label text
	 */
	private function set_align(value:String):String {
		if (value.toLowerCase() == "left")
			_textFormat.align = TextFormatAlign.LEFT;
		else if (value.toLowerCase() == "right")
			_textFormat.align = TextFormatAlign.RIGHT;
		else if (value.toLowerCase() == "center")
			_textFormat.align = TextFormatAlign.CENTER;
		else if (value.toLowerCase() == "justify")
			_textFormat.align = TextFormatAlign.JUSTIFY;
		else if (value.toLowerCase() == "end")
			_textFormat.align = TextFormatAlign.END;
		else if (value.toLowerCase() == "start")
			_textFormat.align = TextFormatAlign.START;

		value = value.toLowerCase();

		return value;
	}

	/**
	 * Return the alignment that is being used
	 */
	private function get_align():String {
		return _align;
	}

	/**
	 * Contains the HTML representation of the label
	 */
	private function set_htmlText(value:String):String {
		_textField.htmlText = value;
		return value;
	}

	/**
	 * Return the HTML text
	 */
	private function get_htmlText():String {
		return _textField.htmlText;
	}

	/**
	 * Specifies whether the label has a border. If true, the label has a border. If false, the label has no border.
	 */
	private function set_border(value:Bool):Bool {
		_border = value;

		return value;
	}

	/**
	 * Return if the label is using a border, true if it is and false if not
	 */
	private function get_border():Bool {
		return _border;
	}

	/**
	 * The color of the label border.
	 */
	private function set_borderColor(value:Int):Int {
		_outlineColor = value;

		return value;
	}

	/**
	 * Resturns If the button is enabled or disable
	 */
	private function get_borderColor():Int {
		return _outlineColor;
	}

	/**
	 * Set the alpha between 1 to 0
	 */
	private function set_borderAlpha(value:Float):Float {
		_outlineAlpha = value;

		return value;
	}

	/**
	 * Returns the border alpha
	 */
	private function get_borderAlpha():Float {
		return _outlineAlpha;
	}

	/**
	 * The color of the label background.
	 */
	private function set_backgroundColor(value:Int):Int {
		_backgroundColor = value;

		return value;
	}

	/**
	 *
	 * Returns the color the label background is using
	 */
	private function get_backgroundColor():Int {
		return _textField.backgroundColor;
	}

	/**
	 * Border thinkness
	 */
	private function set_borderThinkness(value:Float):Float {
		_thinkness = value;

		return value;
	}

	/**
	 * Return the size of the border
	 */
	private function get_borderThinkness():Float {
		return _thinkness;
	}

	/**
	 * Specifies whether the label has a background fill. If true, the label has a background fill. If false, the label has no background fill.
	 */
	private function set_background(value:Bool):Bool {
		_background = value;

		return value;
	}

	/**
	 * Returns true if the background is being filled with a color and false if not.
	 */
	private function get_background():Bool {
		return _background;
	}

	/**
	 * Configure and setup the label to handle embedded fonts
	 *
	 * @param value The font you want to use.
	 *
	 */
	public function setEmbedFont(value:Font):Void {
		_font = value;
		_textFormat.font = _font.fontName;
		_embedFonts = true;
	}

	/**
	 * Unload the font that was set by using the setEmbedFont
	 *
	 */
	public function unloadEmbedFont():Void {
		_font = new Font();
		_textFormat.font = null;
		_embedFonts = false;
	}

	/**
	 * The color of the text in a label, in hexadecimal format
	 */
	private function set_textColor(value:Int):Int {
		_textColor = value;

		return value;
	}

	/**
	 * Return the label color
	 */
	private function get_textColor():Int {
		return _textColor;
	}

	/**
	 * The size of the text
	 */
	private function set_size(value:Dynamic):Dynamic {
		_textFormat.size = value;

		return value;
	}

	/**
	 *  Return the size
	 */
	private function get_size():Dynamic {
		return _textFormat.size;
	}

	/**
	 * The font you want to set the label to
	 */
	private function set_font(value:String):String {
		_textFormat.font = value;

		return value;
	}

	/**
	 * Return the current font being used
	 */
	private function get_font():String {
		return _textFormat.font;
	}

	/**
	 * Set if the label text is editable
	 */
	private function set_editable(value:Bool):Bool {
		_editable = value;
		_textField.selectable = (_enabled && _editable) ? true : false;

		return value;
	}

	/**
		*Returns if the label is editable or not.
	 */
	private function get_editable():Bool {
		return _editable;
	}

	/**
	 * Set if the label text is enabled
	 *
	 * @param value Set to true if you want the text to be enabled and false if not
	 */
	override private function set_enabled(value:Bool):Bool {
		_enabled = value;
		_textField.selectable = (_enabled && _editable) ? true : false;

		return value;
	}

	/**
	 * @return Return if the label is enabled or disable
	 */
	override private function get_enabled():Bool {
		return _enabled;
	}

	/**
	 * This setup and draw the label on the screen
	 */
	override public function draw():Void {
		super.draw();

		_textField.width = _width;
		_textField.x = 0;
		_textField.y = 0;

		// First turn off all the stuff that would be turned on if nomral TextField
		_textField.selectable = ((_enabled && _editable)) ? true : false;

		_textField.setTextFormat(_textFormat, _beginIndex, _endIndex);
		_textField.embedFonts = _embedFonts;
		_textField.textColor = _textColor;
		_textField.background = _background;
		_textField.backgroundColor = _backgroundColor;
		_textField.text = _text;

		// Get ready to draw background and border
		_outline.visible = _border;

		if(_border)
		{
			_outline.width = _width;
			_outline.height = _height;
			_outline.lineColor = _borderColor;
			_outline.draw();
		}
			

		// First figure out if auto resize is being used
		if (_textField.autoSize == TextFieldAutoSize.NONE)
			_textField.height = _height;
		else
			_height = _textField.height;

		_textImage.graphics.clear();

		if (_bitmapMode) {
			_textImage.graphics.beginBitmapFill(CompositeManager.displayObjectToBitmap(_textField, true), null, false, _smoothImage);
			_textImage.graphics.drawRect(0, 0, _textField.width, _textField.height);
			_textImage.graphics.endFill();
		}
	}
}
