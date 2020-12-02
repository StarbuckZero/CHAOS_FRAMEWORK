package com.chaos.mobile.ui;

import openfl.display.BitmapData;
import openfl.display.Shape;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

class CarouselDot extends BaseUI implements IBaseUI
{

	/**
	 * Default state Color
     */
     
    public var defaultColor(get, set) : Int;

	/**
	 * Selected state Color
     */
     
    public var selectedColor(get, set) : Int; 
    
	/**
	 * Set if you want the button to be selected or not
     */
     
	public var selected(get, set) : Bool;    

    private var _dot : Shape = new Shape();

    private var _dotSize : Int = 20;

    private var _selected:Bool = false;
	private var _defaultColor : Int = 0xCCCCCC;
	private var _selectedColor : Int = 0x999999;

    private var _defaultImage : BitmapData;
    private var _selectedImage : BitmapData;


	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new( data : Dynamic = null)
    {
        super(data);
    }


	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData( data : Dynamic) : Void 
    {
        super.setComponentData(data);

		if (Reflect.hasField(data, "selected"))
            _selected = Reflect.field(data, "selected");
                
        // Default Image state
		if (Reflect.hasField(data, "defaultImage"))
            _defaultImage = Reflect.field(data, "defaultImage");
        
        // Selected  Image state
		if (Reflect.hasField(data, "selectedImage"))
            _selectedImage = Reflect.field(data, "selectedImage");
        
        // Selected  Image state
		if (Reflect.hasField(data, "dotSize"))
            _dotSize = Reflect.field(data, "dotSize");
        
        // Default color
		if (Reflect.hasField(data, "defaultColor"))
            _defaultColor = Reflect.field(data, "defaultColor");

        // Selected color
		if (Reflect.hasField(data, "selectedColor"))
            _selectedColor = Reflect.field(data, "selectedColor");             
    }

    override function initialize() {

        super.initialize();

        addChild(_dot);
    }      


	/**
	 * Unload Component
	 */
	
    override public function destroy() : Void 
    {
        super.destroy();

        // Clear out dot
        _dot.graphics.clear();

        if(_defaultImage != null)
            _defaultImage.dispose();

        if(_selectedImage != null)
            _selectedImage.dispose();

        removeChild(_dot);
    }      

    private function set_defaultColor(value : Int) : Int {
		_defaultColor = value;

		return value;
	}

	private function get_defaultColor() : Int {
		return _defaultColor;
	}    

    private function set_selectedColor( value : Int) : Int {
		_selectedColor = value;

		return value;
	}

	private function get_selectedColor() : Int {
		return _selectedColor;
    }  

	/**
	 * Set if you want the button to be selected or not
	 */
     private function set_selected( value : Bool ) : Bool {
		_selected = value;

		return value;
	}

	/**
	 * Return if the button is on it's selected state
	 */
	private function get_selected() : Bool {
		return _selected;
    }    
    
	/**
	 * This is for setting an shape for the dot default state
	 *
	 * @param value Set the shape that you want to use
	 *
     */
     
     public function setDefaultStateImage(value : BitmapData):Void {
		_defaultImage = value;
	}    
    
	/**
	 * This is for setting an shape for the dot down state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
     public function setSelectedStateImage(value : BitmapData):Void {
		_selectedImage = value;
	}

    override function draw() {
        super.draw();

        // Both images have to be set in order to be used all together
        if(_defaultImage != null && _selectedImage != null)
        {
            if (_selected) 
            {
                _dot.graphics.beginBitmapFill(_selectedImage);
                _dot.graphics.drawRect(_selectedImage.width,_selectedImage.height,_selectedImage.width,_selectedImage.height);
                _dot.graphics.endFill();    
            }
            else
            {
                _dot.graphics.beginBitmapFill(_defaultImage);
                _dot.graphics.drawRect(_defaultImage.width,_defaultImage.height,_defaultImage.width,_defaultImage.height);
                _dot.graphics.endFill();
            }
        }
        else
        {
			// Draw dot if selected  
			if (_selected) 
			{
				_dot.graphics.beginFill(_selectedColor);
				_dot.graphics.drawCircle(_dotSize, _dotSize, _dotSize);
				_dot.graphics.endFill();
            }
            else
            {
				_dot.graphics.beginFill(_defaultColor);
				_dot.graphics.drawCircle(_dotSize, _dotSize , _dotSize);
				_dot.graphics.endFill();                
            }
        }

        // Set the size
        _width = _dot.width;
        _height = _dot.height;
    }

}