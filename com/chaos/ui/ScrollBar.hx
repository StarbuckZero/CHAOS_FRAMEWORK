package com.chaos.ui;

import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.drawing.icon.ArrowUpIcon;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.ISlider;
import com.chaos.utils.CompositeManager;
import openfl.display.BitmapData;
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
	private var _sliderSize : Int = 15;
	
	private var _slider : Slider;
	
	private var _sliderData : Dynamic;
	private var _buttonData : Dynamic;

	private var _upIconButtonImage : BitmapData;
	private var _downIconButtonImage : BitmapData;
	
	private var _buttonDefaultImage : BitmapData;
	private var _buttonOverImage : BitmapData;
	private var _buttonDownImage : BitmapData;
	private var _buttonDisableImage : BitmapData;
	
	private var _trackImage : BitmapData;
	
	private var _sliderButtonDefaultImage : BitmapData;
	private var _sliderButtonOverImage : BitmapData;
	private var _sliderButtonDownImage : BitmapData;
	private var _sliderButtonDisableImage : BitmapData;
	
	/**
	 * Constructor
	 */
	
	public function new(data:Dynamic = null)
    {
		super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "buttonSize"))
			_buttonHeight = _buttonWidth = Reflect.field(data,"_buttonWidth");
		
		if (Reflect.hasField(data, "showArrowButton"))
			_showArrowButton = Reflect.field(data, "showArrowButton");
			
		if (Reflect.hasField(data, "sliderResize"))
			_sliderResize = Reflect.field(data, "sliderResize");
		
		if (Reflect.hasField(data, "buttonWidth"))
			_buttonWidth = Reflect.field(data, "buttonWidth");
			
		if (Reflect.hasField(data, "buttonHeight"))
			_buttonHeight = Reflect.field(data, "buttonHeight");
			
		if (Reflect.hasField(data, "sliderSize"))
			_sliderSize = Reflect.field(data, "sliderSize");
			
			
		// Replace if there once skin data has been set
		if (Reflect.hasField(data, "Slider"))
			_sliderData = Reflect.field(data, "Slider");
			
		if (Reflect.hasField(data, "Button"))
			_buttonData = Reflect.field(data, "Button");
			
	}
	
	
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	/**
	 * Create and initialize the slider and arrow elements.
	 */
		
	
	override public function initialize():Void 
	{
		
		// Setup slider
		_slider = new Slider(_sliderData);
		
		// Apply image and remove it
		if (null != _sliderButtonDefaultImage)
		{
			_slider.setSliderImage(_sliderButtonDefaultImage.clone());
			
			_sliderButtonDefaultImage.dispose();
			_sliderButtonDefaultImage = null;
		}
		
		if (null != _sliderButtonOverImage)
		{
			_slider.setSliderOverImage(_sliderButtonOverImage.clone());
			
			_sliderButtonOverImage.dispose();
			_sliderButtonOverImage = null;
		}
		
		if (null != _sliderButtonDownImage)
		{
			_slider.setSliderDownImage(_sliderButtonDownImage.clone());
			
			_sliderButtonDownImage.dispose();
			_sliderButtonDownImage = null;
		}
		
		if (null != _sliderButtonDisableImage)
		{
			_slider.setSliderDisableImage(_sliderButtonDisableImage.clone());
			
			_sliderButtonDisableImage.dispose();
			_sliderButtonDisableImage = null;
		}
		
		if (null != _trackImage)
		{
			_slider.setTrackImage(_trackImage.clone());		
			
			_trackImage.dispose();
			_trackImage = null;
		}		
		
		
		_upButton = new Button(_buttonData);
		_downButton = new Button(_buttonData);
		
		// Set button 
		if (null != _upButton && null != _downButton)
		{
			if ( null != _buttonDefaultImage)
			{
				_upButton.setDefaultStateImage(_buttonDefaultImage.clone());
				_downButton.setDefaultStateImage(_buttonDefaultImage.clone());
				
				_buttonDefaultImage.dispose();
				_buttonDefaultImage = null;
			}
			
			if (null != _buttonOverImage)
			{
				_upButton.setOverStateImage(_buttonOverImage.clone());
				_downButton.setOverStateImage(_buttonOverImage.clone());
				
				_buttonOverImage.dispose();
				_buttonOverImage = null;
			}		
			
			
			if (null != _buttonDownImage)
			{
				_upButton.setDownStateImage(_buttonDownImage.clone());
				_downButton.setDownStateImage(_buttonDownImage.clone());
				
				_buttonDownImage.dispose();
				_buttonDownImage = null;
			}		
			
			if (null != _buttonDisableImage)
			{
				_upButton.setDisableStateImage(_buttonDisableImage.clone());
				_downButton.setDisableStateImage(_buttonDisableImage.clone());
				
				_buttonDisableImage.dispose();
				_buttonDisableImage = null;
			}
			
			if (null != _upIconButtonImage)
			{
				_upButton.setIcon(_upIconButtonImage.clone());
				
				_upIconButtonImage.dispose();
				_upIconButtonImage = null;
			}			
			
			if (null != _downIconButtonImage)
			{
				_downButton.setIcon(_downIconButtonImage.clone());
				
				_downIconButtonImage.dispose();
				_downIconButtonImage = null;
			}		
			
		}
		
		super.initialize();
		
		var upArrowIcon : ArrowUpIcon = new ArrowUpIcon({"width":4, "height":4});
		var downArrowIcon : ArrowDownIcon = new ArrowDownIcon({"width":4,"height":4});
		
		_upButton.setIcon(CompositeManager.displayObjectToBitmap(upArrowIcon, _smoothImage, upArrowIcon.width, upArrowIcon.height));
		_downButton.setIcon(CompositeManager.displayObjectToBitmap(downArrowIcon,_smoothImage, upArrowIcon.width, upArrowIcon.height));
		
		_upButton.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedUp, false, 0, true);
		_downButton.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedDown, false, 0, true);
		
		addChild(_upButton.displayObject);
		addChild(_downButton.displayObject);
		addChild(_slider);
	}
	
	
	
	private function initBitmap() : Void
	{
		// Set scrollbar button  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL)) 
			_buttonDefaultImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL).clone();
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER)) 
			_buttonOverImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER).clone();
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN))
			_buttonDownImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN).clone();
        
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))
			_buttonDisableImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE).clone();
		
		
		// Set Arrow Icons  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON))
			_upIconButtonImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON).clone();
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON)) 
			_downIconButtonImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON).clone();
		
		
		// Set tracker  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK)) 
			_trackImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK).clone();
		
		
		// Set Slider  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))   
			_sliderButtonDefaultImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL).clone();
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER)) 
			_sliderButtonOverImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER).clone();
		
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN))
			_sliderButtonDownImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN).clone();
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE))
			_sliderButtonDisableImage = UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE).clone();
		
		
		// If already there then set and remove BitmapData
		if (null != _slider)
		{
			if (null != _sliderButtonDefaultImage)
			{
				_slider.setSliderImage(_sliderButtonDefaultImage.clone());
				
				_sliderButtonDefaultImage.dispose();
				_sliderButtonDefaultImage = null;
			}
			
			if (null != _sliderButtonOverImage)
			{
				_slider.setSliderOverImage(_sliderButtonOverImage.clone());
				
				_sliderButtonOverImage.dispose();
				_sliderButtonOverImage = null;
			}
			
			if (null != _sliderButtonDownImage)
			{
				_slider.setSliderDownImage(_sliderButtonDownImage.clone());
				
				_sliderButtonDownImage.dispose();
				_sliderButtonDownImage = null;
			}
			
			if (null != _sliderButtonDisableImage)
			{
				_slider.setSliderDisableImage(_sliderButtonDisableImage.clone());
				
				_sliderButtonDisableImage.dispose();
				_sliderButtonDisableImage = null;
			}
			
			if (null != _trackImage)
			{
				_slider.setTrackImage(_trackImage.clone());		
				
				_trackImage.dispose();
				_trackImage = null;
			}
			
		}
		
		// Buttons
		if (null != _downButton && null != _upButton)
		{
			if ( null != _buttonDefaultImage)
			{
				_upButton.setDefaultStateImage(_buttonDefaultImage.clone());
				_downButton.setDefaultStateImage(_buttonDefaultImage.clone());
				
				_buttonDefaultImage.dispose();
				_buttonDefaultImage = null;
			}
			
			if (null != _buttonOverImage)
			{
				_upButton.setOverStateImage(_buttonOverImage.clone());
				_downButton.setOverStateImage(_buttonOverImage.clone());
				
				_buttonOverImage.dispose();
				_buttonOverImage = null;
			}		
			
			
			if (null != _buttonDownImage)
			{
				_upButton.setDownStateImage(_buttonDownImage.clone());
				_downButton.setDownStateImage(_buttonDownImage.clone());
				
				_buttonDownImage.dispose();
				_buttonDownImage = null;
			}		
			
			if (null != _buttonDisableImage)
			{
				_upButton.setDisableStateImage(_buttonDisableImage.clone());
				_downButton.setDisableStateImage(_buttonDisableImage.clone());
				
				_buttonDisableImage.dispose();
				_buttonDisableImage = null;
			}
			
			if (null != _upIconButtonImage)
			{
				_upButton.setIcon(_upIconButtonImage.clone());
				
				_upIconButtonImage.dispose();
				_upIconButtonImage = null;
			}		
			
			if (null != _downIconButtonImage)
			{
				_downButton.setIcon(_downIconButtonImage.clone());
				
				_downIconButtonImage.dispose();
				_downIconButtonImage = null;
			}		
			
			
		}

    }
	
	private function initStyle() : Void 
	{
		_buttonData = {"showLabel":false};
		_sliderData = {};
		
		// Set button colors
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR) 
			Reflect.setField(_buttonData, "defaultColor", UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR)       
			Reflect.setField(_buttonData, "overColor", UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR)     
			Reflect.setField(_buttonData, "downColor", UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR);
		
			
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR)
			Reflect.setField(_buttonData, "disableColor", UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR);
			
		// Set Track color 
		if ( -1 != UIStyleManager.SCROLLBAR_TRACK_COLOR)
			Reflect.setField(_sliderData, "trackColor", UIStyleManager.SCROLLBAR_TRACK_COLOR);
		
		// Set Slider color  
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR) 
			Reflect.setField(_sliderData, "sliderColor", UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR)
			Reflect.setField(_sliderData, "sliderOverColor", UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR)     
			Reflect.setField(_sliderData, "sliderDownColor", UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR);
		
		if ( -1 != UIStyleManager.SLIDER_DISABLE_COLOR) 
			Reflect.setField(_sliderData, "sliderDisableColor", UIStyleManager.SLIDER_DISABLE_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_SIZE)
			Reflect.setField(_sliderData, "sliderSize", UIStyleManager.SCROLLBAR_SLIDER_SIZE);
		
		// Active resize for slider
		_sliderResize = UIStyleManager.SCROLLBAR_SLIDER_ACTIVE_RESIZE;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_SIZE)
		{
			Reflect.setField(_buttonData, "buttonWidth", UIStyleManager.SCROLLBAR_BUTTON_SIZE);
			Reflect.setField(_buttonData, "buttonHeight", UIStyleManager.SCROLLBAR_BUTTON_SIZE);
		}
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OFFSET)      
			Reflect.setField(_sliderData, "sliderOffSet", UIStyleManager.SCROLLBAR_SLIDER_SIZE);
		
		Reflect.setField(_sliderData, "rotateImage", UIStyleManager.SCROLLBAR_ROTATE_IMAGE);
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
		((ScrollBarDirection.VERTICAL == _slider.direction)) ? _slider.sliderHeight = value : _slider.sliderWidth = value;
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
		
		// Clear Bitmap data
		if (null != _buttonDefaultImage)
			_buttonDefaultImage.dispose();
		
		if (null != _buttonOverImage)
			_buttonOverImage.dispose();
			
		if (null != _buttonDownImage)
			_buttonDownImage.dispose();
		
		if (null != _buttonDisableImage)
			_buttonDisableImage.dispose();
		
			
		if (null != _sliderButtonDefaultImage)
			_sliderButtonDefaultImage.dispose();
		
		if (null != _sliderButtonOverImage)
			_sliderButtonOverImage.dispose();
		
		if (null != _sliderButtonDownImage)
			_sliderButtonDownImage.dispose();
			
		if (null != _sliderButtonDisableImage)
			_sliderButtonDisableImage.dispose();
			
		_buttonData = _sliderData = null;
		
		_buttonDisableImage = _buttonDownImage = _buttonOverImage = _buttonDefaultImage = null;
		_sliderButtonDisableImage = _sliderButtonDownImage = _sliderButtonOverImage = _sliderButtonDefaultImage = null;
		
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
		_upButton.width = _downButton.width = _buttonWidth;
		_upButton.height = _downButton.height = _buttonHeight;
		
		_upButton.draw();
		_downButton.draw();
		
		// Set the slider size
		_width = _slider.width = _slider.sliderWidthNum = _buttonWidth;
		
		// Set the size of the track  
		if (_showArrowButton)
		{
			_slider.height = _height - (_buttonHeight * 2) + UIStyleManager.SCROLLBAR_OFFSET;
			_slider.draw();
			
			_slider.y = _upButton.y + _upButton.height;
        }
        else 
		{
			_slider.height = Std.int(_height) + UIStyleManager.SCROLLBAR_OFFSET;
			_slider.draw();
			
			_slider.y = 0;
        }
		
		_downButton.y = (_slider.y +_slider.height) - UIStyleManager.SCROLLBAR_OFFSET;
		
    }
	
	private function setupSliderHorizontal() : Void
	{  
		// Resize buttons
		_upButton.width = _downButton.width = _buttonWidth;
		_upButton.height = _downButton.height = _buttonHeight;
		
		_upButton.draw();
		_downButton.draw();
		
		if (_showArrowButton) 
			_slider.width = Std.int(_width) - (_buttonWidth * 2) + UIStyleManager.SCROLLBAR_OFFSET;
        else 
			_slider.width = Std.int(_width);
		
		_slider.height = _slider.sliderHeightNum = _buttonHeight; 
		_slider.draw();
		
		_downButton.rotation = 90;
		
		_downButton.x = _downButton.width;
		_downButton.y = 0;
		
		if (_showArrowButton) 
		{
			_slider.x = _upButton.width;
			_slider.y = _upButton.y;
        }
        else 
		{
			_slider.x = 0;
			_slider.y = 0;
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