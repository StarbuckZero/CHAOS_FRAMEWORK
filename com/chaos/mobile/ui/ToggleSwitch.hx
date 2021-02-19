package com.chaos.mobile.ui;

import com.chaos.ui.Border;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.mobile.ui.classInterface.IToggleSwitch;


class ToggleSwitch extends BaseUI implements IToggleSwitch implements IBaseUI {

	/**
	 * Set if you want the button to be selected or not
	 */

    public var selected(get, set):Bool;

	/**
	 * The animation when moving to selected and unselected state
	 */

    public var toggleAnimationSpeed(get, set):Float;  

	/**
	 * Set the border button alpha
	 */
     public var borderAlpha(get, set):Float;

     /**
      * Border thinkness
      */
    public var borderThinkness(get, set):Float;

	/**
	 * Border color 
	 */

    public var borderColor(get, set):Int;

	/**
	 * Show border
	 */

     public var border(get, set):Bool;


    /**
    * Set the switch button alpha
    */

    public var switchOutlineAlpha(get, set):Float;

    /**
    * Switch thinkness
    */

    public var switchOutlineThinkness(get, set):Float;

	/**
	 * Switch color 
	 */

    public var switchOutlineColor(get, set):Int;

	/**
	 * Show switch border
	 */

    public var switchOutline(get, set):Bool;    
    

    private var _defaultWidth : Int = 40;
    private var _defaultHeight : Int = 20;

    private var _defaultState : BaseUI;
    private var _selectedState : BaseUI;

    private var _switch : BaseUI;

    private var _selected : Bool = false;

    private var _border : Bool = false;
    private var _borderColor:Int = 0x000000;
    private var _outline : Border;
    private var _thinkness:Float = 1;
	private var _outlineColor:Int = 0x000000;
	private var _outlineAlpha:Float = .2;

    private var _switchOutline:Bool = false;
    private var _switchOutlineThinkness:Float = 1;
    private var _switchOutlineAlpha:Float = .2;
    private var _switchOutlineColor:Int = 0x000000;

    private var _roundedEdge : Int = 20;
    private var _toggleAnimationSpeed:Float = .2;

    /**
    * UI Component 
    * @param	data The proprieties that you want to set on component.
    */
     
    public function new( data:Dynamic = null )
    {
        super(data);

        // Setup evente
        addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 2, true);
    }

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

        // If there is no width or height then set defaults
        if(!Reflect.hasField(data,"width"))
            _width = _defaultWidth;

        if(!Reflect.hasField(data,"height"))
            _height = _defaultHeight;

		if (Reflect.hasField(data, "border"))
			_border = Reflect.field(data, "border");

		if (Reflect.hasField(data, "thinkness"))
			_thinkness = Reflect.field(data, "thinkness");

		if (Reflect.hasField(data, "borderColor"))
			_outlineColor = Reflect.field(data, "outlineColor");

		if (Reflect.hasField(data, "outlineAlpha"))
			_outlineAlpha = Reflect.field(data, "outlineAlpha");
        
		if (Reflect.hasField(data, "switchOutline"))
			_switchOutline = Reflect.field(data, "switchOutline");

		if (Reflect.hasField(data, "switchOutlineAlpha"))
			_switchOutlineAlpha = Reflect.field(data, "switchOutlineAlpha");

		if (Reflect.hasField(data, "switchOutlineColor"))
			_switchOutlineColor = Reflect.field(data, "switchOutlineColor");

		if (Reflect.hasField(data, "switchOutlineThinkness"))
			_switchOutlineThinkness = Reflect.field(data, "switchOutlineThinkness");        
        
    }

    override function initialize() {
        super.initialize();

        _defaultState = new BaseUI();
        _selectedState = new BaseUI();
        _switch = new BaseUI();
		_outline = new Border({"lineColor":_borderColor,"lineThinkness":_thinkness,"lineAlpha":_outlineAlpha,"ellipseWidth":_roundedEdge,"ellipseHeight": _roundedEdge, "width":_width,"height":_height});
        _selectedState.visible = _selected;

		
        addChild(_defaultState);
        addChild(_selectedState);
        addChild(_switch);
        addChild(_outline);
    }

    /**
	 * Set if you want the button to be selected or not
	 */
	private function set_selected(value:Bool):Bool {
		_selected = value;

		return value;
	}

	/**
	 * Return if the button is on it's selected state
	 */
	private function get_selected():Bool {
		return _selected;
	}

	private function set_toggleAnimationSpeed(value:Float):Float {
		_toggleAnimationSpeed = value;

		return value;
	}

    private function get_toggleAnimationSpeed():Float {
        return _toggleAnimationSpeed;
    }
 
	private function set_border(value:Bool):Bool {
		_border = value;

		return value;
	}

    private function get_border():Bool {
        return _border;
    }    

	private function set_switchOutline(value:Bool):Bool {
		_switchOutline = value;

		return value;
	}

    private function get_switchOutline():Bool {
        return _switchOutline;
    }   
    
	private function set_switchOutlineColor(value:Int):Int {
		_switchOutlineColor = value;

		return value;
	}

    private function get_switchOutlineColor():Int {
        return _switchOutlineColor;
    }      

	private function set_switchOutlineThinkness(value:Float):Float {
		_switchOutlineThinkness = value;

		return value;
	}

    private function get_switchOutlineThinkness():Float {
        return _switchOutlineThinkness;
    } 
    
	private function set_switchOutlineAlpha(value:Float):Float {
		_switchOutlineAlpha = value;

		return value;
	}

    private function get_switchOutlineAlpha():Float {
        return _switchOutlineAlpha;
    } 
    
	/**
	 * Border thinkness
	 */
     private function set_borderThinkness(value:Float):Float {
		_thinkness = value;

		return value;
	}

	/**
	 * Return the size of the border
	 */
	private function get_borderThinkness():Float {
		return _thinkness;
	}    

	/**
	 * The color of the label border.
	 */
     private function set_borderColor(value:Int):Int {
		_outlineColor = value;

		return value;
	}

	/**
	 * Resturns If the button is enabled or disable
	 */
	private function get_borderColor():Int {
		return _outlineColor;
	}    
    
	/**
	 * Set the alpha between 1 to 0
	 */
     private function set_borderAlpha(value:Float):Float {
		_outlineAlpha = value;

		return value;
	}

	/**
	 * Returns the border alpha
	 */
	private function get_borderAlpha():Float {
		return _outlineAlpha;
	}    

    override function draw() {
        super.draw();

		// Get ready to draw background and border
		_outline.visible = _border;

		if(_border)
		{
			_outline.width = _width;
			_outline.height = _height;
            _outline.ellipseWidth = _outline.ellipseHeight = _roundedEdge;
			
			_outline.draw();
		}        

        _selectedState.graphics.clear();
        _selectedState.graphics.beginFill(0x00FF00);
        _selectedState.graphics.drawRoundRect(0,0, _width, _height, _roundedEdge, _roundedEdge);
        _selectedState.graphics.endFill();

        _defaultState.graphics.clear();
        _defaultState.graphics.beginFill(0xCCCCCC);
        _defaultState.graphics.drawRoundRect(0,0, _width, _height, _roundedEdge, _roundedEdge);
        _defaultState.graphics.endFill();

        var circleSize : Float = (_width / 4);

        _switch.graphics.clear();

        if(_switchOutline)
            _switch.graphics.lineStyle(_switchOutlineThinkness,_switchOutlineColor,_switchOutlineAlpha);

        _switch.graphics.beginFill(0xFFFFFF);
        _switch.graphics.drawCircle(circleSize, circleSize, circleSize);
        _switch.width = circleSize;
        
    }

	private function mouseDownEvent(event:MouseEvent):Void {
        
		// Toggle selected stage
		_selected = !_selected;

        if(_selected) {

            _selectedState.visible = false;
            _selectedState.alpha = 0;
            _selectedState.animateTo({"alpha":1,"duration":_toggleAnimationSpeed});
            _switch.animateTo({"x":(_width / 2),"duration":_toggleAnimationSpeed});
        }
        else 
        {
            _selectedState.animateTo({"alpha":0,"duration":_toggleAnimationSpeed});
            _switch.animateTo({"x":0,"duration":_toggleAnimationSpeed});
        }
        
    }
    
}

