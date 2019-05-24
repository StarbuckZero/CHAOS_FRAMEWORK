
package com.chaos.ui;



import com.chaos.drawing.Draw;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IOverlay;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Loader;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.filters.BitmapFilter;
import openfl.filters.BitmapFilterQuality;
import openfl.filters.GlowFilter;

import openfl.display.Bitmap;


import openfl.events.MouseEvent;
import openfl.events.Event;

import openfl.text.TextField;
import openfl.text.TextFormatAlign;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;




import com.chaos.ui.Label;


/**
 *  Normal push button with or without an icon
 *
 *  @author Erick Feiling
 *  @date 5-21-19
 * 
 */

class Button extends BaseUI implements IButton implements IBaseUI
{
    public var imageOffSetX(get, set) : Int;
    public var imageOffSetY(get, set) : Int;
	
    public var text(get, set) : String;
	public var label(get, never) : ILabel;
	
    public var showLabel(get, set) : Bool;
	
    public var textFont(get, set) : String;
    public var textItalic(get, set) : Bool;
    public var textBold(get, set) : Bool;
    public var textSize(get, set) : Int;
    public var textColor(get, set) : Int;
    public var textAlign(get, set) : String;
	
    public var buttonColor(get, set) : Int;
    public var buttonOverColor(get, set) : Int;
    public var buttonDownColor(get, set) : Int;
    public var buttonDisableColor(get, set) : Int;
	
    public var roundEdge(get, set) : Int;
	
    public var bitmapAlpha(get, set) : Float;
	
    public var iconDisplay(get, set) : Bool;
    public var tileImage(get, set) : Bool;
    

    /** The type of UI Element */
    public static inline var TYPE : String = "Button";
       
    public var baseNormal : Shape;
    public var baseOver : Shape;
    public var baseDown : Shape;
    public var baseDisable : Shape;
    
    
    private var _imageOffSetX : Int;
    private var _imageOffSetY : Int;
    
    private var _label : Label;
    private var _textFormat : TextFormat;
    
    // Default button colors
    private var _text : String = "";
    
    private var _buttonTextColor : Int = 0xFFFFFF;
    private var _buttonTextBold : Bool = true;
    private var _buttonTextItalic : Bool = false;
    private var _buttonTextSize : Int = 11;
    private var _buttonTextAlign : String = TextFormatAlign.CENTER;
    
    private var _roundEdge : Int = 0;
    
    private var _buttonNormalColor : Int = 0xCCCCCC;
    private var _buttonOverColor : Int = 0x666666;
    private var _buttonDownColor : Int = 0x333333;
    private var _buttonDisableColor : Int = 0x999999;
    
    private var _showLabel : Bool = true;
    private var _showIcon : Bool = false;
    
    private var _bgShowImage : Bool = true;
    
    private var _imageSmooth : Bool = true;
    
    private var _bgAlpha : Float = UIStyleManager.BUTTON_ALPHA;
    
    private var _icon : Shape;
    
    private var _defaultStateImage : BitmapData;
    private var _overStateImage : BitmapData;
    private var _downStateImage : BitmapData;
    private var _disableStateImage : BitmapData;
    
    private var _useMask : Bool = false;
	private var _tileImage:Bool = false;

	
	
    /**
	 * Push Button
	 *
	 * @param	label The text that will be displayed on the label
	 * @param	buttonWidth The button width
	 * @param	buttonHeight The button height
	 */
    
    public function new(text : String = "Button", buttonWidth : Int = 100, buttonHeight : Int = 20)
    {
        
        super();
        

        // Set defaults
        _text = text;
        
        // Set if style is not set
        if (UIStyleManager.BUTTON_WIDTH == -1) 
            width = buttonWidth;
        
        if (UIStyleManager.BUTTON_HEIGHT == -1) 
            height = buttonHeight;
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
    private function onStageAdd(event : Event) : Void
    {
        UIBitmapManager.watchElement(TYPE, this);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        UIBitmapManager.stopWatchElement(TYPE, this);
    }
    
    private function init() : Void
    {
		
        // Init button
        baseNormal = new Shape();
        baseOver = new Shape();
        baseDown = new Shape();
        baseDisable = new Shape();
        
        _label = new Label();
        _textFormat = new TextFormat();
        _label.visible = _showLabel;
        
        _icon = new Shape();
        
        
        // Attach roll over and out event
        addEventListener(MouseEvent.MOUSE_DOWN, downState, false, 0, true);
        addEventListener(MouseEvent.MOUSE_UP, normalState, false, 0, true);
        
        addEventListener(MouseEvent.MOUSE_OVER, overState, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, normalState, false, 0, true);
        
        // Hide Over and Down state
        baseOver.visible = false;
        baseDown.visible = false;
        baseDisable.visible = false;
        
        mouseChildren = false;
        
        addChild(baseNormal);
        addChild(baseOver);
        addChild(baseDown);
        addChild(baseDisable);
        
        addChild(_label);
        addChild(_icon);
        
        // Create base
        reskin();
		
		
    }
    
	/**
	 * @inheritDoc
	 */
    
    override public function reskin() : Void
    {
        super.reskin();
        
        initBitmap();
        initStyle();
        
        draw();
    }
    
    public function initBitmap() : Void
    {
        // Set skining if in UIBitmapManager
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_NORMAL)) 
            setDefaultStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_OVER)) 
            setOverStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_OVER));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DOWN)) 
            setDownStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DOWN));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DISABLE)) 
            setDisableStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DISABLE));
    }
    
    public function initStyle() : Void
    {
        
        // First set style default
        if (UIStyleManager.BUTTON_WIDTH > 0 && UIStyleManager.BUTTON_WIDTH != width) 
            width = UIStyleManager.BUTTON_WIDTH;
        
        if (UIStyleManager.BUTTON_HEIGHT > 0 && UIStyleManager.BUTTON_HEIGHT != height) 
            height = UIStyleManager.BUTTON_HEIGHT;  
        
        // Set the default round edge
        if (-1 != UIStyleManager.BUTTON_ROUND_NUM) 
            _roundEdge = UIStyleManager.BUTTON_ROUND_NUM;  
        
        
        // Set Button Label because on UIStyleManager
        if (-1 != UIStyleManager.BUTTON_TEXT_COLOR) 
            _buttonTextColor = UIStyleManager.BUTTON_TEXT_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_TEXT_SIZE) 
            _buttonTextSize = UIStyleManager.BUTTON_TEXT_SIZE;
        
        _buttonTextItalic = UIStyleManager.BUTTON_TEXT_ITALIC;
        _buttonTextBold = UIStyleManager.BUTTON_TEXT_BOLD;
        
        if ("" != UIStyleManager.BUTTON_TEXT_FONT) 
            _textFormat.font = UIStyleManager.BUTTON_TEXT_FONT;
        
        if ("" != UIStyleManager.BUTTON_TEXT_ALIGN) 
            _buttonTextAlign = UIStyleManager.BUTTON_TEXT_ALIGN;
        
        if (null != UIStyleManager.BUTTON_TEXT_EMBED) 
            _label.setEmbedFont(UIStyleManager.BUTTON_TEXT_EMBED);
        
        if (-1 != UIStyleManager.BUTTON_NORMAL_COLOR) 
            _buttonNormalColor = UIStyleManager.BUTTON_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_OVER_COLOR) 
            _buttonOverColor = UIStyleManager.BUTTON_OVER_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DOWN_COLOR) 
            _buttonDownColor = UIStyleManager.BUTTON_DOWN_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DISABLE_COLOR) 
            _buttonDisableColor = UIStyleManager.BUTTON_DISABLE_COLOR;
        
        _label.x = UIStyleManager.BUTTON_TEXT_OFFSET_X;
        _label.y = UIStyleManager.BUTTON_TEXT_OFFSET_Y;
        
        // Set default loc of image offset
        _imageOffSetX = UIStyleManager.BUTTON_IMAGE_OFFSET_X;
        _imageOffSetY = UIStyleManager.BUTTON_IMAGE_OFFSET_Y;
    }
    
    /**
	 * Remove all roll over and roll out effects while setting button to it's disable state
	 */
    
    override private function set_enabled(value : Bool) : Bool
    {
        
        if (enabled != value) 
        {
            
            if (value) 
            {
                // Attach roll over and out event
                addEventListener(MouseEvent.MOUSE_DOWN, downState, false, 0, true);
                addEventListener(MouseEvent.MOUSE_UP, normalState, false, 0, true);
                
                addEventListener(MouseEvent.MOUSE_OVER, overState, false, 0, true);
                addEventListener(MouseEvent.MOUSE_OUT, normalState, false, 0, true);
                
                baseDisable.visible = false;
            }
            else 
            {
                
                // Attach roll over and out event
                removeEventListener(MouseEvent.MOUSE_DOWN, downState);
                removeEventListener(MouseEvent.MOUSE_UP, normalState);
                
                removeEventListener(MouseEvent.MOUSE_OVER, overState);
                removeEventListener(MouseEvent.MOUSE_OUT, normalState);
                
                baseDisable.visible = true;
            }
        }
        
        super.enabled = value;
		
        return value;
    }
    
    
    /**
	 * The offset of the image icon location on the X axis
	 */
    
    private function set_imageOffSetX(value : Int) : Int
    {
        _imageOffSetX = value;
		
        draw();
        return value;
    }
    
    /**
	 * Return the pixel offset for on X axis
	 */
    
    private function get_imageOffSetX() : Int
    {
        return _imageOffSetX;
    }
    
    /**
	 * The offset of the image icon location on the Y axis
	 */
    
    private function set_imageOffSetY(value : Int) : Int
    {
        _imageOffSetY = value;
        draw();
        return value;
    }
    
    /**
	 * Return the pixel offset for on Y axis
	 */
    
    private function get_imageOffSetY() : Int
    {
        return _imageOffSetY;
    }
    
    /**
	 * Set the text on the button
	 */
    
    private function set_text(value : String) : String
    {
        _text = value;
        draw();
        return value;
    }
    
    /**
	 * Return the text that is on the label
	 */
    
    private function get_text() : String
    {
        return _text;
    }
    
    /**
	 * Show or hide the label on button
	 */
    
    private function set_showLabel(value : Bool) : Bool
    {
        _showLabel = value;
        draw();
        return value;
    }
    
    /**
	 * Return if the label is hidden or is being displayed
	 */
    
    private function get_showLabel() : Bool
    {
        return _showLabel;
    }
    
    /**
	 * Return the label that is being used in the button
	 */
    
    private function get_label() : ILabel
    {
        return _label;
    }
    
    /**
	 * Set the font that will be used
	 */
    
    private function set_textFont(value : String) : String
    {
        _textFormat.font = value;
        draw();
        return value;
    }
    
    /**
	 * Return the font that is being used on the button label
	 */
    
    private function get_textFont() : String
    {
        return _textFormat.font;
    }
    
    /**
	 * Set to true if you want to italicized the text and false if not.
	 */
    
    private function set_textItalic(value : Bool) : Bool
    {
        _buttonTextItalic = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the label is italicize and false if not
	 */
    
    private function get_textItalic() : Bool
    {
        return _buttonTextItalic;
    }
    
    /**
	 * Set to true if you want to boldface the text and false if not.
	 */
    
    private function set_textBold(value : Bool) : Bool
    {
        _buttonTextBold = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the label is boldface and false if not
	 */
    
    private function get_textBold() : Bool
    {
        return _buttonTextBold;
    }
    
    /**
	 * Set the font size of the button
	 */
    
    private function set_textSize(value : Int) : Int
    {
        _buttonTextSize = value;
        draw();
        return value;
    }
    
    /**
	 * Return the font size being used
	 */
    
    private function get_textSize() : Int
    {
        return _buttonTextSize;
    }
    
    /**
	 * Set the label color
	 */
    
    private function set_textColor(value : Int) : Int
    {
        _buttonTextColor = value;
        draw();
        return value;
    }
    
    /**
	 *  Return label color
	 */
    
    private function get_textColor() : Int
    {
        return _buttonTextColor;
    }
    
    /**
	 * Set the label text alignment, use the Adobe TextFormatAlign class to set the label.
	 *
	 * @see openfl.text.TextFormatAlign
	 */
    
    private function set_textAlign(value : String) : String
    {
        _buttonTextAlign = value;
        draw();
        return value;
    }
    
    /**
	 * Return the label text alignment settings as a string
	 */
    
    private function get_textAlign() : String
    {
        return _buttonTextAlign;
    }
    
    /**
	 * The button normal state color
	 */
    
    private function set_buttonColor(value : Int) : Int
    {
        _buttonNormalColor = value;
        
        draw();
        return value;
    }
    
    /**
	 * Return the normal state button color
	 */
    
    private function get_buttonColor() : Int
    {
        return _buttonNormalColor;
    }
    
    /**
	 * The button over state color
	 */
    
    private function set_buttonOverColor(value : Int) : Int
    {
        _buttonOverColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the button over state color
	 */
    
    private function get_buttonOverColor() : Int
    {
        return _buttonOverColor;
    }
    
    /**
	 * The button down state color
	 */
    
    private function set_buttonDownColor(value : Int) : Int
    {
        _buttonDownColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the button down state color
	 */
    
    private function get_buttonDownColor() : Int
    {
        return _buttonDownColor;
    }
    
    /**
	 * The button disable state color
	 */
    
    private function set_buttonDisableColor(value : Int) : Int
    {
        _buttonDisableColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the button disable state color
	 */
    
    private function get_buttonDisableColor() : Int
    {
        return _buttonDisableColor;
    }
    
    /**
	 * Set how rounded the button is
	 */
    
    private function set_roundEdge(value : Int) : Int
    {
        _roundEdge = value;
        draw();
        return value;
    }
    
    /**
	 * Return how rounded the button is
	 */
    
    private function get_roundEdge() : Int
    {
        return _roundEdge;
    }
    
    /**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
    
    private function set_bitmapAlpha(value : Float) : Float
    {
        _bgAlpha = value;
        draw();
        return value;
    }
    
    /**
	 *  Return the alpha of the button
	 */
    
    private function get_bitmapAlpha() : Float
    {
        return _bgAlpha;
    }
    
    /**
	 * Set the icon that will be used on the button
	 *
	 * @param	displayObj The display object that will be used for an icon
	 */
    
    public function setIcon(image : BitmapData) : Void
    {
        _icon.graphics.beginBitmapFill(image, null, false, _imageSmooth);
		_icon.graphics.drawRect(0, 0, image.width, image.height);
		_icon.graphics.endFill();
		
		
        draw();
    }
    
    /**
	 * The DisplayObject being used as the icon for the button
	 *
	 * @return A DisplayObject if there is one if not then return null
	 */
    
    public function getIcon() : Shape
    {
		
        return _icon;
    }
    

    
    /**
	 * Set this if you want to display the icon
	 *
	 * @param value Set true if you want to see the icon and false if not
	 *
	 */
    
    private function set_iconDisplay(value : Bool) : Bool
    {
        _showIcon = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the icon is being display and false if not
	 */
    
    private function get_iconDisplay() : Bool
    {
        return _showIcon;
    }

	private function set_tileImage(value : Bool) : Bool
	{
		_tileImage = value;
		draw();
		return value;
	}
	
	private function get_tileImage() : Bool
	{
		return _tileImage;
	}
    
    /**
	 * This is for setting an image to the button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setDefaultStateImage(value : BitmapData) : Void
    {
        
        _defaultStateImage = value;
        draw();
    }
    

    
    /**
	 * This is for setting an image to the button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setOverStateImage(value : BitmapData) : Void
    {
        
        _overStateImage = value;
        draw();
    }
    
    
    /**
	 * This is for setting an image to the button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setDownStateImage(value : BitmapData) : Void
    {
        
        _downStateImage = value;
        draw();
    }
    

    
    /**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setDisableStateImage(value : BitmapData) : Void
    {
        
        _disableStateImage = value;
        draw();
    }
    
    /**
	 * This setup and draw the button on the screen
	 *
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Hide or Display items
        _icon.visible = _showIcon;
        _label.visible = _showLabel;
        _label.width = 1;

		// Figure to use bitmap or normal mode
		if (_bgShowImage) 
		{
			// Normal
			if (null != _defaultStateImage)
				drawButtonState(baseNormal, _buttonNormalColor, _defaultStateImage);
			else 
				drawButtonState(baseNormal, _buttonNormalColor);
				
			// Over
			if (null != _overStateImage) 
				drawButtonState(baseOver, _buttonOverColor, _overStateImage);
			else
				drawButtonState(baseOver, _buttonOverColor);
			
			// Down
			if (null != _downStateImage) 
				drawButtonState(baseDown, _buttonDownColor, _downStateImage);
			else 
				drawButtonState(baseDown, _buttonDownColor);
			
			// Disable
			if (null != _disableStateImage) 
				drawButtonState(baseDisable, _buttonDisableColor, _disableStateImage);
			else 
				drawButtonState(baseDisable, _buttonDisableColor);
		}
		else 
		{
			
			drawButtonState(baseNormal, _buttonNormalColor);
			drawButtonState(baseOver, _buttonOverColor);
			drawButtonState(baseDown, _buttonDownColor);
			drawButtonState(baseDisable, _buttonDisableColor);
		} 		
		
        
        // Resize all items  
        baseDisable.width = baseDown.width = baseOver.width = baseNormal.width = width;
        baseDisable.height = baseDown.height = baseOver.height = baseNormal.height = height;
		
        // Set label and style
        _label.align = _buttonTextAlign;
        _label.textFormat.italic = _buttonTextItalic;
        _label.textFormat.bold = _buttonTextBold;
        _label.textColor = _buttonTextColor;
        
        
        // Seting label  
        _label.text = _text;
        _label.textField.multiline = true;
        _label.textField.autoSize = TextFieldAutoSize.CENTER;
        
        // Set location of icon
        _icon.x = _imageOffSetX;
        _icon.y = _imageOffSetY;
        
        // Setting loc of items
        if (_showIcon && _showLabel) 
        {
            
            // Set location of text
            _label.width = width - _icon.width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.x = _icon.width + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.y = (height / 2) - (_label.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
            
            // Set this first and then use offset later
            _icon.y = _label.y;
            
            _icon.x = _imageOffSetX;
            _icon.y = _imageOffSetY;
        }
        else if (_showIcon && !_showLabel) 
        {
            
            // Set location of icon
            if (_icon.width < _width) 
                _icon.x = (width / 2) - (_icon.width / 2);
            
            if (_icon.height < height) 
                _icon.y = (height / 2) - (_icon.height / 2);
        }
        else if (!_showIcon && _showLabel)  // Hide and show what is needed by default
        {
            
            // Set location of text
            _label.width = width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.x = (width / 2) - (_label.width / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.y = (height / 2) - (_label.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
			
        }
        
        
        baseNormal.visible = true;
        baseOver.visible = baseDown.visible = baseDisable.visible = false;
        
        addChild(baseNormal);
        addChild(baseOver);
        addChild(baseDown);
        addChild(baseDisable);
        
        addChild(_label);
        addChild(_icon);
    }
	
	public function drawButtonState(square:Shape,  color:Int = 0xFFFFFF, image:BitmapData = null):Void
	{
		square.graphics.clear();
		
		if (null != image) 
			square.graphics.beginBitmapFill(image, null, _tileImage, _imageSmooth);
		else 
			square.graphics.beginFill(color, _bgAlpha);
		
		if (image != null)
			square.graphics.drawRoundRect(0, 0, image.width, image.height, _roundEdge);
		
		square.graphics.endFill();
	}

    
    private function normalState(event : MouseEvent) : Void
    {
        baseNormal.visible = true;
        baseOver.visible = false;
        baseDown.visible = false;
        baseDisable.visible = false;
    }
    
    private function overState(event : MouseEvent) : Void
    {
        
        if (_bgShowImage) 
        {
            
            baseNormal.visible = true;
            baseOver.visible = true;
            baseDown.visible = false;
            baseDisable.visible = false;
        }
        else 
        {
            baseNormal.visible = false;
            baseOver.visible = true;
            baseDown.visible = false;
            baseDisable.visible = false;
        }
    }
    
    private function downState(event : MouseEvent) : Void
    {
        
        
        if (_bgShowImage) 
        {
            baseNormal.visible = true;
            baseOver.visible = false;
            baseDown.visible = true;
            baseDisable.visible = false;
        }
        else 
        {
            baseNormal.visible = false;
            baseOver.visible = false;
            baseDown.visible = true;
            baseDisable.visible = false;
        }
    }
}

