
package com.chaos.ui;



import com.chaos.drawing.Draw;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IOverlay;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.filters.BitmapFilter;
import openfl.filters.BitmapFilterQuality;
import openfl.filters.GlowFilter;

import openfl.display.Bitmap;

//import openfl.filters.BevelFilter;
import openfl.filters.DropShadowFilter;

import openfl.events.MouseEvent;
import openfl.events.Event;

import openfl.text.TextField;
import openfl.text.TextFormatAlign;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;

import com.chaos.media.DisplayImage;

import com.chaos.ui.Overlay;
import com.chaos.ui.Label;
import com.chaos.ui.UIDetailLevel;

/**
 *  Normal push button with or without an icon
 *
 *  @author Erick Feiling
 *  @date 11-5-09
 */

class Button extends Overlay implements IButton implements IOverlay implements IBaseUI
{
    public var imageOffSetX(get, set) : Int;
    public var imageOffSetY(get, set) : Int;
    public var label(get, set) : String;
    public var showLabel(get, set) : Bool;
    public var textLabel(get, never) : ILabel;
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
    public var shadowFilter(get, set) : Bool;
    public var filterMode(get, set) : Bool;
    public var shadowTextFilterDefault(get, set) : DropShadowFilter;
    public var shadowTextFilterDown(get, set) : DropShadowFilter;
    public var shadowTextFilterOver(get, set) : DropShadowFilter;
    //public var buttonBevelFilter(get, set) : BevelFilter;

    /** The type of UI Element */
    public static inline var TYPE : String = "Button";
    
    /** Set the default button state text shadow. The default value is 0x000000. */
    private static inline var NORMAL_STATE_SHADOW_COLOR : Int = 0x000000;
    
    /** Set the default button state text shadow distance. */
    private static inline var NORMAL_STATE_SHADOW_DISTANCE : Float = 2;
    
    /** Set the default button state text shadow angle. The range is from 0 to 360 degrees (floating point). */
    private static inline var NORMAL_STATE_SHADOW_ANGLE : Float = 0;
    
    /** Set the default button state text shadow alpha. Valid values are 0.0 to 1.0. */
    private static inline var NORMAL_STATE_SHADOW_ALPHA : Float = 1;
    
    /** Set the default button state text shadow blurX. Valid values are 0 to 255.0 (floating point). */
    private static inline var NORMAL_STATE_SHADOW_BLUR_X : Float = 5;
    
    /** Set the default button state text shadow blurY. Valid values are 0 to 255.0 (floating point). */
    private static inline var NORMAL_STATE_SHADOW_BLUR_Y : Float = 5;
    
    /** Set the default button state text shadow strength. Valid values are 0 to 255.0. */
    private static inline var NORMAL_STATE_SHADOW_STRENGTH : Float = 1.2;
    
    /** The number of times to apply the filter. Use the BitmapFilterQuality constants: Settings are 1(low),2(Medium) or 3(High).*/
    private static inline var NORMAL_STATE_SHADOW_QUALITY : Int = 2;
    
    /** Set the button state roll over shadow. The default value is 0x000000. */
    private static inline var HIGHLIGHT_STATE_SHADOW_COLOR : Int = 0x000000;
    
    /** Set the button state roll over shadow distance. */
    private static inline var HIGHLIGHT_STATE_SHADOW_DISTANCE : Float = 2;
    
    /** Set the button roll over text shadow angle. The range is from 0 to 360 degrees (floating point). */
    private static inline var HIGHLIGHT_STATE_SHADOW_ANGLE : Float = 90;
    
    /** Set the button roll over text shadow alpha. Valid values are 0.0 to 1.0. */
    private static var HIGHLIGHT_STATE_SHADOW_ALPHA : Float = 1;
    
    /** Set the button roll over text shadow blurX. Valid values are 0 to 255.0 (floating point). */
    private static inline var HIGHLIGHT_STATE_SHADOW_BLUR_X : Float = 5;
    
    /** Set the button roll over text shadow blurY. Valid values are 0 to 255.0 (floating point). */
    private static inline var HIGHLIGHT_STATE_SHADOW_BLUR_Y : Float = 5;
    
    /** Set the button roll over text shadow strength. Valid values are 0 to 255.0. */
    private static inline var HIGHLIGHT_STATE_SHADOW_STRENGTH : Float = 1.2;
    
    /** The number of times to apply the filter. Use the BitmapFilterQuality constants: Settings are 1(low),2(Medium) or 3(High).*/
    private static inline var HIGHLIGHT_STATE_SHADOW_QUALITY : Int = 2;
    
    /** Set the button down state text shadow. The default value is 0x000000 */
    private static inline var DOWN_STATE_SHADOW_COLOR : Int = 0x000000;
    
    /** Set the button down shadow distance. */
    private static inline var DOWN_STATE_SHADOW_DISTANCE : Float = 1;
    
    /** Set the button down text shadow angle. The range is from 0 to 360 degrees (floating point). */
    private static inline var DOWN_STATE_SHADOW_ANGLE : Float = 90;
    
    /** Set the button down text shadow alpha. Valid values are 0.0 to 1.0. */
    private static inline var DOWN_STATE_SHADOW_ALPHA : Float = 1;
    
    /** Set the button down text shadow blurX. Valid values are 0 to 255.0 (floating point). */
    private static inline var DOWN_STATE_SHADOW_BLUR_X : Float = 6;
    
    /** Set the button down text shadow blurY. Valid values are 0 to 255.0 (floating point). */
    private static inline var DOWN_STATE_SHADOW_BLUR_Y : Float = 6;
    
    /** Set the button down text shadow strength. Valid values are 0 to 255.0. */
    private static inline var DOWN_STATE_SHADOW_STRENGTH : Float = 1.2;
    
    /** The number of times to apply the filter. Use the BitmapFilterQuality constants: Settings are 1(low),2(Medium) or 3(High).*/
    private static inline var DOWN_STATE_SHADOW_QUALITY : Int = 2;
    
    /**  (default = 4.0) The offset distance of the bevel, in pixels (floating point). */
    private static inline var BEVEL_DISTANCE : Float = 2;
    
    /** (default = 45) — The angle of the bevel, from 0 to 360 degrees. */
    private static inline var BEVEL_ANGLE : Float = 45;
    
    /** (default = 0xFFFFFF) — The highlight color of the bevel, 0xRRGGBB. */
    private static inline var BEVEL_HIGHLIGHT_COLOR : Int = 0xFFFFFF;
    
    /** (default = 1.0) — The alpha transparency value of the highlight color. Valid values are 0.0 to 1.0. For example, .25 sets a transparency value of 25%. */
    private static inline var BEVEL_HIGHLIGHT_ALPHA : Float = 1.0;
    
    /** (default = 0x000000) — The shadow color of the bevel, 0xRRGGBB. */
    private static inline var BEVEL_SHADOW_COLOR : Int = 0x000000;
    
    /** (default = 1.0) — The alpha transparency value of the shadow color. Valid values are 0.0 to 1.0. For example, .25 sets a transparency value of 25%. */
    private static inline var BEVEL_SHADOW_ALPHA : Float = 1.0;
    
    /** (default = 2.0) — The amount of horizontal blur in pixels. Valid values are 0 to 255.0 (floating point). */
    private static inline var BEVEL_SHADOW_BLUR_X : Float = 2;
    
    /** (default = 2.0) — The amount of vertical blur in pixels. Valid values are 0 to 255.0 (floating point). */
    private static inline var BEVEL_SHADOW_BLUR_Y : Float = 2;
    
    /**  (default = 1) — The strength of the imprint or spread. The higher the value, the more color is imprinted and the stronger the contrast between the bevel and the background. Valid values are 0 to 255.0.*/
    private static inline var BEVEL_SHADOW_STRENGTH : Float = .5;
    
    /**  (default = 1) — The quality of the bevel. Valid values are 0 to 15: */
    private static inline var BEVEL_SHADOW_QUALITY : Int = 1;
    
    /** default = "inner") — The type of bevel. Valid values are BitmapFilterType constants: INNER, OUTER, or FULL. */
    private static inline var BEVEL_TYPE : String = "inner";
    
    /** (default = false) — Applies a knockout effect (true), which effectively makes the object's fill transparent and reveals the background color of the document.  */
    private static var BEVEL_SHADOW_KNOCKOUT : Bool = false;
    
    public var baseNormal : DisplayObject;
    public var baseOver : DisplayObject;
    public var baseDown : DisplayObject;
    public var baseDisable : DisplayObject;
    
    private var _shapeMask : DisplayObject;
    
    private var _imageOffSetX : Int;
    private var _imageOffSetY : Int;
    
    private var _buttonLabel : Label;
    private var _buttonTextFormat : TextFormat;
    
    // Default button colors
    private var _labelText : String = "";
    
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
    
    private var _bgDisplayNormalImage : Bool = false;
    private var _bgDisplayOverImage : Bool = false;
    private var _bgDisplayDownImage : Bool = false;
    private var _bgDisplayDisableImage : Bool = false;
    
    private var _bgSmoothImage : Bool = true;
    
    private var _bgAlpha : Float = UIStyleManager.BUTTON_ALPHA;
    
    private var _filterMode : Bool = UIStyleManager.BUTTON_BEVEL_FILTER;
    private var _shadowFilter : Bool = UIStyleManager.BUTTON_SHADOW_FILTER;
    
    private var _iconArea : Sprite;
    
    private var _displayIcon : DisplayImage;
    
    private var _backgroundImage : DisplayImage;
    private var _backgroundOverImage : DisplayImage;
    private var _backgroundDownImage : DisplayImage;
    private var _backgroundDisableImage : DisplayImage;
    
    private var _useMask : Bool = false;
    
    //private var _buttonBevelFilter : BevelFilter = new BevelFilter(BEVEL_DISTANCE, BEVEL_ANGLE, BEVEL_HIGHLIGHT_COLOR, BEVEL_HIGHLIGHT_ALPHA, BEVEL_SHADOW_COLOR, BEVEL_SHADOW_ALPHA, BEVEL_SHADOW_BLUR_X, BEVEL_SHADOW_BLUR_Y, BEVEL_SHADOW_STRENGTH, BEVEL_SHADOW_QUALITY, BEVEL_TYPE, BEVEL_SHADOW_KNOCKOUT);
    private var _buttonGlowFilter1 : GlowFilter = new GlowFilter(0xFFFFFF, .8, 10, 10, 2, 1, true, false);
    private var _buttonGlowFilter2 : GlowFilter = new GlowFilter(0, .5, 6, 6, 2, 1, true, false);
	
    private var _shadowTextFilterDefault : DropShadowFilter = new DropShadowFilter(NORMAL_STATE_SHADOW_DISTANCE, NORMAL_STATE_SHADOW_ANGLE, NORMAL_STATE_SHADOW_COLOR, NORMAL_STATE_SHADOW_ALPHA, NORMAL_STATE_SHADOW_BLUR_X, NORMAL_STATE_SHADOW_BLUR_Y, NORMAL_STATE_SHADOW_STRENGTH, NORMAL_STATE_SHADOW_QUALITY);
    private var _shadowTextFilterOver : DropShadowFilter = new DropShadowFilter(HIGHLIGHT_STATE_SHADOW_DISTANCE, HIGHLIGHT_STATE_SHADOW_ANGLE, HIGHLIGHT_STATE_SHADOW_COLOR, HIGHLIGHT_STATE_SHADOW_ALPHA, HIGHLIGHT_STATE_SHADOW_BLUR_X, HIGHLIGHT_STATE_SHADOW_BLUR_Y, HIGHLIGHT_STATE_SHADOW_STRENGTH, HIGHLIGHT_STATE_SHADOW_QUALITY);
    private var _shadowTextFilterDown : DropShadowFilter = new DropShadowFilter(DOWN_STATE_SHADOW_DISTANCE, DOWN_STATE_SHADOW_ANGLE, DOWN_STATE_SHADOW_COLOR, DOWN_STATE_SHADOW_ALPHA, DOWN_STATE_SHADOW_BLUR_X, DOWN_STATE_SHADOW_BLUR_Y, DOWN_STATE_SHADOW_STRENGTH, DOWN_STATE_SHADOW_QUALITY);
    
    /**
	 * Creates a button on the fly with flash filters.
	 *
	 * @param	label The text that will be displayed on the label
	 * @param	buttonWidth The button width
	 * @param	buttonHeight The button height
	 */
    
    public function new(label : String = "Button", buttonWidth : Int = 100, buttonHeight : Int = 20)
    {
        
        super();
        
		
		
        // Set defaults
        _labelText = label;
        
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
    
    override function init() : Void
    {
		
		super.init();
		
		
        // Init button
        baseNormal = new Shape();
        baseOver = new Shape();
        baseDown = new Shape();
        baseDisable = new Shape();
        
        _buttonLabel = new Label();
        _buttonTextFormat = new TextFormat();
        _buttonLabel.visible = _showLabel;
        
        _iconArea = new Sprite();
        _displayIcon = new DisplayImage();
        
        _backgroundImage = new DisplayImage();
        _backgroundOverImage = new DisplayImage();
        _backgroundDownImage = new DisplayImage();
        _backgroundDisableImage = new DisplayImage();
        
        // Attach roll over and out event
        addEventListener(MouseEvent.MOUSE_DOWN, downState, false, 0, true);
        addEventListener(MouseEvent.MOUSE_UP, normalState, false, 0, true);
        
        addEventListener(MouseEvent.MOUSE_OVER, overState, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, normalState, false, 0, true);
        
        _displayIcon.onImageComplete = iconLoadComplete;
        
        _backgroundImage.onImageComplete = bgLoadComplete;
        _backgroundOverImage.onImageComplete = bgOverLoadComplete;
        _backgroundDownImage.onImageComplete = bgDownLoadComplete;
        _backgroundDisableImage.onImageComplete = bgDisableLoadComplete;
        
        // Hide Over and Down state
        baseOver.visible = false;
        baseDown.visible = false;
        baseDisable.visible = false;
        
        mouseChildren = false;
        
        addChild(baseNormal);
        addChild(baseOver);
        addChild(baseDown);
        addChild(baseDisable);
        
        addChild(_buttonLabel);
        addChild(_iconArea);
        
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
            setBackgroundBitmap(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_OVER)) 
            setOverBackgroundBitmap(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_OVER));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DOWN)) 
            setDownBackgroundBitmap(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DOWN));
        
        if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DISABLE)) 
            setDisableBackgroundBitmap(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.BUTTON_DISABLE));
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
            _buttonTextFormat.font = UIStyleManager.BUTTON_TEXT_FONT;
        
        if ("" != UIStyleManager.BUTTON_TEXT_ALIGN) 
            _buttonTextAlign = UIStyleManager.BUTTON_TEXT_ALIGN;
        
        if (null != UIStyleManager.BUTTON_TEXT_EMBED) 
            _buttonLabel.setEmbedFont(UIStyleManager.BUTTON_TEXT_EMBED);
        
        if (-1 != UIStyleManager.BUTTON_NORMAL_COLOR) 
            _buttonNormalColor = UIStyleManager.BUTTON_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_OVER_COLOR) 
            _buttonOverColor = UIStyleManager.BUTTON_OVER_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DOWN_COLOR) 
            _buttonDownColor = UIStyleManager.BUTTON_DOWN_COLOR;
        
        if (-1 != UIStyleManager.BUTTON_DISABLE_COLOR) 
            _buttonDisableColor = UIStyleManager.BUTTON_DISABLE_COLOR;
        
        _buttonLabel.x = UIStyleManager.BUTTON_TEXT_OFFSET_X;
        _buttonLabel.y = UIStyleManager.BUTTON_TEXT_OFFSET_Y;
        
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
	 * Set the level of detail on the button. This degrade the button with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 */
    
    override private function set_detail(value : String) : String
    {
        
        // Only turn off filter if medium and low
        if (value.toLowerCase() == UIDetailLevel.HIGH) 
        {
            _filterMode = true;
            _shadowFilter = true;
            
            _bgSmoothImage = true;
            _bgShowImage = true;
        }
        else if (value.toLowerCase() == UIDetailLevel.MEDIUM) 
        {
            _filterMode = false;
            _shadowFilter = false;
            
            _bgSmoothImage = false;
            _bgShowImage = true;
        }
        else if (value.toLowerCase() == UIDetailLevel.LOW) 
        {
            
            _filterMode = false;
            _shadowFilter = false;
            
            _bgShowImage = false;
            _bgSmoothImage = false;
        }
        else 
        {
            
            _bgShowImage = false;
            _filterMode = false;
            
            _shadowFilter = false;
            _bgSmoothImage = false;
            
            super.detail = UIDetailLevel.LOW;
        }
        
        super.detail = value;
        
        draw();
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
    
    private function set_label(value : String) : String
    {
        _labelText = value;
        draw();
        return value;
    }
    
    /**
	 * Return the text that is on the label
	 */
    
    private function get_label() : String
    {
        return _labelText;
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
    
    private function get_textLabel() : ILabel
    {
        return _buttonLabel;
    }
    
    /**
	 * Set the font that will be used
	 */
    
    private function set_textFont(value : String) : String
    {
        _buttonTextFormat.font = value;
        draw();
        return value;
    }
    
    /**
	 * Return the font that is being used on the button label
	 */
    
    private function get_textFont() : String
    {
        return _buttonTextFormat.font;
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
    
    public function setIcon(displayObj : DisplayObject) : Void
    {
        
        if (_iconArea.numChildren > 0) 
            _iconArea.removeChildAt(0);
        
        _iconArea.addChildAt(displayObj, 0);
        
        draw();
    }
    
    /**
	 * The DisplayObject being used as the icon for the button
	 *
	 * @return A DisplayObject if there is one if not then return null
	 */
    
    public function getIcon() : DisplayObject
    {
        if (_iconArea.numChildren > 0) 
            return _iconArea.getChildAt(0);
        
        return null;
    }
    
    /**
	 * Set the icon used on the button based on a URL location
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
    
    public function setIconImage(value : String) : Void
    {
        _displayIcon.load(value);
        
        if (_iconArea.numChildren > 0) 
            _iconArea.removeChildAt(0);
        
        _iconArea.addChildAt(_displayIcon, 0);
        
        draw();
    }
    
    /**
	 * Set the icon used on the button based on a Bitmap image
	 *
	 * @param value Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
    
    public function setIconBitmap(value : Bitmap) : Void
    {
        _displayIcon.setImage(value);
        _showIcon = true;
        
        if (_iconArea.numChildren > 0) 
            _iconArea.removeChildAt(0);
        
        _iconArea.addChildAt(_displayIcon, 0);
        
        draw();
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
    
    /**
	 * Set this if you want to have a drop shadow on the label. The detail settings must be set to "high" in other for it to work.
	 */
    
    private function set_shadowFilter(value : Bool) : Bool
    {
        _shadowFilter = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the shadow is enabled and false if not
	 */
    
    private function get_shadowFilter() : Bool
    {
        return _shadowFilter;
    }
    
    /**
	 * Turn on or off the BevelFilter that is being used
	 */
    
    private function set_filterMode(value : Bool) : Bool
    {
        _filterMode = value;
        draw();
        return value;
    }
    
    /**
		 * Return true if using filterMode
		 */
    
    private function get_filterMode() : Bool
    {
        return _filterMode;
    }
    
    /**
	 * Set the normal state text shadow filter
	 */
    
    private function set_shadowTextFilterDefault(value : DropShadowFilter) : DropShadowFilter
    {
        _shadowTextFilterDefault = value;
        draw();
        return value;
    }
    
    /**
	 * Return filter
	 */
    
    private function get_shadowTextFilterDefault() : DropShadowFilter
    {
        return _shadowTextFilterDefault;
    }
    
    /**
	 * Set the down state text shadow filter
	 */
    
    private function set_shadowTextFilterDown(value : DropShadowFilter) : DropShadowFilter
    {
        _shadowTextFilterDown = value;
        draw();
        return value;
    }
    
    /**
	 * Return filter
	 */
    
    private function get_shadowTextFilterDown() : DropShadowFilter
    {
        return _shadowTextFilterDown;
    }
    
    /**
	 * Set the over state text shadow filter
	 */
    
    private function set_shadowTextFilterOver(value : DropShadowFilter) : DropShadowFilter
    {
        _shadowTextFilterOver = value;
        draw();
        return value;
    }
    
    /**
	 * Return filter
	 */
    
    private function get_shadowTextFilterOver() : DropShadowFilter
    {
        return _shadowTextFilterOver;
    }
    
    /**
	 * The bevel filter that is used for the button.
	 */
    
    //private function set_buttonBevelFilter(value : BevelFilter) : BevelFilter
    //{
    //    _buttonBevelFilter = value;
    //    draw();
    //    return value;
    //}
    
    /**
	 * Return filter
	 */
    
    //private function get_buttonBevelFilter() : BevelFilter
    //{
    //    return _buttonBevelFilter;
    //}
    
    /**
	 * This is for setting an image to the button default state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
    
    public function setBackgroundImage(value : String) : Void
    {
        _backgroundImage.load(value);
        draw();
    }
    
    /**
	 * This is for setting an image to the button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setBackgroundBitmap(value : Bitmap) : Void
    {
        _backgroundImage.setImage(value);
        _bgDisplayNormalImage = true;
        
        draw();
    }
    
    /**
	 * This is for setting an image to the button roll over state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
    
    public function setOverBackgroundImage(value : String) : Void
    {
        _backgroundOverImage.load(value);
        draw();
    }
    
    /**
	 * This is for setting an image to the button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setOverBackgroundBitmap(value : Bitmap) : Void
    {
        _bgDisplayOverImage = true;
        _backgroundOverImage.setImage(value);
        
        draw();
    }
    
    /**
	 * This is for setting an image to the button roll down state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
    
    public function setDownBackgroundImage(value : String) : Void
    {
        _backgroundDownImage.load(value);
        draw();
    }
    
    /**
	 * This is for setting an image to the button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setDownBackgroundBitmap(value : Bitmap) : Void
    {
        
        _bgDisplayDownImage = true;
        _backgroundDownImage.setImage(value);
        
        draw();
    }
    
    /**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
    
    public function setDisableBackgroundImage(value : String) : Void
    {
        _backgroundDisableImage.load(value);
        draw();
    }
    
    /**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
    
    public function setDisableBackgroundBitmap(value : Bitmap) : Void
    {
        
        _bgDisplayDisableImage = true;
        _backgroundDisableImage.setImage(value);
        
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
        _iconArea.visible = _showIcon;
        _buttonLabel.visible = _showLabel;
        _buttonLabel.width = 1;
        
        // Setting up filters
        var buttonFilters : Array<BitmapFilter> = new Array<BitmapFilter>();
		buttonFilters.push(_buttonGlowFilter1);
		buttonFilters.push(_buttonGlowFilter2);
        
		
        if (_filterMode) 
            this.filters = buttonFilters;
        else 
            this.filters = new Array<BitmapFilter>();
		
		// Remove old one if there  
        if (null != baseNormal && null != baseNormal.parent) 
            baseNormal.parent.removeChild(baseNormal);
        
        if (null != baseOver && null != baseOver.parent) 
            baseOver.parent.removeChild(baseOver);
        
        if (null != baseDown && null != baseDown.parent) 
            baseDown.parent.removeChild(baseDown);
        
        if (null != baseDisable && null != baseDisable.parent) 
            baseDisable.parent.removeChild(baseDisable);
			
		// Figure to use bitmap or normal mode
	
		
			if (_bgShowImage) 
			{
				// Create an image that will be scaled later on else draw a shape that will
				
				
				// Normal
				if (null != _backgroundImage.image) 
					baseNormal = Draw.SquareRound(Std.int(_backgroundImage.image.width), Std.int(_backgroundImage.image.height), _buttonNormalColor,_roundEdge, _bgAlpha, true , _bgSmoothImage, _backgroundImage.image.bitmapData, tileMiddleImage)
				else 
					baseNormal = Draw.SquareRound(Std.int(width), Std.int(height), _buttonNormalColor, _roundEdge, _bgAlpha, false, _bgSmoothImage);
				
				// Over
				if (null != _backgroundOverImage.image) 
					baseOver = Draw.SquareRound(Std.int(_backgroundOverImage.image.width), Std.int(_backgroundOverImage.image.height), _buttonOverColor, _roundEdge, _bgAlpha, false, _bgSmoothImage, _backgroundOverImage.image.bitmapData, tileMiddleImage)
				else 
					baseOver = Draw.SquareRound(Std.int(width), Std.int(height), _buttonOverColor, _roundEdge, _bgAlpha, false, _bgSmoothImage);
				
				// Down
				if (null != _backgroundDownImage.image) 
					baseDown = Draw.SquareRound(Std.int(_backgroundDownImage.image.width), Std.int(_backgroundDownImage.image.height), _buttonDownColor, _roundEdge, _bgAlpha, true, _bgSmoothImage, _backgroundDownImage.image.bitmapData, tileMiddleImage)
				else 
					baseDown = Draw.SquareRound(Std.int(width), Std.int(height), _buttonDownColor, _roundEdge, _bgAlpha, false, _bgSmoothImage);
				
				// Disable
				if (null != _backgroundDisableImage.image) 
					baseDisable = Draw.SquareRound(Std.int(_backgroundDisableImage.image.width), Std.int(_backgroundDisableImage.image.height), _buttonDisableColor, _roundEdge, _bgAlpha, true, _bgSmoothImage, _backgroundDisableImage.image.bitmapData, tileMiddleImage)
				else 
					baseDisable = Draw.SquareRound(Std.int(width), Std.int(height), _buttonDisableColor, _roundEdge, _bgAlpha, false, _bgSmoothImage);
			}
			else 
			{
				baseNormal = Draw.SquareRound(Std.int(width), Std.int(height), _buttonNormalColor,0, _bgAlpha, true, _bgSmoothImage);
				baseOver = Draw.SquareRound(Std.int(width), Std.int(height), _buttonOverColor, 0, _bgAlpha, true, _bgSmoothImage);
				baseDown = Draw.SquareRound(Std.int(width), Std.int(height), _buttonDownColor, 0, _bgAlpha, true, _bgSmoothImage);
				baseDisable = Draw.SquareRound(Std.int(width), Std.int(height), _buttonDisableColor, 0, _bgAlpha, true, _bgSmoothImage);
			} 		
		
       
        // Remove old one if there  
        if (null != _shapeMask && null != _shapeMask.parent) 
        {
            _shapeMask.parent.removeChild(_shapeMask);
            
            // Remove old mask
            this.mask = null;
        }  
        
        
        // Apply mask only if edge is higher than 0  
        if (_roundEdge > 0) 
        {
            // Draw new shape
            _shapeMask = Draw.SquareRound(Std.int(width) , Std.int(height), 0, _roundEdge, 1, false);
			
            // Mask based on shape
            this.mask = _shapeMask;
            
            addChild(_shapeMask);
        }  
       
        
        // Resize all items  
        baseDisable.width = baseDown.width = baseOver.width = baseNormal.width = width;
        baseDisable.height = baseDown.height = baseOver.height = baseNormal.height = height;
		
        // Set label and style
        _buttonLabel.align = _buttonTextAlign;
        _buttonLabel.textFormat.italic = _buttonTextItalic;
        _buttonLabel.textFormat.bold = _buttonTextBold;
        _buttonLabel.textColor = _buttonTextColor;
        
        // Setup Show filter
        var textShadowArray : Array<BitmapFilter> = new Array<BitmapFilter>();
        textShadowArray.push(_shadowTextFilterDefault);
        
        if (_shadowFilter) 
        {
            _buttonLabel.filters = new Array<BitmapFilter>();
            _buttonLabel.filters = textShadowArray;
        }
        else 
        {
            _buttonLabel.filters = new Array<BitmapFilter>();
        }  
        
        
        // Seting label  
        _buttonLabel.text = _labelText;
        _buttonLabel.textField.multiline = true;
        _buttonLabel.textField.autoSize = TextFieldAutoSize.CENTER;
        
        // Set location of icon
        _iconArea.x = _imageOffSetX;
        _iconArea.y = _imageOffSetY;
        
        // Setting loc of items
        if (_showIcon && _showLabel) 
        {
            
            // Set location of text
            _buttonLabel.width = width - _iconArea.width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _buttonLabel.x = _iconArea.width + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _buttonLabel.y = (height / 2) - (_buttonLabel.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
            
            // Set this first and then use offset later
            _iconArea.y = _buttonLabel.y;
            
            _iconArea.x = _imageOffSetX;
            _iconArea.y = _imageOffSetY;
        }
        else if (_showIcon && !_showLabel) 
        {
            
            // Set location of icon
            if (_iconArea.width < _width) 
                _iconArea.x = (width / 2) - (_iconArea.width / 2);
            
            if (_iconArea.height < height) 
                _iconArea.y = (height / 2) - (_iconArea.height / 2);
        }
        else if (!_showIcon && _showLabel)  // Hide and show what is needed by default
        {
            
            // Set location of text
            _buttonLabel.width = width - UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _buttonLabel.x = (width / 2) - (_buttonLabel.width / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_X;
            _buttonLabel.y = (height / 2) - (_buttonLabel.height / 2) + UIStyleManager.BUTTON_TEXT_OFFSET_Y;
			
        }
        
        
        baseNormal.visible = true;
        baseOver.visible = baseDown.visible = baseDisable.visible = false;
        
        addChild(baseNormal);
        addChild(baseOver);
        addChild(baseDown);
        addChild(baseDisable);
        
        addChild(_buttonLabel);
        addChild(_iconArea);
    }
    
    private function iconLoadComplete(event : Event) : Void
    {
        // Resize Icon
        if (UIStyleManager.BUTTON_ICON_WIDTH > -1) 
            event.target.content.width = UIStyleManager.BUTTON_ICON_WIDTH;
        
        if (UIStyleManager.BUTTON_ICON_HEIGHT > -1) 
            event.target.content.height = UIStyleManager.BUTTON_ICON_HEIGHT;
        
        _showIcon = true;
        
        draw();
    }
    
    private function bgLoadComplete(event : Event) : Void
    {
        _bgDisplayNormalImage = true;
        draw();
    }
    
    private function bgOverLoadComplete(event : Event) : Void
    {
        _bgDisplayOverImage = true;
        draw();
    }
    
    private function bgDownLoadComplete(event : Event) : Void
    {
        _bgDisplayDownImage = true;
        draw();
    }
    
    private function bgDisableLoadComplete(event : Event) : Void
    {
        _bgDisplayDisableImage = true;
        draw();
    }
    
    private function normalState(event : MouseEvent) : Void
    {
        // Set Roll over shadow filter
        if (_filterMode) 
        {
            var textShadowArray : Array<BitmapFilter> = new Array<BitmapFilter>();
            textShadowArray.push(_shadowTextFilterDefault);
            
            _buttonLabel.filters = textShadowArray;
        }
        
        baseNormal.visible = true;
        baseOver.visible = false;
        baseDown.visible = false;
        baseDisable.visible = false;
    }
    
    private function overState(event : MouseEvent) : Void
    {
        
        // Set Roll over shadow filter
        if (_filterMode) 
        {
            var textShadowArray : Array<BitmapFilter> = new Array<BitmapFilter>();
            textShadowArray.push(_shadowTextFilterOver);
            
            _buttonLabel.filters = textShadowArray;
        }
        
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
        
        // Set Roll over shadow filter
        if (_filterMode) 
        {
            var textShadowArray : Array<BitmapFilter> = new Array<BitmapFilter>();
            textShadowArray.push(_shadowTextFilterDown);
            
            _buttonLabel.filters = textShadowArray;
        }
        
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

