package com.chaos.mobile.ui;

import com.chaos.mobile.ui.event.MobileButtonListEvent;
import openfl.events.MouseEvent;
import com.chaos.ui.event.MenuEvent;
import com.chaos.ui.Label;
import com.chaos.ui.BaseUI;
import com.chaos.mobile.ui.MobileButtonList;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.drawing.icon.ArrowDownIcon;

import openfl.display.Shape;

/**
 * Base UI element used in the framework
 *
 * @author Erick Feiling
 */

 class MobileDropDown extends BaseUI implements IBaseUI
 {

    private static inline var DEFAULT_HEIGHT:Float = 20;

    private var _label : Label;
    private var _downArrowIcon : ArrowDownIcon;

    private var _background : Shape;
    private var _border : Shape;
    private var _thinkness : Float = 1;
    private var _borderAlpha : Float = 1;

    private var _arrowColor : Int = 0;
    private var _borderColor : Int = 0;
    private var _backgroundColor : Int = 0xFFFFFF;
    private var _backgroundAlpha : Float = 1;

    private var _iconWidth : Int = 20;
    private var _iconHeight : Int = 15;

    private var _arrowOffset : Int = 4;

    private var _textSize : Int = 16;

    private var _defaultText : String = "--- Select One ---";

    private var _menuList : MobileButtonList;
    private var _menuData : Array<Dynamic>;


	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
     */
     
    public function new(data:Dynamic = null)
    {
        super(data);
    }

    override function setComponentData(data:Dynamic) {

        super.setComponentData(data);
        
        // If no height set then adjust 
        if(!Reflect.hasField(data,"height"))
            _height = DEFAULT_HEIGHT;

        if(Reflect.hasField(data,"arrowColor"))
            _arrowColor = Reflect.field(data,"arrowColor");

        if(Reflect.hasField(data,"iconWidth"))
            _iconWidth = Reflect.field(data,"arrowWidth");

        if(Reflect.hasField(data,"iconHeight"))
            _iconHeight = Reflect.field(data,"iconHeight");

        if(Reflect.hasField(data,"borderColor"))
            _borderColor = Reflect.field(data,"borderColor");

        if(Reflect.hasField(data,"borderAlpha"))
            _borderAlpha = Reflect.field(data,"borderAlpha");           

        if(Reflect.hasField(data,"backgroundColor"))
            _backgroundColor = Reflect.field(data,"backgroundColor");

        if(Reflect.hasField(data,"backgroundAlpha"))
            _backgroundAlpha = Reflect.field(data,"backgroundAlpha");        
        
        if(Reflect.hasField(data,"textSize"))
            _textSize = Reflect.field(data,"textSize");

        if(Reflect.hasField(data,"defaultText"))
            _defaultText = Reflect.field(data,"defaultText");

        if(Reflect.hasField(data,"thinkness"))
            _thinkness = Reflect.field(data,"thinkness");     

        if (Reflect.hasField(data, "data"))
            _menuData = Reflect.field(data, "data");
        
    }

    override function destroy() {
        super.destroy();

        _downArrowIcon.destroy();
        _label.destroy();

        _border.graphics.clear();

        removeChild(_label);
        removeChild(_downArrowIcon);
        removeChild(_border);        
    }

    override function initialize() {
        super.initialize();

        _background = new Shape();
        _border = new Shape();
        _label = new Label({"text": _defaultText, "size" : _textSize});
        _label.addEventListener(MouseEvent.CLICK,onToggleMenu,false,0,true);

        _downArrowIcon = new ArrowDownIcon();
        _downArrowIcon.addEventListener(MouseEvent.CLICK,onToggleMenu,false,0,true);


        _menuList = new MobileButtonList({"width":_width, "data":_menuData});
        _menuList.addEventListener(MobileButtonListEvent.CHANGE, onMenuButtonClicked, false, 0, true);
        _menuList.visible = false;
        
        addChild(_background);
        addChild(_label);
        addChild(_downArrowIcon);
        addChild(_border);
        addChild(_menuList);
    }

    override function draw() {
        super.draw();

        _label.width = _width - _iconWidth;
        _label.height = _height;

        _downArrowIcon.width = _iconWidth;
        _downArrowIcon.height = _iconHeight;
        _downArrowIcon.borderColor = _downArrowIcon.baseColor = _arrowColor;

        _downArrowIcon.x = _width - _downArrowIcon.width - _arrowOffset;
        _downArrowIcon.y = (_height / 2) - (_downArrowIcon.height / 2);

        _menuList.width = _width;
        _menuList.height = _menuData.length * _menuList.buttonHeight;
        _menuList.y = _height;

        _downArrowIcon.draw();
        _label.draw();
        _menuList.draw();

        _background.graphics.clear();
        _background.graphics.beginFill(_backgroundColor, _backgroundAlpha);
        _background.graphics.drawRect(0, 0, _width, _height);
        _background.graphics.endFill();

        // Setup for border if need be
        _border.graphics.clear();
        _border.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
        _border.graphics.drawRect(0, 0, _width, _height);
        _border.graphics.endFill();
    
        
    }

    private function onToggleMenu(event:MouseEvent) : Void {
        _menuList.visible = !_menuList.visible;
    }

    private function onMenuButtonClicked(event:MobileButtonListEvent) {        

       _label.text = _menuList.dataProvider.getItemAt(_menuList.selectedIndex).text;
       _label.draw();

       _menuList.visible = false;
        
    }

 }