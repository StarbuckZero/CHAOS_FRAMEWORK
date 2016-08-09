package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.BaseUI;
import com.chaos.ui.UIDetailLevel;
import com.chaos.media.DisplayImage;
import com.chaos.ui.classInterface.IBaseUI;
import openfl.filters.BitmapFilter;

import openfl.display.Bitmap;
import openfl.display.Shape;
import openfl.events.Event;

//import openfl.filters.BevelFilter;

/**
 * Base icon with filters and display object to draw shape
 *
 * @author Erick Feiling
 */

class BaseIcon extends BaseUI implements IBasicIcon implements IBaseUI
{
    public var baseColor(get, set) : Int;
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderThinkness(get, set) : Float;
    public var borderAlpha(get, set) : Float;
    public var filterMode(get, set) : Bool;
    public var showImage(get, set) : Bool;
    //public var baseBevelFilter(get, never) : BevelFilter;

    
    private var iconArea : Shape;
    private var displayImg : DisplayImage;
    
    //private var _baseBevelFilter : BevelFilter;
    
    private var _filterMode : Bool = false;
    private var _showImage : Bool = true;
    
    private var _width : Float = 20;
    private var _height : Float = 20;
    
    private var _border : Bool = true;
    
    private var _thinkness : Float = 1;
    private var _borderColor : Int = 0xFFFFFF;
    private var _borderAlpha : Float = 1;
    
    private var _baseColor : Int = 0xFFFFFF;
    
    /**
	 * Create icon on the fly
	 *
	 * @param	iconWidth The width of the icon
	 * @param	iconHeight The height of the icon
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        
        if (iconWidth > 0) 
            _width = iconWidth;
        
        if (iconHeight > 0) 
            _height = iconHeight;
        
        super();
        init();
    }
    
    private function init() : Void
    {
        
        displayImg = new DisplayImage();
        
        //_baseBevelFilter = new BevelFilter();
        //_baseBevelFilter.distance = 1;
        
        iconArea = new Shape();
        addChild(iconArea);
        
        draw();
    }
    
    /**
	 * Set the base color for the icon
	 */
    
    private function set_baseColor(value : Int) : Int
    {
        _baseColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_baseColor() : Int
    {
        return _baseColor;
    }
    
    /**
	 * Show or hide border
	 */
	
    private function set_border(value : Bool) : Bool
    {
        _border = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return true if border is being used and false if not
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
	 * Border thinkness
	 */
    
    private function set_borderThinkness(value : Float) : Float
    {
        _thinkness = value;
        draw();
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
	 * Specifies the border alpha. Set the alpha between 1 to 0.
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
	 * @inheritDoc
	 */
	
    #if flash @:setter(width)
    private function set_width(value : Float) : Void
    {
        _width = value;
        draw();
    }
    #else
    override private function set_width(value : Float) : Float
    {
        _width = value;
        draw();
        return value;
    }
	#end
	
    /**
	 * @inheritDoc
	 */
	
    #if flash @:getter(width)
    private function get_width() : Float
    {
        return _width;
    }
	#else
    override private function get_width() : Float
    {
        return _width;
    }
    #end
	
    /**
	 * @inheritDoc
	 */
    #if flash @:setter(height)
    private function set_height(value : Float) : Void
    {
        _height = value;
        draw();
    }
    #else
    override private function set_height(value : Float) : Float
    {
        _height = value;
        draw();
        return value;
    }
	#end
	  
    /**
	 * @inheritDoc
	 */
    #if flash @:getter(height)
    private function get_height() : Float
    {
        return _height;
    }
    #else
    override private function get_height() : Float
    {
        return _height;
    }
	#end
	
    /**
	 * Set if filter mode
	 */
    
    private function set_filterMode(value : Bool) : Bool
    {
        _filterMode = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the filters are being used and false if not
	 */
    
    private function get_filterMode() : Bool
    {
        return _filterMode;
    }
    
    /**
	 * If true then the image will be displayed and false if image is not being used
	 */
    
    private function set_showImage(value : Bool) : Bool
    {
        _showImage = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if image will be used and false is not
	 */
    
    private function get_showImage() : Bool
    {
        return _showImage;
    }
    
    /**
	 * Return the bevel filter. Use draw method to update.
	 */
    
    //private function get_BaseBevelFilter() : BevelFilter
    //{
    //    return _baseBevelFilter;
    //}
    
    /**
		 * Set a DisplayImage to be used for drawing a bitmap texture.
		 *
		 * @param	displayImage The display image that will be used
		 */
    
    public function setDisplayImage(displayImage : DisplayImage) : Void
    {
        displayImg = displayImage;
        draw();
    }
    
    /**
	 * Loads an image from a location
	 *
	 * @param	value The path to the image
	 */
    
    public function loadImage(value : String) : Void
    {
        displayImg.load(value);
        displayImg.addEventListener(Event.COMPLETE, onLoadComplete, false, 0, true);
    }
    
    /**
	 * Set a bitmap image to be used for the icon
	 *
	 * @param	value The bitmap you want touse
	 */
    
    public function setBitmap(value : Bitmap) : Void
    {
        displayImg.setImage(value);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        iconArea.filters = new Array<BitmapFilter>();
        
        //if (_filterMode) 
        //    iconArea.filters = [_baseBevelFilter];
    }
    
    /**
	 * @inheritDoc
	 */
    
    override private function set_detail(value : String) : String
    {
        super.detail = value;
        
        if (UIDetailLevel.HIGH == value || UIDetailLevel.MEDIUM == value) 
        {
            _filterMode = _showImage = true;
        }
        else if (UIDetailLevel.LOW == value) 
        {
            _filterMode = _showImage = false;
        }
        
        draw();
        return value;
    }
    
    /**
	 * @inheritDoc
	 */
    
    override private function get_detail() : String
    {
        return super.detail;
    }
    
    private function onLoadComplete(event : Event) : Void
    {
        if (displayImg.hasEventListener(Event.COMPLETE)) 
            displayImg.removeEventListener(Event.COMPLETE, onLoadComplete);
        
        draw();
    }
}

