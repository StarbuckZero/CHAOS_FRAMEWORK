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

    private var _lineColor:Int = 0x000000;
    private var _lineThinkness:Float = 1;
    private var _lineAlpha:Float = 1;
    private var _borderShape:Shape = new Shape();

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new( data:Dynamic = null )
    {
        super();
        
        // Make sure all style and bitmap skinning is set first
        reskin();
        
        // If object passed in then start setting defaults
        if (null != data)
            setComponentData(data);
        
        // Init component parts
        initialize();
        
        // Draw and texture object
        draw();
    }

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

		if (Reflect.hasField(data, "lineColor"))
            _lineColor = Reflect.field(data, "lineColor");

		if (Reflect.hasField(data, "lineAlpha"))
            _lineAlpha = Reflect.field(data, "lineAlpha");
        
		if (Reflect.hasField(data, "lineThinkness"))
			_lineThinkness = Reflect.field(data, "lineThinkness");        
    }

    override function destroy() {
        super.destroy();

        _borderShape.graphics.clear();
        removeChild(_borderShape);
    }

    override function initialize() {
        super.initialize();

        _borderShape = new Shape();
        addChild(_borderShape);
    }

    override function draw() {
        super.draw();

        _borderShape.graphics.clear();

        _borderShape.graphics.lineStyle(_lineThinkness, _lineColor, _lineAlpha);
        _borderShape.graphics.drawRect(0,0, _width, _height);
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