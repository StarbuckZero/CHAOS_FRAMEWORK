package com.chaos.ui;


import com.chaos.drawing.icon.ArrowRightIcon;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;

import com.chaos.ui.classInterface.IMenuItem;

import com.chaos.ui.classInterface.IToggleButton;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import openfl.display.Shape;



/**
 * A button that is used for the menu system
 */

class MenuItem extends Button implements IMenuItem implements IToggleButton implements IButton implements IBaseUI
{
	
    /**
	 * Set the menu to being open or closed on roll over
	 */	
    public var open(get, set) : Bool;
	
    /**
	 * Set the button has a parent
	 */
	
    public var hasParent(get, set) : Bool;
	
    /**
	 * Set the button has a sub menu
	 */
	
    public var hasChildren(get, set) : Bool;
	
    /**
	 * Set the parent menu
	 */
	
    public var parentMenuItem(get, set) : IMenuItem;
	
    /**
	 * Set the label over state color
	 */
	
    public var textOverColor(get, set) : Int;
	
    /**
	 * Set the label selected state
	 */
	
    public var textSelectedColor(get, set) : Int;
	
    /**
	 * Set the label disable color
	 */
	
    public var textDisableColor(get, set) : Int;
	
    /**
	 * Show or hide border around button
	 */
	
    public var border(get, set) : Bool;
	
    /**
	 * Show or hide the Sub menu icon
	 */
    	
    public var showSubMenuIcon(get, set) : Bool;

    /**
	 * Set button alpha
	 */
    
    public var fillAlpha(get, set) : Float;	    
    

    /** The offset of the icon from the upper left */
    public static var ICON_OFFSETX : Int = 2;
    
    /** The offset of the icon from the upper left */
    public static var ICON_OFFSETY : Int = 0;
    
    private static inline var DEFAULT_WIDTH : Float = 20;
    private static inline var DEFAULT_HEIGHT : Float = 20;
	
    private var _textColor : Int = 0x000000;
    private var _textOverColor : Int = 0xFFFFFF;
    private var _textSelectedColor : Int = 0x999999;
    private var _textDisableColor : Int = 0xCCCCCC;
    
    private var _showSubMenuIcon : Bool = false;
    
    
    private var _subMenuIconHolder : Sprite;
    private var _subMenuIcon : Shape;
    
    private var _subMenuDisplayImage : BitmapData;
    
    private var _thinkness : Float = 1;
    
    private var _fillAlpha : Float = 1;
    private var _lineAlpha : Float = 1;
    
    private var _hasChildren : Bool = false;
    private var _hasParent : Bool = false;
    
    private var _parentMenuItem : IMenuItem;
    
    private var _open : Bool = false;
    
	/**
	 * MenuItem 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new( data:Dynamic = null)
    {
		
        super(data);
        
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		// Text Label
		if (Reflect.hasField(data, "textColor"))
		_textColor = Reflect.field(data, "textColor");
		
		if (Reflect.hasField(data, "textOverColor"))
		_textOverColor = Reflect.field(data,"textOverColor");
		
		if (Reflect.hasField(data, "textSelectedColor"))
		_textSelectedColor = Reflect.field(data,"textSelectedColor");
		
		if (Reflect.hasField(data, "textDisableColor"))
		_textDisableColor = Reflect.field(data, "textDisableColor");
		
		
	}
    
	/**
	 * initialize all importain objects
	 */
	
    override public function initialize() : Void
    {
		_subMenuIconHolder = new Sprite();
		
		super.initialize();
        
        addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown,false,0,true);
        addEventListener(MouseEvent.MOUSE_UP, onMouseUp,false,0,true);
        addEventListener(MouseEvent.MOUSE_OVER, onMenuOver, false, 0, true);
        addEventListener(MouseEvent.MOUSE_OUT, onMenuOut, false, 0, true);
        addEventListener(MouseEvent.CLICK, onMenuClick, false, 0, true);
        
    }
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
        
        removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        removeEventListener(MouseEvent.MOUSE_OVER, onMenuOver);
        removeEventListener(MouseEvent.MOUSE_OUT, onMenuOut);
        removeEventListener(MouseEvent.CLICK, onMenuClick);
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
            _label.textColor = _textColor;
        else 
            _label.textColor = _textDisableColor;
        
        super.enabled = value;
        return value;
    }
	
    /**
	 * Set the inner menu button alpha
	 */
	
    private function set_fillAlpha(value : Float) : Float
    {
        _fillAlpha = value;
        
		
        return value;
    }
    
    /**
	 * Return alpha
	 */
	
    private function get_fillAlpha() : Float
    {
        return _fillAlpha;
    }
    
    /**
	 * Set the border menu button alpha
	 */
	
    private function set_lineAlpha(value : Float) : Float
    {
        _lineAlpha = value;
        
		
        return value;
    }
    
    /**
	 * Return alpha
	 */
	
    private function get_lineAlpha() : Float
    {
        return _lineAlpha;
    }
	
  
	
	override function set_textColor(value:Int):Int 
	{
		_textColor = value;
		return super.set_textColor(value);
	}
    
    
    /**
	 * Set the label over state color
	 */
    private function set_textOverColor(value : Int) : Int
    {
        _textOverColor = value;
        
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
	 * Show or hide the Sub menu icon
	 */
    
    private function set_showSubMenuIcon(value : Bool) : Bool
    {
        _showSubMenuIcon = value;
        
        return value;
    }
    
    /**
	 * If true sub menu icon is being displayed and false if not.
	 */
	
    private function get_showSubMenuIcon() : Bool
    {
        return _showSubMenuIcon;
    }

    

    
    /**
	 * Return the icon that is being used for the set menu.
	 * @return Return an icon interface
	 */
    
    public function getSubMenuIcon() : Shape
    {
        return _subMenuIcon;
    }
    

	
    
    /**
	 * The bitmap that be used for an icon
	 * @param	value The bitmap that will be used.
	 */
    
    public function setSubMenuIcon(image : BitmapData) : Void
    {
        _subMenuDisplayImage = image;
        
    }

    
	
    /**
	 * This setup and draw the button on the screen
	 */
	
    override public function draw() : Void
    {
		super.draw();
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
            _label.textColor = _textSelectedColor;
        else 
            _label.textColor = _textColor;

        _label.draw();
    }

    private function onMouseDown(event : MouseEvent) 
    {
        _label.textColor = _textSelectedColor;
        _label.draw();
    }

    private function onMouseUp(event : MouseEvent)
    {
        _label.textColor = _textColor;
        _label.draw();
        
    }

}

