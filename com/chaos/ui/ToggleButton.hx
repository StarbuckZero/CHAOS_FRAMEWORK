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

	
    /**
	 * Set if you want the button to be selected or not
	 */
	
	public var selected(get, set) : Bool;

	 /**
	 * The button normal state color
	 */ 
	 
    public var defaultColor(get, set) : Int;
	
	 /**
	 * The button over state color
	 */   
	 
    public var overColor(get, set) : Int;
	
	 /**
	 * The button down state color
	 */ 
	 
    public var downColor(get, set) : Int;
	
	 /**
	 * The button disable state color
	 */   
	 
    public var disableColor(get, set) : Int;
	
	 /**
	 * Set how rounded the button is
	 */ 
	 
    public var roundEdge(get, set) : Int;
	
	 /**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
	 
    public var bitmapAlpha(get, set) : Float;
	
	 /**
	  * Title the image that is being used
	  */
	 
	public var tileImage(get, set) : Bool;
	
	public var normalState : Shape = new Shape();
	public var overState : Shape = new Shape();
	public var downState : Shape = new Shape();
	public var disableState : Shape = new Shape();
	
	
    private var _defaultColor : Int = 0xCCCCCC;
    private var _overColor : Int = 0x666666;
    private var _downColor : Int = 0x333333;
    private var _disableColor : Int = 0x999999;
	
    private var _defaultStateImage : BitmapData;
    private var _overStateImage : BitmapData;
    private var _downStateImage : BitmapData;
    private var _disableStateImage : BitmapData;
	
	private var _roundEdge : Int = 0;
	
	private var _bgAlpha : Float = UIStyleManager.BUTTON_ALPHA;
	
	private var _selected : Bool = false;
	private var _tileImage:Bool = false;
	
	/**
	 * UI Toggle Button 
	 * @param	data The proprieties that you want to set on component.
	 */
  
	public function new( data:Dynamic = null )
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
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
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
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize() : Void
	{
		
		super.initialize();
		
		addChild(normalState);
		addChild(overState);
		addChild(downState);
		addChild(disableState);

    }
	
	/**
	 * Unload Component
	 */
	
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
		
		if (_defaultStateImage != null)
			_defaultStateImage.dispose();
		
		if (_defaultStateImage != null)
			_defaultStateImage.dispose();
			
		if (_downStateImage != null)
			_downStateImage.dispose();
		
		if (_disableStateImage != null)
			_disableStateImage.dispose();
		
		_disableStateImage = _downStateImage = _overStateImage = _defaultStateImage = null;
		disableState = downState = overState = normalState = null;
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
		

		return value;
	}
	
	private function get_tileImage() : Bool
	{
		return _tileImage;
	}	
		

	
	/**
	 * This is for setting an shape for the button default state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */  
	
	public function setDefaultStateImage(value : BitmapData) : Void 
	{
		_defaultStateImage = value;
		
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
				normalState.visible = downState.visible = overState.visible = false;
				
            }
        }
		
		super.enabled = buttonMode = value;
		
        return value;
    }
	

	
	/**
	 * This setup and draw the toogle button on the screen
	 */ 
	
	override public function draw() : Void 
	{
		// Figure to use bitmap or normal mode
		drawButtonState(normalState, _defaultColor, _defaultStateImage);
		drawButtonState(overState, _overColor, _overStateImage);
		drawButtonState(downState, _downColor, _downStateImage);
		drawButtonState(disableState, _disableColor, _disableStateImage);
		
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
		
		
		if (!_enabled)
			disableState.visible = true;
		
		
    }
	
	/**
	 * Draws shape that could be textured
	 * @param	square The shape that will be used
	 * @param	color The color of the shape if no image being passed
	 * @param	image The image
	 */
	
	public function drawButtonState(square:Shape,  color:Int = 0xFFFFFF, image:BitmapData = null):Void
	{
		square.graphics.clear();
		
		if (null != image) 
			square.graphics.beginBitmapFill(image, null, _tileImage, _smoothImage);
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