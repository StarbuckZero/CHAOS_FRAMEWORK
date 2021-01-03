package com.chaos.mobile.ui;

import com.chaos.ui.Button;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

import openfl.events.MouseEvent;

/**
 * Mobile push button with added effect
 *
 * @author Erick Feiling
 */


class MobileButton extends Button implements IBaseUI
{

	/**
	 * Default state Color
     */
     
    public var dotColor(get, set) : Int;

	/**
	 * Default state Color
     */
     
     public var dotSize(get, set) : Int;    

    private var _dot : BaseUI;
    private var _dotColor : Int = 0xFFFFFF;
    private var _dotSize : Int = 5;
    private var _animationSpeed : Float = .5;

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data : Dynamic = null)
    {
        super(data);

        addEventListener(MouseEvent.MOUSE_UP, mobileUpEvent, false, 1, true);
    }    

    override function initialize() {

        super.initialize();

        _dot = new BaseUI({"x":(_width / 2),"y": (_height / 2)});
        _dot.alpha = 0;

        addChild(_dot);
    }    

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

        // Dot size
		if (Reflect.hasField(data, "dotSize"))
            _dotSize = Reflect.field(data, "dotSize");

        // Dot color
		if (Reflect.hasField(data, "dotColor"))
            _dotColor = Reflect.field(data, "dotColor");

        // Dot color
		if (Reflect.hasField(data, "animationSpeed"))
            _animationSpeed = Reflect.field(data, "animationSpeed");        
        
    }

    private function set_dotSize(value : Int) : Int {
		_dotSize = value;

		return value;
	}

	private function get_dotSize() : Int {
		return _dotSize;
    }    

    private function set_dotColor(value : Int) : Int {
		_dotColor = value;

		return value;
	}

	private function get_dotColor() : Int {
		return _dotColor;
    }        

	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();
    }

    override function draw() {
        super.draw();

        _dot.graphics.beginFill(_dotColor);
        _dot.graphics.drawCircle(0, 0, _dotSize);
        _dot.graphics.endFill();        
    }
    
    private function mobileUpEvent( event : MouseEvent ) : Void {

        _dot.scaleY =_dot.scaleX = 0;
        _dot.alpha = 1;
        _dot.visible = true;
        _dot.x = mouseX;
        _dot.y = mouseY;

        _dot.animateTo({"scaleX":_width / 2 ,"scaleY":_height / 2,"alpha":0,"duration":_animationSpeed});
    }


}