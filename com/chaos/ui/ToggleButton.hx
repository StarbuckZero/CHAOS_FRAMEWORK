package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Shape;


/**
 * Creates a simple toggle button it doesn't use a label or icon
 *
 * @author Erick Feiling
 */

class ToggleButton extends BaseUI implements IToggleButton implements IBaseUI
{
	/** The type of UI Element */
	public static inline var TYPE : String = "ToggleButton";

	
	public var selected(get, set) : Bool;

	public var normalState : Shape;
	public var overState : Shape;
	public var downState : Shape;
	public var disableState : Shape;
	
    public var defaultColor(get, set) : Int;
    public var overColor(get, set) : Int;
    public var downColor(get, set) : Int;
    public var disableColor(get, set) : Int;
	
    public var roundEdge(get, set) : Int;
	
    public var bitmapAlpha(get, set) : Float;
	
	
    private var _defaultColor : Int = 0xCCCCCC;
    private var _overColor : Int = 0x666666;
    private var _downColor : Int = 0x333333;
    private var _disableColor : Int = 0x999999;
	
    private var _defaultStateImage : BitmapData;
    private var _overStateImage : BitmapData;
    private var _downStateImage : BitmapData;
    private var _disableStateImage : BitmapData;
	
	private var _bitmapShowImage : Bool = true;
	
	private var _roundEdge : Int = 0;
	
	private var _bgAlpha : Float = 1;
	
	private var _selected : Bool = false;
	private var _tileImage:Bool = false;
	
	private var _imageSmooth : Bool = true;
  
	public function new( toggleWidth:Int = 100, toggleHeight:Int = 100, toggleSelected : Bool = false)
    {
        super();
		
		_width = toggleWidth;
		_height = toggleHeight;
		
		_selected = toggleSelected;
		
		init();
		
    }
	
	private function init() : Void
	{  
		// Setup shapes
		normalState = new Shape();
		overState = new Shape();
		downState = new Shape();
		disableState = new Shape();
		
		addChild(normalState);
		addChild(overState);
		addChild(downState);
		addChild(disableState);
		
		// Setup events 
		addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
		addEventListener(MouseEvent.CLICK, mouseDownEvent, false, 0, true);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true); 
		
		
		mouseChildren = true;
		
		draw();
    }
	
	private function onStageAdd(event : Event) : Void 
	{
		UIBitmapManager.watchElement(TYPE, this);
	}
	
	private function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
    }
	
    /**
	 * Set how rounded the button is
	 */
    
    private function set_roundEdge(value : Int) : Int
    {
        _roundEdge = value;
		
        draw();
        return value;
    }
    
    /**
	 * Return how rounded the button is
	 */
    
    private function get_roundEdge() : Int
    {
        return _roundEdge;
    }	
	
    /**
	 * The button normal state color
	 */
    
    private function set_defaultColor(value : Int) : Int
    {
        _defaultColor = value;
        
        draw();
        return value;
    }
    
    /**
	 * Return the normal state button color
	 */
    
    private function get_defaultColor() : Int
    {
        return _defaultColor;
    }
    
    /**
	 * The button over state color
	 */
    
    private function set_overColor(value : Int) : Int
    {
        _overColor = value;
		
        draw();
        return value;
    }
    
    /**
	 * Return the button over state color
	 */
    
    private function get_overColor() : Int
    {
        return _overColor;
    }
    
    /**
	 * The button down state color
	 */
    
    private function set_downColor(value : Int) : Int
    {
        _downColor = value;
		
        draw();
        return value;
    }
    
    /**
	 * Return the button down state color
	 */
    
    private function get_downColor() : Int
    {
        return _downColor;
    }
    
    /**
	 * The button disable state color
	 */
    
    private function set_disableColor(value : Int) : Int
    {
        _disableColor = value;
		
        draw();
        return value;
    }
    
    /**
	 * Return the button disable state color
	 */
    
    private function get_disableColor() : Int
    {
        return _disableColor;
    }
	
	
	/**
	 * Set if you want the button to be selected or not
	 */
	private function set_selected(value : Bool) : Bool
	{
		_selected = value;
		
		draw();
        return value;
    } 
	
	/**
	 * Return if the button is on it's selected state
	 */
	private function get_selected() : Bool
	{
		return _selected;
    }
	
    /**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
    
    private function set_bitmapAlpha(value : Float) : Float
    {
        _bgAlpha = value;
		
        draw();
        return value;
    }
    
    /**
	 *  Return the alpha of the button
	 */
    
    private function get_bitmapAlpha() : Float
    {
        return _bgAlpha;
    }	
	
	private function set_tileImage(value : Bool) : Bool
	{
		_tileImage = value;
		
		draw();
		return value;
	}
	
	private function get_tileImage() : Bool
	{
		return _tileImage;
	}	
		

	
	/**
	 * This is for setting an shape for the button default stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */  
	
	public function setDefaultStateImage(value : BitmapData) : Void 
	{
		_defaultStateImage = value;
		draw();
    }
	
	/**
	 * This is for setting an shape for the button over stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setOverStateImage(value : BitmapData) : Void
	{  
		_overStateImage = value;
		draw();
    }
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	
	public function setDownStateImage(value : BitmapData) : Void
	{
		_downStateImage = value;
		draw();
    } 
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */  
	public function setDisableStateImage(value : BitmapData) : Void
	{
		_disableStateImage = value;
		draw();
    }
	

	/**
	 * Set if you want the button to be enabled or not
	 *
	 * @param value True if you want the button to be enabled and false if not
	 *
	 */
	override private function set_enabled(value : Bool) : Bool
	{ 
		if (_enabled != value) 
		{
			if (value) 
			{  
				// Add events
				addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
				addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 0, true);
				
				disableState.visible = false;
            }
            else 
			{  
				// Remove Events
				removeEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent);
				removeEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);
				
				disableState.visible = true;
            }
        }
		
		super.enabled = value;
		
        return value;
    }
	
	/**
	 * This setup and draw the toogle button on the screen
	 */ 
	
	override public function draw() : Void 
	{
		// Figure to use bitmap or normal mode
		if (_bitmapShowImage)
		{
			// Normal
			if (null != _defaultStateImage)
				drawButtonState(normalState, _defaultColor, _defaultStateImage);
			else 
				drawButtonState(normalState, _defaultColor);
				
			// Over
			if (null != _overStateImage) 
				drawButtonState(overState, _overColor, _overStateImage);
			else
				drawButtonState(overState, _overColor);
			
			// Down
			if (null != _downStateImage) 
				drawButtonState(downState, _downColor, _downStateImage);
			else 
				drawButtonState(downState, _downColor);
			
			// Disable
			if (null != _disableStateImage) 
				drawButtonState(disableState, _disableColor, _disableStateImage);
			else 
				drawButtonState(disableState, _disableColor);
		}
		else 
		{
			
			drawButtonState(normalState, _defaultColor);
			drawButtonState(overState, _overColor);
			drawButtonState(downState, _downColor);
			drawButtonState(disableState, _disableColor);
		}	
		
		
		// Toggle Seleect state
		if (_selected)
		{
			normalState.visible = false;
			downState.visible = true;
		}
		else
		{
			normalState.visible = true;
			downState.visible = false;
		}		
		
    }
	
	public function drawButtonState(square:Shape,  color:Int = 0xFFFFFF, image:BitmapData = null):Void
	{
		square.graphics.clear();
		
		if (null != image) 
			square.graphics.beginBitmapFill(image, null, _tileImage, _imageSmooth);
		else 
			square.graphics.beginFill(color, _bgAlpha);
		
		if (image != null)
			square.graphics.drawRoundRect(0, 0, image.width, image.height, _roundEdge);
		
		square.graphics.endFill();
	}	
	
	private function mouseOutEvent(event : MouseEvent) : Void 
	{
		
		overState.visible = false;
		
		if (_selected)
			downState.visible = true;
		else
			normalState.visible = true;
		
    }
	
	private function mouseOverEvent(event : MouseEvent) : Void  
	{  
		// Check to set toggle
		overState.visible = true;
		
		if (_selected)
			downState.visible = false;
		else
			normalState.visible = false;
    }
	
	private function mouseDownEvent(event : MouseEvent) : Void
	{
		// Toggle selected stage
		_selected = !_selected;
		
		// Toggle Seleect state
		if (_selected)
		{
			normalState.visible = false;
			downState.visible = true;
		}
		else
		{
			normalState.visible = true;
			downState.visible = false;
		}
		
    }
}