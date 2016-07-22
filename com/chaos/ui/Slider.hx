package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ISlider;
import com.chaos.utils.ThreadManager;
import com.chaos.utils.Utils;
import com.chaos.utils.data.TaskCallBack;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.events.Event;
import openfl.display.Bitmap;
import com.chaos.ui.Button;
import com.chaos.ui.event.SliderEvent;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.media.DisplayImage;
import com.chaos.ui.UIDetailLevel;
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
    public static var sliderEventMode(get, set) : String;
	
    public var showTrack(get, set) : Bool;
    public var sliderOffSet(get, set) : Int;
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
    public var trackWidth(get, set) : Float;
    public var trackHeight(get, set) : Float;
	
  /** The type of UI Element */
  public static inline var TYPE : String = "Slider";
  
  public static var SLIDER_OFFSET : Int = 0; 
  
  /** Does percent update check when slider is moved */  
  public static inline var EVENT_MODE : String = "event";  
  
  /** Starts timer on mouser down and stop it on mosue up*/  
  public static inline var TIMER_MODE : String = "timer";
  
  private static var _eventMode : String = EVENT_MODE;
  
  // elements
  public var track : Sprite;
  public var marker : Button;
  
  private var _trackerColor : Int = 0x999999;
  private var _sliderNormalColor : Int = 0xCCCCCC;
  private var _sliderOverColor : Int = 0x666666;
  private var _sliderDownColor : Int = 0x333333;
  private var _sliderDisableColor : Int = 0x999999;
  private var _smoothImage : Bool = true;
  private var _showImage : Bool = true;
  private var _mode : String = ScrollBarDirection.VERTICAL;
  private var _qualityMode : String = UIDetailLevel.HIGH;
  private var _dragging : Bool = false;
  
  public var trackWidthNum : Float = 15;
  public var trackHeightNum : Float = 15;
  
  public var sliderWidthNum : Float = 15;
  public var sliderHeightNum : Float = 15;
  
  private var _sliderOffSet : Int = 0;
  
  private var _displayTrackerImage : Bool = false;
  private var _trackerImage : DisplayImage;
  private var _rotateImage : Bool = false;
  
  private var _threadCallBack:TaskCallBack;
  
  // percentage  
  private var percentage : Float = 0; 
  
	/**
	 * Constructor
	 */
	
	public function new (sliderWidth : Int = 100, sliderHeight : Int = 15, sliderDirection : String = "vertical")
    {
		super();
		
		trackWidthNum = sliderWidth;
		trackHeightNum = sliderHeight;
		
		_mode = sliderDirection;
		_sliderOffSet = SLIDER_OFFSET;
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		init();
    }
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); } 
	
	/**
	 * Creates and initializes the marker/track elements.
	 */
	private function init() : Void 
	{  
		// Setup image holder for texters 
		_trackerImage = new DisplayImage();
		_trackerImage.onImageComplete = trackerImageComplete;
		
		// Base for scroll bar  
		track = new Sprite(); 
		
		// Slider  
		marker = new Button();
		marker.width = sliderWidthNum;
		marker.height = sliderHeightNum;
		
		marker.showLabel = false;
		
		initSkin();
		initStyle();
		
		marker.buttonColor = _sliderNormalColor;
		marker.buttonOverColor = _sliderOverColor;
		marker.buttonDownColor = _sliderDownColor;
		marker.buttonDisableColor = _sliderDisableColor;
		marker.addEventListener(MouseEvent.MOUSE_DOWN, markerPress, false, 0, true);
		
		_threadCallBack = new TaskCallBack(this, "updatePercent");
		
		
		if (ScrollBarDirection.VERTICAL == _mode) 
			marker.y = track.y + _sliderOffSet;
        else 
			marker.x = track.x + _sliderOffSet;
			
		addChild(track);
		addChild(marker);
		
		draw();
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
		setSliderBitmap(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_OVER))     
        setSliderOverBitmap(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DOWN))
		setSliderDownBitmap(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DISABLE))  
		setSliderDisableBitmap(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_BUTTON_DISABLE));
		
		if (null != UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_TRACK))     
        setTrackBitmap(UIBitmapManager.getUIElement(Slider.TYPE, UIBitmapManager.SLIDER_TRACK));
		
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
		trackHeightNum = trackWidth = UIStyleManager.SLIDER_TRACK_SIZE;
		
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
	#if flash @:getter(width) #else override #end
	private function set_width(value : Float) : Float
	{
		trackWidthNum = value;
		draw();
		
        return value;
    }
	#if flash @:getter(width) #else override #end
	private function get_width() : Float
	{
		return trackWidthNum;
    }
	#if flash @:getter(width) #else override #end
	private function set_height(value : Float) : Float 
	{
		trackHeightNum = value;draw();
        return value;
    }
	#if flash @:getter(width) #else override #end
	private function get_height() : Float
	{
		return trackHeightNum;
    }
	
	/**
	 * Hides or show the track for the slider bar
	 */
	
	private function set_showTrack(value : Bool) : Bool 
	{
		track.visible = value;
		
		return value; 
	}  
	
	/**
	 * Return true if the track is being displayed and false if hidden
	 */
	
	private function get_showTrack() : Bool 
	{
		return track.visible;
	}
	
	
	/**
	 * Slider offset
	 */
	 
	private function set_sliderOffSet(value : Int) : Int
	{
		_sliderOffSet = value;draw();
        return value;
    }
	
	/**
	 * Return the slider
	 */
	
	private function get_sliderOffSet() : Int
	{
		return _sliderOffSet;
    }
	
	/**
	 * This will rotate the images being used by 90 degrees if in horizontal mode
	 */ 
	private function set_rotateImage(value : Bool) : Bool 
	{
		_rotateImage = value;
		draw();
		
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
			marker.y = track.y + percentage * (track.height - marker.height);marker.x = track.x + _sliderOffSet;
        }
        else 
		{
			marker.x = track.x + percentage * (track.width - marker.width);marker.y = track.y + _sliderOffSet;
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
		super.enabled = marker.visible = _enabled = value;
		this.draw();
		
        return value;
    }
	
	/**
	 * Set the color of the track
	 */
	private function set_trackColor(value : Int) : Int
	{
		_trackerColor = value;
		this.draw();
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
		marker.buttonColor = _sliderNormalColor = value;
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
		marker.buttonOverColor = _sliderOverColor = value;
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
		marker.buttonDownColor = _sliderDownColor = value;
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
		marker.buttonDisableColor = _sliderDisableColor = value;
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
			
			marker.height = sliderHeightNum;
			marker.width = sliderWidthNum;
		}
        else
			marker.width = sliderWidthNum;
		
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
			marker.height = sliderHeightNum;
			marker.width = sliderWidthNum;
        }
        else 
		{
			marker.height = sliderHeightNum;
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
	 * Set the slider track width
	 */
	
	private function set_trackWidth(value : Float) : Float 
	{
		trackWidthNum = value;
		this.draw();
		
        return value;
    } 
	
	/**
	 * Returns the slider track width
	 */
	
	private function get_trackWidth() : Float
	{
		return trackWidthNum;
    } 
	
	/**
	 * Set the slider track height
	 */
	
	private function set_trackHeight(value : Float) : Float 
	{
		trackHeightNum = value;
		draw();
		
        return value;
    }
	
	/**
	 * Returns the slider track height
	 */
	private function get_trackHeight() : Float 
	{
		return trackHeightNum;
    } 
	
	/**
	 * Set the track using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	public function setTrackImage(value : String) : Void 
	{
		_trackerImage.load(value);
    }
	
	/**
	 * Set a image to the track
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setTrackBitmap(value : Bitmap) : Void
	{
		_trackerImage.setImage(value);
		_displayTrackerImage = true;
		
		draw();
    }
	
	/**
	 * Set the slider default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	public function setSliderImage(value : String) : Void
	{
		marker.setBackgroundImage(value);
    }  
	
	/**
	 * Set a image to the slider default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderBitmap(value : Bitmap) : Void 
	{
		marker.setBackgroundBitmap(value);
    } 
	
	/**
	 * Set the slider over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	public function setSliderOverImage(value : String) : Void
	{
		marker.setOverBackgroundImage(value);
    }
	
	/**
	 * Set a image to the scrollbar slider over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderOverBitmap(value : Bitmap) : Void
	{
		marker.setOverBackgroundBitmap(value);
    }
	
	/**
	 * Set the slider down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	
	public function setSliderDownImage(value : String) : Void
	{
		marker.setDownBackgroundImage(value);
    }
	
	/**
	 * Set a image to the slider down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	public function setSliderDownBitmap(value : Bitmap) : Void 
	{
		marker.setDownBackgroundBitmap(value);
    }  
	
	/**
	 * Set the slider disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	
	public function setSliderDisableImage(value : String) : Void 
	{
		marker.setDisableBackgroundImage(value);
    }
	
	/**
	 * Set a image to the slider disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setSliderDisableBitmap(value : Bitmap) : Void
	{
		marker.setDisableBackgroundBitmap(value);
    }
	
	/**
	 * Set the level of detail on the Slider. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 * @see com.chaos.ui.UIDetailLevel
	 */  
	
	 override private function set_detail(value : String) : String
	 {
		super.detail = value;  
		
		 // Only turn off filter if medium and low  
		 if (value.toLowerCase() == UIDetailLevel.HIGH) 
		 {
			 _smoothImage = true;
			 _showImage = true;
			 _qualityMode = value.toLowerCase();
        }
        else if (value.toLowerCase() == UIDetailLevel.MEDIUM) 
		{
			_smoothImage = false;
			_showImage = true;
			_qualityMode = value.toLowerCase();
        }
        else if (value.toLowerCase() == UIDetailLevel.LOW) 
		{
			_showImage = false;_qualityMode = value.toLowerCase();
        }
		
        else 
		{
			_showImage = false;super.detail = UIDetailLevel.LOW;
        }
		
		super.detail = marker.detail = _qualityMode; this.draw();
		
        return value;
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
			marker.stopDrag();
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
		marker.stopDrag();
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
			percentage = Math.round((marker.y - track.y) / (track.height - marker.height) * 100) / 100;
        else 
			percentage = Math.round((marker.x - track.x) / (track.width - marker.width) * 100) / 100;
		
		dispatchEvent(new SliderEvent(SliderEvent.CHANGE, percentage));
    } 
	
	//  Executed when the marker is pressed by the user
	private function markerPress(event : MouseEvent) : Void
	{
		// Flag for dragging 
		_dragging = true;
		
		if (ScrollBarDirection.VERTICAL == _mode)
			marker.startDrag(false, new Rectangle(_sliderOffSet, track.y, 0, (trackHeightNum - sliderHeightNum)))
        else
			marker.startDrag(false, new Rectangle(track.x, _sliderOffSet, (trackWidthNum - sliderWidthNum), 0));
		
		if (_eventMode == TIMER_MODE)
			ThreadManager.addEventTimer(_threadCallBack);
        else
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updatePercent, false, 0, true);
		
		stage.addEventListener(MouseEvent.MOUSE_UP, stopSliding, false, 0, true);
    }
	
	/**
	 * Draw the element on the stage
	 *
	 */ 
	override public function draw() : Void
	{
		super.draw();
		track.graphics.clear();
		
		if (_displayTrackerImage && _showImage) 
		{
			if (ScrollBarDirection.VERTICAL == _mode) 
				track.graphics.beginBitmapFill(_trackerImage.image.bitmapData, null, true, _smoothImage);
            else 
				track.graphics.beginBitmapFill(_trackerImage.image.bitmapData, ((_rotateImage)) ? Utils.matrixRotate(_trackerImage, 90) : null, true, _smoothImage);
        }
        else 
		{
			track.graphics.beginFill(_trackerColor, 1);
        }
		
		track.graphics.drawRect(0, 0, trackWidthNum, trackHeightNum);
		track.graphics.endFill();
		
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
		marker.removeEventListener(MouseEvent.MOUSE_DOWN, markerPress);
		stage.removeEventListener(MouseEvent.MOUSE_MOVE, updatePercent);
    }
	
	private function trackerImageComplete(event : Event) : Void
	{
		_displayTrackerImage = true;
		draw();
    }
}