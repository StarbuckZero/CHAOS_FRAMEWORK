package com.chaos.media;


import com.chaos.media.classInterface.IPanorama;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.BaseUI;
import com.chaos.utils.Debug;
import com.chaos.utils.Utils;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * A 2D Panorama that used image
 *
 * @author Erick Feiling
 */

class Panorama2D extends BaseUI implements IPanorama implements IBaseUI
{
    public var spacing(get, set) : Int;
    public var lag(get, set) : Int;
    public var enableZoom(get, set) : Bool;
    public var forceMode(get, set) : Bool;
    public var lock(get, set) : Bool;
    public var enableX(get, set) : Bool;
    public var enableY(get, set) : Bool;
    public var blockSpace(get, set) : Int;
    public var mode(get, never) : String;
    public var source(get, set) : DisplayObject;

    public static inline var TYPE : String = "Panorama2D";
    
    public static inline var MODE_NOMRAL : String = "normal";
    public static inline var MODE_360 : String = "360";
    
    private static inline var ZOOM_MAX : Int = 2;
    private static inline var ZOOM_MIN : Int = 1;
    
    
    // For whem user mouse is over area
    private var active : Bool = false;
    
    private var _mode : String = "360";
    
    private var _velocity : Int = 0;
    private var _blockSpace : Int = 0;
    
    private var _margin : Int = 0;
    private var _spacing : Int = 0;
    
    private var _forceMode : Bool = false;
    private var _lock : Bool = false;
    private var _lag : Int = 10;
    
    private var _maskReady : Bool = false;
    private var _maskWidth : Float = -1;
    private var _maskHeight : Float = -1;
    
    private var _xLock : Bool = false;
    private var _yLock : Bool = false;
    
    private var _pointX : Int = 0;
    private var _pointY : Int = 0;
    
    private var _targetX : Float = 0;
    private var _targetY : Float = 0;
    
    private var maxUp : Float = 0;
    private var maxDown : Float = 0;
    private var maxRight : Float = 0;
    private var maxLeft : Float = 0;
    private var zoomCurrentNum : Int = 0;
    private var zoomNum : Int = 1;
    private var _enableZoom : Bool = false;
    
    // Area for images
    private var slider : Sprite = new Sprite();
    private var forcePoint : Point = new Point(); // Used for force mode
    private var panHolder : Sprite = new Sprite();
    
    private var _source : DisplayObject;
    
    // Hit area
    private var left_mc : Shape = new Shape();
    private var right_mc : Shape = new Shape();
    private var upper_mc : Shape = new Shape();
    private var lower_mc : Shape = new Shape();
    
    // For 360 Pan
    private var img1 : Sprite = new Sprite();
    private var img2 : Sprite = new Sprite();
    private var img3 : Sprite = new Sprite();
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "velocity"))
			_velocity = Reflect.field(data,"velocity");
		
		if (Reflect.hasField(data, "spacing"))
			_spacing = Reflect.field(data,"spacing");
			
		if (Reflect.hasField(data, "mode"))
            _mode = Reflect.field(data,"mode");
        
        if (Reflect.hasField(data, "blockSpace"))
            _blockSpace = Reflect.field(data,"blockSpace");

        if (Reflect.hasField(data, "enableX"))
            _xLock = Reflect.field(data,"enableX");

        if (Reflect.hasField(data, "enableY"))
            _yLock = Reflect.field(data,"enableY");

        if (Reflect.hasField(data, "enableZoom"))
            _enableZoom = Reflect.field(data,"enableZoom");

        if (Reflect.hasField(data, "forceMode"))
            _forceMode = Reflect.field(data,"forceMode");

        if (Reflect.hasField(data, "lag"))
            _lag = Reflect.field(data,"lag");

        if (Reflect.hasField(data, "lock"))
            _lock = Reflect.field(data,"lock");

        if (Reflect.hasField(data, "source"))
            _source = Reflect.field(data,"source");

        if (Reflect.hasField(data, "image"))
            setImage(Reflect.field(data,"image"));

        if (Reflect.hasField(data,"forcePointX") && Reflect.hasField(data,"forcePointY"))
            setForcePoint(Reflect.field(data,"forcePointX"), Reflect.field(data,"forcePointY"));
		
		initSlider(_velocity,  _margin, _spacing, _mode);
		
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
        removeEventListener(Event.ENTER_FRAME, updateSlider);
        removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		
		
        // Remove old display object  
        if (null == _source) 
        {
            if (null != _source.parent) 
                _source.parent.removeChild(_source);
        }
		
        panHolder.removeChild(img1);
        panHolder.removeChild(img2);
        panHolder.removeChild(img3);		
		
        
		
        //removeChild(vr_mask);
        removeChild(slider);
        slider.addChild(panHolder);		
	}
    
    /**
	 * The margin or hit area for when in forceMode
	 */
    
    private function set_spacing(value : Int) : Int
    {
        _spacing = value;
        return value;
    }
    
    /**
	 * Return the hit area size
	 */
    
    private function get_spacing() : Int
    {
        return _spacing;
    }
    
    /**
	 * The higher the number the slower panorama moves
	 */
	
    private function set_lag(value : Int) : Int
    {
        _lag = value;
        return value;
    }
    
    /**
	 * Return the amount of lag apply to the panorama
	 */
    
    private function get_lag() : Int
    {
        return _lag;
    }
    
    /**
	 * Making it so user can zoom in and out
	 */
    
    private function set_enableZoom(value : Bool) : Bool
    {
        _enableZoom = value;
        return value;
    }
    
    /**
	 * If true zooming is supported
	 */
    
    private function get_enableZoom() : Bool
    {
        return _enableZoom;
    }
    
    /**
	 * This is enabled then the image scrolling is based on a point set on the stage
	 */
    
    private function set_forceMode(value : Bool) : Bool
    {
        _forceMode = value;
        return value;
    }
    
    /**
	 * Return true mode is enabled
	 */
    
    private function get_forceMode() : Bool
    {
        return _forceMode;
    }
	
    /**
	 * Lock the whole panorama from moving
	 */
    
    private function set_lock(value : Bool) : Bool
    {
        _lock = value;
        return value;
    }
    
    /**
	 * Returns true of false if panorama is locked or enabled
	 */
    
    private function get_lock() : Bool
    {
        return _lock;
    }
    
    /**
	 * If false will only move on the x axis
	 */
    
    private function set_enableX(value : Bool) : Bool
    {
        _xLock = value;
        return value;
    }
    
    /**
	 * Return true if the x axis is enabled and false if not
	 */
    
    private function get_enableX() : Bool
    {
        return _xLock;
    }
    
    /**
	 * If false will only move on the y axis
	 */
    
    private function set_enableY(value : Bool) : Bool
    {
        _yLock = value;
        return value;
    }
    
    /**
	 * Return true if the y axis is enabled and false if not
	 */
    
    private function get_enableY() : Bool
    {
        return _yLock;
    }
    
    /**
	 * Set the block spacing which display arrow once over
	 */
    
    private function set_blockSpace(value : Int) : Int
    {
        _blockSpace = value;
        return value;
    }
    
    /**
	 * The block size
	 */
    
    private function get_blockSpace() : Int
    {
        return _blockSpace;
    }
    
    /**
	 * The mode being used, which is 360 and normal mode
	 */
    
    private function get_mode() : String
    {
        return _mode;
    }
    
    /**
	 * Set the display object that will be used
	 */
    
    private function set_source(value : DisplayObject) : DisplayObject
    {
        // Remove old display object
        if (null != _source || null == value) 
        {
            if (null != _source.parent) 
                _source.parent.removeChild(_source);
        }
        
        _source = value;
        
        
        if (value != null) 
            panHolder.addChild(value);
			
        return value;
    }
    
    /**
	 * Return the display object being used
	 */
    
    private function get_source() : DisplayObject
    {
        return _source;
    }
    
    /**
	 * Set a mask to current display object
	 *
	 * @param	maskWidth The width of the mask
	 * @param	maskHeight The height of the mask
	 */
    
    public function setMask(maskWidth : Float, maskHeight : Float) : Void
    {
        if (_mode != MODE_NOMRAL) 
            return;
			
		// The new size of
        _maskWidth = maskWidth;
        _maskHeight = maskHeight;
        
        // If not loaded the flag for later
        if (null == _source) 
            return 
        
        // If there is a mask already then remove it
        if (null != panHolder.getChildByName("slider_mask")) 
            panHolder.removeChild(panHolder.getChildByName("slider_mask"));
			
		// Setup mask 
        var source_mask : Shape = drawRectangle(maskWidth, maskWidth);
        source_mask.name = "source_mask";
        _source.mask = source_mask;
        
        var slider_mask : Shape = drawRectangle(maskWidth, maskWidth);
        slider_mask.name = "slider_mask";
        slider.mask = slider_mask;
        
        //slider.scrollRect = new Rectangle(0, 0, maskWidth, maskHeight);
        
        // Add it to the stage of the holder
        panHolder.addChild(slider_mask);
        
        // Flag mask as ready
        _maskReady = true;
    }
    
    /**
	 * Loads an image file
	 *
	 * @param	fileURL The file that will be used
	 */
    
    public function load(fileURL : String) : Void
    {
        var displayImage : DisplayImage = new DisplayImage();
        
        displayImage.addEventListener(Event.COMPLETE, onPanImageLoad, false, 0, true);
        displayImage.load(fileURL);
    }
    
    /**
	 * This moves the panorama to based on a X and Y location set. To use this set forceMode to true.
	 *
	 * @param	locX The X location of the VR
	 * @param	locY The Y location of the VR
	 *
	 * @see com.media.Panorama.forceMode
	 */
    
    public function setForcePoint(locX : Int, locY : Int) : Void
    {
        _pointX = locX;
        _pointY = locY;
		
        recalculateTargetForPanning();
    }
	
	
	public function setImage( image:BitmapData ) : Void
	{
		var bitmap:Bitmap = new Bitmap(image);
        _source = bitmap;
        
        // Set the mask
        if (!_maskReady && _maskWidth != -1 && _maskHeight != -1) 
            setMask(_maskWidth, _maskHeight);
        
        
        // Remove old display object  
        if (null == _source) 
        {
            if (null != _source.parent) 
                _source.parent.removeChild(_source);
        }
        
        if (_mode == MODE_NOMRAL) 
        {
            panHolder.addChild(_source);
        }
        else if (_mode == MODE_360) 
        {
            // See if item is image first
            if (null != bitmap.bitmapData) 
            {
				img1.graphics.clear();
                img1.graphics.beginBitmapFill(bitmap.bitmapData, null, false, false);
                img1.graphics.drawRect(0, 0, bitmap.bitmapData.width, bitmap.bitmapData.height);
                img1.graphics.endFill();
                
				img2.graphics.clear();
                img2.graphics.beginBitmapFill(bitmap.bitmapData, null, false, false);
                img2.graphics.drawRect(0, 0, bitmap.bitmapData.width, bitmap.bitmapData.height);
                img2.graphics.endFill();
                
				img3.graphics.clear();
                img3.graphics.beginBitmapFill(bitmap.bitmapData, null, false, false);
                img3.graphics.drawRect(0, 0, bitmap.bitmapData.width, bitmap.bitmapData.height);
                img3.graphics.endFill();
            }
        }
        else 
        {
            panHolder.addChild(_source);
        }
		
	}
    
    
    private function onPanImageLoad(event : Event) : Void
    {
        var displayImage : DisplayImage = try cast(event.currentTarget, DisplayImage) catch(e:Dynamic) null;
        
        _source = displayImage;
        
        // Set the mask
        if (!_maskReady && _maskWidth != -1 && _maskHeight != -1) 
            setMask(_maskWidth, _maskHeight);
        
        
        // Remove old display object  
        if (null == _source) 
        {
            if (null != _source.parent) 
                _source.parent.removeChild(_source);
        }
        
        if (_mode == MODE_NOMRAL) 
        {
            panHolder.addChild(_source);
        }
        else if (_mode == MODE_360) 
        {
            // See if item is image first
            if (null != displayImage.image) 
            {
                img1.graphics.beginBitmapFill(displayImage.image, null, false, false);
                img1.graphics.drawRect(0, 0, displayImage.image.width, displayImage.image.height);
                img1.graphics.endFill();
                
                img2.graphics.beginBitmapFill(displayImage.image, null, false, false);
                img2.graphics.drawRect(0, 0, displayImage.image.width, displayImage.image.height);
                img2.graphics.endFill();
                
                img3.graphics.beginBitmapFill(displayImage.image, null, false, false);
                img3.graphics.drawRect(0, 0, displayImage.image.width, displayImage.image.height);
                img3.graphics.endFill();
            }
        }
        else 
        {
            panHolder.addChild(_source);
        }
    }
    
    private function initSlider(velocity : Int,  margin : Int, spacing : Int, mode : String = "normal") : Void
    {
        _velocity = velocity;
        
        _mode = mode;

        
        // Slider for holding image
        slider.name = "slider";
        
        // Mask for VR area
        var vr_mask : Shape = drawRectangle(_width, _height);
        vr_mask.name = "vr_mask";
        mask = vr_mask;
        
        panHolder.name = "panHolder";
        
        // Images use for 360 VR
        img1.name = "image1";
        img2.name = "image2";
        img3.name = "image3";
        
        panHolder.addChild(img1);
        panHolder.addChild(img2);
        panHolder.addChild(img3);
        
        _margin = _blockSpace = margin;
        _spacing = spacing;
        
        left_mc = drawRectangle(_width / 2 - _blockSpace, _height);
        right_mc = drawRectangle(_width / 2 - _blockSpace, _height);
        upper_mc = drawRectangle(_width, _width / 2 - _blockSpace);
        lower_mc = drawRectangle(_width, _width / 2 - _blockSpace);
        
        // Start up timer for slider
        addEventListener(Event.ENTER_FRAME, updateSlider, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
        
        addChild(vr_mask);
        addChild(slider);
        slider.addChild(panHolder);
    }
    
    private function onMouseOver(event : MouseEvent) : Void
    {
        active = true;
    }
    
    private function onMouseOut(event : MouseEvent) : Void
    {
        active = false;
    }
    
    
    private function updateSlider(event : Event) : Void
    {
        
        if (!active && !_forceMode) 
            return;
        
        if (_lock == false) 
        {
            if (_mode.toLowerCase() == MODE_NOMRAL) 
            {
                if (_forceMode) 
                    vrForceMove();
                else 
                    vrMouseMove();
            }
            else if (_mode.toLowerCase() == MODE_360) 
            {
                if (_forceMode) 
                    vrForceMove();
                else 
                    vr360Mode();
            }
            else 
                Debug.print("[Panorama::updateSlider] " + _mode + " is not a mode!");
        }
    }
    
    private function vrMouseMove() : Void
    {
        
        // Most be on stage
        if (null == root) 
            return;
        
        maxUp = 0;
        maxLeft = 0;
        
        if (_maskReady) 
        {
            maxDown = _maskHeight * -1 + _height;
            maxRight = _maskWidth * -1 + _width;
        }
        else 
        {
            maxDown = _source.height * -1 + _height;
            maxRight = _source.width * -1 + _width;
        }
        
        
        if (!_xLock) 
            slider.x = Math.round(slider.x + (root.mouseX - (_width / 2)) / - _lag);
        
        if (!_yLock) 
            slider.y = Math.round(slider.y + (root.mouseY - (_height / 2)) / - _lag);
        
        if (slider.x <= maxRight) 
            slider.x = maxRight;
        
        if (slider.x >= maxLeft) 
            slider.x = maxLeft;
        
        if (slider.y >= maxUp) 
            slider.y = maxUp;
        
        if (slider.y <= maxDown) 
            slider.y = maxDown;
    }
    
    private function vr360Mode() : Void
    {
        // Most be on stage
        if (null == root) 
            return;
        
        
         // Set the  
        maxUp = 0;
        maxDown = img1.height * -1 + _height;
        maxRight = img1.width * -1;
        maxLeft = img1.width;
        
        if (_xLock == false) 
            img1.x = Math.round(img1.x + (slider.mouseX - (_width / 2)) / -_lag);
        
        if (_yLock == false) 
            img1.y = Math.round(img1.y + (slider.mouseY - (_height / 2)) / -_lag);
        
        img2.x = img1.x + img1.width;
        img3.x = img1.x - img1.width;
        img2.y = img1.y;
        img3.y = img1.y;
        
        if (img1.x <= maxRight) 
            img1.x = 2;
        
        if (img1.x >= maxLeft) 
            img1.x = 0;
        
        if (img1.y >= maxUp) 
        {
            img1.y = maxUp;
            img2.y = img1.y;
            img3.y = img1.y;
        }
        
        if (img1.y <= maxDown) 
        {
            img1.y = maxDown;
            img2.y = img1.y;
            img3.y = img1.y;
        }
    }
    
    private function vrForceMove() : Void
    {
        // Most be on stage
        if (null == root || null == _source) 
            return;
        
        var deltaX : Float = (_targetX - _source.x) / _velocity;
        
        if (Math.abs(deltaX) < 0.5) 
        {
            _source.x = _targetX;
        }
        else 
        {
            _source.x += deltaX;
        }
        
        var deltaY : Float = (_targetY - _source.y) / _velocity;
        
        if (Math.abs(deltaY) < 0.5) 
        {
            _source.y = _targetY;
        }
        else 
        {
            _source.y += deltaY;
        }
        
        if (_source.x == _targetX && _source.y == _targetY) 
        {
            _lock = true;
        }
    }
    
    /**
	 * Forces it to snap to the calculated pan point instead of waiting for it to move
	 */
    public function forceSnapToPoint() : Void
    {
        _source.x = _targetX;
        _source.y = _targetY;
        _lock = true;
    }
    
    private function recalculateTargetForPanning() : Void
    {
        forcePoint = _source.localToGlobal(new Point(_pointX, _pointY));
        
        maxUp = 0;
        maxLeft = 0;
		
        if (_maskReady) 
        {
            maxDown = Std.int(_maskHeight * -1 + _height);
            maxRight = Std.int(_maskWidth * -1 + _width);
        }
        else 
        {
            maxDown = Std.int(_source.height * -1 + _height);
            maxRight = Std.int(_source.width * -1 + _width);
        }
        
        if (forcePoint.x < (_width * 0.2)) 
        {
            _lock = false;
            _targetX = Math.min(maxLeft, _source.x + (_width / 2) - forcePoint.x);
        }
        else if (forcePoint.x > (_width * 0.8)) 
        {
            _lock = false;
            _targetX = Math.max(maxRight, _source.x + _width / 2 - forcePoint.x);
        }
        
        if (forcePoint.y < (_height * 0.2)) 
        {
            _lock = false;
            _targetY = Math.min(maxUp, _source.y + (_height / 2) - forcePoint.y);
        }
        else if (forcePoint.y > (_height * 0.8)) 
		{
            _lock = false;
            _targetY = Math.max(maxDown, _source.y + _height / 2 - forcePoint.y);
        }
    }
    
    private function drawRectangle(w : Float, h : Float) : Shape
    {
        var newRect : Shape = new Shape();
        
        newRect.graphics.beginFill(0x000000, 1);
        newRect.graphics.drawRect(0, 0, w, h);
        newRect.graphics.endFill();
        
        return newRect;
    }
}

