package com.chaos.mobile.ui;

import com.chaos.mobile.ui.data.NavigationMenuObjectData;
import openfl.display.DisplayObject;
import com.chaos.drawing.icon.NavigationRightArrow;
import openfl.events.MouseEvent;
import com.chaos.ui.Label;
import openfl.display.Shape;
import openfl.display.BitmapData;
import com.chaos.ui.ToggleButton;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IToggleButton;
import com.chaos.mobile.ui.classInterface.INavigationMenu;
import com.chaos.mobile.ui.classInterface.IDragContainer;
import com.chaos.data.DataProvider;

class NavigationMenuItem extends ToggleButton implements IBaseUI implements IToggleButton {

    public var dragContainer(get, never):IDragContainer;
    public var navigationMenu(get, never):INavigationMenu;

    public var arrow(get, set):DisplayObject;

    public var showArrow(get, set):Bool;
    public var arrowColor(get, set):Int;

    public var childObject(get, set):DataProvider<NavigationMenuObjectData>;

    private var _showArrow:Bool;
    private var _icon:Shape;
    private var _label:Label;

    private var _isScrolling:Bool = false;
    private var _arrowColor:Int = 0;

    private var _labelData:Dynamic;

    private var _dragContainer:IDragContainer;
    private var _navigationMenu:INavigationMenu;

    private var _arrow:DisplayObject;

    private var _childObject:DataProvider<NavigationMenuObjectData>;
    
	/**
	 * UI Component
	 * @param	data The proprieties that you want to set on component.
	 */

     public function new(data:Dynamic = null) {
		super(data);
    }
    
    override function setComponentData(data:Dynamic) {

        super.setComponentData(data);

        _dragContainer = Reflect.field(data,"DragContainer");
        _navigationMenu = Reflect.field(data,"NavigationMenu");

        if (Reflect.hasField(data,"icon"))
            setIcon(Reflect.field(data,"icon"));

		if (Reflect.hasField(data, "Label"))
            _labelData = Reflect.field(data, "Label");
		else
            _labelData = {"width":_width,"height":_height};

        if(Reflect.hasField(data, "text"))
            Reflect.setField(_labelData,"text", Reflect.field(data, "text"));

        if(Reflect.hasField(data, "arrow"))
            _arrow = Reflect.field(data,"arrow");

        if(Reflect.hasField(data, "children"))
            _childObject = Reflect.field(data,"children");

    }

    override function initialize() {
        super.initialize();

        _icon = new Shape();
        _label = new Label(_labelData);

        if(_arrow == null) 
            _arrow = new NavigationRightArrow({"baseColor":0x000000,"width":10,"height":_height / 2});

        arrow.x = (_width - arrow.width) - 5;
        arrow.y = (_height / 2) - (arrow.height / 2);

        
        if(_navigationMenu.alwaysDisplaySubMenuIcon)
            arrow.visible = true;
        else
            arrow.visible = (_childObject != null);

        addEventListener(MouseEvent.MOUSE_UP, mouseUpEvent, false, 2, true);

        addChild(_icon);
        addChild(_label);

        addChild(arrow);
    }    

    public function setIcon(icon:BitmapData):Void {

        _icon.graphics.beginBitmapFill(icon);
        _icon.graphics.drawRoundRect(0,0, icon.width,icon.height,0,0);
        _icon.graphics.endFill();
        
    }

    private function get_childObject():DataProvider<NavigationMenuObjectData> {
    
        return _childObject;
    }
    
    private function set_childObject( value:DataProvider<NavigationMenuObjectData> ):DataProvider<NavigationMenuObjectData> {

        _childObject = value;

        return _childObject;
    }

    private function set_arrowColor( value:Int ):Int {
        _arrowColor = value;
        return _arrowColor;
    }

    private function get_arrowColor():Int{
        return _arrowColor;
    }    
    
    private function get_dragContainer():IDragContainer {
        
        return _dragContainer;
    }

    private function get_navigationMenu():INavigationMenu {
        
        return _navigationMenu;
    }


    
    private function set_showArrow(value:Bool):Bool {

        _showArrow = value;
        return value;        
    }

    private function get_showArrow():Bool {
        return _showArrow;
    }
    

    private function set_arrow(value:DisplayObject):DisplayObject {
        
        _arrow = value;
        return _arrow;
    }

    private function get_arrow():DisplayObject {
        
        return _arrow;
    }    

    override function mouseDownEvent(event:MouseEvent) {

           if(!_dragContainer.isMoving && _childObject != null)
            _navigationMenu.goToSubMenu(_childObject);
    }

    override function mouseOverEvent(event:MouseEvent) {

         if(!_dragContainer.isMoving)
             super.mouseOverEvent(event);
    }
    

    
    private function mouseUpEvent(event:MouseEvent) {

        if(!_dragContainer.hasMoved)
            _navigationMenu.menuButtonClicked(this);
    }

}