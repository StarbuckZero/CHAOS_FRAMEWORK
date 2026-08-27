package com.chaos.ui;

import openfl.display.Shape;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IBorder;
import com.chaos.ui.BaseUI;

/**
 * Border for UI Components
 *
 * @author Erick Feiling
 */

 class Border extends BaseUI implements IBorder implements IBaseUI
 {
	/**
	 * Border color
     */
     
    public var lineColor(get, set):Int;

    /**
    * Border thinkness
    */

    public var lineThinkness(get, set):Float;

    /**
    * Border alpha
	*/
		 
    public var lineAlpha(get, set):Float;

    /**
    * Rounded edge for width
	*/
		 
    public var ellipseWidth(get, set):Float;    

    /**
    * Rounded edge for height
	*/
		 
    public var ellipseHeight(get, set):Float;       

    private var _lineColor:Int = 0x000000;
    private var _lineThinkness:Float = 1;
    private var _lineAlpha:Float = 1;
    private var _borderShape:Shape;

    private var _ellipseWidth : Float = 0;
    private var _ellipseHeight : Float = 0;

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new( data:Dynamic = null )
    {
        super(data);
    }

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

		if (Reflect.hasField(data, "lineColor"))
            _lineColor = Reflect.field(data, "lineColor");

		if (Reflect.hasField(data, "lineAlpha"))
            _lineAlpha = Reflect.field(data, "lineAlpha");
        
		if (Reflect.hasField(data, "lineThinkness"))
			_lineThinkness = Reflect.field(data, "lineThinkness");

		if (Reflect.hasField(data, "ellipseWidth"))
			_ellipseWidth = Reflect.field(data, "ellipseWidth");

		if (Reflect.hasField(data, "ellipseHeight"))
			_ellipseHeight = Reflect.field(data, "ellipseHeight");        
    }

    override function destroy() {
        super.destroy();

        if (_borderShape != null) {
            _borderShape.graphics.clear();

            if (_borderShape.parent == this)
                removeChild(_borderShape);

            _borderShape = null;
        }
    }

    override function initialize() {
        super.initialize();

        if (_borderShape == null)
            _borderShape = new Shape();

        if (_borderShape.parent != this)
            addChild(_borderShape);
    }

    override function draw() {
        super.draw();

        if (_borderShape == null)
            return;

        _borderShape.graphics.clear();

        _borderShape.graphics.lineStyle(_lineThinkness, _lineColor, _lineAlpha);
        _borderShape.graphics.drawRoundRect(0,0, _width, _height, _ellipseWidth, _ellipseHeight);
    }

	/**
	 * Thinkness
	 */
     private function set_lineThinkness(value:Float):Float {
		_lineThinkness = value;
		return value;
    }

	private function get_lineThinkness():Float {
		return _lineThinkness;
	}    

    private function set_ellipseWidth(value:Float):Float {
		_ellipseWidth = value;
		return value;
    }

	private function get_ellipseWidth():Float {
		return _ellipseWidth;
	}      
    
    private function set_ellipseHeight(value:Float):Float {
		_ellipseHeight = value;
		return value;
    }

	private function get_ellipseHeight():Float {
		return _ellipseHeight;
	}    

	/**
	* Line color
	*/
    private function set_lineColor(value:Int):Int {
		_lineColor = value;

		return value;
	}

	private function get_lineColor():Int {
		return _lineColor;
	} 

	private function set_lineAlpha(value:Float):Float {
		_lineAlpha = value;
		return value;
	}

	private function get_lineAlpha():Float {
		return _lineAlpha;
    }  
 }
