package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.BaseUI;

import com.chaos.ui.classInterface.IBaseUI;
import openfl.display.BitmapData;
import openfl.filters.BitmapFilter;


import openfl.display.Shape;


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
    
    public var showImage(get, set) : Bool;

    
    private var _iconArea : Shape;
    private var _image : BitmapData;
    
    
    
    private var _showImage : Bool = true;
    
    
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
        
        _iconArea = new Shape();
        addChild(_iconArea);
        
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
	 * Set a image to be used for the icon
	 *
	 * @param	value The bitmap you want touse
	 */
    
    public function setImage(value : BitmapData) : Void
    {
        _image = value;
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        _iconArea.filters = new Array<BitmapFilter>();
    }
    

}

