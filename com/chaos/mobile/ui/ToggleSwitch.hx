package com.chaos.mobile.ui;

import com.chaos.ui.Border;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.mobile.ui.classInterface.IToggleSwitch;


class ToggleSwitch extends BaseUI implements IToggleSwitch implements IBaseUI {

	/**
	 * Default color
	 */

	 public var defaultColor(get, set):Int;


	/**
	 * Selected color
	 */

	 public var selectedColor(get, set):Int;

	/**
	 * Switch color
	 */

	 public var switchColor(get, set):Int;	 

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
    * Set the switch outline alpha
    */

    public var switchOutlineAlpha(get, set):Float;

    /**
    * Switch thinkness
    */

    public var switchOutlineThinkness(get, set):Float;

	/**
	 * Switch outline color 
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

	private var _defaultColor : Int = 0xCCCCCC;
	private var _selectedColor : Int = 0x00FF00;

    private var _switch : BaseUI;

	private var _switchColor : Int = 0xFFFFFF;

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
	private var _swtichSize:Float = 0;

    private var _roundedEdge : Int = 20;
    private var _toggleAnimationSpeed:Float = .2;

	private var _switchStyle:ToggleType = ToggleType.Circle;


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

		if (Reflect.hasField(data, "roundedEdge"))
		_roundedEdge = Reflect.field(data, "roundedEdge");

		if (Reflect.hasField(data, "defaultColor"))
			_defaultColor = Reflect.field(data, "defaultColor");

		if (Reflect.hasField(data, "selectedColor"))
			_selectedColor = Reflect.field(data, "selectedColor");

		if (Reflect.hasField(data, "switchColor"))
			_switchColor = Reflect.field(data, "switchColor");
		
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
		
		if (Reflect.hasField(data, "switchStyle"))
			_switchStyle = getStyle(Reflect.field(data, "switchStyle"));

		// Set default switch size if not set
		if(!Reflect.hasField(data,"swtichSize"))
		{
			if(_switchStyle == Rect)
				_swtichSize = _width / 2;
			else
				_swtichSize = _width / 4;
		}
		
		// If not set then change based on switch type
		if(!Reflect.hasField(data, "roundedEdge") && _switchStyle == Rect)
			_roundedEdge = 0;
		else
			_roundedEdge = 20;
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



    private function set_defaultColor(value:Int):Int {
		_defaultColor = value;

		return value;
	}

	private function get_defaultColor():Int {
		return _defaultColor;
	}   

	private function set_selectedColor(value:Int):Int {
		_selectedColor = value;

		return value;
	}

	private function get_selectedColor():Int {
		return _selectedColor;
	} 	

	private function set_switchColor(value:Int):Int {
		_switchColor = value;

		return value;
	}

	private function get_switchColor():Int {
		return _switchColor;
	} 	


	private function set_selected(value:Bool):Bool {
		_selected = value;

		return value;
	}


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
    

     private function set_borderThinkness(value:Float):Float {
		_thinkness = value;

		return value;
	}


	private function get_borderThinkness():Float {
		return _thinkness;
	}    


     private function set_borderColor(value:Int):Int {
		_outlineColor = value;

		return value;
	}


	private function get_borderColor():Int {
		return _outlineColor;
	}    
    
	
    private function set_borderAlpha(value:Float):Float {
		_outlineAlpha = value;

		return value;
	}


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
        _selectedState.graphics.beginFill(_selectedColor);
        _selectedState.graphics.drawRoundRect(0,0, _width, _height, _roundedEdge, _roundedEdge);
        _selectedState.graphics.endFill();

        _defaultState.graphics.clear();
        _defaultState.graphics.beginFill(_defaultColor);
        _defaultState.graphics.drawRoundRect(0,0, _width, _height, _roundedEdge, _roundedEdge);
        _defaultState.graphics.endFill();

        var circleSize : Float = (_width / 4);

        _switch.graphics.clear();

        if(_switchOutline)
            _switch.graphics.lineStyle(_switchOutlineThinkness,_switchOutlineColor,_switchOutlineAlpha);

		_switch.graphics.beginFill(_switchColor);
		_switch.width = circleSize;	

		if(_switchStyle == ToggleType.Circle)
			_switch.graphics.drawCircle(_swtichSize, _swtichSize, _swtichSize);
		else if(_switchStyle == ToggleType.Rect)
			_switch.graphics.drawRect(0,0,_swtichSize,_swtichSize);

		_switch.graphics.endFill();

		// If selected value change update the toggle
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

	private function getStyle(value : String ) : ToggleType
	{

		if(value.toLowerCase() == "rect")
			return Rect;
		else
			return Circle; 
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

enum ToggleType {
	Circle;
	Rect;
}