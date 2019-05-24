package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.ITextInput;

import com.chaos.media.DisplayImage;

import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.events.FocusEvent;

import openfl.display.Shape;

/**
	 * The base level for user input validation
	 * @author Erick Feiling
	 */
class ValidateField extends InputField implements IFormUI implements com.chaos.ui.classInterface.ITextInput implements com.chaos.ui.classInterface.IBaseUI
{
    public var backgroundValidate : Shape;
    
    private var _backgroundValidColor : Int = 0x00FF00;
    private var _backgroundInvalidColor : Int = 0xFF0000;
    
    private var _showImage : Bool = true;
    private var _smoothImage : Bool = true;
    
    private var _backgroundValidImage : DisplayImage;
    private var _backgroundInvalidImage : DisplayImage;
    
    private var _bgDisplayValidateImage : Bool = false;
    
    /**
		 * Makes sure that user input is valid
		 * @param	labelText
		 */
    
    public function new(labelText : String = "")
    {
        super(labelText);
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
    override public function init() : Void
    {
        super.init();
        
        backgroundValidate = new Shape();
        
        _backgroundValidImage = new DisplayImage();
        _backgroundInvalidImage = new DisplayImage();
        
        backgroundValidate.visible = false;
        addChildAt(backgroundValidate, 3);
    }
    
    private function onStageAdd(event : Event) : Void
    {
        
        // Check for where user click
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onValidateCheck, false, 0, true);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        
        // Remove event once gone
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onValidateCheck);
    }
    
    /**
	 * Set the background of the text input default state using an image file.
	 */
    
    public function setValidBackground(value : String) : Void
    {
        _backgroundValidImage.load(value);
    }
    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    public function setValidBackgroundImage(value : Bitmap) : Void
    {
        _backgroundValidImage.setImage(value);
    }
    
    /**
	 * Set the background of the text input default state using an image file.
	 */
    
    public function setInvalidBackground(value : String) : Void
    {
        _backgroundValidImage.load(value);
    }
    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    public function setInvalidBackgroundImage(value : Bitmap) : Void
    {
        _backgroundValidImage.setImage(value);
    }
    
    /**
	 * An event that need to be maked for override. This is ran once
	 * @param	event
	 */
    
    public function onValidateCheck(event : Event) : Void
    {
        // Show shap now that item has been checked
        backgroundValidate.visible = true;
        
        // Check to see if item is valid and set flag then redraw
        draw();
    }
    
    /**
	 * Check to see if info stored is correct
	 * @return True if it's correct and false if not
	 */
    
    public function isValid() : Bool
    {
        return true;
    }
    
    
    override public function draw() : Void
    {
        super.draw();
        
		// Setup for background
        if (null == backgroundValidate) 
            return;
        
        if (background) 
        {
            
            // Redraw background
            if (_showImage) 
            {
                // Check to see what bitmaps are loaded in
                if (_bgDisplayValidateImage) 
                {
                    ((isValid())) ? backgroundValidate.graphics.beginBitmapFill(_backgroundValidImage.image.bitmapData, null, true, _smoothImage) : backgroundValidate.graphics.beginBitmapFill(_backgroundInvalidImage.image.bitmapData, null, true, _smoothImage);
                }
                else 
                {
                    ((isValid())) ? backgroundValidate.graphics.beginFill(_backgroundValidColor, bitmapAlpha) : backgroundValidate.graphics.beginFill(_backgroundInvalidColor, bitmapAlpha);
                }
            }
            else 
            {
                ((isValid())) ? backgroundValidate.graphics.beginFill(_backgroundValidColor, bitmapAlpha) : backgroundValidate.graphics.beginFill(_backgroundInvalidColor, bitmapAlpha);
            }
            
            backgroundValidate.graphics.drawRect(0, 0, width, height);
            backgroundValidate.graphics.endFill();
        }
        else 
        {
            backgroundValidate.graphics.clear();
        }
    }
}

