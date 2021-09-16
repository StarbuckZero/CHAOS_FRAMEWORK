package com.chaos.form.ui;


import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ITextInput;

import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Shape;

/**
 * The base level for user input validation
 * @author Erick Feiling
 */
class ValidateField extends InputField implements IFormUI implements ITextInput implements IBaseUI
{
    public var backgroundValidate : Shape = new Shape();
    
    private var _backgroundValidColor : Int = 0x00FF00;
    private var _backgroundInvalidColor : Int = 0xFF0000;
    
    private var _backgroundValidImage : BitmapData;
    private var _backgroundInvalidImage : BitmapData;
    
    /**
	 * Makes sure that user input is valid
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		super.initialize();
		
        backgroundValidate.visible = false;
		
		// Add in right before disable background
		addChildAt(backgroundValidate, 3);        
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
        removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
        removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		stage.removeEventListener(MouseEvent.MOUSE_DOWN, onValidateCheck);

		backgroundValidate.graphics.clear();
		
		removeChild(backgroundValidate);
		
		if (_backgroundValidImage != null)
			_backgroundValidImage.dispose();
			
		if (_backgroundInvalidImage != null)
			_backgroundInvalidImage.dispose();
			
		backgroundValidate = null;
		
		_backgroundInvalidImage = _backgroundValidImage = null;
		
	}
	
    
    override private function onStageAdd(event : Event) : Void
    {
        
        // Check for where user click
        stage.addEventListener(MouseEvent.MOUSE_DOWN, onValidateCheck, false, 0, true);
    }
    
    override private function onStageRemove(event : Event) : Void
    {
        
        // Remove event once gone
        stage.removeEventListener(MouseEvent.MOUSE_DOWN, onValidateCheck);
    }
    

    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    public function setValidBackgroundImage(value : BitmapData) : Void
    {
        _backgroundValidImage = value;
    }
    
    
    /**
	 * This is for setting an image to the text input default state. It is best to set an image that can be tile.
	 */
    
    public function setInvalidBackgroundImage(value : BitmapData) : Void
    {
        _backgroundValidImage = value;
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
        return !isEmpty();
    }
    
    
    override public function draw() : Void
    {
        super.draw();
        
        if (background) 
        {
            // User image if both are loaded
            if (_backgroundValidImage != null && _backgroundInvalidImage != null) 
                isValid() ? backgroundValidate.graphics.beginBitmapFill(_backgroundValidImage, null, true, _smoothImage) : backgroundValidate.graphics.beginBitmapFill(_backgroundInvalidImage, null, true, _smoothImage);
            else 
                isValid() ? backgroundValidate.graphics.beginFill(_backgroundValidColor, bitmapAlpha) : backgroundValidate.graphics.beginFill(_backgroundInvalidColor, bitmapAlpha);
            
            backgroundValidate.graphics.drawRect(0, 0, _width, _height);
            backgroundValidate.graphics.endFill();
        }
        else 
        {
            backgroundValidate.graphics.clear();
        }
    }
}

