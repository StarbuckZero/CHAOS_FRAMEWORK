package com.chaos.ui;


import com.chaos.drawing.icon.ArrowRightIcon;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.media.DisplayImage;
import com.chaos.ui.Overlay;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IMenuItem;
import com.chaos.ui.classInterface.IOverlay;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import openfl.display.Shape;



/**
 * A button that is used for a menu system.
 * @author Erick Feiling
 */

class MenuItem extends ToggleButtonLite implements IMenuItem implements IToggleButton implements IBaseUI
{
    public var open(get, set) : Bool;
    public var hasParent(get, set) : Bool;
    public var hasChildren(get, set) : Bool;
    public var parentMenuItem(get, set) : com.chaos.ui.classInterface.IMenuItem;
    public var useMask(get, set) : Bool;
    public var menuDefaultColor(get, set) : Int;
    public var menuOverColor(get, set) : Int;
    public var menuDownColor(get, set) : Int;
    public var menuDisableColor(get, set) : Int;
    public var normalBorderColor(get, set) : Int;
    public var overBorderColor(get, set) : Int;
    public var downBorderColor(get, set) : Int;
    public var disableBorderColor(get, set) : Int;
    public var fillAlpha(get, set) : Float;
    public var lineAlpha(get, set) : Float;
    public var textColor(get, set) : Int;
    public var textOverColor(get, set) : Int;
    public var textSelectedColor(get, set) : Int;
    public var textDisableColor(get, set) : Int;
    public var showIcon(get, set) : Bool;
    public var border(get, set) : Bool;
    public var borderThinkness(get, set) : Float;
    public var showSubMenuIcon(get, set) : Bool;
    public var smoothImage(get, set) : Bool;

    /** The type of UI Element */
    public static inline var TYPE : String = "MenuItem";
    
    /** The offset of the icon from the upper left */
    public static var ICON_OFFSETX : Int = 2;
    
    /** The offset of the icon from the upper left */
    public static var ICON_OFFSETY : Int = 0;
    
    private static inline var DEFAULT_WIDTH : Float = 20;
    private static inline var DEFAULT_HEIGHT : Float = 20;
    
    //private var _baseNormal : Shape = new Shape();
    //private var _baseOver : Shape = new Shape();
    //private var _baseDown : Shape = new Shape();
    //private var _baseDisable : Shape = new Shape();
    
    private var _normalDisplayImage : DisplayImage = new DisplayImage();
    private var _overDisplayImage : DisplayImage = new DisplayImage();
    private var _downDisplayImage : DisplayImage = new DisplayImage();
    private var _disableDisplayImage : DisplayImage = new DisplayImage();
    
    private var _overlay : com.chaos.ui.classInterface.IOverlay = new Overlay();
    
    private var _smoothImage : Bool = true;
    private var _showImage : Bool = true;
    
    private var _normalFillColor : Int = 0xFFFFFF;
    private var _overFillColor : Int = 0x666666;
    private var _downFillColor : Int = 0x999999;
    private var _disableFillColor : Int = 0xFFFFFF;
    
    private var _normalLineColor : Int = 0x000000;
    private var _overLineColor : Int = 0x666666;
    private var _downLineColor : Int = 0x000000;
    private var _disableLineColor : Int = 0xCCCCCC;
    
    private var _textColor : Int = 0x000000;
    private var _textOverColor : Int = 0xFFFFFF;
    private var _textSelectedColor : Int = 0x999999;
    private var _textDisableColor : Int = 0xCCCCCC;
    
    private var _showSubMenuIcon : Bool = false;
    private var _label : com.chaos.ui.classInterface.ILabel = new Label("Text");
    
    private var _subMenuIconHolder : Sprite = new Sprite();
    private var _subMenuIcon : com.chaos.drawing.icon.classInterface.IBasicIcon = new ArrowRightIcon(5, 5);
    private var _icon : DisplayImage = new DisplayImage();
    private var _subMenuDisplayImage : DisplayImage = new DisplayImage();
    
    private var _border : Bool = false;
    private var _thinkness : Float = 1;
    private var _useMask : Bool = false;
    
    private var _alpha : Float = 1;
    private var _lineAlpha : Float = 1;
    
    private var _width : Float = 100;
    private var _height : Float = 20;
    
    private var _showIcon : Bool = false;
    
    private var _hasChildren : Bool = false;
    private var _hasParent : Bool = false;
    
    private var _parentMenuItem : com.chaos.ui.classInterface.IMenuItem;
    
    private var _open : Bool = false;
    
    /**
		 * A display object that is used for the menu system.
		 */
    
    public function new(text : String, width : Float = 100, height : Float = 20, icon : DisplayImage = null, subMenuIcon : DisplayImage = null)
    {
        super();
        
        _label.text = text;
        _width = width;
        _height = height;
        
        if (null != icon) 
            _icon = icon;
        
        if (null != subMenuIcon) 
            _subMenuDisplayImage = subMenuIcon;
        
        if (null != _icon || null != _subMenuDisplayImage) 
            _showImage = true;
        
        init();
        
        mouseChildren = false;
    }
    
    private function init() : Void
    {
        setNormalState(_baseNormal);
        setOverState(_baseOver);
        setDownState(_baseDown);
        setDisableState(_baseDisable);
        
        addChild(_label.displayObject);
        addChild(_icon.displayObject);
        addChild(_subMenuIconHolder);
        addChild(_overlay.displayObject);
        
        addEventListener(MouseEvent.MOUSE_OVER, onMenuOver, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, onMenuOut, false, 0, true);
        addEventListener(MouseEvent.CLICK, onMenuClick, false, 0, true);
        
        _subMenuIconHolder.addChild(_subMenuIcon.displayObject);
        
        _subMenuIcon.filterMode = false;
        _subMenuIcon.baseColor = _subMenuIcon.borderColor = 0;
        
        draw();
    }
    
	#if flash @:getter(width) #else override #end
    private function get_width() : Float
    {
        return _width;
    }
	
    #if flash @:getter(width) #else override #end
    private function set_width(value : Float) : Float
    {
        _width = value;
        draw();
        return value;
    }
	
    #if flash @:getter(width) #else override #end
    private function get_height() : Float
    {
        return _height;
    }
	
    #if flash @:getter(width) #else override #end
    private function set_height(value : Float) : Float
    {
        _height = value;
        draw();
        return value;
    }
    
    /**
	 * Set the menu to being open or closed on roll over
	 */
    private function set_open(value : Bool) : Bool
    {
        _open = value;
        return value;
    }
    
    /**
	 * Return true if open and false if closed
	 */
    private function get_open() : Bool
    {
        return _open;
    }
    
    /**
	 * Set the button has a parent
	 */
    private function set_hasParent(value : Bool) : Bool
    {
        _hasParent = value;
        return value;
    }
    
    /**
	 * Return true if has parent button and false if not
	 */
    
    private function get_hasParent() : Bool
    {
        return _hasParent;
    }
    
    /**
	 * Set the button has a sub menu
	 */
    private function set_hasChildren(value : Bool) : Bool
    {
        _hasChildren = value;
        return value;
    }
    
    /**
	 * Return true if has sub menu and false if not
	 */
    private function get_hasChildren() : Bool
    {
        return _hasChildren;
    }
    
    /**
	 * Set the parent menu
	 */
    
    private function set_parentMenuItem(value : IMenuItem) : IMenuItem
    {
        _parentMenuItem = value;
        return value;
    }
    
    /**
	 *  Return parent menu button
	 */
    
    private function get_parentMenuItem() : IMenuItem
    {
        return _parentMenuItem;
    }
    
    override private function set_enabled(value : Bool) : Bool
    {
        if (value) 
        {
            _label.textColor = _textColor;
        }
        else 
        {
            _label.textColor = _textDisableColor;
        }
        
        super.enabled = value;
        return value;
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
	 * Set the default menu icon color
	 */
    
    private function set_menuDefaultColor(value : Int) : Int
    {
        _normalFillColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuDefaultColor() : Int
    {
        return _normalFillColor;
    }
    
    /**
	 * Set the over menu icon color
	 */
    
    private function set_menuOverColor(value : Int) : Int
    {
        _overFillColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuOverColor() : Int
    {
        return _overFillColor;
    }
    
    /**
	 * Set the down menu icon color
	 */
    
    private function set_menuDownColor(value : Int) : Int
    {
        _downFillColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuDownColor() : Int
    {
        return _downFillColor;
    }
    
    /**
	 * Set the disable menu icon color
	 */
    
    private function set_menuDisableColor(value : Int) : Int
    {
        _disableFillColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuDisableColor() : Int
    {
        return _disableFillColor;
    }
    
    /**
	 * Border color for normal button state
	 */
    
    private function set_normalBorderColor(value : Int) : Int
    {
        _normalLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    private function get_normalBorderColor() : Int
    {
        return _normalLineColor;
    }
    
    /**
	 * Border color for over button state
	 */
    
    private function set_overBorderColor(value : Int) : Int
    {
        _overLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_overBorderColor() : Int
    {
        return _overLineColor;
    }
    
    /**
	 * Border color for down button state
	 */
    
    private function set_downBorderColor(value : Int) : Int
    {
        _downLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
	
    private function get_downBorderColor() : Int
    {
        return _downLineColor;
    }
    
    /**
	 * Border color for disable button state
	 */
    
    private function set_disableBorderColor(value : Int) : Int
    {
        _disableLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
	
    private function get_disableBorderColor() : Int
    {
        return _disableLineColor;
    }
    
    /**
	 * Set the inner menu button alpha
	 */
	
    private function set_fillAlpha(value : Float) : Float
    {
        _alpha = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return alpha
	 */
	
    private function get_fillAlpha() : Float
    {
        return _alpha;
    }
    
    /**
	 * Set the border menu button alpha
	 */
	
    private function set_lineAlpha(value : Float) : Float
    {
        _lineAlpha = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return alpha
	 */
	
    private function get_lineAlpha() : Float
    {
        return _lineAlpha;
    }
    
    /**
	 * Set the label text color
	 */
	
    private function set_textColor(value : Int) : Int
    {
        _textColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textColor() : Int
    {
        return _textColor;
    }
    
    /**
	 * Set the label over state color
	 */
    private function set_textOverColor(value : Int) : Int
    {
        _textOverColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textOverColor() : Int
    {
        return _textOverColor;
    }
    
    /**
	 * Set the label selected state
	 */
    
    private function set_textSelectedColor(value : Int) : Int
    {
        _textSelectedColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
	
    private function get_textSelectedColor() : Int
    {
        return _textSelectedColor;
    }
    
    /**
	 * Set the label disable color
	 */
    
    private function set_textDisableColor(value : Int) : Int
    {
        _textDisableColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textDisableColor() : Int
    {
        return _textDisableColor;
    }
    
    /**
	 * Set the menu button icon
	 */
    
    private function set_showIcon(value : Bool) : Bool
    {
        _showIcon = value;
        draw();
        return value;
    }
    
    /**
	 * True if the icon is being displayed and false if not
	 */
    
    private function get_showIcon() : Bool
    {
        return _showIcon;
    }
    
    /**
	 * Show or hide border around button
	 */
    
    private function set_border(value : Bool) : Bool
    {
        _border = value;
        draw();
        return value;
    }
    
    /**
	 * Return true if border is being shown and false if not
	 */
	
    private function get_border() : Bool
    {
        return _border;
    }
    
    /**
	 * Border thinkness
	 */
	
    private function set_borderThinkness(value : Float) : Float
    {
        _thinkness = value;
        return value;
    }
    
    /**
	 * Return thinkness
	 */
    
    private function get_borderThinkness() : Float
    {
        return _thinkness;
    }
    
    /**
	 * Show or hide the Sub menu icon
	 */
    
    private function set_showSubMenuIcon(value : Bool) : Bool
    {
        _showSubMenuIcon = value;
        draw();
        return value;
    }
    
    /**
	 * If true sub menu icon is being displayed and false if not.
	 */
	
    private function get_showSubMenuIcon() : Bool
    {
        return _showSubMenuIcon;
    }
    
    override private function get_detail() : String
    {
        return super.detail;
    }
    
    override private function set_detail(value : String) : String
    {
        super.detail = _label.detail = _icon.detail = _subMenuIcon.detail = value;
        return value;
    }
    
    /**
	 * Turn on and off image smoothing
	 */
    
    private function set_smoothImage(value : Bool) : Bool
    {
        _smoothImage = value;
        return value;
    }
    
    /**
	 * Return true if smoothing is on and false if not
	 */
	
    private function get_smoothImage() : Bool
    {
        return _smoothImage;
    }
    
    /**
	 * Set the icon that will be used based on a URL location.
	 * @param	strImage The path to the file that will be used.
	 */
    
    public function setIconURL(strImage : String) : Void
    {
        _icon.onImageComplete = function() : Void
                {
                    _icon.onImageComplete = null;
                    draw();
                };
        
        _icon.load(strImage);
    }
    
    /**
	 * Set the icon that will be used using a bitmap image
	 * @param	bitmap The bitmap that will be used
	 */
    
    public function setIconBitmap(bitmap : Bitmap) : Void
    {
        _icon.setImage(bitmap);
        draw();
    }
    
    /**
	 * Return the icon that is being used for the set menu.
	 * @return Return an icon interface
	 */
    
    public function getSubMenuIcon() : IBasicIcon
    {
        return _subMenuIcon;
    }
    
    /**
	 * Set a new icon to the button menu.
	 *
	 * @param	newIcon The new display icon
	 */
    
    public function setSubMenuIcon(newIcon : IBasicIcon) : Void
    {
        if (_subMenuIcon.parent != null) 
            _subMenuIconHolder.removeChild(_subMenuIcon.displayObject);
        
        _subMenuIcon = newIcon;
        _subMenuIconHolder.addChild(_subMenuIcon.displayObject);
    }
    
    /**
	 * The file location of the image that will be used.
	 *
	 * @param	fileURL The file location
	 */
    
    public function setSubMenuURL(fileURL : String) : Void
    {
        
        _subMenuDisplayImage.onImageComplete = function() : Void
                {
                    _subMenuDisplayImage.onImageComplete = null;
                    draw();
                };
        
        _subMenuDisplayImage.load(fileURL);
        
        // Remove old icon out of display list
        if (_subMenuIcon.parent != null) 
            _subMenuIconHolder.removeChild(_subMenuIcon.displayObject);
        
        _subMenuIconHolder.addChild(_subMenuDisplayImage);
    }
    
    /**
	 * The bitmap that be used for an icon
	 * @param	bitmap The bitmap that will be used.
	 */
    
    public function setSubMenuBitmap(bitmap : Bitmap) : Void
    {
        
        _subMenuDisplayImage.setImage(bitmap);
        
        // Remove old icon out of display list
        if (_subMenuIcon.parent != null) 
            _subMenuIconHolder.removeChild(_subMenuIcon.displayObject);
        
        _subMenuIconHolder.addChild(_subMenuDisplayImage);
    }
    
    /**
	 * The overlay that is being used for the button. This is for masking the bottom button layer shape.
	 *
	 * @return An Overlay interface interface
	 */
    
    public function getOvery() : IOverlay
    {
        return _overlay;
    }
    
    /**
	 * Return the label being used
	 *
	 * @return An interface
	 */
    
    public function getLabel() : ILabel
    {
        return _label;
    }
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    public function setDefaultStateURL(strImage : String) : Void
    {
        _normalDisplayImage.onImageComplete = function() : Void
                {
                    _normalDisplayImage.onImageComplete = null;
                    draw();
                };
        
        _normalDisplayImage.load(strImage);
    }
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
	
    public function setDefaultStateBitmap(bitmap : Bitmap) : Void
    {
        _normalDisplayImage.setImage(bitmap);
    }
    
    /**
		 * Set the state based on the URL location.
		 * @param	strImage The path to the file that will be used
		 */
    
    public function setOverStateURL(strImage : String) : Void
    {
        _overDisplayImage.load(strImage);
    }
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    public function setOverStateBitmap(bitmap : Bitmap) : Void
    {
        _overDisplayImage.setImage(bitmap);
    }
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    public function setDownStateURL(strImage : String) : Void
    {
        _downDisplayImage.load(strImage);
    }
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    public function setDownStateBitmap(bitmap : Bitmap) : Void
    {
        _downDisplayImage.setImage(bitmap);
    }
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    public function setDisableStateURL(strImage : String) : Void
    {
        _disableDisplayImage.load(strImage);
    }
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    public function setDisableStateBitmap(bitmap : Bitmap) : Void
    {
        _disableDisplayImage.setImage(bitmap);
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        _baseNormal.graphics.clear();
        _baseOver.graphics.clear();
        _baseDown.graphics.clear();
        _baseDisable.graphics.clear();
        
        if (_border) 
		{
			_baseNormal.graphics.lineStyle(_thinkness, _normalLineColor, _lineAlpha);
			_baseOver.graphics.lineStyle(_thinkness, _overLineColor, _lineAlpha);
			_baseDown.graphics.lineStyle(_thinkness, _downLineColor, _lineAlpha);
			_baseDisable.graphics.lineStyle(_thinkness, _disableLineColor, _lineAlpha);
		}
		
		(_normalDisplayImage.image != null && _showImage) ? _baseNormal.graphics.beginBitmapFill(_normalDisplayImage.image.bitmapData, null, true, _smoothImage) : _baseNormal.graphics.beginFill(_normalFillColor, _alpha);
		
		// Draw square 
        _baseNormal.graphics.drawRect(0, 0, _width, _height);
        _baseNormal.graphics.endFill();
        
        (_overDisplayImage.image != null && _showImage) ? _baseOver.graphics.beginBitmapFill(_overDisplayImage.image.bitmapData, null, true, _smoothImage) : _baseOver.graphics.beginFill(_overFillColor, _alpha);
        _baseOver.graphics.drawRect(0, 0, _width, _height);
        _baseOver.graphics.endFill();
        
        (_downDisplayImage.image != null && _showImage) ? _baseDown.graphics.beginBitmapFill(_downDisplayImage.image.bitmapData, null, true, _smoothImage) : _baseDown.graphics.beginFill(_downFillColor, _alpha);
        _baseDown.graphics.drawRect(0, 0, _width, _height);
        _baseDown.graphics.endFill();
        
        (_disableDisplayImage.image != null && _showImage) ? _baseDisable.graphics.beginBitmapFill(_disableDisplayImage.image.bitmapData, null, true, _smoothImage) : _baseDisable.graphics.beginFill(_disableFillColor, _alpha);
        _baseDisable.graphics.drawRect(0, 0, _width, _height);
        _baseDisable.graphics.endFill();
        
        // Show icon
        _subMenuIconHolder.visible = _showSubMenuIcon;
        
        _subMenuIconHolder.y = (height / 2) - (_subMenuIconHolder.height / 2);
        _subMenuIconHolder.x = width - _subMenuIconHolder.width - 5;
        
        // Hide or show icon
        _icon.visible = _showIcon;
        
        if (_showIcon) 
        {
            _icon.x = ICON_OFFSETX;
            _icon.y = (height / 2) - (_icon.height / 2) + ICON_OFFSETY;
            
            _label.width = width - _icon.width;
        }
        else 
        {
            _label.width = width;
        }
        
        _label.height = height;
    }
    
    private function onMenuOver(event : MouseEvent) : Void
    {
        if (enabled) 
            _label.textColor = _textOverColor;
    }
    
    private function onMenuOut(event : MouseEvent) : Void
    {
        if (enabled) 
            onMenuClick(event);
    }
    
    private function onMenuClick(event : MouseEvent) : Void
    {
        if (selected) 
        {
            
            _label.textColor = _textSelectedColor;
        }
        else 
        {
            _label.textColor = _textColor;
        }
    }
    
    private function applyContentMask() : Void
    {
        //toggleButton.addChild(_overlay.overlayMask);
        //toggleButton.mask = _overlay.overlayMask;
        
    }
    
    private function removeContentMask() : Void
    {
        toggleButton.mask = null;
    }
}

