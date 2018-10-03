package com.chaos.ui;



import com.chaos.media.DisplayImage;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IBubble;
import com.chaos.ui.classInterface.IOverlay;

import com.chaos.ui.Overlay;
import com.chaos.utils.Utils;

import openfl.display.DisplayObject;
import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;

import openfl.geom.Point;

/**
 * Creates a bubble which can also double as a tool-tip.
 *
 * @author Erick Feiling
 */

class Bubble extends Overlay implements IBubble implements IOverlay implements IBaseUI
{
    public var useMask(get, set) : Bool;
    public var content(get, never) : Sprite;
    public var rounded(get, set) : Int;
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderAlpha(get, set) : Float;
    public var borderThinkness(get, set) : Float;
    public var backgroundColor(get, set) : Int;
    public var backgroundAlpha(get, set) : Float;
    public var showTail(get, set) : Bool;
    public var tailSize(get, set) : Float;
    public var tailPlacement(get, set) : String;
    public var tailLocation(never, set) : Float;
    public var tailAutoCenter(get, set) : Bool;

    public static inline var TYPE : String = "Bubble";
    
    public var contentHolder : Sprite;
    
    private var _backgroundColor : Int = 0xFFFFFF;
    private var _backgroundAlpha : Float = 1;
    
    private var _thinkness : Float = 2;
    
    private var _border : Bool = true;
    private var _borderColor : Int = 0x000000;
    private var _borderAlpha : Float = 1;
    
    //private var _showImage : Bool = true;
    //private var _smoothImage : Bool = true;
    
    private var _imageBackground : Bitmap = null;
    private var _backgroundDisplayImage : DisplayImage;
    
    private var _showTail : Bool = true;
    private var _tailSize : Float = 10;
    private var _tail : Shape;
    
    private var _tailAutoCenter : Bool = true;
    private var _tailLocation : Float = 40;
    
    private var _tailPlacement : String = "bottom";
    
    private var _background : Shape;
    private var _backgroundBorder : Shape;
    private var _content : Sprite;
    
    private var _rounded : Int = 40;
    
    private var _useMask : Bool = false;
    
    public function new(defaultWidth : Float = 100, defaultHeight : Float = 100)
    {
        
        super(defaultWidth, defaultHeight);
        
        //init();
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
    
    override private function init() : Void
    {
		super.init();
		
        contentHolder = new Sprite();
        
        _background = new Shape();
        _tail = new Shape();
        
        _backgroundBorder = new Shape();
        
        _content = new Sprite();
        
        _backgroundDisplayImage = new DisplayImage();
        
        contentHolder.addChild(_background);
        contentHolder.addChild(_content);
        contentHolder.addChild(_backgroundBorder);
        contentHolder.addChild(_tail);
        
        addChildAt(contentHolder, 0);
        
        initBitmap();
        initStyle();
        
        draw();
    }
    
    private function initStyle() : Void
    {
        if (-1 != UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR) 
            backgroundColor = UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.BUBBLE_BACKGROUND_ALPHA) 
            backgroundAlpha = UIStyleManager.BUBBLE_BACKGROUND_ALPHA;
        
        if (-1 != UIStyleManager.BUBBLE_BORDER_ALPHA) 
            borderAlpha = UIStyleManager.BUBBLE_BORDER_ALPHA;
        
        if (-1 != UIStyleManager.BUBBLE_BORDER_COLOR) 
            borderColor = UIStyleManager.BUBBLE_BORDER_COLOR;
        
        _border = UIStyleManager.BUBBLE_BORDER;
    }
    
    private function initBitmap() : Void
    {
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_BACKGROUND)) 
            setBackgroundBitmap(UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_BACKGROUND));
        
        var topLeftImage : Bitmap = null;
        var topMiddleImage : Bitmap = null;
        var topRightImage : Bitmap = null;
        
        var middleLeftImage : Bitmap = null;
        var middleRightImage : Bitmap = null;
        
        var bottomLeftImage : Bitmap = null;
        var bottomMiddleImage : Bitmap = null;
        var bottomRightImage : Bitmap = null;
        
        // Top
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_LEFT)) 
            topLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_MIDDLE)) 
            topMiddleImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_MIDDLE);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_RIGHT)) 
            topRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_TOP_RIGHT);
        
        setTopImage(topLeftImage, topMiddleImage, topRightImage);
        
        // Middle
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_LEFT)) 
            middleLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_RIGHT)) 
            middleRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_RIGHT);
        
        setMiddleCenterImage(middleLeftImage, middleRightImage);
        
        // Bottom
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_LEFT)) 
            bottomLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_MIDDLE)) 
            bottomMiddleImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_MIDDLE);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_RIGHT)) 
            bottomRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_RIGHT);
        
        setBottomImage(bottomLeftImage, bottomMiddleImage, bottomRightImage);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function reskin() : Void
    {
        super.reskin();
        
        initStyle();
        initBitmap();
    }
    
    /**
	 * If true this will apply a mask content layer
	 */
    
    private function set_useMask(value : Bool) : Bool
    {
        _useMask = value;
        
        ((_useMask)) ? applyContentMask() : removeContentMask();
        return value;
    }
    
    /**
	 * Return true if using mask and false if not
	 */
    
    private function get_useMask() : Bool
    {
        return _useMask;
    }
    
    /**
	 * This is the content DisplayObject. You can add DisplayObject into this content area.
	 */
    
    private function get_content() : Sprite
    {
        return _content;
    }
    
    /**
	 * How rounded the edges of the bubble will be
	 */
    
    private function set_rounded(value : Int) : Int
    {
        _rounded = value;
        draw();
        return value;
    }
    
    /**
	 * Returns how rounded the bubbleis
	 */
    
    private function get_rounded() : Int
    {
        return _rounded;
    }
    
    /**
	 * Toggle on and off border
	 */
    
    private function set_border(value : Bool) : Bool
    {
        _border = value;
        draw();
        return value;
    }
    
    /**
	 * Returns true if the border is on and false if not
	 */
    
    private function get_border() : Bool
    {
        return _border;
    }
    
    /**
	 * The border color
	 */
    
    private function set_borderColor(value : Int) : Int
    {
        _borderColor = value;
        draw();
        return value;
    }
    
    /**
	 * Returns the color
	 */
    
    private function get_borderColor() : Int
    {
        return _borderColor;
    }
    
    /**
	 * Set the alpha between 1 to 0. For example 0.4
	 */
    
    private function set_borderAlpha(value : Float) : Float
    {
        _borderAlpha = value;
        draw();
        return value;
    }
    
    /**
	 * Returns the boarder alpha
	 */
    
    private function get_borderAlpha() : Float
    {
        return _borderAlpha;
    }
    
    /**
	 * The border thinkness
	 */
    
    private function set_borderThinkness(value : Float) : Float
    {
        _thinkness = value;
        return value;
    }
    
    /**
	 * Return the thinkness of the border
	 */
    
    private function get_borderThinkness() : Float
    {
        return _thinkness;
    }
    
    /**
	 * The background color of the bubble
	 */
    
    private function set_backgroundColor(value : Int) : Int
    {
        _backgroundColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_backgroundColor() : Int
    {
        return _backgroundColor;
    }
    
    /**
	 * The background alpha
	 */
    
    private function set_backgroundAlpha(value : Float) : Float
    {
        _backgroundAlpha = value;
        draw();
        return value;
    }
    
    /**
	 * Return background alpha
	 */
    
    private function get_backgroundAlpha() : Float
    {
        return _backgroundAlpha;
    }
    
    /**
	 * Show the tail of the bubble
	 */
    
    private function set_showTail(value : Bool) : Bool
    {
        _showTail = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the tail is shown and false if not
	 */
    
    private function get_showTail() : Bool
    {
        return _showTail;
    }
    
    /**
	 * The size of the tail
	 */
    
    private function set_tailSize(value : Float) : Float
    {
        _tailSize = value;
        draw();
		
        return value;
    }
    
    /**
	 * Get the tail the size
	 */
    
    private function get_tailSize() : Float
    {
        return _tailSize;
    }
    
    /**
	 * Set the placement of the tail which could be "top", "bottom", "left" or "right"
	 */
    
    private function set_tailPlacement(value : String) : String
    {
        _tailPlacement = value;
        
        draw();
        return value;
    }
    
    /**
	 * Get where the tail is placed
	 */
    
    private function get_tailPlacement() : String
    {
        return _tailPlacement;
    }
    
    /**
	 * The tail location, this only works if the tailAutoCenter is false
	 */
    
    private function set_tailLocation(value : Float) : Float
    {
        _tailLocation = value;
        draw();
        return value;
    }
    
    /**
	 * Set to true if you want the tail to be auto center on the bubble
	 */
    
    private function set_tailAutoCenter(value : Bool) : Bool
    {
        _tailAutoCenter = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the tail is center on the bubble and false if not
	 */
    
    private function get_tailAutoCenter() : Bool
    {
        return _tailAutoCenter;
    }
    
    /**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */
    
    public function setBackgroundBitmap(value : Bitmap) : Void
    {
        _imageBackground = value;
        draw();
    }
    
    /**
	 *
	 * Set the background image
	 *
	 * @param	value The URL of the image that will be used
	 *
	 */
    
    public function setBackgroundImage(value : String) : Void
    {
        _backgroundDisplayImage.load(value);
        _backgroundDisplayImage.addEventListener(Event.COMPLETE, onImageLoaded, false, 0, true);
    }
    
    /**
	 * Set the level of detail on the Window. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 * @see com.chaos.ui.UIDetailLevel
	 */
    
    override private function set_detail(value : String) : String
    {
        
        // Set detail settings
        if (UIDetailLevel.HIGH == value) 
        {
            _showImage = true;
            _smoothImage = true;
        }
        else if (UIDetailLevel.MEDIUM == value) 
        {
            _showImage = true;
            _smoothImage = false;
        }
        // Apply settings to detail
        else if (UIDetailLevel.LOW == value) 
        {
            _showImage = false;
            _smoothImage = false;
        }
        else 
        {
            _showImage = false;
            _smoothImage = false;
            
            super.detail = UIDetailLevel.LOW;
        }
        
        
        
        super.detail = value;
        
        draw();
        return value;
    }
    
    /**
	 * Draw the Bubble and all the UI classes it's using
	 */
    
    override public function draw() : Void
    {
        
        _background.graphics.clear();
        _backgroundBorder.graphics.clear();
        _tail.graphics.clear();
        
        if (_showImage && null != _imageBackground) 
        {
            _background.graphics.beginBitmapFill(_imageBackground.bitmapData, null, true, _smoothImage);
        }
        else 
        {
            _background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
        }
        
        _background.graphics.drawRoundRect(topLeftPattern.width, topLeftPattern.height, width - (middleRightPattern.width + middleLeftPattern.width), height - (bottomMiddlePattern.height + topMiddlePattern.height), _rounded, _rounded);
        _background.graphics.endFill();
        
        // Show border
        if (_border) 
        {
            _backgroundBorder.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
            _backgroundBorder.graphics.drawRoundRect(0, 0, width, height, _rounded, _rounded);
        }
        
        _tail.x = 0;
        _tail.y = 0;
        _tail.rotation = 0;
        
        if (_showTail) 
            drawTail();
        
        super.draw();
    }
    
    private function drawTail() : Void
    {
        
        // NOTE: Was going to use drawTriangles method but learn that lineTo and moveTo functions are faster for what I'm doing
        if (_showImage && null != _imageBackground) 
        {
            _tail.graphics.beginBitmapFill(_imageBackground.bitmapData, null, true, _smoothImage);
        }
        else 
        {
            _tail.graphics.beginFill(_backgroundColor, _backgroundAlpha);
        }
        
		_tail.graphics.moveTo(_tailSize / 2, 0);
		_tail.graphics.lineTo(_tailSize, _tailSize);
        
        if (_border) 
            _tail.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
        
		_tail.graphics.lineTo(0, _tailSize);
		_tail.graphics.lineTo(_tailSize / 2, 0);

        _tail.graphics.endFill();
        
        // Placement
        if (_tailPlacement == "bottom") 
        {
            _tail.rotation = 180;
            
            _tail.x = (_tailAutoCenter) ? (width / 2) : _tailLocation;
            _tail.y = height + _tail.height;
        }
        else if (_tailPlacement == "top") 
        {
            _tail.rotation = 0;
            
            _tail.x = (_tailAutoCenter) ? (width / 2) : _tailLocation;
            _tail.y = -_tail.height;
        }
        else if (_tailPlacement == "left") 
        {
            _tail.rotation = 90;
            
            _tail.x = _tail.width;
            _tail.y = (_tailAutoCenter) ? (height / 2) : _tailLocation;
        }
        else if (_tailPlacement == "right") 
        {
            _tail.rotation = -90;
            
            _tail.x = width - _tail.width;
            _tail.y = (_tailAutoCenter) ? (height / 2) : _tailLocation;
        }
    }
    
    private function onImageLoaded(event : Event) : Void
    {
        _imageBackground = cast(event.currentTarget, DisplayImage).image;
        
        if (_backgroundDisplayImage.hasEventListener(Event.COMPLETE)) 
            _backgroundDisplayImage.removeEventListener(Event.COMPLETE, onImageLoaded);
        
        draw();
    }
    
    private function applyContentMask() : Void
    {
        //contentHolder.addChild(overlayMask);
        //contentHolder.mask = overlayMask;
        
    }
    
    private function removeContentMask() : Void
    {
        contentHolder.mask = null;
    }
}

