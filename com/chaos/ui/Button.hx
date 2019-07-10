
package com.chaos.ui;


import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IToggleButton;

import openfl.display.BitmapData;
import openfl.display.Shape;
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

class Button extends ToggleButton implements IButton implements IToggleButton implements IBaseUI
{
	
    /** The type of UI Element */
    public static inline var TYPE : String = "Button";
	
	private static inline var PRESS_MODE:String = "press";
	private static inline var TOGGLE_MODE:String = "toggle";
	
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
    public var mode(get, set) : String;
	
    public var iconDisplay(get, set) : Bool;
    public var tileImage(get, set) : Bool;
    
    private var _imageOffSetX : Int;
    private var _imageOffSetY : Int;
    
    private var _label : Label;
    private var _textFormat : TextFormat;
    
    // Default button colors
    private var _text : String = "";
	
	private var _labelData:Dynamic = null;
    
    private var _showLabel : Bool = true;
    private var _showIcon : Bool = false;
    
    private var _bgShowImage : Bool = true;
    
    private var _icon : Shape;
	
	private var _mode:String = "press";
	
    /**
	 * Push Button
	 *
	 * @param	data The data object with all the values. Use text, width and height 
	 */
    
    public function new(data:Dynamic = null)
    {
		
        super(data);
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 1, true);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "text"))
			_text = Reflect.field(data, "text");
		
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
			
		if (Reflect.hasField(data, "showLabel"))
			_showLabel = Reflect.field(data, "showLabel");
			
	}

    override public function initialize() : Void
    {
		if (_labelData == null)
			_labelData = {"textColor": 0xFFFFFF};
		
		// Init core components first
        _label = new Label(_labelData);
        _textFormat = new TextFormat();
        _icon = new Shape();
		
		// Now init and add everything 
		super.initialize();
        
        _label.visible = _showLabel;
        _bgAlpha = UIStyleManager.BUTTON_ALPHA;
        
        mouseChildren = false;
        
        addChild(_label);
        addChild(_icon);
        
		_labelData = null;
		
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
    
    private function initBitmap() : Void
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
    
    private function initStyle() : Void
    {
        
        // First set style default
        if (UIStyleManager.BUTTON_WIDTH > 0 && UIStyleManager.BUTTON_WIDTH != width) 
            _width = UIStyleManager.BUTTON_WIDTH;
        
        if (UIStyleManager.BUTTON_HEIGHT > 0 && UIStyleManager.BUTTON_HEIGHT != height) 
            _height = UIStyleManager.BUTTON_HEIGHT;  
        
        // Set the default round edge
        if (-1 != UIStyleManager.BUTTON_ROUND_NUM) 
            _roundEdge = UIStyleManager.BUTTON_ROUND_NUM;  
        
        // Set Button Label because on UIStyleManager
        if (-1 != UIStyleManager.BUTTON_TEXT_COLOR) 
            _label.textColor = UIStyleManager.BUTTON_TEXT_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_TEXT_SIZE) 
            _label.size = UIStyleManager.BUTTON_TEXT_SIZE;
        
        _label.textFormat.italic = UIStyleManager.BUTTON_TEXT_ITALIC;
        _label.textFormat.bold = UIStyleManager.BUTTON_TEXT_BOLD;
        
        if ("" != UIStyleManager.BUTTON_TEXT_FONT) 
            _textFormat.font = UIStyleManager.BUTTON_TEXT_FONT;
        
        if ("" != UIStyleManager.BUTTON_TEXT_ALIGN) 
            _label.align = UIStyleManager.BUTTON_TEXT_ALIGN;
        
        if (null != UIStyleManager.BUTTON_TEXT_EMBED) 
            _label.setEmbedFont(UIStyleManager.BUTTON_TEXT_EMBED);
        
        if (-1 != UIStyleManager.BUTTON_NORMAL_COLOR) 
            _defaultColor = UIStyleManager.BUTTON_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_OVER_COLOR) 
            _overColor = UIStyleManager.BUTTON_OVER_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DOWN_COLOR) 
            _downColor = UIStyleManager.BUTTON_DOWN_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DISABLE_COLOR) 
            _disableColor = UIStyleManager.BUTTON_DISABLE_COLOR;
        
        _label.x = UIStyleManager.BUTTON_TEXT_OFFSET_X;
        _label.y = UIStyleManager.BUTTON_TEXT_OFFSET_Y;
        
        // Set default loc of image offset
        _imageOffSetX = UIStyleManager.BUTTON_IMAGE_OFFSET_X;
        _imageOffSetY = UIStyleManager.BUTTON_IMAGE_OFFSET_Y;
    }
    
    /**
	 * Remove all roll over and roll out effects while setting button to it's disable state
	 */
    
	
	//@:setter(enabled)
	override function set_enabled(value:Bool):Bool 
	{
		
		if (_mode.toLowerCase() == PRESS_MODE)
		{
			if (enabled != value) 
			{
				
				if (value) 
				{
					// Attach roll over and out event
					if (!hasEventListener(MouseEvent.MOUSE_UP))
						addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 0, true);
						
					disableState.visible = false;
				}
				else 
				{
					
					// Attach roll over and out event
					removeEventListener(MouseEvent.MOUSE_UP, mouseUpEvent);
					disableState.visible = true;
				}
			}
		}
		
		buttonMode = value;
		
		return super.set_enabled(value);
	}
	
    
    
	private function set_mode(value:String):String
	{
		_mode = value;
		
		
		if (_mode == PRESS_MODE)
			downState.visible = disableState.visible = overState.visible = normalState.visible = true;
		else
		{
			downState.visible = disableState.visible = overState.visible = normalState.visible = true;
			
			// Toggle Seleect state
			if (_selected)
			{
				normalState.visible = false;
				downState.visible = true;
			}
			else
			{
				normalState.visible = true;
				downState.visible = false;
			}
		
		}
		
		return value;
	}
	
	private function get_mode():String
	{
		return _mode;
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
        _label.textFormat.italic = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the label is italicize and false if not
	 */
    
    private function get_textItalic() : Bool
    {
        return _label.textFormat.italic;
    }
    
    /**
	 * Set to true if you want to boldface the text and false if not.
	 */
    
    private function set_textBold(value : Bool) : Bool
    {
        _label.textFormat.bold = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the label is boldface and false if not
	 */
    
    private function get_textBold() : Bool
    {
        return _label.textFormat.bold;
    }
    
    /**
	 * Set the font size of the button
	 */
    
    private function set_textSize(value : Int) : Int
    {
        _label.size = value;
        draw();
        return value;
    }
    
    /**
	 * Return the font size being used
	 */
    
    private function get_textSize() : Int
    {
        return _label.size;
    }
    
    /**
	 * Set the label color
	 */
    
    private function set_textColor(value : Int) : Int
    {
        _label.textColor = value;
        return value;
    }
    
    /**
	 *  Return label color
	 */
    
    private function get_textColor() : Int
    {
        return _label.textColor;
    }
    
    /**
	 * Set the label text alignment, use the Adobe TextFormatAlign class to set the label.
	 *
	 * @see openfl.text.TextFormatAlign
	 */
    
    private function set_textAlign(value : String) : String
    {
        _label.align = value;
        draw();
        return value;
    }
    
    /**
	 * Return the label text alignment settings as a string
	 */
    
    private function get_textAlign() : String
    {
        return _label.align;
    }
    

    
    /**
	 * Set the icon that will be used on the button
	 *
	 * @param	displayObj The display object that will be used for an icon
	 */
    
    public function setIcon(image : BitmapData) : Void
    {
		_icon.graphics.clear();
        _icon.graphics.beginBitmapFill(image, null, false, _imageSmooth);
		_icon.graphics.drawRect(0, 0, image.width, image.height);
		_icon.graphics.endFill();
		
		
        draw();
    }
    
    /**
	 * The Shape being used as the icon for the button
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
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Unload label
		_label.destroy();
		
		// Event
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		// Clear icon
		_icon.graphics.clear();
		
		// Remove
		if (_icon.parent != null)
			_icon.parent.removeChild(_icon);
		
		_icon = null;
		
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
            _label.width = _width - _icon.width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.x = _icon.width + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.y = (_height / 2) - (_label.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
            
            // Set this first and then use offset later
            _icon.y = _label.y;
            
            _icon.x = _imageOffSetX;
            _icon.y = _imageOffSetY;
        }
        else if (_showIcon && !_showLabel) 
        {
            // Set location of icon
            if (_icon.width < _width) 
                _icon.x = (_width / 2) - (_icon.width / 2);
            
            if (_icon.height < _height) 
                _icon.y = (_height / 2) - (_icon.height / 2);
			
        }
        else if (!_showIcon && _showLabel)  // Hide and show what is needed by default
        {
            
            // Set location of text
            _label.width = _width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.x = (_width / 2) - (_label.width / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _label.y = (_height / 2) - (_label.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
			
        }
		
		if (_mode.toLowerCase() == PRESS_MODE)
		{
			
			normalState.visible = true;
			disableState.visible = overState.visible = downState.visible = false;
		}
		else
		{
			if(_selected)
				normalState.visible = true;
			else
				downState.visible = true;
				
		}        
    }
	
	private function mouseUpEvent(event:MouseEvent):Void 
	{
		normalState.visible = true;
		disableState.visible = overState.visible = downState.visible = false;
	}	
	
	override function mouseDownEvent(event:MouseEvent):Void 
	{
		// Either go with what is done in the ToggleButton Super class
		if (_mode.toLowerCase() != PRESS_MODE)
			super.mouseDownEvent(event);
		else
		{
			// Or Just show down state on mouse down
			downState.visible = true;	
			disableState.visible = overState.visible = normalState.visible = false;
		}
	}
	
	
}

