package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.display.Shape;
import com.chaos.ui.event.ToggleEvent;
import com.chaos.media.DisplayImage;
import com.chaos.ui.UIDetailLevel;
//import com.chaos.ui.interface.IToggleButton;
//import com.chaos.ui.interface.IBaseUI;  

/**
 * Creates a simple toggle button that only support sprites and bitmaps. This is mainly used for radio button and checkbox classes.
 *
 * @author Erick Feiling
 */

class ToggleButtonLite extends BaseUI implements com.chaos.ui.classInterface.IToggleButton implements com.chaos.ui.classInterface.IBaseUI
{
	/** The type of UI Element */
	public static inline var TYPE : String = "ToggleButton";

	public var toggleButton(get, never) : Sprite;
	public var selected(get, set) : Bool;


	private var _normalIndex : Int = 0;
	private var _overIndex : Int = 1;
	private var _downIndex : Int = 2;
	private var _disableIndex : Int = 3;
	private var _buttonClip : Sprite;
	private var _blnNormal : Bool = false;
	private var _blnOver : Bool = false;
	private var _blnDown : Bool = false;
	private var _blnDisable : Bool = false;
	private var _baseNormal : Shape;
	private var _baseOver : Shape;
	private var _baseDown : Shape;
	private var _baseDisable : Shape;
	private var _toggleDown : Bool = false;
  
  public function new(toggleSelected : Bool = false)
    {
        super();
		
		_toggleDown = toggleSelected;
		
		init_toggle();
    }
	
	private function init_toggle() : Void
	{  
		// Setup sprites and add them to the stage 
		_buttonClip = new Sprite();
		_baseNormal = new Shape();
		_baseOver = new Shape();
		_baseDown = new Shape();
		_baseDisable = new Shape();
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true); 
		
		// Add toggle button to stage which default to 0  
		addChild(_buttonClip); 
		
		// Setup events 
		addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
		addEventListener(MouseEvent.CLICK, mouseDownEvent, false, 0, true);
		
		mouseChildren = true;
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
	 * Return the display object that holds all the shapes that are being used to draw the button
	 */
	
	private function get_toggleButton() : Sprite
	{
		return _buttonClip;
    }
	
	/**
	 * This is for setting an shape for the button default stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */  
	public function setNormalState(normalSprite : Shape) : Void 
	{  
		// Remove item if already in display  
		if (_blnNormal)         
		_buttonClip.removeChildAt(_normalIndex);
		
		_baseNormal = normalSprite;
		_buttonClip.addChildAt(_baseNormal, _normalIndex);
		_blnNormal = true;
		_baseNormal.visible = true;
		
		draw();
    }
	
	/**
	 * This is for setting an shape for the button over stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setOverState(overState : Shape) : Void
	{  
		// Remove item if already in display 
		if (_blnOver)      
		_buttonClip.removeChildAt(_overIndex);
		
		_baseOver = overState;
		_buttonClip.addChildAt(_baseOver, _overIndex);
		_blnOver = true;
		
		_baseOver.visible = false;
		
		draw();
    }
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	
	public function setDownState(downState : Shape) : Void
	{
		if (_blnDown)       
		_buttonClip.removeChildAt(_downIndex);
		
		_baseDown = downState;
		_buttonClip.addChildAt(_baseDown, _downIndex);
		_blnDown = true;
		_baseOver.visible = false;
		
		draw();
    } 
	
	/**
	 * This is for setting an shape for the button down stage
	 *
	 * @param value Set the shape that you want to use
	 *
	 */  
	public function setDisableState(disableState : Shape) : Void
	{
		if (_blnDisable)
		_buttonClip.removeChildAt(_disableIndex);
		
		_baseDisable = disableState;
		_buttonClip.addChildAt(_baseDisable, _disableIndex);
		
		_blnDisable = true;
		_baseDisable.visible = false;
		
		draw();
		
		dispatchEvent(new ToggleEvent(ToggleEvent.DISABLE_STATE));
    }
	
	/**
	 * Set if you want the button to be selected or not
	 */
	private function set_selected(value : Bool) : Bool
	{
		_toggleDown = value;
		draw();
		
        return value;
    } 
	
	/**
	 * Return if the button is on it's selected state
	 */
	private function get_selected() : Bool
	{
		return _toggleDown;
    }
	
	/**
	 * Set if you want the button to be enabled or not
	 *
	 * @param value True if you want the button to be enabled and false if not
	 *
	 */
	override private function set_enabled(value : Bool) : Bool
	{ 
		if (enabled != value) 
		{ 
			if (value) 
			{  
				// Add events
				_buttonClip.addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
				_buttonClip.addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
				_buttonClip.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 0, true);
				
				_baseDisable.visible = false;
            }
            else 
			{  
				// Remove Events
				_buttonClip.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent);
				_buttonClip.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent);
				_buttonClip.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);
				
				_baseDisable.visible = true;
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
		// Check to set toggle
		if (_toggleDown) 
		{
			_baseNormal.visible = false;
			_baseDown.visible = true;
        }
        else 
		{
			_baseNormal.visible = true;
			_baseDown.visible = false;
        }
    }
	
	private function mouseOutEvent(event : MouseEvent) : Void 
	{  
		// Check to set toggle
		draw();
		
		_baseOver.visible = false;
		dispatchEvent(new ToggleEvent(ToggleEvent.NORMAL_STATE));
    }
	
	private function mouseOverEvent(event : MouseEvent) : Void  
	{  
		// Check to set toggle
		_baseNormal.visible = false;
		_baseDown.visible = false;
		_baseOver.visible = true;
		
		dispatchEvent(new ToggleEvent(ToggleEvent.OVER_STATE));
    }
	
	private function mouseDownEvent(event : MouseEvent) : Void
	{
		if (_toggleDown) 
		{
			_toggleDown = false;
        }
        else 
		{
			_toggleDown = true;
        }
		
		draw();
		
		_baseOver.visible = false;
		dispatchEvent(new ToggleEvent(ToggleEvent.DOWN_STATE));
    }
}