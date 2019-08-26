package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.ITextInput;

import openfl.text.TextFormatAlign;
import openfl.text.TextFieldType;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.FocusEvent;


/**
 * Creates a TextInput field on the fly
 *
 * @author Erick Feiling
 */
class TextInput extends Label implements ITextInput implements ILabel implements IBaseUI
{
	/** The type of UI Element */
	public static inline var TYPE : String = "TextInput";

	public var upperCaseFirst(get, set) : Bool;
	public var textOverColor(get, set) : Int;
	public var textSelectedColor(get, set) : Int;
	public var textDisableColor(get, set) : Int;
	public var backgroundOverColor(get, set) : Int;
	public var backgroundSelectedColor(get, set) : Int;
	public var backgroundDisableColor(get, set) : Int;
	public var bitmapAlpha(get, set) : Float;

	private var _textOverColor : Int = 0x000000;
	private var _textSelectedColor : Int = 0x000000;
	private var _textDisableColor : Int = 0x000000;
	
	private var _showImage : Bool = true;
	private var _displayImage : Bool = false;

	public var backgroundNormal : Shape = new Shape();
	public var backgroundOver : Shape = new Shape();
	public var backgroundSelected : Shape = new Shape();
	public var backgroundDisable : Shape = new Shape();

	private var _backgroundImage : BitmapData;
	private var _backgroundOverImage : BitmapData;
	private var _backgroundSelectedImage : BitmapData;
	private var _backgroundDisableImage : BitmapData;

	private var _backgroundNormalColor : Int = 0xF1F1F1;
	private var _backgroundOverColor : Int = 0xCCCCCC;
	private var _backgroundSelectedColor : Int = 0xF1F1F1;
	private var _backgroundDisableColor : Int = 0xCCCCCC;
	
	private var _defaultString : String = "";
	private var _upperCaseFirst : Bool = false;

	/**
	 * @inheritDoc
	 */
	public function new(data:Dynamic = null)
	{
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "textOverColor"))
			_textOverColor = Reflect.field(data, "textOverColor");
		
		if (Reflect.hasField(data, "textSelectedColor"))
			_textSelectedColor = Reflect.field(data, "textSelectedColor");
			
		if (Reflect.hasField(data, "textDisableColor"))
			_textDisableColor = Reflect.field(data, "textDisableColor");
			
		if (Reflect.hasField(data, "backgroundNormalColor"))
			_backgroundNormalColor = Reflect.field(data, "backgroundNormalColor");
			
		if (Reflect.hasField(data, "backgroundOverColor"))
			_backgroundOverColor = Reflect.field(data, "backgroundOverColor");

		if (Reflect.hasField(data, "backgroundSelectedColor"))
			_backgroundSelectedColor = Reflect.field(data, "backgroundSelectedColor");
			
		if (Reflect.hasField(data, "backgroundDisableColor"))
			_backgroundDisableColor = Reflect.field(data, "backgroundDisableColor");
			
		if (Reflect.hasField(data, "defaultString"))
			_defaultString = Reflect.field(data, "defaultString");
			
		if (Reflect.hasField(data, "upperCaseFirst"))
			_upperCaseFirst = Reflect.field(data, "upperCaseFirst");
			
		// If input string is empty then set to default text
		if (_text == "" && _defaultString != "")
			_text = _defaultString;
		
	}

	override function onStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(TYPE, this);

		// Check for where user click
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onInputCheck, false, 0, true);
	}

	override function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);

		// Remove event once gone
		if (stage.hasEventListener(MouseEvent.MOUSE_DOWN))
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onInputCheck);
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		
		super.initialize();
		
		// Add if offset & align
		textFormat.indent = UIStyleManager.LABEL_INDENT;
		textField.background = false;
		textField.border = false;
		textField.type = TextFieldType.INPUT;
		textFormat.align = align = TextFormatAlign.LEFT;
		
		

		// Set some input defaults
		enabled = editable = true;

		// Default
		backgroundNormal.visible = true;
		backgroundOver.visible = false;
		backgroundSelected.visible = false;
		backgroundDisable.visible = false;

		// Attach roll over and out event
		addEventListener(MouseEvent.MOUSE_OVER, overState, false, 0, true);
		addEventListener(MouseEvent.MOUSE_OUT, normalState, false, 0, true);
		addEventListener(FocusEvent.FOCUS_IN, selectedState, false, 0, true);
		addEventListener(FocusEvent.FOCUS_OUT, normalState, false, 0, true);

		// Add to display
		addChild(backgroundNormal);
		addChild(backgroundOver);
		addChild(backgroundSelected);
		addChild(backgroundDisable);
		addChild(textField);		
		
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function destroy():Void 
	{
		super.destroy();
		
		// Attach roll over and out event
		removeEventListener(MouseEvent.MOUSE_OVER, overState);
		removeEventListener(MouseEvent.MOUSE_OUT, normalState);
		removeEventListener(FocusEvent.FOCUS_IN, selectedState);
		removeEventListener(FocusEvent.FOCUS_OUT, normalState);
		
		if (null != stage && stage.hasEventListener(MouseEvent.MOUSE_DOWN))
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onInputCheck);
		
		backgroundNormal.graphics.clear();
		backgroundOver.graphics.clear();
		backgroundSelected.graphics.clear();
		backgroundDisable.graphics.clear();
		
		removeChild(backgroundNormal);
		removeChild(backgroundOver);
		removeChild(backgroundSelected);
		removeChild(backgroundDisable);
		
		if (null != _backgroundImage)
			_backgroundImage.dispose();
			
		if(null != _backgroundOverImage)
			_backgroundOverImage.dispose();
		
		if (null != _backgroundSelectedImage)
			_backgroundSelectedImage.dispose();
			
		if (null != _backgroundSelectedImage)	
			_backgroundDisableImage.dispose();
		
		backgroundDisable = backgroundSelected = backgroundOver = backgroundNormal = null;	
		_backgroundDisableImage = _backgroundSelectedImage = _backgroundOverImage = _backgroundImage = null;
	}


	private function initBitmap() : Void
	{

		if (null != UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_NORMAL))
			setBackgroundImage(UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_NORMAL));

		if (null != UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_OVER))
			setOverBackgroundImage(UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_OVER));

		if (null != UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_SELECTED))
			setSelectedBackgroundImage(UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_SELECTED));

		if (null != UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_DISABLE))
			setDisableBackgroundImage(UIBitmapManager.getUIElement(TextInput.TYPE, UIBitmapManager.TEXTINPUT_DISABLE));
		
	}

	override function initStyle() : Void
	{
		super.initStyle();

		if ( -1 != UIStyleManager.INPUT_BORDER_COLOR)
			borderColor = UIStyleManager.INPUT_BORDER_COLOR;

		if ( -1 != UIStyleManager.INPUT_BORDER_ALPHA)
			borderAlpha = UIStyleManager.INPUT_BORDER_ALPHA;

		if ( -1 != UIStyleManager.INPUT_BORDER_THINKNESS)
			borderThinkness = UIStyleManager.INPUT_BORDER_THINKNESS;

		if ( -1 != UIStyleManager.INPUT_TEXT_COLOR)
			textColor = UIStyleManager.INPUT_TEXT_COLOR;

		if ( -1 != UIStyleManager.INPUT_TEXT_OVER_COLOR)
			_textOverColor = UIStyleManager.INPUT_TEXT_OVER_COLOR;

		if ( -1 != UIStyleManager.INPUT_TEXT_SELECTED_COLOR)
			_textSelectedColor = UIStyleManager.INPUT_TEXT_SELECTED_COLOR;

		if ( -1 != UIStyleManager.INPUT_TEXT_DISABLE_COLOR)
			_textDisableColor = UIStyleManager.INPUT_TEXT_DISABLE_COLOR;

		if ( -1 != UIStyleManager.INPUT_BACKGROUND_NORMAL_COLOR)
			_backgroundNormalColor = UIStyleManager.INPUT_BACKGROUND_NORMAL_COLOR;

		if ( -1 != UIStyleManager.INPUT_BACKGROUND_OVER_COLOR)
			_backgroundOverColor = UIStyleManager.INPUT_BACKGROUND_OVER_COLOR;

		if ( -1 != UIStyleManager.INPUT_BACKGROUND_OVER_COLOR)
			_backgroundSelectedColor = UIStyleManager.INPUT_BACKGROUND_OVER_COLOR;

		if ( -1 != UIStyleManager.INPUT_BACKGROUND_DISABLE_COLOR)
			_backgroundDisableColor = UIStyleManager.INPUT_BACKGROUND_DISABLE_COLOR;

		if ("" != UIStyleManager.INPUT_TEXT_FONT)
			textFormat.font = UIStyleManager.INPUT_TEXT_FONT;

		if (null != UIStyleManager.INPUT_TEXT_EMBED)
			setEmbedFont(UIStyleManager.INPUT_TEXT_EMBED);

		_border = UIStyleManager.INPUT_BORDER;
		_background = UIStyleManager.INPUT_BACKGROUND;
		
		_bold = UIStyleManager.INPUT_TEXT_BOLD;
		_italic = UIStyleManager.INPUT_TEXT_ITALIC;
		
	}

	/**
	 * @inheritDoc
	 */

	override public function reskin() : Void
	{
		super.reskin();

		initBitmap();
		initStyle();
	}

	/**
	 * Display default text when string is empty
	 *
	 * @param	value The text that will be used
	 */

	public function defaultString(value : String) : Void
	{
		_defaultString = value;

		// Set default string to be empty
		if (_defaultString.length > 0 && _textField.text.length == 0)
			_textField.text = _text = _defaultString;
	}

	/**
	 * This will check to see if TextInput is empty
	 *
	 * @return True if there is nothing in the TextInput and False if not
	 */

	public function isEmpty() : Bool
	{
		// True if text length is 0 or default string is the same as text other then that false
		return (_defaultString == _textField.text) ? true : false;
	}

	/**
	 * Will upper case first letter on FOCUS_OUT event
	 */

	private function set_upperCaseFirst(value : Bool) : Bool
	{
		_upperCaseFirst = value;
		return value;
	}

	/**
	 * Return true if the first letter will be upper case by default and false if not
	 */

	private function get_upperCaseFirst() : Bool
	{
		return _upperCaseFirst;
	}

	/**
	 * The color that will be used for the text input in this state
	 */
	private function set_textOverColor(value : Int) : Int
	{
		_textOverColor = value;

		return value;
	}

	/**
	 * Return the color
	 */

	private function get_textOverColor() : Int
	{
		return _textOverColor;
	}

	/**
	 * The color that will be used for the text input in this state
	 */
	private function set_textSelectedColor(value : Int) : Int
	{
		_textSelectedColor = value;
		return value;
	}

	/**
	 * Return the color
	 */
	private function get_textSelectedColor() : Int
	{
		return _textSelectedColor;
	}

	/**
	 * The color that will be used for the text input in this state
	 */
	private function set_textDisableColor(value : Int) : Int
	{
		_textDisableColor = value;
		return value;
	}

	/**
	 *Return the color
	 */

	private function get_textDisableColor() : Int
	{
		return _textDisableColor;
	}

	/**
	 * The color of the text input background over state
	 */
	private function set_backgroundOverColor(value : Int) : Int
	{
		_backgroundOverColor = value;
		return value;
	}

	/**
	 * Return the background state color
	 */

	private function get_backgroundOverColor() : Int
	{
		return _backgroundOverColor;
	}

	/**
	 * The color of the text input background down state
	 */

	private function set_backgroundSelectedColor(value : Int) : Int
	{
		_backgroundSelectedColor = value; draw();
		return value;
	}

	/**
	 * Return the background state color
	 */
	private function get_backgroundSelectedColor() : Int
	{
		return _backgroundSelectedColor;
	}

	/**
	 * The color of the text input background disable state
	 */
	private function set_backgroundDisableColor(value : Int) : Int
	{
		_backgroundDisableColor = value;
		
		return value;
	}

	/**
	 * Return the background state color
	 */

	private function get_backgroundDisableColor() : Int
	{
		return _backgroundDisableColor;
	}

	/**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */

	public function setBackgroundImage(value : BitmapData) : Void
	{
		_backgroundImage = value;

	}

	/**
	 * This is for setting an image to the text input roll over state. It is best to set an image that can be tile.
	 */
	public function setOverBackgroundImage(value : BitmapData) : Void
	{
		_backgroundOverImage = value;
	}

	/**
	 * This is for setting an image to the text input selected state. It is best to set an image that can be tile.
	 */

	public function setSelectedBackgroundImage(value : BitmapData) : Void
	{
		_backgroundSelectedImage = value;
	}

	/**
	 * This is for setting an image to the text input disable state. It is best to set an image that can be tile.
	 */
	public function setDisableBackgroundImage(value : BitmapData) : Void
	{
		_backgroundDisableImage = value;
	}

	/**
	 * Remove all roll over and roll out effects while setting text input to it's disable state
	 *
	 * @param value Disable or Enable button
	 */
	override private function set_enabled(value : Bool) : Bool
	{
		super.enabled = value;

		if (super.enabled != value)
		{
			if (value)
			{
				// Use default color from label/super class
				textFormat.color = textField.textColor = textColor;
				// Attach roll over and out event
				addEventListener(MouseEvent.MOUSE_OVER, overState, false, 0, true);
				addEventListener(MouseEvent.MOUSE_OUT, normalState, false, 0, true);
				addEventListener(FocusEvent.FOCUS_IN, selectedState, false, 0, true);
				addEventListener(FocusEvent.FOCUS_OUT, normalState, false, 0, true);
				backgroundDisable.visible = false;
			}
		}
		else
		{
			// Use disable color for text input field
			textFormat.color = textField.textColor = _textDisableColor;

			// Attach roll over and out event
			removeEventListener(MouseEvent.MOUSE_OVER, overState);
			removeEventListener(MouseEvent.MOUSE_OUT, normalState);
			removeEventListener(FocusEvent.FOCUS_IN, selectedState);
			removeEventListener(FocusEvent.FOCUS_OUT, normalState);
			backgroundDisable.visible = true;
		}
		
		return value;
	}

	/**
	 * The alpha of the text input roll over and down state. Use this if you only set the default bitmap image, this will tint the text input.
	 */
	private function set_bitmapAlpha(value : Float) : Float
	{
		_bgAlpha = value;
		
		return value;
	}

	/**
	 * Return the alpha of the text input
	 */
	private function get_bitmapAlpha() : Float
	{
		return _bgAlpha;
	}

	/**
	 * This setup and draw the text input on the screen
	 */
	override public function draw() : Void
	{
		super.draw();

		// Turn off background because using shape
		textField.background = false;

		// Set format this way to fix embed front problems for input field
		textField.defaultTextFormat = textFormat;

		// Add if offset and alignment
		textFormat.indent = UIStyleManager.LABEL_INDENT;

		// Get ready to draw background and border
		if (null != backgroundNormal)
			backgroundNormal.graphics.clear();

		if (null != backgroundOver)
			backgroundOver.graphics.clear();

		if (null != backgroundSelected)
			backgroundSelected.graphics.clear();

		if (null != backgroundDisable)
			backgroundDisable.graphics.clear();

		// Make sure the size of the textfield the set height
		if (textField.textHeight < height)
			textField.height = height;

		textField.setTextFormat(textFormat);

		// Setup for background
		if (background)
		{
			// Redraw background

			if (_showImage)
			{
				// Check to see what bitmaps are loaded in
				if (null != _backgroundImage)
					backgroundNormal.graphics.beginBitmapFill(_backgroundImage, null, true, _smoothImage);
				else
					backgroundNormal.graphics.beginFill(_backgroundNormalColor);
				
				if (null != _backgroundOverImage)
					backgroundOver.graphics.beginBitmapFill(_backgroundOverImage, null, true, _smoothImage);
				else
					backgroundOver.graphics.beginFill(_backgroundOverColor, _bgAlpha);
				
				if (null != _backgroundSelectedImage)
					backgroundSelected.graphics.beginBitmapFill(_backgroundSelectedImage, null, true, _smoothImage);
				else
					backgroundSelected.graphics.beginFill(_backgroundSelectedColor, _bgAlpha);
				
				if (null != _backgroundDisableImage)
					backgroundDisable.graphics.beginBitmapFill(_backgroundDisableImage, null, true, _smoothImage);
				else
					backgroundDisable.graphics.beginFill(_backgroundDisableColor);
			}
			else
			{
				backgroundNormal.graphics.beginFill(_backgroundNormalColor, _bgAlpha);
				backgroundOver.graphics.beginFill(_backgroundOverColor, _bgAlpha);
				backgroundSelected.graphics.beginFill(_backgroundSelectedColor, _bgAlpha);
				backgroundDisable.graphics.beginFill(_backgroundDisableColor, _bgAlpha);
			}
		}

		// Draw box if either background or border is on
		if (border || background)
		{
			backgroundNormal.graphics.drawRect(0, 0, width, height);
			backgroundOver.graphics.drawRect(0, 0, width, height);
			backgroundSelected.graphics.drawRect(0, 0, width, height);
			backgroundDisable.graphics.drawRect(0, 0, width, height);
			backgroundNormal.graphics.endFill();
			backgroundOver.graphics.endFill();
			backgroundSelected.graphics.endFill();
			backgroundDisable.graphics.endFill();
		}
	}

	private function onInputCheck(event : MouseEvent) : Void
	{
		// If there is nothing in the text field and default string is greather than 0
		if (_textField.text.length == 0 && _defaultString.length > 0 && !hitTestPoint(stage.mouseX, stage.mouseY))
			_textField.text = _defaultString;

		// Upper case first letter
		if (_upperCaseFirst && _textField.text.length > 0 && _textField.text != _defaultString)
			_textField.text = _textField.text.charAt(0).toUpperCase() + text.substr(1);
	}

	private function normalState(event : Event) : Void
	{
		// Set the text color
		textFormat.color = textField.textColor = textColor;
		backgroundNormal.visible = true;
		backgroundOver.visible = false;
		backgroundSelected.visible = false;
		backgroundDisable.visible = false;
	}

	private function overState(event : Event) : Void
	{
		// Set the text color
		textFormat.color = textField.textColor = _textOverColor;

		if (_showImage)
		{
			backgroundNormal.visible = true;
			backgroundOver.visible = true;
			backgroundSelected.visible = false;
			backgroundDisable.visible = false;
		}
		else
		{
			backgroundNormal.visible = false;
			backgroundOver.visible = true;
			backgroundSelected.visible = false;
			backgroundDisable.visible = false;
		}
	}

	private function selectedState(event : Event) : Void
	{
		// Set the text color
		textFormat.color = textField.textColor = _textSelectedColor;

		// Default string is not empty and text is the same as default text then clear it
		if (_defaultString.length > 0 && _textField.text == _defaultString)
			_textField.text = "";

		if (_showImage)
		{
			backgroundNormal.visible = true;
			backgroundOver.visible = false;
			backgroundSelected.visible = true;
			backgroundDisable.visible = false;
		}
		else
		{
			backgroundNormal.visible = false;
			backgroundOver.visible = false;
			backgroundSelected.visible = true;
			backgroundDisable.visible = false;
		}
	}


}