package com.chaos.ui;



import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IBubble;
import com.chaos.ui.classInterface.IOverlay;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.errors.Error;
import com.chaos.ui.UIBitmapManager;

import com.chaos.ui.Overlay;


import openfl.display.Sprite;
import openfl.events.Event;


/**
 * Creates a bubble which can also double as a tool-tip.
 *
 * @author Erick Feiling
 */

class Bubble extends Overlay implements IBubble implements IOverlay implements IBaseUI
{
	
	/**
	 * If true this will apply a mask content layer
	 */	
    public var useMask(get, set) : Bool;
	
    /**
	 * This is the content DisplayObject. You can add DisplayObject into this content area.
	 */	
	
    public var content(get, never) : Sprite;
	
	
	/**
	 * How rounded the edges of the bubble will be
	 */
	
    public var rounded(get, set) : Int;
	
	/**
	 * Toggle on and off border
	 */
	
    public var border(get, set) : Bool;
	
	/**
	 * The border color
	 */	
	
    public var borderColor(get, set) : Int;
	
	/**
	 * Set the alpha between 1 to 0. For example 0.4
	 */
	
    public var borderAlpha(get, set) : Float;
	
	/**
	 * The border thinkness
	 */
	
    public var borderThinkness(get, set) : Float;
	
	/**
	 * The background color of the bubble
	 */
	
    public var backgroundColor(get, set) : Int;
	
	/**
	 * The background alpha
	 */
	
    public var backgroundAlpha(get, set) : Float;
	
	/**
	 * Show the tail of the bubble
	 */
	
    public var showTail(get, set) : Bool;
	
	/**
	 * The size of the tail
	 */
	
    public var tailSize(get, set) : Float;
	
	/**
	 * Set the placement of the tail which could be "top", "bottom", "left" or "right"
	 */
	
    public var tailPlacement(get, set) : BubbleTailLocation;
	
	/**
	 * The tail location, this only works if the tailAutoCenter is false
	 */
	
    public var tailLocation(never, set) : Float;
	
	/**
	 * Set to true if you want the tail to be auto center on the bubble
	 */
	
    public var tailAutoCenter(get, set) : Bool;

    
    public var contentHolder : Sprite = new Sprite();
    
    private var _backgroundColor : Int = 0xFFFFFF;
    private var _backgroundAlpha : Float = 1;
    
    private var _thinkness : Float = 2;
    
    private var _border : Bool = true;
    private var _borderColor : Int = 0x000000;
    private var _borderAlpha : Float = 1;

    private var _imageBackground : BitmapData;
    
    
    private var _showTail : Bool = true;
    private var _tailSize : Float = 10;
    private var _tail : Shape = new Shape();
    
    private var _tailAutoCenter : Bool = true;
    private var _tailLocation : Float = 40;
    
    private var _tailPlacement : BubbleTailLocation = BubbleTailLocation.BOTTOM;
    
    private var _background : Shape = new Shape();
    private var _backgroundBorder : Shape = new Shape();
    private var _content : Sprite = new Sprite();
    
    private var _rounded : Int = 40;
    
    private var _useMask : Bool = false;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new(data:Dynamic = null)
    {
        
        super(data);
        
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
    private function onStageAdd(event : Event) : Void
    {
        UIBitmapManager.watchElement(UIBitmapType.Bubble, this);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        UIBitmapManager.stopWatchElement(UIBitmapType.Bubble, this);
    }
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "thinkness"))
			_thinkness = Reflect.field(data, "thinkness");
		
		if (Reflect.hasField(data, "border"))
			_border = Reflect.field(data, "border");
			
		if (Reflect.hasField(data, "borderColor"))
			_borderColor = Reflect.field(data, "borderColor");
			
		if (Reflect.hasField(data, "borderAlpha"))
			_borderAlpha = Reflect.field(data, "borderAlpha");
			
			
		if (Reflect.hasField(data, "rounded"))
			_rounded = Reflect.field(data, "rounded");
			
			
		if (Reflect.hasField(data, "useMask"))
			_useMask = Reflect.field(data, "useMask");
			
			
		if (Reflect.hasField(data, "showTail"))
			_showTail = Reflect.field(data, "showTail");
			
		if (Reflect.hasField(data, "tailSize"))
			_tailSize = Reflect.field(data, "tailSize");
			
		if (Reflect.hasField(data, "tailAutoCenter"))
			_tailAutoCenter = Reflect.field(data, "tailAutoCenter");
			
		
		if (Reflect.hasField(data, "tailLocation"))
			_tailLocation = Reflect.field(data, "tailLocation");
			
			
		if (Reflect.hasField(data, "tailPlacement"))
			_tailPlacement = getTailLoc(Reflect.field(data, "tailPlacement"));
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
        
		super.initialize();
		
        addChild(_background);
        addChild(_content);
        addChild(_backgroundBorder);
        addChild(_tail);
        
        //addChildAt(contentHolder, 0);
		
	}
	
	/**
	 * @inheritDoc
	 */
	override public function destroy():Void 
	{
		super.destroy();
		
		
		_background.graphics.clear();
		_tail.graphics.clear();
		_backgroundBorder.graphics.clear();
		
		
		try
		{
			_content.removeChildren(0, _content.numChildren - 1);
		}
		catch (e:Error)
		{
			trace("[Bubble::destroy] Something went wrong when trying to remove children from content area.");
		}
		
		removeChild(_background);
		removeChild(_tail);
		removeChild(_backgroundBorder);
		removeChild(_content);
		
		
	}

    
    private function initStyle() : Void
    {
        if (UIStyleManager.hasStyle(UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR))
            backgroundColor = UIStyleManager.getStyle(UIStyleManager.BUBBLE_BACKGROUND_NORMAL_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUBBLE_BACKGROUND_ALPHA)) 
            backgroundAlpha = UIStyleManager.getStyle(UIStyleManager.BUBBLE_BACKGROUND_ALPHA);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUBBLE_BORDER_ALPHA)) 
            borderAlpha = UIStyleManager.getStyle(UIStyleManager.BUBBLE_BORDER_ALPHA);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUBBLE_BORDER_COLOR))
            borderColor = UIStyleManager.getStyle(UIStyleManager.BUBBLE_BORDER_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.BUBBLE_BORDER))
            _border = UIStyleManager.getStyle(UIStyleManager.BUBBLE_BORDER);
    }
    
    private function initBitmap() : Void
    {
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_BACKGROUND)) 
            setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_BACKGROUND));
        
        var topLeftImage : BitmapData = null;
        var topMiddleImage : BitmapData = null;
        var topRightImage : BitmapData = null;
        
        var middleLeftImage : BitmapData = null;
        var middleRightImage : BitmapData = null;
        
        var bottomLeftImage : BitmapData = null;
        var bottomMiddleImage : BitmapData = null;
        var bottomRightImage : BitmapData = null;
        
        // Top
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_LEFT)) 
            topLeftImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_LEFT);
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_MIDDLE)) 
            topMiddleImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_MIDDLE);
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_RIGHT)) 
            topRightImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_TOP_RIGHT);
        
        setTopImage(topLeftImage, topMiddleImage, topRightImage);
        
        // Middle
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_LEFT)) 
            middleLeftImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_LEFT);
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_RIGHT)) 
            middleRightImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_MIDDLE_RIGHT);
        
        setMiddleCenterImage(middleLeftImage, middleRightImage);
        
        // Bottom
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_LEFT)) 
            bottomLeftImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_LEFT);
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_MIDDLE)) 
            bottomMiddleImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_MIDDLE);
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_RIGHT)) 
            bottomRightImage = UIBitmapManager.getUIElement(UIBitmapType.Bubble, UIBitmapManager.BUBBLE_OVERLAY_BOTTOM_RIGHT);
        
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
    
    private function set_tailPlacement(value : BubbleTailLocation) : BubbleTailLocation
    {
        _tailPlacement = value;
        
        return value;
    }
    
    /**
	 * Get where the tail is placed
	 */
    
    private function get_tailPlacement() : BubbleTailLocation
    {
        return _tailPlacement;
    }
    
    /**
	 * The tail location, this only works if the tailAutoCenter is false
	 */
    
    private function set_tailLocation(value : Float) : Float
    {
        _tailLocation = value;
        
        return value;
    }
    
    /**
	 * Set to true if you want the tail to be auto center on the bubble
	 */
    
    private function set_tailAutoCenter(value : Bool) : Bool
    {
        _tailAutoCenter = value;
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
    
    public function setBackgroundImage(value : BitmapData) : Void
    {
        _imageBackground = value;
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
            _background.graphics.beginBitmapFill(_imageBackground, null, true, _smoothImage);
        else 
            _background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
        
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
            _tail.graphics.beginBitmapFill(_imageBackground, null, true, _smoothImage);
        else 
            _tail.graphics.beginFill(_backgroundColor, _backgroundAlpha);
        
		_tail.graphics.moveTo(_tailSize / 2, 0);
		_tail.graphics.lineTo(_tailSize, _tailSize);
        
        if (_border) 
            _tail.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
        
		_tail.graphics.lineTo(0, _tailSize);
		_tail.graphics.lineTo(_tailSize / 2, 0);

        _tail.graphics.endFill();
        
        // Placement
        if (_tailPlacement == BubbleTailLocation.BOTTOM) 
        {
            _tail.rotation = 180;
            
            _tail.x = (_tailAutoCenter) ? (width / 2) : _tailLocation;
            _tail.y = height + _tail.height;
        }
        else if (_tailPlacement == BubbleTailLocation.TOP) 
        {
            _tail.rotation = 0;
            
            _tail.x = (_tailAutoCenter) ? (width / 2) : _tailLocation;
            _tail.y = -_tail.height;
        }
        else if (_tailPlacement == BubbleTailLocation.LEFT) 
        {
            _tail.rotation = 90;
            
            _tail.x = _tail.width;
            _tail.y = (_tailAutoCenter) ? (height / 2) : _tailLocation;
        }
        else if (_tailPlacement == BubbleTailLocation.RIGHT) 
        {
            _tail.rotation = -90;
            
            _tail.x = width - _tail.width;
            _tail.y = (_tailAutoCenter) ? (height / 2) : _tailLocation;
        }
    }
    
    private function getTailLoc( value : String ) : BubbleTailLocation {

        switch(value.toLowerCase())
        {
            case "top":
                return BubbleTailLocation.TOP;
            case "bottom":
                return BubbleTailLocation.BOTTOM;
            case "right":
                return BubbleTailLocation.RIGHT;
            case "left":
                return BubbleTailLocation.LEFT;

            default:
                return BubbleTailLocation.BOTTOM;
        }
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

