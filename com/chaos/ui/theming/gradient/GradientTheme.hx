package com.chaos.ui.theming.gradient;

import openfl.geom.Matrix;
import openfl.display.InterpolationMethod;
import openfl.display.SpreadMethod;
import openfl.display.GradientType;
import openfl.display.Shape;

/**
* Apply Gradient to button
**/

class GradientTheme extends Theme {

    private var _width : Int = 100;
    private var _height : Int = 50;
    private var _rotation : Float = Math.PI/2;
    

    /**
    * Style Components based on passed in values
    *  @param	data The colors that will be used for the theme
    *  
    * width - The width of gradient being used
    * height - The width of gradient being used
    * rotation - The direction of the gradient
    * primaryColor - The default color 
    * secondaryColor - The border color 
    * selectedColor - The down state or selected state. Will use secondaryColor if not set.
    * primaryTextColor - The default color text
    * secondaryTextColor - The down or selected state for text
    * highlightColor - The over state 
    * shadowColor - The down state 
    * background - The background color used on all layout containers
    **/

    public function new(data:Dynamic = null) {
        super(data);
    }

    override function initialize(data:Dynamic) {
        super.initialize(data);

        //TODO: Update gradient values 

        createGradient();
    }

    private function createGradient() {

        // Build Gradient
		var matrix:Matrix = new Matrix ();
		matrix.createGradientBox(_width,_height,_rotation,0,0);

		var shape:Shape = new Shape();
		shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
		shape.graphics.drawRoundRect(0,0,100,100,0,0);
        shape.graphics.endFill();
        
        
        //TODO: Turn into bitmap

		//addChild(shape);        
        
    }

    override function skin() {
        super.skin();

        //TODO: Apply to bnutton
    }



}