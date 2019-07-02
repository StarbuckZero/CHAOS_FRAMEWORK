package com.chaos.ui;

import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.drawing.icon.ArrowUpIcon;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.ISlider;
import com.chaos.utils.CompositeManager;
import openfl.events.Event;
import openfl.events.MouseEvent;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.ui.Slider;

import com.chaos.ui.Button;

/*
 * A scrollbar that could be attached to display objects or text field
 *
 *  @author Erick Feiling
 *  @date 11-13-09
 *
 */

class ScrollBar extends BaseUI implements IScrollBar implements IBaseUI
{
	
	/** The type of UI Element */
	public static inline var TYPE : String = "ScrollBar"; 
	
    public var scrollAmount(get, set) : Float;
    public var sliderActiveResize(get, set) : Bool;
    public var showArrowButton(get, set) : Bool;
	public var slider(get, never) : ISlider;
	
    public var buttonWidth(get, set) : Int;
    public var buttonHeight(get, set) : Int;
	
    public var sliderSize(get, set) : Float;
    public var trackSize(get, set) : Float;
	
	public var upButton(get, never) : IButton;
	public var downButton(get, never) : IButton;
	
	
	// elements  
	private var _upButton : IButton;
	private var _downButton : IButton;
	private var _scrollAmount : Float = .01;
	private var _buttonHeight : Int = 15;
	private var _buttonWidth : Int = 15;
	private var _showArrowButton : Bool = true;
	private var _sliderResize : Bool = true;
	private var _smoothImage : Bool = true;
	
	private var _slider : Slider;
	

	
	
	/**
	 * Constructor
	 */
	
	public function new(data:Dynamic = null)
    {
		super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	/**
	 * Create and initialize the slider and arrow elements.
	 */
		
	
	override public function initialize():Void 
	{
		
		
		_slider = new Slider();
		_upButton = new Button();
		_downButton = new Button();
		
		_slider.sliderOffSet = UIStyleManager.SCROLLBAR_SLIDER_OFFSET;
		
		super.initialize();
		
		var upArrowIcon : ArrowUpIcon = new ArrowUpIcon(4, 4);
		var downArrowIcon : ArrowDownIcon = new ArrowDownIcon(4, 4);
		
		// Setting Up Arrow  
		_upButton.showLabel = false;
		_upButton.iconDisplay = true;  
		
		// Setting Down Arrow  
		_downButton.showLabel = false;
		_downButton.iconDisplay = true;
		
		_upButton.setIcon(CompositeManager.displayObjectToBitmap(upArrowIcon, _smoothImage, upArrowIcon.width, upArrowIcon.height));
		_downButton.setIcon(CompositeManager.displayObjectToBitmap(downArrowIcon,_smoothImage, upArrowIcon.width, upArrowIcon.height));
		
		_upButton.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedUp, false, 0, true);
		_downButton.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedDown, false, 0, true);
		
		// Style UISkin and Style
		initBitmap();
		initStyle();
		
		addChild(_upButton.displayObject);
		addChild(_downButton.displayObject);
		
	}
	
	
	
	private function initBitmap() : Void
	{
		// Set scrollbar button  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL)) 
		{
			_upButton.setDefaultStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
			_downButton.setDefaultStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
		}
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER)) 
		{
			_upButton.setOverStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
			_downButton.setOverStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
		}
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN))
		{
			_upButton.setDownStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
			_downButton.setDownStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
		}
        
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))
		{
			_upButton.setDisableStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE));
			_downButton.setDisableStateImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE)); 
		}
		
		
		// Set Arrow Icons  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON)) 
		_upButton.setIcon(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON)) 
		_downButton.setIcon(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON));
		
		// Set tracker  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK))  
		_slider.setTrackImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK));
		
		// Set Slider  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))   
		_slider.setSliderImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER)) 
		_slider.setSliderOverImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN))       
		_slider.setSliderDownImage(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN));
		
		//if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE) )
		//setSliderDisableBitmap( UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE) );
    }
	
	private function initStyle() : Void 
	{
		// Set button colors
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR) 
			_downButton.defaultColor = _upButton.defaultColor = UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR)       
			_downButton.overColor = _upButton.overColor = UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR)     
			_downButton.downColor = _upButton.downColor =  UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR;
		
			
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR)
			_downButton.disableColor = _upButton.disableColor =  UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR;
			
		// Set Track color 
		if ( -1 != UIStyleManager.SCROLLBAR_TRACK_COLOR)
			_slider.trackColor = UIStyleManager.SCROLLBAR_TRACK_COLOR;
		
		// Set Slider color  
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR) 
			_slider.sliderColor = UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR)       
			_slider.sliderOverColor = UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR)     
			_slider.sliderDownColor = UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR;
		
		if (-1 != UIStyleManager.SLIDER_DISABLE_COLOR) 
			_slider.sliderDisableColor = UIStyleManager.SLIDER_DISABLE_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_SIZE) 
			sliderSize = UIStyleManager.SCROLLBAR_SLIDER_SIZE;
		
		// Active resize for slider
		_sliderResize = UIStyleManager.SCROLLBAR_SLIDER_ACTIVE_RESIZE;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_SIZE)     
			_buttonWidth = _buttonHeight = UIStyleManager.SCROLLBAR_BUTTON_SIZE;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OFFSET)      
			_slider.sliderOffSet = UIStyleManager.SCROLLBAR_SLIDER_OFFSET;
		
		_slider.rotateImage = UIStyleManager.SCROLLBAR_ROTATE_IMAGE;
    } 
	
	private function get_upButton():IButton
	{
		return _upButton;
	}
	
	private function get_downButton():IButton
	{
		return _downButton;
	}
	
	private function get_slider():ISlider
	{
		return _slider;
	}
	
	/**
	 * @inheritDoc
	 */
	
	override public function reskin() : Void 
	{
		super.reskin();
		
		initBitmap();
		initStyle(); 
	}  
	
	
	/**
	 * The amount in percent wise to when it comes to scroll amount
	 */
	
	private function set_scrollAmount(value : Float) : Float 
	{ 
		_scrollAmount = value;
		
		return value; 
	}
	
	
	/**
	 * Return the scroll amount
	 */
	
	private function get_scrollAmount() : Float 
	{ 
		return _scrollAmount; 
	} 
	
	
	/**
	 * Remove all roll over and roll out effects while setting the scrollbar to it's disable state
	 *
	 * @param value Disable or Enable scrollbar
	 */
	
	override private function set_enabled(value : Bool) : Bool 
	{
		super.draw();
		
		_enabled = _downButton.enabled = _upButton.enabled = super.enabled = value;
		
		draw();
		
		
		return value; 
	} 
	
	/**
	 *
	 * @return Return if the scrollbar is enabled or disable
	 */
	override private function get_enabled() : Bool { return _enabled; }
		
	
	/**
	 * Set if the slider will resize itself based on the content size
	 */
	private function set_sliderActiveResize(value : Bool) : Bool 
	{ 
		_sliderResize = value;
		draw();
		
		return value; 
	}
	
	/**
	 * Returns true if the slider will resize once attached to some form of content and false if not.
	 */
	private function get_sliderActiveResize() : Bool 
	{
		return _sliderResize; 
	}
	
	/**
	 * If you want to use the scrollbar arrow buttons or not
	 */
	private function set_showArrowButton(value : Bool) : Bool 
	{ 
		_downButton.visible = _upButton.visible = _showArrowButton = value;
		draw();
		
		return value; 
	} 
	
	
	/**
	 * Returns true if the scrollbar arrows are being displayed and false if not
	 */
	
	private function get_showArrowButton() : Bool { return _showArrowButton; }

	
	/**
	 * Set the size of the button used on the scrollbar
	 */
	
	private function set_buttonWidth(value : Int) : Int 
	{ 
		_buttonWidth = value; 
		draw();
		
		return value; 
	} 
	
	
	/**
	 *  Returns the size of the button width being used.
	 */
	
	private function get_buttonWidth() : Int 
	{ 
		return _buttonWidth; 
		
	}
	
	
	/**
	 * Set the size of the button used on the scrollbar
	 */
	
	private function set_buttonHeight(value : Int) : Int 
	{ 
		_buttonHeight = value;
		draw();
		
		return value;
		
	}
	
	/**
	 * Returns the size of the height width being used.
	 */
	
	private function get_buttonHeight() : Int { return _buttonHeight; } 
	
	
	/**
	 * Set the slider size based on the direction. If ScrollBarDirection.VERTICAL being used it adjust the height and if ScrollBarDirection.HORIZONTAL it adjust the width.
	 */
	private function set_sliderSize(value : Float) : Float 
	{
		((ScrollBarDirection.VERTICAL == _slider.direction)) ? slider.sliderHeight = value : slider.sliderWidth = value;
		return value; 
	}
	
		
	/**
	 *  Returns the slider size based on what mode it's in
	 */
	private function get_sliderSize() : Float
	{
		if (ScrollBarDirection.VERTICAL == _slider.direction) 
		{
			return slider.sliderHeight;
        }
        else 
		{
			return slider.sliderWidth;
        }
    }
	
	/**
	 * Set the track size of the scrollbar
	 */
	
	private function set_trackSize(value : Float) : Float 
	{
		if (ScrollBarDirection.VERTICAL == _slider.direction) 
			_height = value;
        else if (ScrollBarDirection.HORIZONTAL == _slider.direction) 
			_width = value;
		
        return value;
    }
	
	/**
	 *  Returns the track size which is based on the direction the scrollbar is pointed
	 */  
	private function get_trackSize() : Float
	{
		if (ScrollBarDirection.VERTICAL == _slider.direction) 
			return _height;
        else if (ScrollBarDirection.HORIZONTAL == _slider.direction) 
			return _width;
		
		return -1;
    }
	
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Events
		_upButton.removeEventListener(MouseEvent.MOUSE_DOWN, arrowPressedUp);
		_downButton.removeEventListener(MouseEvent.MOUSE_DOWN, arrowPressedDown);
		
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		removeChild(_upButton.displayObject);
		removeChild(_downButton.displayObject);
		removeChild(_slider.displayObject);
		
		// Unload button and slider
		_upButton.destroy();
		_downButton.destroy();
		_slider.destroy();
		
		_upButton = null;
		_downButton = null;
		_slider = null;
	}

	
	/**
	 * Draw the element on the stage
	 *
	 */
	override public function draw() : Void
	{
		
		super.draw();
		
		// Setup the scrollbar
		if (ScrollBarDirection.VERTICAL == _slider.direction) 
			setupSliderVerticalMode();
        else
			setupSliderHorizontal();
		
		
    }
	
	private function setupSliderVerticalMode() : Void
	{  
		// Up Button & Down Button
		if (null != _upButton && null != _downButton) 
		{
			_upButton.width = _downButton.width = _buttonWidth;
			_upButton.height = _downButton.height = _buttonHeight;
        } 
		
		// Set the slider size
		_width = _slider.width = _slider.sliderWidthNum = _buttonWidth;
		
		// Set the size of the track  
		if (_showArrowButton)
		{
			_slider.y = _upButton.y + _upButton.height;
			_slider.height = _height - (_buttonHeight * 2) + UIStyleManager.SCROLLBAR_OFFSET;
        }
        else 
		{
			_slider.y = 0;
			_slider.height = Std.int(_height) + UIStyleManager.SCROLLBAR_OFFSET;
        }
		
		if (null != _downButton)
			_downButton.y = (_slider.y +_slider.height) - UIStyleManager.SCROLLBAR_OFFSET;
			
		addChild(_slider);
    }
	
	private function setupSliderHorizontal() : Void
	{  
		// Resize buttons
		_upButton.width = _downButton.width = _buttonWidth;
		_upButton.height = _downButton.height = _buttonHeight;
		
		if (_showArrowButton) 
			_slider.width = Std.int(_width) - (_buttonWidth * 2) + UIStyleManager.SCROLLBAR_OFFSET;
        else 
			_slider.width = Std.int(_width);
		
		_slider.height = _slider.sliderHeightNum = _buttonHeight; 
		_downButton.rotation = 90;
		_downButton.x = _downButton.width; _downButton.y = 0;
		
		if (_showArrowButton) 
		{
			_slider.track.x = _upButton.width;
			_slider.track.y = _upButton.y;
        }
        else 
		{
			_slider.track.x = 0;
			_slider.track.y = 0;
        }
		
		_upButton.rotation = 90;
		_upButton.x = _width;
    }
	
	// executes when the up arrow is pressed  
	private function arrowPressedUp(event : MouseEvent) : Void
	{
		if (_enabled) 
		{
			var dir : Int = 0;
			
			if (ScrollBarDirection.VERTICAL == _slider.direction) 
				dir = -1;
            else 
				dir = 1;
			
			_slider.percent = _slider.percent + dir * _scrollAmount;
        }
    }
	
	// executes when the down arrow is pressed 
	private function arrowPressedDown(event : MouseEvent) : Void 
	{
		if (_enabled) 
		{
			var dir : Int = 0;
			
			if (ScrollBarDirection.VERTICAL == _slider.direction) 
				dir = 1;
            else 
				dir = -1;
			
			_slider.percent = _slider.percent + dir * _scrollAmount;
        }
    }
}