package com.chaos.ui;

import com.chaos.ui.MenuItem;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IMenu;
import com.chaos.ui.classInterface.IMenuItem;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IFitContainer;
import openfl.display.BitmapData;

import com.chaos.data.DataProvider;
import com.chaos.media.DisplayImage;
import com.chaos.ui.data.MenuItemObjectData;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.FitContainer;
import com.chaos.ui.event.MenuEvent;

import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;


/**
	 * Creates an menu system
	 * 
	 * @author Erick Feiling
	 */

class Menu extends BaseContainer implements IBaseContainer implements IMenu implements IBaseUI
{
    public var buttonContainer(get, never) : IFitContainer;
    public var reverse(get, set) : Bool;
    public var menuDefaultColor(get, set) : Int;
    public var menuSubDefaultColor(get, set) : Int;
    public var menuOverColor(get, set) : Int;
    public var menuSubOverColor(get, set) : Int;
    public var menuDownColor(get, set) : Int;
    public var menuSubDownColor(get, set) : Int;
    public var menuDisableColor(get, set) : Int;
    public var menuSubDisableColor(get, set) : Int;
    public var normalBorderColor(get, set) : Int;
    public var normalSubBorderColor(get, set) : Int;
    public var overBorderColor(get, set) : Int;
    public var overSubBorderColor(get, set) : Int;
    public var downBorderColor(get, set) : Int;
    public var downSubBorderColor(get, set) : Int;
    public var disableBorderColor(get, set) : Int;
    public var disableSubBorderColor(get, set) : Int;
    public var fillAlpha(get, set) : Float;
    public var subAlpha(get, set) : Float;
    public var lineAlpha(get, set) : Float;
    public var subLineAlpha(get, set) : Float;
    public var textColor(get, set) : Int;
    public var subTextColor(get, set) : Int;
    public var textOverColor(get, set) : Int;
    public var textSubOverColor(get, set) : Int;
    public var textSelectedColor(get, set) : Int;
    public var textSubSelectedColor(get, set) : Int;
    public var textDisableColor(get, set) : Int;
    public var textSubDisableColor(get, set) : Int;
    public var borderThinkness(get, set) : Float;
    public var subBorderThinkness(get, set) : Float;
    public var smoothImage(get, set) : Bool;
    public var showSubMenuIcon(get, set) : Bool;

    
    /** The type of UI Element */
    public static inline var TYPE : String = "Menu";
    
    /** Use this to turn the on x axis  */
    public static inline var HORIZONTAL : String = "horizontal";  // Left to Right  
    
    /** Use this to turn the on y axis  */
    public static inline var VERTICAL : String = "vertical";  // Up and Down  
    
    private var _list : DataProvider<MenuItemObjectData> = new DataProvider<MenuItemObjectData>();  // Main list  
    
    //NOTE: Build out something for overlay layer in buttons
    //private var _smoothImage : Bool = true;
    
    private var _normalDisplayImage : BitmapData;
    private var _overDisplayImage : BitmapData;
    private var _downDisplayImage : BitmapData;
    private var _disableDisplayImage : BitmapData;
    
    private var _normalSubDisplayImage : BitmapData;
    private var _overSubDisplayImage : BitmapData;
    private var _downSubDisplayImage : BitmapData;
    private var _disableSubDisplayImage : BitmapData;
    
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
    
    private var _subMenuDefaultColor : Int = 0xFFFFFF;
    private var _subMenuOverColor : Int = 0xCCCCCC;
    private var _subMenuDownColor : Int = 0x666666;
    private var _subMenuDisableColor : Int = 0x000000;
    
    private var _subNormalLineColor : Int = 0xFFFFFF;
    private var _subOverLineColor : Int = 0x666666;
    private var _subDownLineColor : Int = 0x000000;
    private var _subDisableLineColor : Int = 0xCCCCCC;
    
    private var _subTextColor : Int = 0x000000;
    private var _subTextOverColor : Int = 0xFFFFFF;
    private var _subTextSelectedColor : Int = 0x999999;
    private var _subTextDisableColor : Int = 0xCCCCCC;
    
    private var _border : Bool = false;
    private var _thinkness : Float = 1;
    
    private var _subBorder : Bool = false;
    private var _subThinkness : Float = 1;
    
    private var _useMask : Bool = false;
    
    private var _showSubMenuIcon : Bool = false;
    
    private var _icon : BitmapData;
    private var _subIcon : BitmapData;
    
    private var _subMenuDisplayImage : BitmapData;
    
    private var _alpha : Float = 1;
    private var _lineAlpha : Float = 1;
    
    private var _subAlpha : Float = 1;
    private var _subLineAlpha : Float = 1;
    
    private var _buttonWidth : Float = 100;
    private var _buttonHeight : Float = 20;
    
    private var buttonArea : FitContainer = new FitContainer();
    private var subButtonArea : Sprite = new Sprite();
    private var menuLevel : Int = 0;
    
    private var _reverse : Bool = false;
    
    private var oldMenuButton : IMenuItem;
    
    /**
	 * Creates a menu based on a list of MenuItemObjectData
	 * @param	menuList A list of menu items that will be created. The first level is the only thing that will be create at first.
	 * @param	direction The direction the menu is going to be going which is either horizontal or vertical
	 * 
	 * @example var menu = new Menu(menuDataList, Menu.HORIZONTAL)
	 */
    
    public function new(menuWidth : Int = 100, menuHeight : Int = 100, menuList : DataProvider<MenuItemObjectData> = null, direction : String = "horizontal")
    {
        super();
		
		
        if (null != menuList) 
            _list = menuList;
			
        
        buttonArea.direction = direction;
        
        width = menuWidth;
        height = menuHeight;
        
        reskin();
        
        init();
        build();
    }
	
    override public function reskin() : Void
    {
        super.reskin();
        
        // Set style
        initStyle();
        initBitmap();
        
        draw();
    }
    
    private function initStyle() : Void
    {
        
        // Background
        if (UIStyleManager.MENU_BACKGROUND_COLOR != -1) 
            backgroundColor = UIStyleManager.MENU_BACKGROUND_COLOR;
        
        if (UIStyleManager.MENU_BACKGROUND_ALPHA != -1) 
            backgroundAlpha = UIStyleManager.MENU_BACKGROUND_ALPHA;  
        
        // Button Color 
        if (UIStyleManager.MENU_NORMAL_COLOR != -1) 
            _normalFillColor = UIStyleManager.MENU_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_OVER_COLOR != -1) 
            _overFillColor = UIStyleManager.MENU_OVER_COLOR;
        
        if (UIStyleManager.MENU_DISABLE_COLOR != -1) 
            _disableFillColor = UIStyleManager.MENU_DISABLE_COLOR;
        
        if (UIStyleManager.MENU_DOWN_COLOR != -1) 
            _downFillColor = UIStyleManager.MENU_DOWN_COLOR;
        
        
          // Button Border
        if (UIStyleManager.MENU_BORDER_NORMAL_COLOR != -1) 
            _normalLineColor = UIStyleManager.MENU_BORDER_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_BORDER_OVER_COLOR != -1) 
            _overLineColor = UIStyleManager.MENU_BORDER_OVER_COLOR;
        
        if (UIStyleManager.MENU_BORDER_DOWN_COLOR != -1) 
            _downLineColor = UIStyleManager.MENU_BORDER_DOWN_COLOR;
        
        if (UIStyleManager.MENU_BORDER_DISABLE_COLOR != -1) 
            _disableLineColor = UIStyleManager.MENU_BORDER_DISABLE_COLOR;
        
        if (UIStyleManager.MENU_BORDER_ALPHA != -1) 
            _lineAlpha = UIStyleManager.MENU_BORDER_ALPHA;
        
        if (UIStyleManager.MENU_BORDER_THINKNESS != -1) 
            _thinkness = UIStyleManager.MENU_BORDER_THINKNESS;
        
        _border = UIStyleManager.MENU_BORDER;
        
        // Button Text
        if (UIStyleManager.MENU_LABEL_TEXT_NORMAL_COLOR != -1) 
            _textColor = UIStyleManager.MENU_LABEL_TEXT_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_LABEL_TEXT_OVER_COLOR != -1) 
            _textOverColor = UIStyleManager.MENU_LABEL_TEXT_OVER_COLOR;
        
        if (UIStyleManager.MENU_LABEL_TEXT_DOWN_COLOR != -1) 
            _textSelectedColor = UIStyleManager.MENU_LABEL_TEXT_DOWN_COLOR;
        
        if (UIStyleManager.MENU_LABEL_TEXT_DISABLE_COLOR != -1) 
            _textDisableColor = UIStyleManager.MENU_LABEL_TEXT_DISABLE_COLOR;
        
        
        
          // Sub Menu
        if (UIStyleManager.MENU_SUB_NORMAL_COLOR != -1) 
            _subMenuDefaultColor = UIStyleManager.MENU_SUB_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_SUB_OVER_COLOR != -1) 
            _subMenuOverColor = UIStyleManager.MENU_SUB_OVER_COLOR;
        
        if (UIStyleManager.MENU_SUB_DISABLE_COLOR != -1) 
            _subMenuDisableColor = UIStyleManager.MENU_SUB_DISABLE_COLOR;
        
        if (UIStyleManager.MENU_SUB_DOWN_COLOR != -1) 
            _subMenuDownColor = UIStyleManager.MENU_SUB_DOWN_COLOR;
        
        
         // Button Border
        if (UIStyleManager.MENU_SUB_BORDER_NORMAL_COLOR != -1) 
            _normalLineColor = UIStyleManager.MENU_SUB_BORDER_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_SUB_BORDER_OVER_COLOR != -1) 
            _overLineColor = UIStyleManager.MENU_SUB_BORDER_OVER_COLOR;
        
        if (UIStyleManager.MENU_SUB_BORDER_DOWN_COLOR != -1) 
            _downLineColor = UIStyleManager.MENU_SUB_BORDER_DOWN_COLOR;
        
        if (UIStyleManager.MENU_SUB_BORDER_DISABLE_COLOR != -1) 
            _disableLineColor = UIStyleManager.MENU_SUB_BORDER_DISABLE_COLOR;
        
        if (UIStyleManager.MENU_SUB_BORDER_ALPHA != -1) 
            _lineAlpha = UIStyleManager.MENU_BORDER_ALPHA;
        
        if (UIStyleManager.MENU_SUB_BORDER_THINKNESS != -1) 
            _subThinkness = UIStyleManager.MENU_SUB_BORDER_THINKNESS;
        
        _subBorder = UIStyleManager.MENU_SUB_BORDER;
        
        // Sub Menu Text
        if (UIStyleManager.MENU_SUB_LABEL_TEXT_NORMAL_COLOR != -1) 
            _textColor = UIStyleManager.MENU_SUB_LABEL_TEXT_NORMAL_COLOR;
        
        if (UIStyleManager.MENU_SUB_LABEL_TEXT_OVER_COLOR != -1) 
            _textOverColor = UIStyleManager.MENU_SUB_LABEL_TEXT_OVER_COLOR;
        
        if (UIStyleManager.MENU_SUB_LABEL_TEXT_DOWN_COLOR != -1) 
            _textSelectedColor = UIStyleManager.MENU_SUB_LABEL_TEXT_DOWN_COLOR;
        
        if (UIStyleManager.MENU_SUB_LABEL_TEXT_DISABLE_COLOR != -1) 
            _textDisableColor = UIStyleManager.MENU_SUB_LABEL_TEXT_DISABLE_COLOR;
    }
    
    private function initBitmap() : Void
    {
        // Menu Background
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BACKGROUND)) 
            setBackgroundImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BACKGROUND));
        
        
          // UI Skinning
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_NORMAL)) 
            setDefaultStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_OVER)) 
            setOverStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_OVER));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_DOWN)) 
            setDownStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_DOWN));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_DISABLE)) 
            setDisableStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_DISABLE));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_ICON)) 
            setIcon(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_ICON));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_SUB_MENU_DROPDOWN)) 
            setSubMenuDropDownIconImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_BUTTON_SUB_MENU_DROPDOWN));
        
        
          // UI Sub Menu Skinning
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_NORMAL)) 
            setSubDefaultStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_OVER)) 
            setSubOverStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_OVER));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_DOWN)) 
            setSubDownStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_DOWN));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_DISABLE)) 
            setSubDisableStateImage(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_DISABLE));
        
        if (null != UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_ICON)) 
            setSubIcon(UIBitmapManager.getUIElement(Menu.TYPE, UIBitmapManager.MENU_SUB_BUTTON_ICON));
    }
    
    private function init() : Void
    {
        
        // Make it so you can see drop down button
        buttonArea.clipping = false;
        contentObject.addChild(subButtonArea);
        contentObject.addChild(buttonArea.displayObject);
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
	#if flash @:setter(width) 
    override private function set_width(value : Float) : Void
    {
        _width = buttonArea.width = value;
    }
    #else
    override private function set_width(value : Float) : Float
    {
		
        _width = buttonArea.width = value;
        return value;
    }
	#end
	
	#if flash @:setter(height) 
    override private function set_height(value : Float) : Void
    {
        _height = buttonArea.height = value;
    }
	#else
    override private function set_height(value : Float) : Float
    {
        _height = buttonArea.height = value;
        return value;
    }	
    #end
	
    
    /**
	 * Return a container with the menu top level buttons
	 */
    
    private function get_buttonContainer() : IFitContainer
    {
        return buttonArea;
    }
    
    
    /**
	 * Flip what side the drop down menu is done.
	 */
    
    private function set_reverse(value : Bool) : Bool
    {
        _reverse = value;
        return value;
    }
    
    /**
	 * Return if the sub menu button will be created on the other side of the menu
	 */
    
    private function get_reverse() : Bool
    {
        return _reverse;
    }
    
    /**
	 * Set the default menu color
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
	 * Set the default sub menu color
	 */
    
    private function set_menuSubDefaultColor(value : Int) : Int
    {
        _subMenuDefaultColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuSubDefaultColor() : Int
    {
        return _subMenuDefaultColor;
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
	 * Set the over sub menu color
	 */
	
    private function set_menuSubOverColor(value : Int) : Int
    {
        _subMenuOverColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuSubOverColor() : Int
    {
        return _subMenuOverColor;
    }
    
    /**
	 * Set the down menu color
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
	 * Set the down sub menu color
	 */
    
    private function set_menuSubDownColor(value : Int) : Int
    {
        _subMenuDownColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuSubDownColor() : Int
    {
        return _subMenuDownColor;
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
	 * Set the disable sub menu color
	 */
    
    private function set_menuSubDisableColor(value : Int) : Int
    {
        _subMenuDisableColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_menuSubDisableColor() : Int
    {
        return _subMenuDisableColor;
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
	 * Border color for sub normal button state
	 */
    
    private function set_normalSubBorderColor(value : Int) : Int
    {
        _subNormalLineColor = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_normalSubBorderColor() : Int
    {
        return _subNormalLineColor;
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
	 * Border color for over sub button state 
	 */
    
    private function set_overSubBorderColor(value : Int) : Int
    {
        _subOverLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_overSubBorderColor() : Int
    {
        return _subOverLineColor;
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
	 * Border color for down sub button state 
	 */
	
    private function set_downSubBorderColor(value : Int) : Int
    {
        _subDownLineColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
	
    private function get_downSubBorderColor() : Int
    {
        return _subDownLineColor;
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
	 * Border color for disable sub button state 
	 */
    
    private function set_disableSubBorderColor(value : Int) : Int
    {
        _subDisableLineColor = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return the color
	 */
	
    private function get_disableSubBorderColor() : Int
    {
        return _subDisableLineColor;
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
	 * Set the inner menu sub button alpha
	 */
    
    private function set_subAlpha(value : Float) : Float
    {
        _subAlpha = value;
        draw();
        return value;
    }
    
    /**
	 * Return alpha
	 */
    
    private function get_subAlpha() : Float
    {
        return _subAlpha;
    }
    
    /**
	 * Set the border menu button alpha
	 */
	
    private function set_lineAlpha(value : Float) : Float
    {
        _alpha = value;
        draw();
        return value;
    }
    
    /**
	 * Return alpha
	 */
    
    private function get_lineAlpha() : Float
    {
        return _alpha;
    }
    
    /**
	 * Set the border sub menu button alpha
	 */
	
    private function set_subLineAlpha(value : Float) : Float
    {
        _subLineAlpha = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return alpha
	 */
    
    private function get_subLineAlpha() : Float
    {
        return _subLineAlpha;
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
	 * Set the sub label text color
	 */
    
    private function set_subTextColor(value : Int) : Int
    {
        _subTextColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_subTextColor() : Int
    {
        return _subTextColor;
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
	 * Set the sub label over state color
	 */
    
    private function set_textSubOverColor(value : Int) : Int
    {
        _subTextOverColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textSubOverColor() : Int
    {
        return _subTextOverColor;
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
	 * Set the label selected state
	 */
    
    private function set_textSubSelectedColor(value : Int) : Int
    {
        _subTextSelectedColor = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textSubSelectedColor() : Int
    {
        return _subTextSelectedColor;
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
	 * Set the sub button label disable color
	 */
    
    private function set_textSubDisableColor(value : Int) : Int
    {
        _subTextDisableColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_textSubDisableColor() : Int
    {
        return _subTextDisableColor;
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
	 * Return thinkness
	 */
    
    private function get_borderThinkness() : Float
    {
        return _thinkness;
    }
    
    /**
	 * Border thinkness
	 */
    
    private function set_subBorderThinkness(value : Float) : Float
    {
        _subThinkness = value;
        draw();
		
        return value;
    }
    
    /**
	 * Return thinkness
	 */
    
    private function get_subBorderThinkness() : Float
    {
        return _subThinkness;
    }
    

    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
	
    public function setDefaultStateImage(value : BitmapData) : Void
    {
        _normalDisplayImage = value;
    }
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
	
    public function setSubDefaultStateImage(value : BitmapData) : Void
    {
        _normalSubDisplayImage = value;
    }
    

    
    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setOverStateImage(value : BitmapData) : Void
    {
        _overDisplayImage = value;
    }
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setSubOverStateImage(value : BitmapData) : Void
    {
        _overSubDisplayImage = value;
    }
    
    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setDownStateImage(value : BitmapData) : Void
    {
        _downDisplayImage = value;
    }
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setSubDownStateImage(value : BitmapData) : Void
    {
        _downSubDisplayImage = value;
    }
    
    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setDisableStateImage(value : BitmapData) : Void
    {
        _disableDisplayImage = value;
    }
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    public function setSubDisableStateImage(value : BitmapData) : Void
    {
        _disableSubDisplayImage = value;
    }
    
    /**
	 * For buttons with sub menus. The bitmap image that be used for an icon.
	 * @param	value The bitmap that will be used.
	 */
    
    public function setSubMenuDropDownIconImage(value : BitmapData) : Void
    {
        _subMenuDisplayImage = value;
    }	
	
    /**
	 * Set the icon that will be used using a bitmap image
	 * @param	value The bitmap that will be used
	 */
    
    public function setIcon(value : BitmapData) : Void
    {
        _icon = value;
        draw();
    }
    
    /**
	 * Set the sub menu icon that will be used using a bitmap image
	 * @param	value The bitmap that will be used
	 */
    
    public function setSubIcon(value : BitmapData) : Void
    {
        _subIcon = value;
        draw();
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
	 * Show or hide the Sub menu icon for button
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
    

    

    
    override public function draw() : Void
    {
        super.draw();
        
        updateButtons(_list);
    }
    
    /**
	 * Unload all menu items
	 */
	
    public function unload() : Void
    {
        // Remove and UnRef all sub menu items first
        removeSubMenu();
        
        for (i in 0..._list.length)
		{
            var menuObj : MenuItemObjectData = cast(_list.getItemAt(i), MenuItemObjectData);
            
            if (null != menuObj.menuItem) 
                menuObj.menuItem = null;
            
            if (buttonArea.numChildren > 0) 
                buttonArea.removeChildAt(0);
        }
    }
    
    public function removeSubMenu() : Void
    {
		
        while (subButtonArea.numChildren > 0)
        {
			
            if (null != subButtonArea.getChildAt(0)) 
            {
                var oldHolder : Sprite = cast(subButtonArea.removeChildAt(0), Sprite);
				
                removeMenuItemRef(oldHolder);
                dispatchEvent(new MenuEvent(MenuEvent.MENU_CLOSE, null, oldHolder));
            }
        }
        
        menuLevel = 0;
    }
    
    private function build() : Void
    {
        for (i in 0..._list.length)
		{
            if (Std.is(_list.getItemAt(i), MenuItemObjectData)) 
            {
                var dataObj : MenuItemObjectData = cast(_list.getItemAt(i), MenuItemObjectData);
                var menu : IMenuItem = new MenuItem(dataObj.text, _buttonWidth, _buttonHeight, dataObj.icon, dataObj.subMenuIcon);
                menu.name = "menu" + i;
                menu.hasChildren = dataObj.hasSubMenu;
                
                // Only if font is set in Style Manager
                if (null != UIStyleManager.MENU_LABEL_TEXT_EMBED) 
                    menu.getLabel().setEmbedFont(UIStyleManager.MENU_LABEL_TEXT_EMBED);
                
                if ("" != UIStyleManager.MENU_LABEL_TEXT_FONT) 
                    menu.getLabel().font = UIStyleManager.MENU_LABEL_TEXT_FONT;
                
                dataObj.menuItem = menu;
                
                // Display sub menu
                if (dataObj.hasSubMenu) 
                    menu.addEventListener(MouseEvent.MOUSE_OVER, onMenuItemRollOver, false, 0, true);
                
                
                // Remove sub menu
                menu.addEventListener(MouseEvent.ROLL_OVER, onMenuItemRollOut, false, 0, true);
                
                menu.addEventListener(MouseEvent.CLICK, onClick, false, 5, true);
				
                styleMenuButton(menu);
				
                buttonArea.addElement(menu);
            }
        }
    }
    
    private function buildSubMenu(menuButton : IMenuItem, subMenu : DataProvider<MenuItemObjectData>) : Void
    {
        if (null == subMenu) 
            return; 
        
        var menuHolder : Sprite = new Sprite();
        
        
        // Place items in sub menu area
        menuHolder.name = "subHolder" + menuLevel;
        subButtonArea.addChild(menuHolder);
        
        
        for (i in 0...subMenu.length)
		{
			
            if (Std.is(subMenu.getItemAt(i), MenuItemObjectData)) 
            {
                var dataObj : MenuItemObjectData = subMenu.getItemAt(i);
                var menu : IMenuItem = new MenuItem(dataObj.text, _buttonWidth, _buttonHeight, dataObj.icon, dataObj.subMenuIcon);
                var subCount : Int;
                var parentHolder : DisplayObject;
                
                menu.name = "menu" + menuLevel + "_" + i;
                menu.parentMenuItem = menuButton;
                menu.hasChildren = dataObj.hasSubMenu;
                menu.hasParent = true;
                
                if (null != UIStyleManager.MENU_SUB_LABEL_TEXT_EMBED) 
                    menu.getLabel().setEmbedFont(UIStyleManager.MENU_SUB_LABEL_TEXT_EMBED);
                
                if ("" != UIStyleManager.MENU_SUB_LABEL_TEXT_FONT) 
                    menu.getLabel().font = UIStyleManager.MENU_SUB_LABEL_TEXT_FONT;
                
                if (buttonArea.direction == HORIZONTAL) 
                {
                    if (menuLevel == 0) 
                    {
                        menuHolder.x = menuButton.x;
                        menuHolder.y = ((_reverse)) ? -menuButton.height : menuButton.height;
                    }
                    else 
                    {
                        
                        subCount = Std.parseInt(menuButton.name.substring(menuButton.name.indexOf("_") + 1));  
						
						// Get the menu item number  
                        parentHolder = subButtonArea.getChildByName("subHolder" + (menuLevel - 1));  
						
						// Get the parent holder  
                        menuHolder.x = parentHolder.x + parentHolder.width;  
						// Moves holder right over beside button  
                        menuHolder.y = ((_reverse)) ? parentHolder.y - (menu.height * (subCount)) : parentHolder.y + (menu.height * (subCount));
                    }
                    
                    menu.y = ((_reverse)) ? -(menu.height * i) : menu.height * i;
                }
                else 
                {
                    
                    if (menuLevel == 0) 
                    {
                        menuHolder.x = ((_reverse)) ? -menuButton.width : menuButton.width;
                        menuHolder.y = menuButton.y;
                    }
                    else 
                    {
                        
                        subCount = Std.parseInt(menuButton.name.substring(menuButton.name.indexOf("_") + 1)); 
						
						// Get the menu item number  
                        parentHolder = subButtonArea.getChildByName("subHolder" + (menuLevel - 1)); 
						
						// Get the parent holder  
                        menuHolder.x = ((_reverse)) ? parentHolder.x - parentHolder.width : parentHolder.x + parentHolder.width; 
						
						// Moves holder right over beside button  
                        menuHolder.y = parentHolder.y + (menu.height * (subCount));
                    }
                    
                    menu.y = menu.height * i;
                }
                
                dataObj.menuItem = menu;
                menuHolder.addChild(menu.displayObject);
                
                menu.addEventListener(MouseEvent.MOUSE_OVER, onMenuItemRollOver, false, 0, true);
                menu.addEventListener(MouseEvent.ROLL_OUT, onMenuItemRollOut, false, 0, true);
                menu.addEventListener(MouseEvent.CLICK, onClick, false, 5, true);
                
                styleSubMenuButton(menu);
            }
        }
        
        dispatchEvent(new MenuEvent(MenuEvent.MENU_OPEN, menuButton, menuHolder));
        
        // Update count of sub menu
        menuLevel++;
    }
    
    private function updateButtons(dataObj : DataProvider<MenuItemObjectData>) : Void
    {
        
        for (i in 0 ... dataObj.length)
		{
            var menuObj : MenuItemObjectData = dataObj.getItemAt(i);
            
            if (null != menuObj.menuItem) 
            {
                // Check for top menu
                if (menuObj.menuItem.parentMenuItem == null) 
                {
                    styleMenuButton(menuObj.menuItem);
                }
                // Else sub menu
                else 
                {
                    styleSubMenuButton(menuObj.menuItem);
                }
            } 
            
            
            // Update sub menu button  
            if (menuObj.hasSubMenu) 
                updateButtons(menuObj.subMenuList);
        }
    }
    
    
    private function removeOldParentMenu() : Void
    {
        if (menuLevel <= 0) 
            return;
        
        var oldHolder : Sprite = cast(subButtonArea.removeChildAt(menuLevel - 1), Sprite);
        removeMenuItemRef(oldHolder);
        menuLevel--;
        
        
        dispatchEvent(new MenuEvent(MenuEvent.MENU_CLOSE, null, oldHolder));
    }
    
    private function removeMenuItemRef(holder : Sprite) : Void
    {
        for (i in 0...holder.numChildren)
		{
            var dataObj : DataProvider<MenuItemObjectData> = getMenuDataObject( cast(holder.getChildAt(i), IMenuItem).parentMenuItem, _list);
            
            if (dataObj != null) 
            {
				var dataArray:Array<Dynamic> = dataObj.dataArray;
				
                for (a in 0...dataArray.length)
                {
                    var menuObj : MenuItemObjectData = dataObj.getItemAt( dataObj.getItemIndex( dataArray[a]) );
                    menuObj.menuItem = null;
                }
            }
        }
    }
    
    
    
    private function onMenuItemRollOver(event : MouseEvent) : Void
    {
        var menu : IMenuItem = cast(event.currentTarget, IMenuItem);
		var dataObj : DataProvider<MenuItemObjectData> = getMenuDataObject(menu, _list);
		
		
        if (null != menu) 
        {
            // If have sub menu and is not open it then open
            if (menu.hasChildren && dataObj != null && !menu.open) 
            {
                // Only close if not top level, not parent and is open
                if (oldMenuButton != null && oldMenuButton.hasParent && menu.parentMenuItem != oldMenuButton && oldMenuButton.open) 
                {
                    removeOldParentMenu();
                    oldMenuButton.open = false;
                }
                
                buildSubMenu(menu, dataObj);
                menu.open = true;
            }
            else if (menu.hasChildren && menu.open) // If is a menu button with sub menu open
            {
                removeOldParentMenu();
                menu.open = false;
            }
            else if (oldMenuButton.open) 
            {
                // Only close if not top level and not parent
                if (oldMenuButton.hasParent && menu.parentMenuItem != oldMenuButton) 
                {
                    removeOldParentMenu();
                    oldMenuButton.open = false;
                }
                
                // If have children open the menu  
                if (menu.hasChildren) 
                {
                    buildSubMenu(menu, dataObj);
                    menu.open = true;
                }
            }
        }
        
        
        oldMenuButton = menu;
    }
    
    
    private function onMenuItemRollOut(event : MouseEvent) : Void
    {
        
		
        var menu : IMenuItem = cast(event.currentTarget, IMenuItem);
		
		
        // First check to see top level menu and remove sub menu
        if (!menu.hasParent) 
        {
            removeSubMenu();
            menu.open = false;
        }
		
    }
    
    private function getMenuDataObject(menu : IMenuItem, menuList : DataProvider<MenuItemObjectData>) : DataProvider<MenuItemObjectData>
    {
        for (i in 0...menuList.length)
		{
            if ((menuList.getItemAt(i).menuItem == menu))
                return menuList.getItemAt(i).subMenuList;
            
            if (menuList.getItemAt(i).hasSubMenu) 
            {
                var subMenu : DataProvider<MenuItemObjectData> = getMenuDataObject(menu, menuList.getItemAt(i).subMenuList);
                
                if (null != subMenu) 
                    return subMenu;
            }
        }
        
        return null;
    }
    
    
    private function styleMenuButton(menu : IMenuItem) : Void
    {
        
        menu.textColor = _textColor;
        menu.textOverColor = _textOverColor;
        menu.textSelectedColor = _textSelectedColor;
        menu.textDisableColor = _textDisableColor;
        
        menu.menuDefaultColor = _normalFillColor;
        menu.menuOverColor = _overFillColor;
        menu.menuDownColor = _downFillColor;
        menu.menuDisableColor = _disableFillColor;
        
        menu.fillAlpha = _alpha;
        menu.lineAlpha = _lineAlpha;
        menu.border = _border;
        menu.borderThinkness = _thinkness;
        
        menu.normalBorderColor = _normalLineColor;
        menu.overBorderColor = _overLineColor;
        menu.downBorderColor = _downLineColor;
        menu.disableBorderColor = _disableLineColor;
        
        menu.smoothImage = _smoothImage;
        
        if (_normalDisplayImage != null) 
            menu.setDefaultStateImage(_normalDisplayImage);
        
        if (_overDisplayImage != null) 
            menu.setOverStateImage(_overDisplayImage);
        
        if (_downDisplayImage != null) 
            menu.setDownStateImage(_downDisplayImage);
        
        if (_disableDisplayImage != null) 
            menu.setDisableStateImage(_disableDisplayImage);
        
		//TODO: Update menu Item button
        //if (_icon != null) 
        //    menu.setIconBitmap(_icon);
        //
        //if (_subMenuDisplayImage != null) 
        //    menu.setSubMenuImage(_subMenuDisplayImage);
    }
    
    private function styleSubMenuButton(menu : IMenuItem) : Void
    {
        menu.textColor = _subTextColor;
        menu.textOverColor = _subTextOverColor;
        menu.textSelectedColor = _subTextSelectedColor;
        menu.textDisableColor = _subTextDisableColor;
        
        menu.menuDefaultColor = _subMenuDefaultColor;
        menu.menuOverColor = _subMenuOverColor;
        menu.menuDownColor = _subMenuDownColor;
        menu.menuDisableColor = _subMenuDisableColor;
        
        menu.fillAlpha = _subAlpha;
        menu.lineAlpha = _subLineAlpha;
        menu.border = _subBorder;
        menu.borderThinkness = _subThinkness;
        
        menu.normalBorderColor = _subNormalLineColor;
        menu.overBorderColor = _subOverLineColor;
        menu.downBorderColor = _subDownLineColor;
        menu.disableBorderColor = _subDisableLineColor;
        
        menu.smoothImage = _smoothImage;
        
        if (_normalSubDisplayImage != null) 
            menu.setDefaultStateImage(_normalSubDisplayImage);
        
        if (_overSubDisplayImage != null) 
            menu.setOverStateImage(_overSubDisplayImage);
        
        if (_downSubDisplayImage != null) 
            menu.setDownStateImage(_downSubDisplayImage);
        
        if (_disableSubDisplayImage != null) 
            menu.setDisableStateImage(_disableSubDisplayImage);
        
        if (_subIcon != null) 
            menu.setIcon(_subIcon);
        
        if (_subMenuDisplayImage != null) 
            menu.setSubMenuIcon(_subMenuDisplayImage);
    }
    
    private function onClick(event : Event) : Void
    {
        var menuItem : IMenuItem = cast(event.currentTarget, MenuItem);
        
        dispatchEvent(new MenuEvent(MenuEvent.MENU_BUTTON_CLICK, cast(event.currentTarget, MenuItem), null));
        
        if (null != menuItem.parentMenuItem) 
            removeSubMenu();
    }
    
    private function onStageClick(event : Event) : Void
    {
        
        dispatchEvent(new MenuEvent(MenuEvent.MENU_BUTTON_CLICK, null, null));
    }
    
    private function onStageAdd(event : Event) : Void
    {
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageClick, false, 2, true);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMenuLeave, false, 2, true);
		
        UIBitmapManager.watchElement(TYPE, this);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMenuItemRollOut);
        UIBitmapManager.stopWatchElement(TYPE, this);
    }
    
    private function onMenuLeave(event : MouseEvent) : Void
    {
		
        if (event.target == stage) 
            removeSubMenu();
    }
}

