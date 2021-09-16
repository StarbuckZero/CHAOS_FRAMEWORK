package com.chaos.ui;

import openfl.display.Shape;
import openfl.display.BitmapData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButtonBase;
import com.chaos.ui.classInterface.IBorder;
import com.chaos.ui.BaseUI;
import com.chaos.ui.Border;

/**
 * Shape for base buttons
 *
 * @author Erick Feiling
 */

 class ButtonBase extends Border implements IButtonBase implements IBorder implements IBaseUI
 {
    /**
    * Color for button state
    */
     
     public var baseColor(get, set):Int;
 
     /**
     * Alpha for base
     */
          
     public var baseAlpha(get, set):Float; 

     /**
     * Image for base
     */
          
     public var image(get, set):BitmapData;

    /**
    * Title the image that is being used
    */
     
     public var tileImage(get, set):Bool;

    /**
    * Border for button
    */
     
     public var border(get, set):Bool;        

    /**
    * Set how rounded the button is
    */
    
     public var roundEdge(get, set):Int;

     public var shapeBase:Shape = new Shape();

     private var _roundEdge:Int = 0;
     private var _border:Bool = false;
     private var _baseColor:Int = 0xCCCCCC;
     private var _baseAlpha:Float = 1;
     private var _image:BitmapData = null;
     private var _tileImage:Bool = false;
     
 
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

          if (Reflect.hasField(data, "baseColor"))
            _baseColor = Reflect.field(data, "baseColor");

          if (Reflect.hasField(data, "baseAlpha"))
            _baseAlpha = Reflect.field(data, "baseAlpha");  

          if (Reflect.hasField(data, "image"))
            _image = Reflect.field(data, "image");

          if (Reflect.hasField(data, "tileImage"))
            _tileImage = Reflect.field(data, "tileImage");

          if (Reflect.hasField(data, "border"))
            _border = Reflect.field(data, "border");
          
          if (Reflect.hasField(data, "roundEdge"))
            _roundEdge = Reflect.field(data, "roundEdge");
     }

     override function initialize() {

      // Add base in first so border can be drawn above it
      addChild(shapeBase);

      super.initialize();

          
     }

     override function destroy() {
          super.destroy();

          shapeBase.graphics.clear();
          removeChild(shapeBase);
     }


     override function draw() {

        if(_border)  
            super.draw();
        else
          _borderShape.graphics.clear();

        shapeBase.graphics.clear();

        if (null != _image)
          shapeBase.graphics.beginBitmapFill(_image, null, _tileImage, _smoothImage);
		  else
		  	shapeBase.graphics.beginFill(_baseColor, _baseAlpha);

	  	if (_image != null)
			  shapeBase.graphics.drawRoundRect(0, 0, _width, _height, _roundEdge);
		  else
			  shapeBase.graphics.drawRoundRect(0, 0, _width, _height, _roundEdge);

		    shapeBase.graphics.endFill();          
     }

     private function set_tileImage(value:Bool):Bool {
		_tileImage = value;

		return value;
	}

	private function get_tileImage():Bool {
		return _tileImage;
    }   


    private function set_image(value:BitmapData):BitmapData {
		_image = value;

		return value;
	}

	private function get_image():BitmapData {
		return _image;
    }      
    
	/**
	* Line color
	*/
    private function set_baseColor(value:Int):Int {
		_baseColor = value;

		return value;
	}

	private function get_baseColor():Int {
		return _baseColor;
	}     

	/**
	 * Show or hide border around button
     */
     
     private function set_border(value:Bool):Bool {
		_border = value;

		return value;
	}

	private function get_border():Bool {
		return _border;
	}    
    
	/**
	 * Set how rounded base is
	 */
     private function set_roundEdge(value:Int):Int {
		_roundEdge = value;

		return value;
	}


	private function get_roundEdge():Int {
		return _roundEdge;
	}    

	/**
	 * Alpha of the baase image or block
     */

	private function set_baseAlpha(value:Float):Float {
		_baseAlpha = value;
		return value;
	}

	private function get_baseAlpha():Float {
		return _baseAlpha;
    }    
 }