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

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return createCustomRender(_primaryColor,_secondaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                return createCustomRender(_primaryColor,_highlightColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                return createCustomRender(_secondaryColor,_primaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                return createCustomRender(_secondaryColor,_shadowColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);

        }

        return null;

        
    }

    private function radioButtonCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            // Leaving the same because drawing circle
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
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"style")  && Reflect.hasField(data,"state")) {

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return createCustomRender(_primaryColor,_secondaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                return createCustomRender(_primaryColor,_highlightColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                return createCustomRender(_secondaryColor,_primaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                return createCustomRender(_secondaryColor,_shadowColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
        }

        return null;
    }    

    private function accordionCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return createCustomRender(_primaryColor,_secondaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                return createCustomRender(_primaryColor,_highlightColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                return createCustomRender(_secondaryColor,_primaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,5,0);
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                return createCustomRender(_secondaryColor,_shadowColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation,0,5);
        }

        return null;
    }

    private function scrollPaneCustomRender( data:Dynamic ) {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height")) {
            return createCustomRender(_primaryColor,_background,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);
        }

        return null;

        
    }

    private function scrollBarCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state") && Reflect.hasField(data,"direction")) {

            if(Std.string(Reflect.field(data,"state")).toLowerCase() == "track")
            return null;
            
            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return createCustomRender(_primaryColor,_secondaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), (Reflect.field(data,"direction") == "horizontal") ? _rotation : 0 );
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "over")
                return createCustomRender(_primaryColor,_highlightColor,Reflect.field(data,"width"),Reflect.field(data,"height"), (Reflect.field(data,"direction") == "horizontal") ? _rotation : 0 );
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "down" || Std.string(Reflect.field(data,"state")).toLowerCase() == "selected")
                return createCustomRender(_secondaryColor,_primaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), (Reflect.field(data,"direction") == "horizontal") ? _rotation : 0 );
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "disable")
                return createCustomRender(_secondaryColor,_shadowColor,Reflect.field(data,"width"),Reflect.field(data,"height"), (Reflect.field(data,"direction") == "horizontal") ? _rotation : 0 );
        }

        return null;
    }

    private function progressBarCustomRender(data:Dynamic) :BitmapData {
        
        if(Reflect.hasField(data,"width") && Reflect.hasField(data,"height") && Reflect.hasField(data,"state")) {

            if( Std.string(Reflect.field(data,"state")).toLowerCase() == "default")
                return null;
            else if( Std.string(Reflect.field(data,"state")).toLowerCase() == "loaded")
                return createCustomRender(_primaryColor,_secondaryColor,Reflect.field(data,"width"),Reflect.field(data,"height"), _rotation);
        }

        return null;
    }


    private function createCustomRender(firstColor:Int,secondColor:Int, customWidth:Float, customHeight:Float,rotation:Float, tx:Int = 0, ty:Int = 0):BitmapData {

        var matrix:Matrix = new Matrix ();

        matrix.createGradientBox(customWidth,customHeight, rotation,tx,ty);
        var shape:Shape = new Shape();

        shape.graphics.beginGradientFill(GradientType.LINEAR,[firstColor,secondColor],[1,1],[0, 255],matrix,SpreadMethod.PAD,InterpolationMethod.LINEAR_RGB);
        shape.graphics.drawRoundRect(0,0,customWidth,customHeight,0,0);
        shape.graphics.endFill();

        return CompositeManager.displayObjectToBitmap(shape);
        
    }


    override function style() {
        super.style();

        UIStyleManager.setStyle(UIStyleManager.BUTTON_TILE_IMAGE, true);
        UIStyleManager.setStyle(UIStyleManager.BUTTON_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.SCROLLBAR_BUTTON_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.ACCORDION_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.PROGRESSBAR_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.RADIOBUTTON_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.CHECKBOX_USE_CUSTOM_RENDER, true);
        UIStyleManager.setStyle(UIStyleManager.SCROLLPANE_USE_CUSTOM_RENDER, true);
        
    }

    override function skin() {
        super.skin();

        UIBitmapManager.addCustomRenderTexture(Accordion.TYPE, accordionCustomRender);
        UIBitmapManager.addCustomRenderTexture(Button.TYPE, buttonCustomRender);
        UIBitmapManager.addCustomRenderTexture(ScrollBar.TYPE, scrollBarCustomRender);
        //UIBitmapManager.addCustomRenderTexture(ScrollPane.TYPE, scrollPaneCustomRender);
        UIBitmapManager.addCustomRenderTexture(ProgressBar.TYPE, progressBarCustomRender);
        UIBitmapManager.addCustomRenderTexture(RadioButton.TYPE, radioButtonCustomRender);
        UIBitmapManager.addCustomRenderTexture(CheckBox.TYPE, checkBoxCustomRender);
    }



}