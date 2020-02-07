package com.chaos.ui.theming.gradient;

import haxe.macro.Type.Ref;
import openfl.display.BitmapData;
import com.chaos.utils.CompositeManager;
import openfl.geom.Matrix;
import openfl.display.InterpolationMethod;
import openfl.display.SpreadMethod;
import openfl.display.GradientType;
import openfl.display.Shape;

/**
* Apply Gradient to button
**/

class GradientTheme extends Theme {

    private var _rotation : Float = Math.PI/2;

    private var _defaultButtonImage : BitmapData;
    private var _overButtonImage : BitmapData;
    private var _selectedButtonImage : BitmapData;
    private var _disableButtonImage : BitmapData;

    /**
    * Style Components based on passed in values
    *  @param	data The colors that will be used for the theme
    *  
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

    override function initialize(data:Dynamic = null) {
        super.initialize(data);

    }

    private function buttonCustomRender(data:Dynamic):BitmapData {

        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();
            matrix.createGradientBox(customWidth,customHeight,_rotation,0,0);
    
            var shape:Shape = new Shape();

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_highlightColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_primaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_shadowColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);

            shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);
        }

        return null;

        
    }

    private function radioButtonCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            
            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();
            matrix.createGradientBox(customWidth,customHeight, _rotation,0,5);
    
            var shape:Shape = new Shape();

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_highlightColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_primaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_shadowColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);

            shape.graphics.drawCircle(customWidth / 2,customWidth / 2,customWidth / 2);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);      

        }

        return null;
    }

    private function checkBoxCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            
            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();
            matrix.createGradientBox(customWidth,customHeight, _rotation,0,5);
    
            var shape:Shape = new Shape();

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_highlightColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_primaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_shadowColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);

            shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);      

        }

        return null;
    }    

    private function accordionCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();
            matrix.createGradientBox(customWidth,customHeight, _rotation,0,5);
    
            var shape:Shape = new Shape();

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_highlightColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_primaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_shadowColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);

            shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);            

        }

        return null;
    }

    private function scrollBarCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state") && Reflect.hasField(data,"direction")) {

            if(Std.string(Reflect.field(data,"state")).toLowerCase() == "track")
            return null;

            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();

            
            if(Reflect.field(data,"direction") == "horizontal")
                matrix.createGradientBox(customWidth,customHeight, _rotation,0,0);
            else
                matrix.createGradientBox(customWidth,customHeight,0,0,0);
                
            
            var shape:Shape = new Shape();

            //TODO: Refactor this into something better later on
            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_highlightColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_primaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_secondaryColor,_shadowColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
            

            shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);            
        }

        return null;
    }

    private function progressBarCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

           
            var customWidth:Int = Reflect.field(data,"width");
            var customHeight:Int = Reflect.field(data,"height");

            var matrix:Matrix = new Matrix ();

            matrix.createGradientBox(customWidth,customHeight, _rotation,0,0);
                
            var shape:Shape = new Shape();

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return null;
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "loaded")
                shape.graphics.beginGradientFill(GradientType.LINEAR,[_primaryColor,_secondaryColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);

            shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
            shape.graphics.endFill();

            return CompositeManager.displayObjectToBitmap(shape);            
        }

        return null;
    }


    override function style() {
        super.style();

        UIStyleManager.BUTTON_TILE_IMAGE = true;
        UIStyleManager.BUTTON_USE_CUSTOM_RENDER = true;
        UIStyleManager.SCROLLBAR_BUTTON_USE_CUSTOM_RENDER = true;
        UIStyleManager.ACCORDION_USE_CUSTOM_RENDER = true;
        UIStyleManager.PROGRESSBAR_USE_CUSTOM_RENDER = true;
        UIStyleManager.RADIOBUTTON_USE_CUSTOM_RENDER = true;
        UIStyleManager.CHECKBOX_USE_CUSTOM_RENDER = true;
        
    }

    override function skin() {
        super.skin();

        
        UIBitmapManager.addCustomRenderTexture(Button.TYPE, buttonCustomRender);
        UIBitmapManager.addCustomRenderTexture(ScrollBar.TYPE, scrollBarCustomRender);
        UIBitmapManager.addCustomRenderTexture(Accordion.TYPE, accordionCustomRender);
        UIBitmapManager.addCustomRenderTexture(ProgressBar.TYPE, progressBarCustomRender);
        UIBitmapManager.addCustomRenderTexture(RadioButton.TYPE, radioButtonCustomRender);
        UIBitmapManager.addCustomRenderTexture(CheckBox.TYPE, checkBoxCustomRender);
    }



}