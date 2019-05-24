package com.chaos.ui;

import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.drawing.icon.ArrowUpIcon;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.ISlider;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Bitmap;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.ui.Slider;
import com.chaos.ui.event.SliderEvent;
import com.chaos.ui.Button;

/*
 * A scrollbar that could be attached to display objects or flash text field
 *
 *  @author Erick Feiling
 *  @date 11-13-09
 *
 */
class ScrollBar extends Slider implements IScrollBar implements ISlider
{
    public var scrollAmount(get, set) : Float;
    public var sliderActiveResize(get, set) : Bool;
    public var showArrowButton(get, set) : Bool;
    public var buttonWidth(get, set) : Int;
    public var buttonHeight(get, set) : Int;
    public var buttonColor(get, set) : Int;
    public var buttonOverColor(get, set) : Int;
    public var buttonDownColor(get, set) : Int;
    public var buttonDisableColor(get, set) : Int;
    public var sliderSize(get, set) : Float;
    public var trackSize(get, set) : Float;
	
	/** The type of UI Element */
	public static inline var TYPE : String = "ScrollBar"; 
	
	// elements  
	private var up_arrow : Button;
	private var down_arrow : Button;
	private var _scrollAmount : Float = .01;
	private var _buttonHeight : Int = 15;
	private var _buttonWidth : Int = 15;
	private var _showArrowButton : Bool = true;
	private var _sliderResize : Bool = true;
	private var _buttonNormalColor : Int = 0xCCCCCC;
	private var _buttonOverColor : Int = 0x666666;
	private var _buttonDownColor : Int = 0x333333;
	private var _buttonDisableColor : Int = 0x999999;
	
	
	/**
	 * Constructor
	 */
	
	public function new()
    {
		super();
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	override private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	
	
	override private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	
	/**
	 * Create and initialize the slider and arrow elements.
	 */
		
	override private function init() : Void
	{
		super.init();
		
		super.sliderOffSet = UIStyleManager.SCROLLBAR_SLIDER_OFFSET;
		var upArrowIcon : ArrowUpIcon = new ArrowUpIcon(4, 4);
		var downArrowIcon : ArrowDownIcon = new ArrowDownIcon(4, 4);
		upArrowIcon.filterMode = downArrowIcon.filterMode = false;
		
		// Setting Up Arrow  
		up_arrow = new Button();
		up_arrow.showLabel = false;
		up_arrow.iconDisplay = true;  
		
		// Setting Down Arrow  
		down_arrow = new Button();
		down_arrow.showLabel = false;
		down_arrow.iconDisplay = true;
		up_arrow.setIcon(upArrowIcon.displayObject);
		
		down_arrow.setIcon(downArrowIcon.displayObject);
		up_arrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedUp, false, 0, true);
		down_arrow.addEventListener(MouseEvent.MOUSE_DOWN, arrowPressedDown, false, 0, true);
		
		// Style UISkin and Style
		initBitmap();
		initStyle();
		
		addChild(up_arrow);
		addChild(down_arrow);
		
		draw();
    }
	
	private function initBitmap() : Void
	{
		// Set scrollbar button  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL)) 
		setButtonBackgroundBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER)) 
		setButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN))     
        setButtonDownBackgroundBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))   
		setButtonDisableBackgroundBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE)); 
		
		// Set Arrow Icons  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON)) 
		setDownIconBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON)) 
		setUpIconBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON));
		
		// Set tracker  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK))  
		setTrackBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK));
		
		// Set Slider  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))   
		setSliderBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER)) 
		setSliderOverBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN))       
		setSliderDownBitmap(UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN));
		
		//if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE) )
		//setSliderDisableBitmap( UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE) );
    }
	
	override private function initStyle() : Void 
	{
		super.initStyle();
		
		// Set button colors
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR) 
		buttonColor = UIStyleManager.SCROLLBAR_BUTTON_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR)       
		buttonOverColor = UIStyleManager.SCROLLBAR_BUTTON_OVER_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR)     
        buttonDownColor = UIStyleManager.SCROLLBAR_BUTTON_DOWN_COLOR;
		
		// Set Track color 
		//buttonDisableColor = UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR;
		//if (undefined != UIStyleManager.SCROLLBAR_BUTTON_DISABLE_COLOR);
		
		if ( -1 != UIStyleManager.SCROLLBAR_TRACK_COLOR)
		trackColor = UIStyleManager.SCROLLBAR_TRACK_COLOR;
		
		// Set Slider color  
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR) 
		sliderColor = UIStyleManager.SCROLLBAR_SLIDER_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR)       
		sliderOverColor = UIStyleManager.SCROLLBAR_SLIDER_OVER_COLOR;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR)     
        sliderDownColor = UIStyleManager.SCROLLBAR_SLIDER_DOWN_COLOR;
		
		
		//if (undefined != UIStyleManager.SLIDER_DISABLE_COLOR) 
		//sliderDisableColor = UIStyleManager.SLIDER_DISABLE_COLOR;		
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_SIZE) 
		sliderSize = UIStyleManager.SCROLLBAR_SLIDER_SIZE;
		
		// Active resize for slider
		_sliderResize = UIStyleManager.SCROLLBAR_SLIDER_ACTIVE_RESIZE;
		
		if ( -1 != UIStyleManager.SCROLLBAR_BUTTON_SIZE)     
        _buttonWidth = _buttonHeight = UIStyleManager.SCROLLBAR_BUTTON_SIZE;
		
		if ( -1 != UIStyleManager.SCROLLBAR_SLIDER_OFFSET)      
		sliderOffSet = UIStyleManager.SCROLLBAR_SLIDER_OFFSET;
		
		super.rotateImage = UIStyleManager.SCROLLBAR_ROTATE_IMAGE;
    } 
	
	/**
	 * @inheritDoc
	 */
	
	override public function reskin() : Void { super.reskin(); initBitmap(); initStyle(); }  
		 
	
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
		_enabled = down_arrow.enabled = up_arrow.enabled = super.enabled = value;
		
		draw();
		super.draw();
		
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
		down_arrow.visible = up_arrow.visible = _showArrowButton = value;
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
	 * Set the color of the button
	 */
	
	private function set_buttonColor(value : Int) : Int 
	{ 
		down_arrow.buttonColor = up_arrow.buttonColor = _buttonNormalColor = value;
		return value; 
	}
	
	/**
	 * Returns the color
	 */
	
	private function get_buttonColor() : Int { return _buttonNormalColor; }
	
	
	/**
	 * Set the color of the button over state
	 */
	
	private function set_buttonOverColor(value : Int) : Int 
	{ 
		down_arrow.buttonOverColor = up_arrow.buttonOverColor = _buttonOverColor = value;
		
		return value; 
	} 
	
	/**
	 *  Returns the color
	 */
	
	private function get_buttonOverColor() : Int { return _buttonOverColor; }
	
	
	/**
	 * Set the color of the button down state
	 */
	
	private function set_buttonDownColor(value : Int) : Int 
	{ 
		down_arrow.buttonDownColor = up_arrow.buttonDownColor = _buttonDownColor = value; 
		return value; 
		
	}
	
	
	/**
	 * Returns the color
	 */
	
	private function get_buttonDownColor() : Int { return _buttonDownColor; }
	
	
	/**
	 * Set the color of the button disabled state
	 */
	
	private function set_buttonDisableColor(value : Int) : Int 
	{
		down_arrow.buttonDisableColor = up_arrow.buttonDisableColor = _buttonDisableColor = value;
		
		return value; 
	}
	
	
	/**
	 * Returns the color
	 */
	private function get_buttonDisableColor() : Int { return _buttonDisableColor; }
	
	/**
	 * Set the slider size based on the direction. If ScrollBarDirection.VERTICAL being used it adjust the height and if ScrollBarDirection.HORIZONTAL it adjust the width.
	 */
	private function set_sliderSize(value : Float) : Float 
	{
		((ScrollBarDirection.VERTICAL == direction)) ? super.sliderHeight = value : super.sliderWidth = value;
		return value; 
	}
	
		
	/**
	 *  Returns the slider size based on what mode it's in
	 */
	private function get_sliderSize() : Float
	{
		if (ScrollBarDirection.VERTICAL == direction) 
		{
			return super.sliderHeight;
        }
        else 
		{
			return super.sliderWidth;
        }
    }
	
	/**
	 * Set the track size of the scrollbar
	 */
	
	private function set_trackSize(value : Float) : Float 
	{
		if (ScrollBarDirection.VERTICAL == super.direction) 
		{
			super.trackHeight = value;
        }
        else if (ScrollBarDirection.HORIZONTAL == super.direction) 
		{
			super.trackWidth = value;
        }
		
        return value;
    }
	
	/**
	 *  Returns the track size which is based on the direction the scrollbar is pointed
	 */  
	private function get_trackSize() : Float
	{
		if (ScrollBarDirection.VERTICAL == super.direction) 
		{
			return super.trackHeight;
        }
        else if (ScrollBarDirection.HORIZONTAL == super.direction) 
		{
			return super.trackWidth;
        }
		
		return -1;
    }
	
	
	/**
	 * Set the icon to be used inside the button based on a DisplayObject
	 *
	 * @param value The display object that will be used
	 */ 
	public function setUpIcon(value : DisplayObject) : Void { up_arrow.setIcon(value); }
	
	/**
	 * Set the icon used on the button based on a URL location
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setUpIconImage(value : String) : Void { up_arrow.setIconImage(value); }
	
	/**
	 * Set the icon used on the button based on a Bitmap image
	 *
	 * @param value Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setUpIconBitmap(value : Bitmap) : Void { up_arrow.setIconBitmap(value); }
	
	/**
	 * Set the icon to be used inside the button based on a DisplayObject
	 *
	 * @param value The display object that will be used
	 */
	
	public function setDownIcon(value : DisplayObject) : Void { down_arrow.setIcon(value); }
	
	
	/**
	 * Set the scrollbar down icon using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setDownIconImage(value : String) : Void { down_arrow.setIconImage(value); }
		 
	/**
	 * Set a image to the scrollbar down icon.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setDownIconBitmap(value : Bitmap) : Void { down_arrow.setIconBitmap(value); }
	
	/**
	 * Set a image to the scrollbar buttons default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	public function setButtonBackgroundImage(value : String) : Void { up_arrow.setBackgroundImage(value); down_arrow.setBackgroundImage(value); }
	
	/**
	 * Set a image to the scrollbar buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	public function setButtonBackgroundBitmap(value : Bitmap) : Void { up_arrow.setDefaultStateBitmap(value); down_arrow.setDefaultStateBitmap(value); }
	
	/**
	 * Set a image to the scrollbar buttons over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	
	public function setButtonOverBackgroundImage(value : String) : Void { up_arrow.setOverBackgroundImage(value); down_arrow.setOverBackgroundImage(value); }
	
	/**
	 * Set a image to the scrollbar buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	public function setButtonOverBackgroundBitmap(value : Bitmap) : Void { up_arrow.setOverStateImage(value); down_arrow.setOverStateImage(value); }
	
	/**
	 * Set a image to the scrollbar up button down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */  
	
	public function setButtonDownBackgroundImage(value : String) : Void { up_arrow.setDownBackgroundImage(value); down_arrow.setDownBackgroundImage(value); }
	
	/**
	 * Set a image to the scrollbar up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setButtonDownBackgroundBitmap(value : Bitmap) : Void { up_arrow.setDownStateImage(value); down_arrow.setDownStateImage(value); }
	
	
	/**
	 * Set a image to the scrollbar up button disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setButtonDisableBackgroundImage(value : String) : Void { up_arrow.setDisableBackgroundImage(value); down_arrow.setDisableBackgroundImage(value); }
	
	/**
	 * Set a image to the scrollbar up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setButtonDisableBackgroundBitmap(value : Bitmap) : Void { up_arrow.setDisableStateImage(value); down_arrow.setDisableStateImage(value); }
	

	
	/**
	 * Draw the element on the stage
	 *
	 */
	override public function draw() : Void
	{
		// Setup the scrollbar
		if (ScrollBarDirection.VERTICAL == direction) 
		{
			setupSliderVerticalMode();
        }
        else
		{
			setupSliderHorizontal();
        }
		super.draw();
    }
	
	private function setupSliderVerticalMode() : Void
	{  
		// Up Button & Down Button
		if (null != up_arrow && null != down_arrow) 
		{
			up_arrow.width = down_arrow.width = _buttonWidth;
			up_arrow.height = down_arrow.height = _buttonHeight;
        } 
		
		// Set the slider size
		trackWidthNum = sliderWidthNum = _buttonWidth;
		
		// Set the size of the track  
		if (_showArrowButton) 
		{
			if (null != up_arrow)
			track.y = up_arrow.height;
			
			trackHeightNum = Std.int(_height) - (_buttonHeight * 2) + UIStyleManager.SCROLLBAR_OFFSET;
        }
        else 
		{
			track.y = 0;
			trackHeightNum = Std.int(_height) + UIStyleManager.SCROLLBAR_OFFSET;
        }
		
		if (null != down_arrow)
		down_arrow.y = (track.y + trackHeightNum) - UIStyleManager.SCROLLBAR_OFFSET;
    }
	
	private function setupSliderHorizontal() : Void
	{  
		// Resize buttons
		up_arrow.width = down_arrow.width = _buttonWidth;
		up_arrow.height = down_arrow.height = _buttonHeight;
		
		if (_showArrowButton) 
		{
			trackWidthNum = Std.int(_width) - (_buttonWidth * 2) + UIStyleManager.SCROLLBAR_OFFSET;
        }
        else 
		{
			trackWidthNum = Std.int(_width);
        }
		
		trackHeightNum = sliderHeightNum = _buttonHeight; 
		down_arrow.rotation = 90;
		down_arrow.x = down_arrow.width; down_arrow.y = 0;
		
		if (_showArrowButton) 
		{
			track.x = up_arrow.width;track.y = up_arrow.y;
        }
        else 
		{
			track.x = 0;
			track.y = 0;
        }
		
		up_arrow.rotation = 90;
		up_arrow.x = _width;
    }
	
	// executes when the up arrow is pressed  
	private function arrowPressedUp(event : MouseEvent) : Void
	{
		if (_enabled) 
		{
			var dir : Int = 0;
			
			if (ScrollBarDirection.VERTICAL == direction) 
			{
				dir = -1;
            }
            else 
			{
				dir = 1;
            }
			
			percent = percent + dir * _scrollAmount;
        }
    }
	
	// executes when the down arrow is pressed 
	private function arrowPressedDown(event : MouseEvent) : Void 
	{
		if (_enabled) 
		{
			var dir : Int = 0;
			
			if (ScrollBarDirection.VERTICAL == direction) 
			{
				dir = 1;
            }
            else 
			{
				dir = -1;
            }
			
			percent = percent + dir * _scrollAmount;
        }
    }
}