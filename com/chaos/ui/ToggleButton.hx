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
  
	public function new( data:Dynamic = null)
    {
        super(data);
		
		
		// Setup events 
		addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 2, true);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true); 
		
		buttonMode = true;
		mouseChildren = false;
		
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "selected"))
			_selected = Reflect.field(data, "selected");
			
		if (Reflect.hasField(data, "defaultColor"))
			_defaultColor = Reflect.field(data, "defaultColor");
			
		if (Reflect.hasField(data, "overColor"))
			_overColor = Reflect.field(data, "overColor");
			
		if (Reflect.hasField(data, "downColor"))
			_downColor = Reflect.field(data, "downColor");
			
		if (Reflect.hasField(data, "disableColor"))
			_disableColor = Reflect.field(data, "disableColor");
			
		if (Reflect.hasField(data, "roundEdge"))
			_roundEdge = Reflect.field(data, "roundEdge");
			
		if (Reflect.hasField(data, "backgroundAlpha"))
			_roundEdge = Reflect.field(data, "backgroundAlpha");
			
			
			
	}
	
	override public function initialize() : Void
	{
		// Setup shapes
		normalState = new Shape();
		overState = new Shape();
		downState = new Shape();
		disableState = new Shape();
		
		super.initialize();
		
		addChild(normalState);
		addChild(overState);
		addChild(downState);
		addChild(disableState);
		
		reskin();
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
				if (!hasEventListener(MouseEvent.MOUSE_OUT))
					addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
				
				if (!hasEventListener(MouseEvent.MOUSE_OVER))
					addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
				
				if (!hasEventListener(MouseEvent.MOUSE_DOWN))
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
		
		super.enabled = buttonMode = value;
		
        return value;
    }
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Remove Events 
		removeEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent);
		removeEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent);
		removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);
		
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove); 
		
		normalState.graphics.clear();
		overState.graphics.clear();
		downState.graphics.clear();
		disableState.graphics.clear();
		
		removeChild(normalState);
		removeChild(overState);
		removeChild(downState);
		removeChild(disableState);
		
		_defaultStateImage = null;
		_overStateImage = null;
		_downStateImage = null;
		_disableStateImage = null;
		
		normalState = null;
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
			downState.visible = true;
			disableState.visible = normalState.visible = false;
		}
		else
		{
			normalState.visible = true;
			disableState.visible = downState.visible = false;
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
		else
			square.graphics.drawRoundRect(0, 0, _width, _height, _roundEdge);
		
		square.graphics.endFill();
	}	
	
	private function mouseOutEvent(event : MouseEvent) : Void 
	{
		
		overState.visible = false;
		
		if (_selected)
		{
			downState.visible = true;
			normalState.visible = disableState.visible = false;
		}
		else
		{
			normalState.visible = true;
			downState.visible = disableState.visible = false;
		}
		
    }
	
	private function mouseOverEvent(event : MouseEvent) : Void  
	{  
		// Check to set toggle
		overState.visible = true;
		
		disableState.visible = downState.visible = normalState.visible = false;
		
		//if (_selected)
		//{
		//	downState.visible = false;
		//	disableState.visible = false;
		//	
		//}
		//else
		//{
		//	disableState.visible = false;
		//	normalState.visible = false;
		//}
    }
	
	private function mouseDownEvent(event : MouseEvent) : Void
	{
		
		// Toggle selected stage
		_selected = !_selected;
		
		// Toggle Seleect state
		if (_selected)
		{
			downState.visible = true;
			overState.visible = disableState.visible = normalState.visible = false;
		}
		else
		{
			normalState.visible = true;
			overState.visible = disableState.visible = downState.visible = false;
		}
		
    }
}