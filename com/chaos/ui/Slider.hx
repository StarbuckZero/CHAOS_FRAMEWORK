package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ISlider;
import com.chaos.utils.ThreadManager;
import com.chaos.utils.Utils;
import com.chaos.utils.data.TaskCallBack;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.events.Event;
import openfl.display.Bitmap;
import com.chaos.ui.Button;
import com.chaos.ui.event.SliderEvent;
import com.chaos.ui.ScrollBarDirection;

import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

/* A simple slider with track
 *
 *  @author Erick Feiling
 *  @date 11-13-09
 *
 */

class Slider extends BaseUI implements ISlider implements IBaseUI
{
	
	/** The type of UI Element */
	public static inline var TYPE : String = "Slider";
	
	public static var sliderEventMode(get, set) : String;

	public var showTrack(get, set) : Bool;
	public var sliderOffSet(get, set) : Float;
	public var rotateImage(get, set) : Bool;
	public var percent(get, set) : Float;
	public var direction(get, set) : String;
	public var trackColor(get, set) : Int;
	public var sliderColor(get, set) : Int;
	public var sliderOverColor(get, set) : Int;
	public var sliderDownColor(get, set) : Int;
	public var sliderDisableColor(get, set) : Int;
	public var sliderWidth(get, set) : Float;
	public var sliderHeight(get, set) : Float;
	
	public var track(get, never) : Shape;
	public var marker(get, never) : IButton;
	

	public static var SLIDER_OFFSET : Float = 0; 

	/** Does percent update check when slider is moved */  
	public static inline var EVENT_MODE : String = "event";  

	/** Starts timer on mouser down and stop it on mosue up*/  
	public static inline var TIMER_MODE : String = "timer";

	private static var _eventMode : String = EVENT_MODE;

	// elements
  
	private var _trackerColor : Int = 0x999999;
	private var _sliderNormalColor : Int = 0xCCCCCC;
	private var _sliderOverColor : Int = 0x666666;
	private var _sliderDownColor : Int = 0x333333;
	private var _sliderDisableColor : Int = 0x999999;
	private var _smoothImage : Bool = true;
	private var _showImage : Bool = true;
	private var _mode : String = ScrollBarDirection.VERTICAL;
	private var _dragging : Bool = false;

	private var _track : Shape;
	private var _marker : Button;
	
	public var sliderWidthNum : Float = 15;
	public var sliderHeightNum : Float = 15;

	private var _sliderOffSet : Float = 0;

	private var _trackerImage : BitmapData;
	private var _rotateImage : Bool = false;

	private var _threadCallBack:TaskCallBack;

	// percentage  
	private var percentage : Float = 0; 
  
	/**
	 * Constructor
	 */
	
	public function new (data:Dynamic = null)
    {
		
		// If nothing is pasted then setup default with and height
		if (data == null)
			data = {"width":100, "height":15};
		
		super(data);
		
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		addEventListener(Event.ADDED_TO_STAGE, stageInit, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, removeStageListener, false, 0, true);
		
		
		
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		
		_mode = (Reflect.hasField(data, "sliderDirection")) ? Reflect.field(data, "sliderDirection") : "vertical";
		_sliderOffSet = SLIDER_OFFSET;
		
		super.setComponentData(data);
		
	}
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); } 
	
	/**
	 * Creates and initializes the marker/track elements.
	 */
	
	override public function initialize():Void 
	{
		
		// Base for scroll bar  
		_track = new Shape(); 
		
		// Slider  
		_marker = new Button();
		
		
		super.initialize();
		
		
		_marker.width = sliderWidthNum;
		_marker.height = sliderHeightNum;
		
		_marker.showLabel = false;
		_marker.iconDisplay = false;
		
		
		_marker.defaultColor = _sliderNormalColor;
		_marker.overColor = _sliderOverColor;
		_marker.downColor = _sliderDownColor;
		_marker.disableColor = _sliderDisableColor;
		_marker.addEventListener(MouseEvent.MOUSE_DOWN, markerPress, false, 0, true);
		
		_threadCallBack = new TaskCallBack(this, "updatePercent");
		
		
		if (ScrollBarDirection.VERTICAL == _mode) 
			_marker.y = _track.y + _sliderOffSet;
        else 
			_marker.x = _track.x + _sliderOffSet;
			
		addChild(_track);
		addChild(_marker);
		
		//draw();		
	}

	
	override public function reskin() : Void
	{
		super.reskin();
		
		initSkin();
		initStyle();
		
		draw();
    }
	
	private function initSkin() : Void
	{
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_NORMAL))    
		setSliderImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_OVER))     
        setSliderOverImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DOWN))
		setSliderDownImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DISABLE))  
		setSliderDisableImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DISABLE));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_TRACK))     
        setTrackImage(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_TRACK));
		
    }
	
	private function initStyle() : Void 
	{
		if ( -1 != UIStyleManager.SLIDER_NORMAL_COLOR)    
			sliderColor = UIStyleManager.SLIDER_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.SLIDER_OVER_COLOR)       
			sliderOverColor = UIStyleManager.SLIDER_OVER_COLOR;
		
		if ( -1 != UIStyleManager.SLIDER_DOWN_COLOR)   
			sliderDownColor = UIStyleManager.SLIDER_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.SLIDER_DISABLE_COLOR)      
			sliderDisableColor = UIStyleManager.SLIDER_DISABLE_COLOR;
		
		if ( -1 != UIStyleManager.SLIDER_SIZE)        
			sliderWidth = sliderHeightNum = UIStyleManager.SLIDER_SIZE;
		
		if ( -1 != UIStyleManager.SLIDER_TRACK_SIZE)  
			_width = _height = UIStyleManager.SLIDER_TRACK_SIZE;
		
		if ( -1 != UIStyleManager.SLIDER_TRACK_COLOR)    
			trackColor = UIStyleManager.SLIDER_TRACK_COLOR;
		
		if ( -1 != UIStyleManager.SLIDER_OFFSET)      
			SLIDER_OFFSET = UIStyleManager.SLIDER_OFFSET; 
		
		rotateImage = UIStyleManager.SLIDER_ROTATE_IMAGE;
    } 
	
	
	
	/**
	 * Set the mode that is being used once user click on slider. Use Slider.EVENT_MODE or Slider.TIMER_MODE
	 */
	
	private static function set_sliderEventMode(value : String) : String 
	{
		_eventMode = value;
        return value;
    }
	
	/** @private */
	
	private static function get_sliderEventMode() : String
	{
		return _eventMode;
    }
	
	private function get_marker():IButton
	{
		return _marker;
	}
	
	private function get_track():Shape
	{
		return _track;
	}
	
	

	/**
	 * Hides or show the track for the slider bar
	 */
	
	private function set_showTrack(value : Bool) : Bool 
	{
		_track.visible = value;
		
		return value; 
	}  
	
	/**
	 * Return true if the track is being displayed and false if hidden
	 */
	
	private function get_showTrack() : Bool 
	{
		return _track.visible;
	}
	
	
	/**
	 * Slider offset
	 */
	 
	private function set_sliderOffSet(value : Float) : Float
	{
		_sliderOffSet = value;
		//draw();
		
        return value;
    }
	
	/**
	 * Return the slider
	 */
	
	private function get_sliderOffSet() : Float
	{
		return _sliderOffSet;
    }
	
	/**
	 * This will rotate the images being used by 90 degrees if in horizontal mode
	 */ 
	private function set_rotateImage(value : Bool) : Bool 
	{
		_rotateImage = value;
		//draw();
		
        return value;
    }
	
	/**
	 * Return if the image will be rotated by 90 degrees if in horizontal mode
	 */
	
	private function get_rotateImage() : Bool
	{
		return _rotateImage;
    } 
	
	/**
	 * The percent is represented as a value between 0 and 1.
	 */  
	private function set_percent(value : Float) : Float
	{
		percentage = Math.min(1, Math.max(0, value));
		
		if (ScrollBarDirection.VERTICAL == _mode) 
		{
			_marker.y = _track.y + percentage * (_track.height - _marker.height);
			_marker.x = _track.x + _sliderOffSet;
        }
        else 
		{
			_marker.x = _track.x + percentage * (_track.width - _marker.width);
			_marker.y = _track.y + _sliderOffSet;
        }
		
		dispatchEvent(new SliderEvent(SliderEvent.CHANGE, percentage));
		
        return value;
		
    } 
	
	/**
	 * The percent is represented as a value between 0 and 1.
	 */
	
	private function get_percent() : Float
	{
		return percentage;
    }
	
	/**
	 * Set the direction of the slider, this use the same static class to set the direction just like the scrollbar classe. ScrollBarDirection.HORIZONTAL or ScrollBarDirection.VERTICAL
	 *
	 * @see com.chaos.ui.ScrollBarDirection;
	 */  
	
	private function set_direction(value : String) : String 
	{
		if (ScrollBarDirection.HORIZONTAL == value || ScrollBarDirection.VERTICAL == value) 
		_mode = value;
		
		// Write the direction of the track and slider
		draw();
		
        return value;
    }
	
	/**
	 * Returns the direction the scrollbar is facing.
	 */
	
	private function get_direction() : String
	{
		return _mode;
    } 
	
	/**
	 * Remove all roll over and roll out effects while setting the slider to it's disable state
	 *
	 * @param value Disable or Enable slider
	 */
	
	override private function set_enabled(value : Bool) : Bool
	{
		super.enabled = _marker.visible = _enabled = value;
		draw();
		
        return value;
    }
	
	/**
	 * Set the color of the track
	 */
	private function set_trackColor(value : Int) : Int
	{
		_trackerColor = value;
		draw();
		
        return value;
    }
	
	/**
	 * Returns the color of the slider track
	 */
	
	private function get_trackColor() : Int
	{
		return _trackerColor;
    }
	
	/**
	 * Set the color of the slider
	 */
	private function set_sliderColor(value : Int) : Int
	{
		_marker.defaultColor = _sliderNormalColor = value;
        return value;
    } 
	
	/**
	 * Returns the color
	 */
	
	private function get_sliderColor() : Int 
	{
		return _sliderNormalColor;
    }
	
	/**
	 * Set the color of the slider over state
	 */ 
	private function set_sliderOverColor(value : Int) : Int
	{
		_marker.overColor = _sliderOverColor = value;
        return value;
    }
	
	/**
	 * Returns the color
	 */
	
	private function get_sliderOverColor() : Int
	{
		return _sliderOverColor;
    }
	
	/**
	 * Set the color of the slider down state
	 */
	
	private function set_sliderDownColor(value : Int) : Int
	{
		_marker.downColor = _sliderDownColor = value;
        return value;
    }
	
	/**
	 * Returns the color
	 */
	private function get_sliderDownColor() : Int
	{
		return _sliderDownColor;
    }
	
	/**
	 * Set the color of the slider disabled state
	 */
	private function set_sliderDisableColor(value : Int) : Int
	{
		_marker.disableColor = _sliderDisableColor = value;
        return value;
    } 
	
	/**
	 * Returns the color
	 */
	private function get_sliderDisableColor() : Int
	{
		return _sliderDisableColor;
    } 

	/**
	 * Set the slider width
	 */
	private function set_sliderWidth(value : Float) : Float 
	{
		sliderWidthNum = value;
		
		if (ScrollBarDirection.VERTICAL == _mode)
		{
			
			_marker.width = sliderWidthNum;
			_marker.height = sliderHeightNum;
		}
        else
			_marker.width = sliderWidthNum;
		
		draw();
		
        return value;
		
    } 
	
	/**
	 * Returns the slider width
	 */
	private function get_sliderWidth() : Float 
	{
		return sliderWidthNum;
    }  
	
	/**
	 * Set the slider height
	 */
	private function set_sliderHeight(value : Float) : Float 
	{
		sliderHeightNum = value;
		
		if (ScrollBarDirection.VERTICAL == _mode) 
		{
			_marker.width = sliderWidthNum;
			_marker.height = sliderHeightNum;
        }
        else 
		{
			_marker.height = sliderHeightNum;
        }
		
		draw();
		
        return value;
    } 
	
	/**
	 * Returns the slider height
	 */
		
	private function get_sliderHeight() : Float
	{
		return sliderHeightNum;
    } 
	


	
	/**
	 * Set a image to the track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setTrackImage(value : BitmapData) : Void
	{
		_trackerImage = value;
		
		draw();
    }
	

	
	/**
	 * Set a image to the slider default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderImage(value : BitmapData) : Void 
	{
		_marker.setDefaultStateImage(value);
    } 
	

	
	/**
	 * Set a image to the scrollbar slider over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderOverImage(value : BitmapData) : Void
	{
		_marker.setOverStateImage(value);
    }
	

	
	/**
	 * Set a image to the slider down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	public function setSliderDownImage(value : BitmapData) : Void 
	{
		_marker.setDownStateImage(value);
    }  
	

	
	/**
	 * Set a image to the slider disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderDisableImage(value : BitmapData) : Void
	{
		_marker.setDisableStateImage(value);
    }
	

	
	/**
	 * Stop the slider from moving
	 */
	
	public function stop() : Void
	{
		if (_dragging) 
		{ 
			// Flag for dragging
			_dragging = false;
			
			_marker.stopDrag();
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePercent);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopSliding);
			
			ThreadManager.removeEventTimer(_threadCallBack);
        }
    }
	
	// ends the sliding session 
	private function stopSliding(event : MouseEvent) : Void
	{
		// Flag for dragging
		_dragging = false;
		_marker.stopDrag();
		
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePercent);
		stage.removeEventListener(MouseEvent.MOUSE_UP, stopSliding);
		
		
		ThreadManager.removeEventTimer(_threadCallBack);
    } 
	
	// updates the data to reflect the visuals
	private function updatePercent(event : MouseEvent = null) : Void
	{
		if (null != event)
			event.updateAfterEvent();
		
		if (ScrollBarDirection.VERTICAL == _mode)
			percentage = Math.round((_marker.y - _track.y) / (_track.height - _marker.height) * 100) / 100;
        else 
			percentage = Math.round((_marker.x - _track.x) / (_track.width - _marker.width) * 100) / 100;
		
		dispatchEvent(new SliderEvent(SliderEvent.CHANGE, percentage));
    } 
	
	//  Executed when the marker is pressed by the user
	private function markerPress(event : MouseEvent) : Void
	{
		// Flag for dragging 
		_dragging = true;
		
		if (ScrollBarDirection.VERTICAL == _mode)
			_marker.startDrag(false, new Rectangle(_sliderOffSet, _track.y, 0, (_height - sliderHeightNum)))
        else
			_marker.startDrag(false, new Rectangle(_track.x, _sliderOffSet, (_width - sliderWidthNum), 0));
		
		if (_eventMode == TIMER_MODE)
			ThreadManager.addEventTimer(_threadCallBack);
        else
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updatePercent, false, 0, true);
		
		stage.addEventListener(MouseEvent.MOUSE_UP, stopSliding, false, 0, true);
    }
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Event
		if (_dragging) 
		{ 
			// Flag for dragging
			_dragging = false;
			
			_marker.stopDrag();
			
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePercent);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopSliding);
			
			ThreadManager.removeEventTimer(_threadCallBack);
        }
		
		// Drawing
		_track.graphics.clear();
		
		removeChild(_track);
		removeChild(_marker);
		
		_marker.destroy();
		
		_track = null;
		_marker = null;
		_trackerImage = null;
	}
	
	/**
	 * Draw the element on the stage
	 *
	 */ 
	override public function draw() : Void
	{
		super.draw();
		
		_track.graphics.clear();
		
		if (_trackerImage != null && _showImage) 
		{
			if (ScrollBarDirection.VERTICAL == _mode) 
				_track.graphics.beginBitmapFill(_trackerImage, null, true, _smoothImage);
            else 
				_track.graphics.beginBitmapFill(_trackerImage, ((_rotateImage)) ? Utils.matrixRotate(new Bitmap(_trackerImage), 90) : null, true, _smoothImage);
        }
        else 
		{
			_track.graphics.beginFill(_trackerColor, 1);
        }
		
		_track.graphics.drawRect(0, 0, _width, _height);
		_track.graphics.endFill();
		
		// This updates the slider bar
		percent = percentage;
    }
	
	private function stageInit(event : Event) : Void
	{
		stage.addEventListener(MouseEvent.MOUSE_UP, stopSliding, false, 0, true);
		ThreadManager.stage = stage;
    }
	
	private function removeStageListener(event : Event) : Void
	{
		stage.removeEventListener(MouseEvent.MOUSE_UP, stopSliding);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePercent);
		
		_marker.removeEventListener(MouseEvent.MOUSE_DOWN, markerPress);
    }
	

}