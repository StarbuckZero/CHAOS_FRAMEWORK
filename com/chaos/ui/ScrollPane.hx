package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.utils.Utils;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.Loader;
import openfl.display.MovieClip;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.events.Event;
import openfl.net.URLRequest;
import com.chaos.ui.ScrollPolicy;
import com.chaos.media.DisplayImage;
import com.chaos.ui.layout.BaseContainer;

/** 
*  A container for loading in swf and images
*
*  @author Erick Feiling
*  @date 11-19-09  
*/

class ScrollPane extends BaseContainer implements IScrollPane implements IBaseContainer
{
    public var borderThinkness(get, set) : Float;
    public var trackColor(get, set) : Int;
    public var sliderColor(get, set) : Int;
    public var sliderOverColor(get, set) : Int;
    public var sliderDownColor(get, set) : Int;
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderAlpha(get, set) : Float;
    public var scrollBarH(get, never) : IScrollBar;
    public var scrollBarV(get, never) : IScrollBar;
    public var source(get, set) : DisplayObject;
    public var showArrowButton(get, set) : Bool;
    public var trackSize(get, set) : Float;
    public var mode(get, set) : String;
    public var buttonWidth(get, set) : Int;
    public var buttonHeight(get, set) : Int;
    public var buttonColor(get, set) : Int;
    public var buttonOverColor(get, set) : Int;
    public var buttonDownColor(get, set) : Int;
    public var buttonDisableColor(get, set) : Int;
	
	public static inline var TYPE : String = "ScrollPane";
	
	public var shapeBlock : Shape;
	private var _urlRequest : URLRequest;
	private var _totalBytes : Float;
	private var _mode : String = ScrollPolicy.AUTO;
	private var _showArrowButton : Bool = true;
	private var _scrollBarOver : Bool = false;
	private var _scrollContentLoaded : Bool = false;
	private var _trackSize : Float = 15;
	private var _scrollContentH : ScrollContent;
	private var _scrollContentV : ScrollContent;
	private var _scrollRectH : Rectangle;
	private var _scrollRectV : Rectangle;
	private var _scrollBarH : IScrollBar;
	private var _scrollBarV : IScrollBar;
	private var _contentSizeBox : Shape;
	
	// This is used for the real size  
	private var _outline : Shape;
	private var _buttonHeight : Int = 15;
	private var _buttonWidth : Int = 15;
	private var _buttonNormalColor : Int = 0xCCCCCC;
	private var _buttonOverColor : Int = 0x666666;
	private var _buttonDownColor : Int = 0x333333;
	private var _buttonDisableColor : Int = 0x999999;
	private var _trackerColor : Int = 0x999999;
	private var _sliderNormalColor : Int = 0xCCCCCC;
	private var _sliderOverColor : Int = 0x666666;
	private var _sliderDownColor : Int = 0x333333;
	private var _shapeBlockColor : Int = 0xCCCCCC;
	private var _border : Bool = false;
	private var _thinkness : Float = 1;
	private var _borderColor : Int = 0x000000;
	private var _borderAlpha : Float = 1;
	private var _bgDisplayImage : Bool = false;
	
	
	public function new(paneWidth : Int = 400, paneHeight : Int = 300)
    {
		super(paneWidth, paneHeight);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		init();
    }
	
	private function onStageAdd(event : Event) : Void 
	{
		UIBitmapManager.watchElement(TYPE, this);
	}
	
	private function onStageRemove(event : Event) : Void 
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
	}
	
	
	public function init() : Void
	{
		
		_urlRequest = new URLRequest();
		_scrollBarH = new ScrollBar();
		_scrollBarV = new ScrollBar();
		_scrollBarH.direction = ScrollBarDirection.HORIZONTAL; 
		_scrollBarV.direction = ScrollBarDirection.VERTICAL;
		_scrollBarH.visible = false;
		_scrollBarV.visible = false;
		
		//_backgroundShape = new Shape();
		shapeBlock = new Shape();
		_outline = new Shape();
		
		// Set background from UIBitmapManager and UIStyle Manager if need be  
		initUISkin();
		initStyle();
		
		
		_contentSizeBox = new Shape();
		_contentSizeBox.visible = false;
		contentHolder.addChild(backgroundShape);
		contentHolder.addChild(_contentSizeBox);
		contentHolder.addChild(contentObject);
		contentHolder.addChild(_scrollBarH.displayObject);
		contentHolder.addChild(_scrollBarV.displayObject);
		
		contentHolder.addChild(shapeBlock);
		contentHolder.addChild(_outline); 
		
		//addChild(contentHolder);  
		
		draw();
    }
	
	private function initUISkin() : Void
	{
		if (null != UIBitmapManager.getUIElement(ScrollPane.TYPE, UIBitmapManager.SCROLLPANE_BACKGROUND))     
			setBackgroundImage(UIBitmapManager.getUIElement(ScrollPane.TYPE, UIBitmapManager.SCROLLPANE_BACKGROUND));
    }
	
	private function initStyle() : Void 
	{
		if ( -1 != UIStyleManager.SCROLLPANE_BACKGROUND)  
			super.backgroundColor = UIStyleManager.SCROLLPANE_BACKGROUND;
		
		_border = UIStyleManager.SCROLLPANE_BORDER;
		if ( -1 != UIStyleManager.SCROLLPANE_BORDER_COLOR) 
		_borderColor = UIStyleManager.SCROLLPANE_BORDER_COLOR; 
		
		if ( -1 != UIStyleManager.SCROLLPANE_BORDER_ALPHA)
		_borderAlpha = UIStyleManager.SCROLLPANE_BORDER_ALPHA;
		
		if ( -1 != UIStyleManager.SCROLLPANE_BORDER_ALPHA)      
		_thinkness = UIStyleManager.SCROLLPANE_BORDER_THINKNESS;
		
    } 
	
	
	
	/**
	 * Border thinkness
	 */ 
	private function set_borderThinkness(value : Float) : Float
	{
		_thinkness = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return the size of the border
	 */
	
	private function get_borderThinkness() : Float { return _thinkness; } 
	
	
	/**
	* Set the color of the ScrollPane background
	* 
	* @param value The color that you want to set the scroll pane background to
	* 
	*/
	override private function set_backgroundColor(value : Int) : Int 
	{
		super.backgroundColor = value;
		draw();
		
		return value;
	} 
		
	/**
	*
	* @return Returns the color
	*/
	override private function get_backgroundColor() : Int 
	{ 
		return super.backgroundColor; 
	}
	
	
	/**
	* Set the color of the track
	*/
	
	private function set_trackColor(value : Int) : Int 
	{ 
		_scrollBarV.trackColor = _scrollBarH.trackColor = _trackerColor = value;
		return value;
	}
		
	
	/**
	* Returns the color of the track
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
		_scrollBarV.sliderColor = _scrollBarH.sliderColor = _sliderNormalColor = value;
		return value;
	}
		
	/**
	* Returns the color slider 
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
		_scrollBarV.sliderOverColor = _scrollBarH.sliderOverColor = _sliderOverColor = value;
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
		_scrollBarV.sliderDownColor = _scrollBarH.sliderDownColor = _sliderDownColor = value;
		return value;
	}
		
	
	/**
	* Returns the color
	*/
	
	private function get_sliderDownColor() : Int { return _sliderDownColor; }  
		
	
	/**
	* Toggle on and off border
	*/
	
	private function set_border(value : Bool) : Bool 
	{ 
		_border = value; 
		draw();
		
		return value; 
	}
		
	
	/**
	* Returns true if the border is on and false if not
	*/
	
	private function get_border() : Bool { return _border; }
	
	/**
	* The ScrollPane border color
	*/
	
	private function set_borderColor(value : Int) : Int 
	{
		_borderColor = value; 
		draw();
		
		return value;
	}
	
	/**
	* Returns the color
	*/
	
	private function get_borderColor() : Int { return _borderColor; }

	
	/**
	* Specifies the border alpha. Set the alpha between 1 to 0.
	*/
	
	private function set_borderAlpha(value : Float) : Float 
	{ 
		_borderAlpha = value;
		draw(); 
		
		return value;
	}
	
	
	/**
	* Returns the boarder alpha 
	*/
	
	private function get_borderAlpha() : Float 
	{
		return _borderAlpha; 
	}
	
	
	/**
	* Set the ScrollPane width
	*/  
	
	
    /**
	 * @inheritDoc
	 */
	
    #if flash @:setter(width) 
    override private function set_width(value : Float) : Void
    {
		
        _width = value;
        draw();
		
		update();
    }
	#else
	override private function set_width(value : Float) : Float
	{
        _width = value;
        draw();
		
		// Update scroll pane
		update();
		
		return value;
	}
	#end
	
	
	/**
	* Set the ScrollPane height
	*/ 
	#if flash @:setter(height) 
	override private function set_height(value : Float) : Void 
	{
		
		_height = value;  
		
		// Update scroll pane
		update();
		
		draw();
	}
	#else
	override private function set_height(value : Float) : Float 
	{
		_height = value;  
		
		// Update scroll pane
		update();
		
		draw();
		
		return value;
		
	}	
	#end

	/**
	* Set if the ScrollPane is enabled
	*/
	override private function set_enabled( value : Bool) : Bool
	{
		_scrollBarH.enabled = _scrollBarV.enabled = super.enabled = value;
        return value;
    }
	
	/**
	*
	* @return Return if the ScrollPane is enabled or disable
	*/
	
	override private function get_enabled() : Bool { return super.enabled; }
	
	/**
	 * Returns the bottom horizontal scrollbar being used
	 */
	
	private function get_scrollBarH() : IScrollBar { return _scrollBarH; } 
	
	/**
	 * Returns the vertical scrollbar on the righ side
	 */
	
	private function get_scrollBarV() : IScrollBar { return _scrollBarV; }
	
	/**
	 * The content clip that hoses the data that was loaded.
	 */
	
	override private function get_content() : DisplayObject { return ((contentObject.numChildren > 0)) ? contentObject.getChildAt(0) : null; } 
	
	/**
	* Places a DisplayObject in the ScrollPane
	*/ 
	private function set_source(value : DisplayObject) : DisplayObject
	{
		if (null == _scrollBarH && null == _scrollBarV)
		return null;
		
		// Unload if something has been loaded because scroll content has been set  
		_scrollBarH.percent = 0;
		_scrollBarV.percent = 0;
		
		if (_scrollContentLoaded)
		{
			_scrollContentH.unload();_scrollContentV.unload();
        }
		_contentSizeBox.graphics.clear();
		_contentSizeBox.graphics.beginFill(backgroundColor);
		_contentSizeBox.graphics.drawRect(0, 0, value.width, value.height);
		_contentSizeBox.graphics.endFill();
		
		// See if some content is already loaded  
		if (contentObject.numChildren > 0)
		contentObject.removeChildAt(0);
		contentObject.addChild(value);
		
		// Update scroll pane  
		update();
		
        return value;
    } 
	
	/**
	* Returns the DisplayObject that was stored. If nothing was set then return null.
	*/
	private function get_source() : DisplayObject 
	{
		return ((contentObject.numChildren > 0)) ? contentObject.getChildAt(0) : null; 
	}
	
	
	/**
	* If you want to use the scrollbar arrow buttons or not
	*/
	private function set_showArrowButton(value : Bool) : Bool 
	{
		_showArrowButton = _scrollBarH.showArrowButton = _scrollBarV.showArrowButton = value;
        return value;
    } 
	
	/**
	* Returns true if the scrollbar arrows buttons are being displayed and false if not
	*/
	
	private function get_showArrowButton() : Bool { return _showArrowButton; }
	
	/**
	* Reload the content that is inside the ScrollPane
	*/ 
	
	public function refreshPane() : Void
	{
		if (null == contentObject || contentObject.numChildren == 0)
		return;
		
		// Pull content out of display clip
		var tempClip : DisplayObject = contentObject.getChildAt(0);
		contentObject.removeChild(tempClip);
		
		// Redraw the content size blog based on display object removed
		_contentSizeBox.graphics.clear();
		_contentSizeBox.graphics.beginFill(super.backgroundColor);
		_contentSizeBox.graphics.drawRect(0, 0, tempClip.width, tempClip.height);
		_contentSizeBox.graphics.endFill();
		
		// Update Scrollbar
		contentObject = new Sprite();
		contentObject.addChild(tempClip);
		contentHolder.addChild(backgroundShape);
		contentHolder.addChild(_contentSizeBox);
		contentHolder.addChild(contentObject);
		contentHolder.addChild(_scrollBarH.displayObject);
		contentHolder.addChild(_scrollBarV.displayObject);
		contentHolder.addChild(_outline);
		contentHolder.addChild(shapeBlock);
		
		update();
    }
	
	/**
	* Set the track size of the scrollbar
	*/ 
		
	private function set_trackSize(value : Float) : Float 
	{ 
		_scrollBarV.trackSize = _scrollBarH.trackSize = _trackSize = value; 
		return value; 
		
	}  
	
	/**
	* Returns the track size which is based on the direction the scrollbar is pointed
	*/
	private function get_trackSize() : Float { return _trackSize; }
	
	/**
	* Update the content area, this is needed for when the content loaded inside the ScrollPane size has changed
	*/
	
	public function update() : Void 
	{ 
		// Scroll rect for width and height of the content area
		_scrollRectH = new Rectangle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X, UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y, _width, _height - shapeBlock.height);
		_scrollRectV = new Rectangle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X, UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y, _width, _height - shapeBlock.height);
		
		contentObject.scrollRect = null;
		
		if (_scrollContentLoaded) 
		{
			_scrollContentH.unload();
			_scrollContentV.unload();
        }
		
		_scrollBarH.percent = 0;
		_scrollBarV.percent = 0;
		_scrollContentH = new ScrollContent(contentObject, _scrollBarH, _scrollRectH);
		_scrollContentV = new ScrollContent(contentObject, _scrollBarV, _scrollRectV);
		
		contentObject.visible = _scrollContentLoaded = true;
		
		updatePolicy(_mode);
    }
	
	/**
	* Draw the ScrollPane and all the UI classes it's using
	* 
	*/
	
	override public function draw() : Void
	{  
		// Draw background image
		super.draw();
		
		if (null == _outline || null == shapeBlock)
		return;
		
		shapeBlock.graphics.clear();
		shapeBlock.alpha = 0;
		
		shapeBlock.graphics.drawRect(0, 0, _buttonWidth, _buttonHeight);
		shapeBlock.graphics.endFill();
		
		_outline.graphics.clear();  
		
		// Setup for border if need be  
		if (_border) 
		{
			_outline.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
			_outline.graphics.drawRect(0, 0, _width, _height);
			_outline.graphics.endFill();
        }
		
    }

	
	/**
	* Change the ScrollBar settings on the ScrollPane. This changes the way the scrollbars react to content.
	* The settings are ScrollPolicy.AUTO,ScrollPolicy.VERTICAL_ONLY,ScrollPolicy.HORIZONTAL_ONLY,ScrollPolicy.ON or ScrollPolicy.OFF.
	* 
	* @see com.chaos.ui.ScrollPolicy
	*/
		
	public function set_mode(value : String) : String
	{
		_mode = value;
		updatePolicy(_mode);
		
        return value;
    } 
	
	/**
	* Returns what mode the ScrollPane is in
	*
	* @see com.chaos.ui.ScrollPolicy
	*/
	
	public function get_mode() : String { return _mode; }
		
	/**
	 * Set the up icon
	 * 
	 * @param	value A DisplayObject that you want to use
	 */ 
	
	public function setUpIcon(value : DisplayObject) : Void 
	{

	}
	
	/**
	* Set the icon used on the button based on a URL location
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setUpIconImage(value : String) : Void 
	{
		_scrollBarH.setUpIconImage(value);
		_scrollBarV.setUpIconImage(value); 
	}
		
	/**
	* Set the icon used on the button based on a Bitmap image
	*
	* @param value Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setUpIconBitmap(value : Bitmap) : Void 
	{
		_scrollBarH.setUpIconBitmap(value);
		_scrollBarV.setUpIconBitmap(value); 
	}
	
	
	/**
	 * Set the down icon
	 * 
	 * @param	value A DisplayObject that you want to use
	 */
	
	public function setDownIcon(value : DisplayObject) : Void
	{

    }
	
	/**
	* Set the scrollbar down icon using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/ 
	
	public function setDownIconImage(value : String) : Void 
	{
		_scrollBarH.setDownIconImage(value);
		_scrollBarV.setDownIconImage(value); 
	}  
	
	/**
	* Set a image to the scrollbar down icon.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/  
	public function setDownIconBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setDownIconBitmap(value);
		_scrollBarV.setDownIconBitmap(value);
    }
	
	/**
	* Set the scrollbar slider default state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	public function setSliderImage(value : String) : Void 
	{
		_scrollBarH.setSliderImage(value);
		_scrollBarV.setSliderImage(value); 
	}
	
	/**
	* Set a image to the scrollbar slider default state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/ 
	
	public function setSliderBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setSliderBitmap(value);
		_scrollBarV.setSliderBitmap(value);
    }
	
	/**
	* Set the scrollbar slider over state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setSliderOverImage(value : String) : Void 
	{
		_scrollBarH.setSliderOverImage(value);
		_scrollBarV.setSliderOverImage(value);
	}
		
	/**
	* Set a image to the scrollbar slider over state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/ 
	
	public function setSliderOverBitmap(value : Bitmap) : Void 
	{
		_scrollBarH.setSliderOverBitmap(value);
		_scrollBarV.setSliderOverBitmap(value); 
	} 
	
	/**
	* Set the scrollbar slider down state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setSliderDownImage(value : String) : Void 
	{
		_scrollBarH.setSliderDownImage(value);
		_scrollBarV.setSliderDownImage(value);
	}
	
	/**
	* Set a image to the scrollbar slider down state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public function setSliderDownBitmap(value : Bitmap) : Void 
	{
		_scrollBarH.setSliderDownBitmap(value);
		_scrollBarV.setSliderDownBitmap(value); 
	}
	
	/**
	* Set the scrollbar track using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setTrackImage(value : String) : Void
	{
		_scrollBarH.setTrackImage(value);
		_scrollBarV.setTrackImage(value);
    }
	
	/**
	* Set a image to the scrollbar track
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setTrackBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setTrackBitmap(value);
		_scrollBarV.setTrackBitmap(value);
    } 
	
	/**
	* Set the size of the button used on the ScrollPane. The width is based on the height of the ScrollPane. 
	*/  
	
	private function set_buttonWidth(value : Int) : Int
	{
		_scrollBarV.buttonWidth = _scrollBarH.buttonWidth = _buttonWidth = value;
        return value;
    }
	
	/**
	* Returns the size of the button width being used on the ScrollPane.
	*/ 
	
	private function get_buttonWidth() : Int { return _buttonWidth; }
		
	/**
	* Set the size of the button used on the ScrollPane. The height is based on the height of the ScrollPane. 
	*/
	
	private function set_buttonHeight(value : Int) : Int 
	{ 
		_scrollBarV.buttonHeight = _scrollBarH.buttonHeight = _buttonHeight = value; 
		return value;
	}
	
	/**
	* Returns the size of the button height being used on the ScrollPane.
	*/ 
	
	private function get_buttonHeight() : Int { return _buttonHeight; }  
	
	/**
	* Set the color of the buttons
	*/
	
	private function set_buttonColor(value : Int) : Int 
	{
		_scrollBarV.buttonColor = _scrollBarH.buttonColor = _buttonNormalColor = value;
		return value; 
	}
		
		
	/**
	* Returns the color used on the buttons
	*/
	
	private function get_buttonColor() : Int { return _buttonNormalColor; } 
		
	/**
	* Set the color of the button over state
	*/ 
	
	private function set_buttonOverColor(value : Int) : Int 
	{ 
		_scrollBarV.buttonOverColor = _scrollBarH.buttonOverColor = _buttonOverColor = value;
		
		return value; 
	}
		
	/**
	* Returns the color
	*/
	
	private function get_buttonOverColor() : Int { return _buttonOverColor; }
	
	
	/**
	* Set the color of the button down state
	*/
	
	private function set_buttonDownColor(value : Int) : Int 
	{
		_scrollBarV.buttonDownColor = _scrollBarH.buttonDownColor = _buttonDownColor = value;
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
		_scrollBarV.buttonDisableColor = _scrollBarH.buttonDisableColor = _buttonDisableColor = value;
		return value;
	}
	
	/**
	* Returns the color
	*/
	private function get_buttonDisableColor() : Int { return _buttonDisableColor; }
	
	/**
	* Set a image to the scrollbar buttons default state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	public function setButtonBackgroundImage(value : String) : Void
	{
		_scrollBarH.setButtonBackgroundImage(value);
		_scrollBarV.setButtonBackgroundImage(value);
    }
	/**
	* Set a image to the scrollbar buttons default state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public function setButtonBackgroundBitmap(value : Bitmap) : Void 
	{
		_scrollBarH.setButtonBackgroundBitmap(value);
		_scrollBarV.setButtonBackgroundBitmap(value);
    }
	
	/**
	* Set a image to the scrollbar buttons over state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	public function setButtonOverBackgroundImage(value : String) : Void
	{
		_scrollBarH.setButtonOverBackgroundImage(value);
		_scrollBarV.setButtonOverBackgroundImage(value);
    }
	
	/**
		* Set a image to the scrollbar buttons over state
		*
		* @param value Set the image based on a Bitmap being pass
		*
		*/
	public function setButtonOverBackgroundBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setButtonOverBackgroundBitmap(value);
		_scrollBarV.setButtonOverBackgroundBitmap(value);
    }
	
	/**
	* Set a image to the scrollbar up button down state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	public function setButtonDownBackgroundImage(value : String) : Void
	{
		_scrollBarH.setButtonDownBackgroundImage(value);
		_scrollBarV.setButtonDownBackgroundImage(value);
    } 
	
	/**
	* Set a image to the scrollbar up button down state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setButtonDownBackgroundBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setButtonDownBackgroundBitmap(value);
		_scrollBarV.setButtonDownBackgroundBitmap(value);
    }
	/**
	* Set a image to the scrollbar up button disable state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	public function setButtonDisableBackgroundImage(value : String) : Void
	{
		_scrollBarH.setButtonDisableBackgroundImage(value);
		_scrollBarV.setButtonDisableBackgroundImage(value);
    }
	
	/**
	* Set a image to the scrollbar up button disable state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	public function setButtonDisableBackgroundBitmap(value : Bitmap) : Void
	{
		_scrollBarH.setButtonDisableBackgroundBitmap(value);
		_scrollBarV.setButtonDisableBackgroundBitmap(value);
    }
	
	private function updatePolicy(value : String = "auto") : Void 
	{
			// If nothing was setup then leave
			if(contentObject.numChildren == 0)
			return;
			
			// Figure out width and height based on what's loaded
			var contentWidth:Int = Std.int(contentObject.width);
			var contentHeight:Int = Std.int(contentObject.height);
			
			// Figure out what to do with the
			if(value == ScrollPolicy.AUTO)
			{
				// Make sure scroll bars are hidden
				_scrollBarH.visible = true;
				_scrollBarV.visible = true;
				shapeBlock.visible = true;
				
				// Set the size of the scrollbars
				_scrollBarH.width =  (_width - shapeBlock.width) - UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				_scrollBarV.height = (_height - shapeBlock.height) - UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET;
				
				
				// Check to see width of the content loaded width greather 
				if(_contentSizeBox.width > _width)
				{
					_scrollBarH.visible = true;
				}
				else
				{
					shapeBlock.visible = false;
					_scrollBarH.visible = false;
				}
				
				// Check to see height of the content loaded width greather 
				if(_contentSizeBox.height > _height)
				{
					_scrollBarV.visible = true;
					
				}
				else
				{
					shapeBlock.visible = false;
					_scrollBarV.visible = false;
				}
				
				// If you can see the shape block then move the block into the right place
				if (shapeBlock.visible)
				{
					//shapeBlock.x = width + shapeBlock.width;
					//shapeBlock.y = height + shapeBlock.height;
					
					shapeBlock.x = _scrollBarH.width + UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
					shapeBlock.y = _scrollBarV.height + UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET;
				}
				// Else figure out how to adjust the scroll bars
				else
				{
					// If Hoz is the only one being displayed
					if (_scrollBarH.visible && !_scrollBarV.visible)
						_scrollBarH.width = _width - UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;	
					else if (!_scrollBarH.visible && _scrollBarV.visible) // If Vert is the only one being displayed
						_scrollBarV.height = _height - UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET;
					
					// Move to a safe place
					shapeBlock.x =  shapeBlock.y = 0;
				}
				
			}
			else if(value == ScrollPolicy.ON)
			{
				
				_scrollBarH.width =  (_width - shapeBlock.width) - UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				_scrollBarV.height = (_height - shapeBlock.height) - UIStyleManager.SCROLLPANE_CONTENT_HEIGHT_OFFSET;
				
				_scrollBarH.visible = (contentObject.numChildren == 0) ? false : true;
				_scrollBarV.visible = (contentObject.numChildren == 0) ? false : true;
				
				// Check to see width of the content loaded width greather 
				if(_contentSizeBox.width > _width)
				{
					_scrollBarH.enabled = true;
				}
				else
				{
					_scrollBarH.enabled = false;
				}
				
				// Check to see height of the s loaded width greather 
				if(_contentSizeBox.height > _height)
				{
					_scrollBarV.enabled = true;
				}
				else
				{
					_scrollBarV.enabled = false;
				}
				
				
			}
			else if (value == ScrollPolicy.ONLY_VERTICAL)
			{
				_scrollBarH.visible = false;
				_scrollBarV.visible = true;
				shapeBlock.visible = false;
				
				_scrollBarV.height = _height + UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				
				// Check to see height of the s loaded width greather 
				if(_contentSizeBox.height > _height)
				{
					_scrollBarV.enabled = true;
				}
				else
				{
					_scrollBarV.enabled = false;
				}
			}
			else if (value == ScrollPolicy.ONLY_HORIZONTAL)
			{
				_scrollBarV.visible = false;
				_scrollBarH.visible = true;
				shapeBlock.visible = false;
				
				_scrollBarH.width = _width + UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				
				// Check to see width of the content loaded width greather 
				if(_contentSizeBox.width > _width)
				{
					_scrollBarH.enabled = true;
				}
				else
				{
					_scrollBarH.enabled = false;
				}				
			}
			else if(value == ScrollPolicy.OFF)
			{
				_scrollBarH.visible = false;
				_scrollBarV.visible = false;
				shapeBlock.visible = false;
			}
		
    }
	
	private function bgLoadComplete(event : Event) : Void
	{
		_bgDisplayImage = true;
		draw();
    }
}