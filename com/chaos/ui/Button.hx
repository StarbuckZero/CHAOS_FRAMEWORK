
package com.chaos.ui;


import com.chaos.ui.UIBitmapManager.UIBitmapType;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IToggleButton;

import openfl.display.BitmapData;
import openfl.display.Shape;

import openfl.events.MouseEvent;
import openfl.events.Event;

import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;




import com.chaos.ui.Label;


/**
 *  Normal push button with or without an icon
 */

class Button extends ToggleButton implements IButton implements IToggleButton implements IBaseUI
{	
	private static inline var PRESS_MODE:String = "press";
	private static inline var TOGGLE_MODE:String = "toggle";
	
	
    /**
	 * The offset of the image icon location on the X axis
	 */ 
	
    public var imageOffSetX(get, set) : Int;
	
	/**
	 * The offset of the image icon location on the Y axis
	 */
	
    public var imageOffSetY(get, set) : Int;
	
	/**
	 * Set the text on the button
	 */
	
    public var text(get, set) : String;
	
	 /**
	 * Return the label that is being used in the button
	 */	
	public var label(get, never) : ILabel;
	
	/**
	 * Show or hide the label on button
	 */
	
    public var showLabel(get, set) : Bool;
	
	/**
	 * Change button to "press" or "toggle" state. Set to press by default.
	 */
	
    public var mode(get, set) : String;
	
	 /**
	 * Set or return the font being used
	 */	
	 
    public var textFont(get, set) : String;
	
	 /**
	 * Set to true if you want to boldface the text and false if not.
	 */ 
	 
	public var textBold(get, set) : Bool;
	
	 /**
	 * Set to true if you want to italicize  the text and false if not.
	 */ 
	 
    public var textItalic(get, set) : Bool;
    
	 /**
	 * Set the font size of the button
	 */
	 
    public var textSize(get, set) : Int;
	
	 /**
	 * Set the label color
	 */
	 
    public var textColor(get, set) : Int;
	
	 /**
	 * Set the label text alignment, use the Adobe TextFormatAlign class to set the label.
	 *
	 * @see openfl.text.TextFormatAlign
	 */
	 
    public var textAlign(get, set) : String;
	
	 /**
	 * Set this if you want to display the icon
	 */   
	 
    public var iconDisplay(get, set) : Bool;
    
	
    
    private var _imageOffSetX : Int;
    private var _imageOffSetY : Int;
    
    private var _label : Label;
    private var _textFormat : TextFormat = new TextFormat();
    
    // Default button colors
    private var _text : String = "";
	
	private var _labelData:Dynamic = {};
    
    private var _showLabel : Bool = true;
    private var _showIcon : Bool = false;
    
    private var _bgShowImage : Bool = true;
    
    private var _icon : Shape = new Shape();
	
	private var _mode : String = "press";
	
	private var _bold : Bool = false; 
	private var _italic : Bool = false;

    private var _labelSize : Int = 11;
    private var _textColor : Int = 0xFFFFFF;
	
	/**
	 * UI Button 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data:Dynamic = null)
    {
		
        super(data);
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 1, true);
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "text"))
			_text = Reflect.field(data, "text");
		
        // Get Label variables
		if (Reflect.hasField(data, "Label")) 
        {
            _labelData = Reflect.field(data, "Label");
            
            if(Reflect.hasField(_labelData,"size")) 
                _labelSize = Reflect.field(_labelData, "size");

            if(Reflect.hasField(_labelData,"textColor")) 
                _textColor = Reflect.field(_labelData, "textColor");

            if(Reflect.hasField(_labelData,"italic")) 
                _italic = Reflect.field(_labelData, "italic");

            if(Reflect.hasField(_labelData,"bold")) 
                _bold = Reflect.field(_labelData, "bold");            

        }
		else 
        {
            _labelData = {"textColor": _textColor, "bold":_bold, "italic":_italic, "size": _labelSize};
        }
            
			

		if (Reflect.hasField(data, "showLabel"))
			_showLabel = Reflect.field(data, "showLabel");
			
		if (Reflect.hasField(data, "showIcon"))	
			_showIcon = Reflect.field(data, "showIcon");
			
		if (Reflect.hasField(data, "imageOffSetX"))	
			_imageOffSetX = Reflect.field(data, "imageOffSetX");
			
		if (Reflect.hasField(data, "imageOffSetY"))	
			_imageOffSetY = Reflect.field(data, "imageOffSetY");
			
		if (Reflect.hasField(data, "mode"))
			_mode = Reflect.field(data, "mode");
	}
	
	/**
	 * initialize all importain objects
	 */

    override public function initialize() : Void
    {
		
		// Init core components first
        _label = new Label(_labelData);
		
		// Now init and add everything 
		super.initialize();
        
        _label.visible = _showLabel;
        
        mouseChildren = false;
        
        addChild(_label);
        addChild(_icon);
        
		_labelData = null;
		
    }
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		
		// Unload label
		removeChild(_label);
		_label.destroy();
		
		// Clear icon
		_icon.graphics.clear();
		
		// Remove
		if (_icon.parent != null)
			_icon.parent.removeChild(_icon);
		
		// Clear memory
		_label = null;
		_icon = null;
		
	}	
    
    /**
	 * Reload all bitmap images and UI Styles
	 */
    
    override public function reskin() : Void
    {
		super.reskin();
		
        initBitmap();
        initStyle();
    }

    
    
    override private function initBitmap() : Void
    {
        super.initBitmap();

        // Set skining if in UIBitmapManager
        if (UIBitmapManager.hasUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_NORMAL)) 
            setDefaultStateImage(UIBitmapManager.getUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_NORMAL));
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_OVER)) 
            setOverStateImage(UIBitmapManager.getUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_OVER));
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_DOWN)) 
            setDownStateImage(UIBitmapManager.getUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_DOWN));
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_DISABLE)) 
            setDisableStateImage(UIBitmapManager.getUIElement(UIBitmapType.Button, UIBitmapManager.BUTTON_DISABLE));
    }
    
    override private function initStyle() : Void
    {
        super.initStyle();
        
        // First set style default
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_WIDTH) && UIStyleManager.getStyle(UIStyleManager.BUTTON_WIDTH) != _width) 
            _width = UIStyleManager.getStyle(UIStyleManager.BUTTON_WIDTH);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_HEIGHT) && UIStyleManager.getStyle(UIStyleManager.BUTTON_WIDTH) != _height) 
            _height = UIStyleManager.getStyle(UIStyleManager.BUTTON_WIDTH);  
        
        // Set the default round edge
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_ROUND_NUM)) 
            _roundEdge = UIStyleManager.getStyle(UIStyleManager.BUTTON_ROUND_NUM);
        
        // Set Button Label because on UIStyleManager
        if (UIStyleManager.hasStyle( UIStyleManager.BUTTON_TEXT_COLOR)) 
            Reflect.setField(_labelData,"textColor",UIStyleManager.BUTTON_TEXT_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_SIZE))
            Reflect.setField(_labelData,"size",UIStyleManager.BUTTON_TEXT_SIZE);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_ITALIC))
		    _italic = UIStyleManager.getStyle(UIStyleManager.BUTTON_TEXT_ITALIC);

        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_BOLD))
		    _bold = UIStyleManager.getStyle(UIStyleManager.BUTTON_TEXT_BOLD);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_FONT)) 
            _textFormat.font = UIStyleManager.BUTTON_TEXT_FONT;
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_ALIGN))
            Reflect.setField(_labelData,"align",UIStyleManager.BUTTON_TEXT_ALIGN);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_EMBED)) 
            Reflect.setField(_labelData,"embedFont",UIStyleManager.BUTTON_TEXT_EMBED);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_NORMAL_COLOR)) 
            _defaultColor = UIStyleManager.getStyle(UIStyleManager.BUTTON_NORMAL_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_OVER_COLOR))
            _overColor = UIStyleManager.getStyle(UIStyleManager.BUTTON_OVER_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_DOWN_COLOR))
            _downColor = UIStyleManager.getStyle(UIStyleManager.BUTTON_DOWN_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_DISABLE_COLOR))
            _disableColor = UIStyleManager.getStyle(UIStyleManager.BUTTON_DISABLE_COLOR);
        

        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_USE_CUSTOM_RENDER))
            _useCustomRender = UIStyleManager.getStyle(UIStyleManager.BUTTON_USE_CUSTOM_RENDER);

        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_TILE_IMAGE))
            _tileImage = UIStyleManager.getStyle(UIStyleManager.BUTTON_TILE_IMAGE);
        
        // Set default loc of image offset
        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_IMAGE_OFFSET_X))
            _imageOffSetX = UIStyleManager.getStyle(UIStyleManager.BUTTON_IMAGE_OFFSET_X);

        if (UIStyleManager.hasStyle(UIStyleManager.BUTTON_IMAGE_OFFSET_Y))
            _imageOffSetY = UIStyleManager.getStyle(UIStyleManager.BUTTON_IMAGE_OFFSET_Y);
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
       _labelSize = _label.size = value;
        
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
        _textColor = _label.textColor = value;
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
		_showIcon = true;
		
		_icon.graphics.clear();
        _icon.graphics.beginBitmapFill(image, null, false, _smoothImage);
		_icon.graphics.drawRect(0, 0, image.width, image.height);
		_icon.graphics.endFill();
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
        
        return value;
    }
    
    /**
	 * Return true if the icon is being display and false if not
	 */
    
    private function get_iconDisplay() : Bool
    {
        return _showIcon;
    }
    
    /**
	 * This setup and draw the button on the screen
	 */
    
    override public function draw() : Void
    {
        // Check to see if Custom Texture will need to be used first
        if(_useCustomRender && UIBitmapManager.hasCustomRenderTexture(UIBitmapType.Button) && _width > 0 && _height > 0) {
            _defaultStateImage = UIBitmapManager.runCustomRender(UIBitmapType.Button,{"width":_width,"height":_height,"state":"default"});
            _overStateImage = UIBitmapManager.runCustomRender(UIBitmapType.Button,{"width":_width,"height":_height,"state":"over"});
            _downStateImage = UIBitmapManager.runCustomRender(UIBitmapType.Button,{"width":_width,"height":_height,"state":"down"});
            _disableStateImage = UIBitmapManager.runCustomRender(UIBitmapType.Button,{"width":_width,"height":_height,"state":"down"});
        }

        super.draw();
        
        // Hide or Display items
        _icon.visible = _showIcon;
        _label.visible = _showLabel;
        
        // Seting label  
        _label.text = _text;
        _label.size = _labelSize;
        _label.italic = _italic;
        _label.bold = _bold;
        _label.textColor = _labelSize;
        _label.textField.multiline = true;
        _label.textField.autoSize = TextFieldAutoSize.CENTER;
        
        // Set location of icon
        _icon.x = _imageOffSetX;
        _icon.y = _imageOffSetY;

        // Button Offset
        var buttonOffSetX : Int = UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_OFFSET_X) ? UIStyleManager.getStyle(UIStyleManager.BUTTON_TEXT_OFFSET_X) : 0;
        var buttonOffSetY : Int = UIStyleManager.hasStyle(UIStyleManager.BUTTON_TEXT_OFFSET_Y) ? UIStyleManager.getStyle(UIStyleManager.BUTTON_TEXT_OFFSET_Y) : 0;
    
        // Setting loc of items
        if (_showIcon && _showLabel) 
        {

            // Set location of text
            _label.width = _width - _icon.width - buttonOffSetX;
			_label.draw();
			
            _label.x = _icon.width + buttonOffSetX;
            _label.y = (_height / 2) - (_label.height / 2) + buttonOffSetY;
            
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
            _label.width = _width - buttonOffSetX;
			_label.draw();

            _label.x = Std.int((_width / 2) - (_label.width / 2) + buttonOffSetX);
            _label.y = Std.int((_height / 2) - (_label.textField.textHeight / 2) + _imageOffSetY);
			
        }

		
		if (_mode.toLowerCase() == PRESS_MODE)
		{
			normalState.alpha = 1;
			overState.alpha = downState.alpha = 0;
		}
		else
		{
			
			// Toggle Seleect state
			if (_selected)
			{
				downState.alpha = 1;
				disableState.alpha = overState.alpha = normalState.alpha = 0;
			}
			else
			{
				normalState.alpha = 1;
				disableState.alpha = overState.alpha = downState.alpha = 0;
			}
			
        }
        
    }
	
	private function mouseUpEvent(event:MouseEvent):Void 
	{
        if (_stateFadeSpeed > 0)
        {
            overState.alpha = 0;

            normalState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
            downState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
        }
        else
        {
            normalState.alpha = 1;
            disableState.alpha = overState.alpha = downState.alpha = 0;
        }
	}	
	
	override function mouseDownEvent(event:MouseEvent):Void 
	{
		// Either go with what is done in the ToggleButton Super class
		if (_mode.toLowerCase() != PRESS_MODE)
			super.mouseDownEvent(event);
		else
		{
            
            if (_stateFadeSpeed > 0 && _fadeToDownState)
            {                
                downState.stopAnimate();
                downState.alpha = 1;

                normalState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
                overState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
            }
            else
            {
                // Or Just show down state on mouse down
                downState.alpha = 1;
                disableState.alpha = overState.alpha = normalState.alpha = 0;
            }
		}
	}
	
	
}

