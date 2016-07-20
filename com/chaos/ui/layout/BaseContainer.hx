package com.chaos.ui.layout;



/**
 * A very basic container.
 * @author Erick Feiling
 */

import com.chaos.media.DisplayImage;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;

import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;

class BaseContainer extends BaseUI implements IBaseContainer implements IBaseUI
{
    public var content(get, never) : DisplayObject;
    public var showImage(get, set) : Bool;
    public var imageSmoothing(get, set) : Bool;
    public var background(get, set) : Bool;
    public var backgroundColor(get, set) : Int;
    public var backgroundAlpha(get, set) : Float;

    
    /** This could be used for holding other DisplayObjects */
    public var contentHolder : Sprite;
    
    /** The background shape */
    public var backgroundShape : Shape;
    
    /** This is used for the content getting property */
    public var contentObject : Sprite;
    
    private var _width : Float;
    private var _height : Float;
    
    private var _imageBackground : Bitmap = null;
    private var _backgroundDisplayImage : DisplayImage = new DisplayImage();
    private var _backgroundAlpha : Float = 1;
    private var _backgroundColor : Int = 0xCCCCCC;
    private var _background : Bool = true;
    
    private var _smoothImage : Bool = true;
    private var _showImage : Bool = true;
    
    public function new(baseWidth : Int = 400, baseHeight : Int = 300)
    {
        super();
        _width = baseWidth;
        _height = baseHeight;
        
        contentHolder = new Sprite();
        
        backgroundShape = new Shape();
        contentObject = new Sprite();
        
        contentHolder.addChild(backgroundShape);
        contentHolder.addChild(contentObject);
        
        addChild(contentHolder);
        
        draw();
    }
	
    #if flash @:getter(width) #else override #end
    private function set_width(value : Float) : Float
    {
        _width = value;
        draw();
        return value;
    }
	
    #if flash @:getter(width) #else override #end
    private function get_width() : Float
    {
        return _width;
    }
    
	#if flash @:getter(width) #else override #end
    private function set_height(value : Float) : Float
    {
        _height = value;
        draw();
        return value;
    }
	
    #if flash @:getter(width) #else override #end
    private function get_height() : Float
    {
        return _height;
    }
    
    /**
	 * The content layer
	 */
    
    private function get_content() : DisplayObject
    {
        return contentObject;
    }
    
    /**
	 * Toggle on and off images, if false then will use default render
	 */
    
    private function set_showImage(value : Bool) : Bool
    {
        _showImage = value;
        return value;
    }
    
    /**
	 * Return true if showing images and false if not
	 */
    
    private function get_showImage() : Bool
    {
        return _showImage;
    }
    
    /**
	 * Turns on or off image smoothing
	 */
    
    private function set_imageSmoothing(value : Bool) : Bool
    {
        _smoothImage = value;
        return value;
    }
    
    /**
	 * Return the image being used
	 */
    
    private function get_imageSmoothing() : Bool
    {
        return _smoothImage;
    }
    
    /**
	 * Hide or show the background
	 */
    
    private function set_background(value : Bool) : Bool
    {
        _background = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if the being displayed
	 */
    
    private function get_background() : Bool
    {
        return _background;
    }
    
    /**
	 * The background color
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
	 * Draw the container
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        backgroundShape.visible = _background;
        
        backgroundShape.graphics.clear();
        
        (_showImage && null != _imageBackground) ? backgroundShape.graphics.beginBitmapFill(_imageBackground.bitmapData, null, true, _smoothImage) : backgroundShape.graphics.beginFill(_backgroundColor, _backgroundAlpha);
		
        backgroundShape.graphics.drawRect(0, 0, _width, _height);
        backgroundShape.graphics.endFill();
    }
    
    private function onImageLoaded(event : Event) : Void
    {
        _imageBackground = cast(event.currentTarget, DisplayImage).image;
        
        if (_backgroundDisplayImage.hasEventListener(Event.COMPLETE)) 
            _backgroundDisplayImage.removeEventListener(Event.COMPLETE, onImageLoaded);
        
        draw();
    }
}

