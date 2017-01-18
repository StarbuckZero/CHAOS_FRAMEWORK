package com.chaos.ui;


import com.chaos.ui.classInterface.IOverlay;
import com.chaos.utils.Utils;
import openfl.events.Event;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

/**
 * This is a layer that goes applies an object
 *
 * @author Erick Feiling
 */

class Overlay extends BaseUI implements IOverlay
{
    public var tileTopCenterImage(get, set) : Bool;
    public var tileMiddleImage(get, set) : Bool;
    public var tileBottomCenterImage(get, set) : Bool;

    public static inline var TYPE : String = "Overlay";
    
    public var topLeftPattern : Shape;
    public var topMiddlePattern : Shape;
    public var topRightPattern : Shape;
    
    public var bottomLeftPattern : Shape;
    public var bottomMiddlePattern : Shape;
    public var bottomRightPattern : Shape;
    
    public var middleLeftPattern : Shape;
    public var middleRightPattern : Shape;
    
    private var _topLeftImage : Bitmap;
    private var _topMiddleImage : Bitmap;
    private var _topRightImage : Bitmap;
    
    private var _bottomLeftImage : Bitmap;
    private var _bottomMiddleImage : Bitmap;
    private var _bottomRightImage : Bitmap;
    
    private var _middleLeftImage : Bitmap;
    private var _middleRightImage : Bitmap;
    
    private var _width : Float;
    private var _height : Float;
    
    private var _smoothImage : Bool = true;
    private var _showImage : Bool = true;
    
    private var _tileTopCenterImage : Bool = false;
    private var _tileMiddleImage : Bool = false;
    private var _tileBottomCenterImage : Bool = false;
    
    private var _qualityMode : String = UIDetailLevel.HIGH;
    
    public function new(defaultWidth : Float = 100, defaultHeight : Float = 100)
    {
        
        super();
        
        _width = defaultWidth;
        _height = defaultHeight;
        
        init();
    }
    
    private function init() : Void
    {
        mouseChildren = true;
        
        topLeftPattern = new Shape();
        topMiddlePattern = new Shape();
        topRightPattern = new Shape();
        
        bottomLeftPattern = new Shape();
        bottomMiddlePattern = new Shape();
        bottomRightPattern = new Shape();
        
        middleLeftPattern = new Shape();
        middleRightPattern = new Shape();
        
        _topLeftImage = new Bitmap();
        _topMiddleImage = new Bitmap();
        _topRightImage = new Bitmap();
        
        _bottomLeftImage = new Bitmap();
        _bottomMiddleImage = new Bitmap();
        _bottomRightImage = new Bitmap();
        
        _middleLeftImage = new Bitmap();
        _middleRightImage = new Bitmap();
        
        // Overlay corners first
        addChild(middleLeftPattern);
        addChild(middleRightPattern);
        
        addChild(topMiddlePattern);
        addChild(bottomMiddlePattern);
        
        addChild(topLeftPattern);
        addChild(topRightPattern);
        
        addChild(bottomLeftPattern);
        addChild(bottomRightPattern);
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
	
    #if flash @:getter(width) #else override #end
    private function get_width() : Float
    {
        return _width;
    }
	
    
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
	
    #if flash @:getter(height) #else override #end
    private function get_height() : Float
    {
        return _height;
    }
	
    
    /**
	 * If you want to scale or just title the top center image
	 */
    
    private function set_tileTopCenterImage(value : Bool) : Bool
    {
        _tileTopCenterImage = value;
        return value;
    }
    
    /**
	 * Return if top center part of object will be title or not
	 */
    
    private function get_tileTopCenterImage() : Bool
    {
        return _tileTopCenterImage;
    }
    
    /**
	 * Set if the middle part of the object will be tile
	 */
    
    private function set_tileMiddleImage(value : Bool) : Bool
    {
        _tileMiddleImage = value;
        return value;
    }
    
    /**
	 * Return if the center of the object will be tile or not
	 */
    
    private function get_tileMiddleImage() : Bool
    {
        return _tileMiddleImage;
    }
    
    /**
	 * Set if the bottom center image will be tile
	 */
    
    private function set_tileBottomCenterImage(value : Bool) : Bool
    {
        _tileBottomCenterImage = value;
        return value;
    }
    
    /**
	 * Return if the center image will tile or not
	 */
    
    private function get_tileBottomCenterImage() : Bool
    {
        return _tileBottomCenterImage;
    }
    
    /**
	 * Setting the Upper half of the object
	 *
	 * @param	leftImage An image the left
	 * @param	middleImage An middle image that will tile
	 * @param	rightImage An right image that will be used
	 */
    
    public function setTopImage(leftImage : Bitmap = null, middleImage : Bitmap = null, rightImage : Bitmap = null) : Void
    {
        if (null != leftImage) 
            _topLeftImage = leftImage;
        
        if (null != middleImage) 
            _topMiddleImage = middleImage;
        
        if (null != rightImage) 
            _topRightImage = rightImage;
        
        drawTopImage();
    }
    
    /**
	 * Set the middle sides of the object
	 * @param	leftImage left hand side
	 * @param	rightImage right hand side
	 */
    
    public function setMiddleCenterImage(leftImage : Bitmap = null, rightImage : Bitmap = null) : Void
    {
        if (null != leftImage) 
            _middleLeftImage = leftImage;
        
        if (null != rightImage) 
            _middleRightImage = rightImage;
        
        drawMiddleImage();
    }
    
    /**
	 * Left the bottom part of the object
	 * @param	leftImage lower left image
	 * @param	middleImage lower center image
	 * @param	rightImage lower right image
	 */
    
    public function setBottomImage(leftImage : Bitmap = null, middleImage : Bitmap = null, rightImage : Bitmap = null) : Void
    {
        if (null != leftImage) 
            _bottomLeftImage = leftImage;
        
        if (null != middleImage) 
            _bottomMiddleImage = middleImage;
        
        if (null != rightImage) 
            _bottomRightImage = rightImage;
        
        drawBottomImage();
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
    
    override function set_detail(value : String) : String
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
        else if (UIDetailLevel.LOW == value) 
        {
            _showImage = false;
            _smoothImage = false;
        }
        else 
        {
            _showImage = false;
            _smoothImage = false;
            
            _qualityMode = UIDetailLevel.LOW;
        }
        
        draw();
        return value;
    }
    
    /**
	 *
	 * @return Return low, medium or high as string.
	 *
	 * @see com.chaos.ui.UIDetailLevel
	 */
    
    override function get_detail() : String
    {
        return _qualityMode;
    }
    
    /**
	 * Draw the Overlay and all the UI classes it's using
	 */
    
    override public function draw() : Void
    {
        
        super.draw();
        
        drawTopImage();
        drawMiddleImage();
        drawBottomImage();
        
        // Upper Left
        topLeftPattern.x = topLeftPattern.y = 0;
        
        // Middle
        topMiddlePattern.x = topLeftPattern.width;
        topMiddlePattern.y = 0;
        
        // Upper Right
        topRightPattern.x = _width - topRightPattern.width;
        topRightPattern.y = 0;
        
        // Middle Left
        middleLeftPattern.x = 0;
        middleLeftPattern.y = topLeftPattern.height;
        
        // Middle Right
        middleRightPattern.x = _width - middleRightPattern.width;
        middleRightPattern.y = topRightPattern.height;
        
        // Bottom Left
        bottomLeftPattern.x = 0;
        bottomLeftPattern.y = middleLeftPattern.height + topLeftPattern.height;
        
        // Bottom Middle
        bottomMiddlePattern.x = bottomLeftPattern.width;
        bottomMiddlePattern.y = bottomLeftPattern.y;
        
        // Bottom Right
        bottomRightPattern.x = _width - bottomRightPattern.width;
        bottomRightPattern.y = bottomMiddlePattern.y;
    }
    
    private function drawTopImage() : Void
    {
        
        // Top Left
        
        topLeftPattern.graphics.clear();
        
        if (null != _topLeftImage.bitmapData) 
        {
            topLeftPattern.graphics.beginBitmapFill(_topLeftImage.bitmapData, null, false, _smoothImage);
            topLeftPattern.graphics.drawRect(0, 0, _topLeftImage.bitmapData.width, _topLeftImage.bitmapData.height);
            topLeftPattern.graphics.endFill();
        }  // Top Right  
        
        
        
        topRightPattern.graphics.clear();
        
        if (null != _topRightImage.bitmapData) 
        {
            topRightPattern.graphics.beginBitmapFill(_topRightImage.bitmapData, null, false, _smoothImage);
            topRightPattern.graphics.drawRect(0, 0, _topRightImage.bitmapData.width, _topRightImage.bitmapData.height);
            topRightPattern.graphics.endFill();
        }  // Top Middle  
        
        
        
        topMiddlePattern.graphics.clear();
        
        if (null != _topMiddleImage.bitmapData) 
        {
            topMiddlePattern.graphics.beginBitmapFill(_topMiddleImage.bitmapData, null, _tileTopCenterImage, _smoothImage);
            topMiddlePattern.graphics.drawRect(0, 0, _width - (topRightPattern.width + topLeftPattern.width), _topMiddleImage.height);
            topMiddlePattern.graphics.endFill();
        }
    }
    
    private function drawMiddleImage() : Void
    {
        // Middle takes into account the top and bottom
        
        // Middle Left
        middleLeftPattern.graphics.clear();
        
        if (null != _middleLeftImage.bitmapData) 
        {
            
            middleLeftPattern.graphics.beginBitmapFill(_middleLeftImage.bitmapData, null, _tileMiddleImage, _smoothImage);
            middleLeftPattern.graphics.drawRect(0, 0, _middleLeftImage.width, _height - (bottomLeftPattern.height + topLeftPattern.height));
            middleLeftPattern.graphics.endFill();
        }  // Middle Right  
        
        
        
        middleRightPattern.graphics.clear();
        
        if (null != _middleRightImage.bitmapData) 
        {
            middleRightPattern.graphics.beginBitmapFill(_middleRightImage.bitmapData, null, _tileMiddleImage, _smoothImage);
            middleRightPattern.graphics.drawRect(0, 0, _middleRightImage.width, _height - (bottomRightPattern.height + topRightPattern.height));
            middleRightPattern.graphics.endFill();
        }
    }
    
    private function drawBottomImage() : Void
    {
        // Bottom Left
        bottomLeftPattern.graphics.clear();
        
        if (null != _bottomLeftImage.bitmapData) 
        {
            bottomLeftPattern.graphics.beginBitmapFill(_bottomLeftImage.bitmapData, null, false, _smoothImage);
            bottomLeftPattern.graphics.drawRect(0, 0, _bottomLeftImage.width, _bottomLeftImage.height);
            bottomLeftPattern.graphics.endFill();
        }  // Bottom Right  
        
        
        
        bottomRightPattern.graphics.clear();
        
        if (null != _bottomRightImage.bitmapData) 
        {
            bottomRightPattern.graphics.beginBitmapFill(_bottomRightImage.bitmapData, null, false, _smoothImage);
            bottomRightPattern.graphics.drawRect(0, 0, _bottomRightImage.width, _bottomRightImage.height);
            bottomRightPattern.graphics.endFill();
        }  // Bottom Middle  
        
        
        
        bottomMiddlePattern.graphics.clear();
        
        if (null != _bottomMiddleImage.bitmapData) 
        {
            bottomMiddlePattern.graphics.beginBitmapFill(_bottomMiddleImage.bitmapData, null, _tileBottomCenterImage, _smoothImage);
            bottomMiddlePattern.graphics.drawRect(0, 0, _width - (bottomLeftPattern.width + bottomRightPattern.width), _bottomMiddleImage.height);
            bottomMiddlePattern.graphics.endFill();
        }
    }
}

