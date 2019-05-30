package com.chaos.ui;

import com.chaos.media.DisplayImage;
import com.chaos.ui.Label;

import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBox;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.text.Font;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

class CheckBox extends ToggleButton implements ICheckBox implements IBaseUI
{
	
	/** The type of UI Element */
	public static inline var TYPE : String = "CheckBox";
	
	public var textFormat(get, set) : TextFormat;     
	public var textField(get, never) : Label;      
	public var text(get, set) : String;      
	public var textWidth(get, set) : Float;      
	public var textSize(get, set) : Int;     
	public var textItalic(get, set) : Bool;     
	public var textBold(get, set) : Bool;    
	public var textColor(get, set) : Int;      
	public var textAlign(get, set) : String;  
	public var showLabel(get, set) : Bool;

	//private var _baseNormal : Shape;
	//private var _baseOver : Shape;
	//private var _baseDown : Shape;
	//private var _baseDisable : Shape;
	private var _normalLineColor : Int = 0x000000;
	private var _overLineColor : Int = 0x666666;
	private var _downLineColor : Int = 0x000000;
	private var _disableLineColor : Int = 0xCCCCCC;
	private var _normalFillColor : Int = 0xFFFFFF;
	private var _overFillColor : Int = 0x666666;
	private var _downFillColor : Int = 0xFFFFFF;
	private var _disableFillColor : Int = 0xFFFFFF;
	private var _downMarkColor : Int = 0x000000;
	private var _lineSize : Int = 2;
	private var _bgAlpha : Float = 1;
	private var _lineAlpha : Float = 1;
	private var _overAlpha : Float = .2;
	private var _blnNormalImage : Bool = false;
	private var _blnOverImage : Bool = false;
	private var _blnDownImage : Bool = false;
	private var _blnDisableImage : Bool = false;
	private var _normalDisplayImage : DisplayImage;
	private var _overDisplayImage : DisplayImage;
	private var _downDisplayImage : DisplayImage;
	private var _disableDisplayImage : DisplayImage; 

	// Default text 
	private var _labelText : String = "CheckBox";
	private var _labelTextField : Label;
	private var _labelTextFormat : TextFormat;
	private var _textItalic : Bool = false;
	private var _textBold : Bool = false;
	private var _textColor : Int = 0x000000;
	private var _textAlign : String = "left";
	private var _textSize : Int = 11;
	private var _showLabel : Bool = true;
	private var _textWidth : Float = 65;
	private var _textSelectable : Bool = true;
	private var _smoothImage : Bool = true;
	private var _showImage : Bool = true;
	private var _useTextFormat : Bool = false;
  
	/**
	 * Creates new check box
	 * @param	labelText The label name
	 */
	
	public function new(labelText : String = "")
    {
        super();
		
		// Create Text field
		_labelTextField = new Label();
		_labelTextFormat = new TextFormat();
		
		// Init toggle class first
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		_labelText = labelText;
		
		init();
    }
	
	override function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	override function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	
	private function init() : Void
	{ 
		// Setup Shapes
		_baseNormal = new Shape();
		_baseOver = new Shape();
		_baseDown = new Shape();
		_baseDisable = new Shape();
		
		setNormalState(_baseNormal);
		setOverState(_baseOver);
		setDownState(_baseDown);
		setDisableState(_baseDisable);
		
		_normalDisplayImage = new DisplayImage();
		_overDisplayImage = new DisplayImage();
		_downDisplayImage = new DisplayImage();
		_disableDisplayImage = new DisplayImage();
		
		_normalDisplayImage.onImageComplete = normalImageComplete;
		_overDisplayImage.onImageComplete = overImageComplete;
		_downDisplayImage.onImageComplete = downImageComplete;
		_disableDisplayImage.onImageComplete = disableImageComplete;
		
		reskin();
		
		addChildAt(_labelTextField, 0);
		
		draw();
    }
	
	private function initSkin() : Void
	{
		// Skin element
		if (null != UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_NORMAL))
		setNormalBitmap(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_OVER))   
		setOverBitmap(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_OVER));
		
		if (null != UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DOWN)) 
		setDownBitmap(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DOWN));
		
		if (null != UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DISABLE))
		setDisableBitmap(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DISABLE));
    }
	
	private function initStyle() : Void 
	{
		// Unselected Color
		if ( -1 != UIStyleManager.CHECKBOX_NORMAL_COLOR)
		_normalLineColor = UIStyleManager.CHECKBOX_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_OVER_COLOR)   
		_overLineColor = UIStyleManager.CHECKBOX_OVER_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_DOWN_COLOR) 
		_downLineColor = UIStyleManager.CHECKBOX_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_DISABLE_COLOR) 
		_disableLineColor = UIStyleManager.CHECKBOX_DISABLE_COLOR;
		
		// Selected Color 
		if ( -1 != UIStyleManager.CHECKBOX_NORMAL_SELECTED_COLOR)  
		_normalFillColor = UIStyleManager.CHECKBOX_NORMAL_SELECTED_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_OVER_SELECTED_COLOR)  
		_overFillColor = UIStyleManager.CHECKBOX_OVER_SELECTED_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_DOWN_SELECTED_COLOR)       
		_downFillColor = UIStyleManager.CHECKBOX_DOWN_SELECTED_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_DISABLE_SELECTED_COLOR)
		_disableFillColor = UIStyleManager.CHECKBOX_DISABLE_SELECTED_COLOR;
		
		// Label Settings  
		if ( -1 != UIStyleManager.CHECKBOX_TEXT_COLOR)
		_textColor = UIStyleManager.CHECKBOX_TEXT_COLOR;
		
		if ( -1 != UIStyleManager.CHECKBOX_TEXT_SIZE)
		_textSize = UIStyleManager.CHECKBOX_TEXT_SIZE;
		
		_textItalic = UIStyleManager.CHECKBOX_TEXT_ITALIC;
		_textBold = UIStyleManager.CHECKBOX_TEXT_BOLD;
		
		if ("" != UIStyleManager.CHECKBOX_TEXT_FONT)  
		_labelTextFormat.font = UIStyleManager.CHECKBOX_TEXT_FONT;
		
		if ("" != UIStyleManager.CHECKBOX_TEXT_ALIGN) 
		_textAlign = UIStyleManager.CHECKBOX_TEXT_ALIGN;
		
		if (null != UIStyleManager.CHECKBOX_TEXT_EMBED) 
		_labelTextField.setEmbedFont(UIStyleManager.CHECKBOX_TEXT_EMBED);
    }
	
	override public function reskin() : Void
	{
		initSkin();
		initStyle();
    }
	
		/**
		 * Set the textformat to label
		 *
		 * @param value The text format object that you want to use on the label
		 */
	private function set_textFormat(textFormat : TextFormat) : TextFormat
	{
		_useTextFormat = true;
		_labelTextFormat = textFormat;
		draw();
		return textFormat; 
	} 
	
	/**
	 * Return the text format object
	 */
	private function get_textFormat() : TextFormat { return _labelTextFormat; } 
		 
	/**
	 * Return the text field that is being used
	 */
	private function get_textField() : Label { return _labelTextField; }
	
	/**
	 * Set the label text
	 */
	private function set_text(value : String) : String 
	{ 
		_labelTextField.text = _labelText = value; 
		return value;
		
	}
		 
	/**
	 * Return the text that is currenly being used in the label
	 */
	private function get_text() : String { return _labelText; }
	 
	/**
	 * Set the label widtht the label to
	 */
	
	private function set_textWidth(value : Float) : Float { _textWidth = value; draw(); return value; }
		
	/**
	 * Return the width of the label
	 */
	
	private function get_textWidth() : Float { return _textWidth; } 
		 
	/**
	 * Change the font size of the text field
	 */
	
	 private function set_textSize(value : Int) : Int { _textSize = value; return value; } 
		 
		
	/**
	 * Return text size
	 */ 
	
	private function get_textSize() : Int { return _textSize; } 
		
	/**
	 * Indicates whether text in this text format is italicized. The default value is false, which means no italics are used
	 */
	private function set_textItalic(value : Bool) : Bool { _textItalic = value; draw(); return value; }
		 
	/**
	 * True if using italicized text and false if not
	 */
	private function get_textItalic() : Bool { return _textItalic; }
		 
	/**
	 * Specifies whether the text is boldface. The default value is false, which means no boldface is used. If the value is true, then the text is boldface.
	 */
	private function set_textBold(value : Bool) : Bool { _textBold = value; draw(); return value; } 
	 
	/**
	 * True if using boldface text and false if not
	 */
	private function get_textBold() : Bool { return _textBold; }
		 
		/**
		 * The color of the text in a text field, in hexadecimal format
		 */ 
		private function set_textColor(value : Int) : Int { _labelTextField.textColor = _textColor = value; return value; } 
		
		/**
		 * Return the label color
		 */
		private function get_textColor() : Int { return _textColor; } 
		 
		/**
		 * Set the alignment of the label text
		 */ 
		
		private function set_textAlign(value : String) : String { _textAlign = value; draw(); return value; }
		
		/**
		 * Return the alignment that is being used
		 */
		private function get_textAlign() : String { return _textAlign; }
		 
		/**
		 * Show or hide the label on checkbox
		 */
		
		private function set_showLabel(value : Bool) : Bool { _labelTextField.visible = _showLabel = value; return value; } 
		 
		
		/**
		 * Return if the label is hidden or is being displayed
		 */
		
		private function get_showLabel() : Bool { return _showLabel; }
		 
		/**
		 * Configure and setup the label to handle embedded fonts
		 *
		 * @param value The font you want to use.
		 *
		 */ 
		public function setEmbedFont(value : Font) : Void { _labelTextField.setEmbedFont(value); } 
		
		/**
		 * Unload the font that was set by using the setEmbedFont
		 */
		
		 public function unloadEmbedFont() : Void { _labelTextField.unloadEmbedFont(); }
		 
		/**
		 * This is for setting an image to the checkbox default state.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		public function setNormalImage(value : String) : Void { _normalDisplayImage.load(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox default state.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		public function setNormalBitmap(value : Bitmap) : Void { _blnNormalImage = true; _normalDisplayImage.setImage(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox roll over state.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */ 
		
		public function setOverImage(value : String) : Void { _overDisplayImage.load(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox roll over state.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		public function setOverBitmap(value : Bitmap) : Void { _blnOverImage = true; _overDisplayImage.setImage(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox roll down state.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		public function setDownImage(value : String) : Void { _downDisplayImage.load(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox press down state.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		public function setDownBitmap(value : Bitmap) : Void { _blnDownImage = true; _downDisplayImage.setImage(value); draw(); } 
		 
		/**
		 * This is for setting an image to the checkbox disable state.
		 *
		 * @param value Set the image based on a URL file path.
		 *
		 */
		
		public function setDisableImage(value : String) : Void { _disableDisplayImage.load(value); draw(); }
		 
		/**
		 * This is for setting an image to the checkbox disable state.
		 *
		 * @param value Set the image based on a Bitmap being pass
		 *
		 */
		
		public function setDisableBitmap(value : Bitmap) : Void { _blnDisableImage = true; _disableDisplayImage.setImage(value); draw(); } 
		 
		 
		 /**
		 * This setup and draw the checkbox on the screen
		 *
		 */
		override public function draw() : Void
		{
			// This make sure it toggle the down or up state  
			super.draw();
			
			// Draw check box layers
			_baseNormal.graphics.clear();
			_baseOver.graphics.clear();
			_baseDown.graphics.clear();
			_baseDisable.graphics.clear();
			
			// Drawing out check box or using bitmap image if loaded  
			if (_blnNormalImage && _showImage) 
			{
				_baseNormal.graphics.beginBitmapFill(_normalDisplayImage.image.bitmapData, null, true, _smoothImage);
				_baseNormal.graphics.drawRect(0, 0, _normalDisplayImage.image.bitmapData.width, _normalDisplayImage.image.bitmapData.height);
				_baseNormal.graphics.endFill();
			}
			else 
			{
				_baseNormal.graphics.lineStyle(_lineSize, _normalLineColor, _lineAlpha);
				_baseNormal.graphics.drawRect(0, 0, UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
			}  
			
			// Drawing out check box or using bitmap image if loaded
			if (_blnOverImage && _showImage)
			{
				_baseOver.graphics.beginBitmapFill(_overDisplayImage.image.bitmapData, null, true, _smoothImage);
				_baseOver.graphics.drawRect(0, 0, _overDisplayImage.image.bitmapData.width, _overDisplayImage.image.bitmapData.height);
				_baseOver.graphics.endFill();
			}
			else 
			{
				_baseOver.graphics.lineStyle(_lineSize, _overLineColor, _lineAlpha);
				_baseOver.graphics.drawRect(0, 0, UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE); 
				
				// Draw X if selected  
				if (selected) 
				{
					// Down State
					_baseOver.graphics.lineTo(UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
					_baseOver.graphics.moveTo(UIStyleManager.CHECKBOX_SIZE, 0);
					_baseOver.graphics.lineTo(0, UIStyleManager.CHECKBOX_SIZE);
				}
			} 
			
			// Drawing out check box or using bitmap image if loaded  
			if (_blnDownImage && _showImage)
			{
				_baseDown.graphics.beginBitmapFill(_downDisplayImage.image.bitmapData, null, true, _smoothImage);
				_baseDown.graphics.drawRect(0, 0, _downDisplayImage.image.bitmapData.width, _downDisplayImage.image.bitmapData.height);
				_baseDown.graphics.endFill();
			}
			else 
			{
				_baseDown.graphics.lineStyle(_lineSize, _normalLineColor, _lineAlpha);
				_baseDown.graphics.drawRect(0, 0, UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
				
				// Down State  
				_baseDown.graphics.lineTo(UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
				_baseDown.graphics.moveTo(UIStyleManager.CHECKBOX_SIZE, 0);
				_baseDown.graphics.lineTo(0, UIStyleManager.CHECKBOX_SIZE);
				
			}
			
			// Drawing out check box button or using bitmap image if loaded  
			if (_blnDisableImage && _showImage) 
			{
				_baseDisable.graphics.beginBitmapFill(_disableDisplayImage.image.bitmapData, null, true, _smoothImage);
				_baseDisable.graphics.drawRect(0, 0, _disableDisplayImage.image.bitmapData.width, _disableDisplayImage.image.bitmapData.height);
				_baseDisable.graphics.endFill();
			}
			else 
			{
				_baseDisable.graphics.lineStyle(_lineSize, _normalLineColor, _lineAlpha);
				_baseDisable.graphics.drawRect(0, 0, UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
				
				// Draw X if selected  
				if (selected) 
				{
					// Down State
					_baseDisable.graphics.lineTo(UIStyleManager.CHECKBOX_SIZE, UIStyleManager.CHECKBOX_SIZE);
					_baseDisable.graphics.moveTo(UIStyleManager.CHECKBOX_SIZE, 0);
					_baseDisable.graphics.lineTo(0, UIStyleManager.CHECKBOX_SIZE);
				}
				
			}
			
			// Set label and style
			_labelTextField.align = _textAlign;
			_labelTextField.textFormat.italic = _textItalic;
			_labelTextField.textFormat.bold = _textBold;
			_labelTextField.textColor = _textColor;
			_labelTextField.size = _textSize;  
			
			// Text field    
			//_labelTextField.setTextFormat(_labelTextFormat); 
			_labelTextField.textField.selectable = false;
			_labelTextField.textField.wordWrap = true;
			_labelTextField.textField.multiline = false;
			_labelTextField.textField.autoSize = TextFieldAutoSize.LEFT;
			_labelTextField.x = UIStyleManager.CHECKBOX_LABEL_OFFSET_X;
			_labelTextField.y = UIStyleManager.CHECKBOX_LABEL_OFFSET_Y;
			
			if (_blnNormalImage) 
			_labelTextField.x += _normalDisplayImage.image.bitmapData.width;
			
			_labelTextField.width = _textWidth;
			_labelTextField.text = _labelText;
			_labelTextField.visible = _showLabel;
			
			// Draw clear box for rollover states  
			if (_textSelectable) 
			{
				_baseNormal.graphics.lineStyle(_lineSize, _normalLineColor, 0);
				_baseNormal.graphics.beginFill(_normalFillColor, 0);
				_baseNormal.graphics.drawRect(0, 0, width, height);
				_baseNormal.graphics.endFill(); 
				
				_baseOver.graphics.lineStyle(_lineSize, _overLineColor, 0);
				_baseOver.graphics.beginFill(_overFillColor, 0);
				_baseOver.graphics.drawRect(0, 0, width, height);
				_baseOver.graphics.endFill();
				
				_baseDown.graphics.lineStyle(_lineSize, _downLineColor, 0);
				_baseDown.graphics.beginFill(_downFillColor, 0);
				_baseDown.graphics.drawRect(0, 0, width, height);
				_baseDown.graphics.endFill();
				
				_baseDisable.graphics.lineStyle(_lineSize, _downLineColor, 0);
				_baseDisable.graphics.beginFill(_disableFillColor, 0);
				_baseDisable.graphics.drawRect(0, 0, width, height);
				_baseDisable.graphics.endFill();
			}
    }
	
	private function normalImageComplete(event : Event) : Void { _blnNormalImage = true; draw(); }
	private function overImageComplete(event : Event) : Void { _blnOverImage = true; draw(); }
	private function downImageComplete(event : Event) : Void { _blnDownImage = true; draw(); }
	private function disableImageComplete(event : Event) : Void { _blnDisableImage = true; draw(); }
}