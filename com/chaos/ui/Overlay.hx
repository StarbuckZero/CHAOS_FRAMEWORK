package com.chaos.ui;


import com.chaos.ui.classInterface.IOverlay;

import openfl.display.BitmapData;
import openfl.display.Shape;



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
    
    public var topLeftPattern : Shape = new Shape();
    public var topMiddlePattern : Shape = new Shape();
    public var topRightPattern : Shape = new Shape();
    
    public var bottomLeftPattern : Shape = new Shape();
    public var bottomMiddlePattern : Shape = new Shape();
    public var bottomRightPattern : Shape = new Shape();
    
    public var middleLeftPattern : Shape = new Shape();
    public var middleRightPattern : Shape = new Shape();
    
    private var _topLeftImage : BitmapData;
    private var _topMiddleImage : BitmapData;
    private var _topRightImage : BitmapData;
    
    private var _bottomLeftImage : BitmapData;
    private var _bottomMiddleImage : BitmapData;
    private var _bottomRightImage : BitmapData;
    
    private var _middleLeftImage : BitmapData;
    private var _middleRightImage : BitmapData;
    
    private var _smoothImage : Bool = true;
    private var _showImage : Bool = true;
    
    private var _tileTopCenterImage : Bool = false;
    private var _tileMiddleImage : Bool = false;
    private var _tileBottomCenterImage : Bool = false;
    
    
    
    public function new(data:Dynamic = null)
    {
		// defaultWidth : Float = 100, defaultHeight : Float = 100
        
        super(data);
        
        
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "tileTopCenterImage"))
			_tileTopCenterImage = Reflect.field(data, "tileTopCenterImage");
		
		if (Reflect.hasField(data, "tileMiddleImage"))
			_tileMiddleImage = Reflect.field(data, "tileMiddleImage");
			
		if (Reflect.hasField(data, "tileBottomCenterImage"))
			_tileBottomCenterImage = Reflect.field(data, "tileBottomCenterImage");
	}
	
	override public function initialize():Void 
	{
        mouseChildren = true;
        
		
		super.initialize();
        
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
	
	override public function destroy():Void 
	{
		super.destroy();
		
        topLeftPattern.graphics.clear();
        topMiddlePattern.graphics.clear();
        topRightPattern.graphics.clear();
        
        bottomLeftPattern.graphics.clear();
        bottomMiddlePattern.graphics.clear();
        bottomRightPattern.graphics.clear();
        
        middleLeftPattern.graphics.clear();
        middleRightPattern.graphics.clear();
		
        removeChild(middleLeftPattern);
        removeChild(middleRightPattern);
        
        removeChild(topMiddlePattern);
        removeChild(bottomMiddlePattern);
        
        removeChild(topLeftPattern);
        removeChild(topRightPattern);
        
        removeChild(bottomLeftPattern);
        removeChild(bottomRightPattern);		
		
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
    
    public function setTopImage(leftImage : BitmapData = null, middleImage : BitmapData = null, rightImage : BitmapData = null) : Void
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
    
    public function setMiddleCenterImage(leftImage : BitmapData = null, rightImage : BitmapData = null) : Void
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
    
    public function setBottomImage(leftImage : BitmapData = null, middleImage : BitmapData = null, rightImage : BitmapData = null) : Void
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
        topRightPattern.x = width - topRightPattern.width;
        topRightPattern.y = 0;
        
        // Middle Left
        middleLeftPattern.x = 0;
        middleLeftPattern.y = topLeftPattern.height;
        
        // Middle Right
        middleRightPattern.x = width - middleRightPattern.width;
        middleRightPattern.y = topRightPattern.height;
        
        // Bottom Left
        bottomLeftPattern.x = 0;
        bottomLeftPattern.y = middleLeftPattern.height + topLeftPattern.height;
        
        // Bottom Middle
        bottomMiddlePattern.x = bottomLeftPattern.width;
        bottomMiddlePattern.y = bottomLeftPattern.y;
        
        // Bottom Right
        bottomRightPattern.x = width - bottomRightPattern.width;
        bottomRightPattern.y = bottomMiddlePattern.y;
    }
    
    private function drawTopImage() : Void
    {
        
        // Top Left
        
        topLeftPattern.graphics.clear();
        
        if (null != _topLeftImage) 
        {
            topLeftPattern.graphics.beginBitmapFill(_topLeftImage, null, false, _smoothImage);
            topLeftPattern.graphics.drawRect(0, 0, _topLeftImage.width, _topLeftImage.height);
            topLeftPattern.graphics.endFill();
        }  // Top Right  
        
        
        
        topRightPattern.graphics.clear();
        
        if (null != _topRightImage) 
        {
            topRightPattern.graphics.beginBitmapFill(_topRightImage, null, false, _smoothImage);
            topRightPattern.graphics.drawRect(0, 0, _topRightImage.width, _topRightImage.height);
            topRightPattern.graphics.endFill();
        }  // Top Middle  
        
        
        
        topMiddlePattern.graphics.clear();
        
        if (null != _topMiddleImage) 
        {
            topMiddlePattern.graphics.beginBitmapFill(_topMiddleImage, null, _tileTopCenterImage, _smoothImage);
            topMiddlePattern.graphics.drawRect(0, 0, width - (topRightPattern.width + topLeftPattern.width), _topMiddleImage.height);
            topMiddlePattern.graphics.endFill();
        }
    }
    
    private function drawMiddleImage() : Void
    {
        // Middle takes into account the top and bottom
        
        // Middle Left
        middleLeftPattern.graphics.clear();
        
        if (null != _middleLeftImage) 
        {
            
            middleLeftPattern.graphics.beginBitmapFill(_middleLeftImage, null, _tileMiddleImage, _smoothImage);
            middleLeftPattern.graphics.drawRect(0, 0, _middleLeftImage.width, height - (bottomLeftPattern.height + topLeftPattern.height));
            middleLeftPattern.graphics.endFill();
        }  // Middle Right  
        
        
        
        middleRightPattern.graphics.clear();
        
        if (null != _middleRightImage) 
        {
            middleRightPattern.graphics.beginBitmapFill(_middleRightImage, null, _tileMiddleImage, _smoothImage);
            middleRightPattern.graphics.drawRect(0, 0, _middleRightImage.width, height - (bottomRightPattern.height + topRightPattern.height));
            middleRightPattern.graphics.endFill();
        }
    }
    
    private function drawBottomImage() : Void
    {
        // Bottom Left
        bottomLeftPattern.graphics.clear();
        
        if (null != _bottomLeftImage) 
        {
            bottomLeftPattern.graphics.beginBitmapFill(_bottomLeftImage, null, false, _smoothImage);
            bottomLeftPattern.graphics.drawRect(0, 0, _bottomLeftImage.width, _bottomLeftImage.height);
            bottomLeftPattern.graphics.endFill();
        }  // Bottom Right  
        
        
        
        bottomRightPattern.graphics.clear();
        
        if (null != _bottomRightImage) 
        {
            bottomRightPattern.graphics.beginBitmapFill(_bottomRightImage, null, false, _smoothImage);
            bottomRightPattern.graphics.drawRect(0, 0, _bottomRightImage.width, _bottomRightImage.height);
            bottomRightPattern.graphics.endFill();
        }  // Bottom Middle  
        
        
        
        bottomMiddlePattern.graphics.clear();
        
        if (null != _bottomMiddleImage) 
        {
            bottomMiddlePattern.graphics.beginBitmapFill(_bottomMiddleImage, null, _tileBottomCenterImage, _smoothImage);
            bottomMiddlePattern.graphics.drawRect(0, 0, width - (bottomLeftPattern.width + bottomRightPattern.width), _bottomMiddleImage.height);
            bottomMiddlePattern.graphics.endFill();
        }
    }
}

