package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.events.Event;

import com.chaos.ui.ScrollPolicy;

import com.chaos.ui.layout.BaseContainer;

/** 
*  A container for loading in DisplayObject
*
*  @author Erick Feiling
*  @date 11-19-09  
*/

class ScrollPane extends BaseContainer implements IScrollPane implements IBaseContainer
{
	public static inline var TYPE : String = "ScrollPane";
	
	private static inline var RECT_MODE : String = "rect";
	private static inline var MASK_MODE : String = "mask";
	
    public var borderThinkness(get, set) : Float;
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderAlpha(get, set) : Float;
    public var scrollBarH(get, never) : IScrollBar;
    public var scrollBarV(get, never) : IScrollBar;
    public var source(get, set) : DisplayObject;
    
    
    public var mode(get, set) : String;
	
	public var shapeBlock : Shape;
	
	private var _mode : String = ScrollPolicy.AUTO;
	private var _scrollContentType:String = RECT_MODE;
	
	private var _scrollContentLoaded : Bool = false;
	
	private var _scrollContentH : ScrollContentBase;
	private var _scrollContentV : ScrollContentBase;
	private var _scrollRectH : Rectangle;
	private var _scrollRectV : Rectangle;
	private var _scrollMask : Shape;
	private var _scrollBarH : IScrollBar;
	private var _scrollBarV : IScrollBar;
	private var _contentSizeBox : Shape;
	private var _mask : Shape;
	
	// This is used for the real size  
	private var _outline : Shape;
	
	private var _border : Bool = false;
	private var _thinkness : Float = 1;
	private var _borderColor : Int = 0x000000;
	private var _borderAlpha : Float = 1;
	private var _bgDisplayImage : Bool = false;
	
	
	
	public function new(data:Dynamic = null)
    {
		super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
    }
	
	private function onStageAdd(event : Event) : Void 
	{
		UIBitmapManager.watchElement(TYPE, this);
	}
	
	private function onStageRemove(event : Event) : Void 
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
	}

	override function setComponentData(data:Dynamic) 
	{
		super.setComponentData(data);

		if(Reflect.hasField(data,"border"))
			_border = Reflect.field(data,"border");

		if(Reflect.hasField(data,"thinkness"))
			_thinkness = Reflect.field(data,"thinkness");

		if(Reflect.hasField(data,"borderColor"))
			_borderColor = Reflect.field(data,"borderColor");

		if(Reflect.hasField(data,"borderAlpha"))
			_borderAlpha = Reflect.field(data,"borderAlpha");

		if(Reflect.hasField(data,"mode"))
			_mode = Reflect.field(data, "mode");
			
		if (Reflect.hasField(data, "scrollContentType"))
		{
			if (Reflect.field(data, "scrollContentType") == RECT_MODE || Reflect.field(data, "scrollContentType") == MASK_MODE)
				_scrollContentType = Reflect.field(data, "scrollContentType");
		}

	}
	
	
	override public function initialize():Void 
	{
		_scrollBarH = new ScrollBar();
		_scrollBarV = new ScrollBar();
		
		shapeBlock = new Shape();
		_outline = new Shape();
		
		_scrollMask = new Shape();
		
		_contentSizeBox = new Shape();
		_contentSizeBox.visible = false;

		_mask = new Shape();

		
		super.initialize();
		
		_scrollBarH.slider.direction = ScrollBarDirection.HORIZONTAL; 
		_scrollBarV.slider.direction = ScrollBarDirection.VERTICAL;
		_scrollBarH.visible = false;
		_scrollBarV.visible = false;
		
		
		// Set background from UIBitmapManager and UIStyle Manager if need be  
		initUISkin();
		initStyle();
		
		//addChild(backgroundShape);
		addChild(_contentSizeBox);
		//addChild(contentObject);
		addChild(shapeBlock);
		addChild(_outline); 
		addChild(_scrollBarH.displayObject);
		addChild(_scrollBarV.displayObject);
		
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
		_backgroundColor = value;
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
		//_scrollBarH.slider.percent = 0;
		//_scrollBarV.slider.percent = 0;
		//
		//if (_scrollContentLoaded)
		//{
		//	_scrollContentH.unload();
		//	_scrollContentV.unload();
        //}
		
		_contentSizeBox.graphics.clear();
		_contentSizeBox.graphics.beginFill(_backgroundColor);
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
	* Reload the content that is inside the ScrollPane
	*/ 
	
	public function refreshPane() : Void
	{
		if (null == contentObject || contentObject.numChildren == 0)
		return;
		
		// Pull content out of display clip
		var tempClip : DisplayObject = contentObject.getChildAt(0);
		//contentObject.removeChild(tempClip);
		
		// Redraw the content size blog based on display object removed
		_contentSizeBox.graphics.clear();
		_contentSizeBox.graphics.beginFill(_backgroundColor);
		_contentSizeBox.graphics.drawRect(0, 0, tempClip.width, tempClip.height);
		_contentSizeBox.graphics.endFill();
		
		// Update Scrollbar
		//contentObject = new Sprite();
		//contentObject.addChild(tempClip);
		//contentHolder.addChild(backgroundShape);
		//contentHolder.addChild(_contentSizeBox);
		//contentHolder.addChild(contentObject);
		contentHolder.addChild(_scrollBarH.displayObject);
		contentHolder.addChild(_scrollBarV.displayObject);
		contentHolder.addChild(_outline);
		//contentHolder.addChild(shapeBlock);
		
		update();
		//draw();
    }

	
	/**
	* Update the content area, this is needed for when the content loaded inside the ScrollPane size has changed
	*/
	
	public function update() : Void 
	{
		
		if (_scrollContentLoaded) 
		{
			_scrollContentH.unload();
			_scrollContentV.unload();
        }
		
		// Set things based on scroll mode
		if (_scrollContentType == RECT_MODE)
		{
			_scrollRectH = new Rectangle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X, UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y, _width, _height - shapeBlock.height);
			_scrollRectV = new Rectangle(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X, UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y, _width, _height - shapeBlock.height);
			
			_scrollContentH = new ScrollRectContent(contentObject, _scrollBarH, _scrollRectH);
			_scrollContentV = new ScrollRectContent(contentObject, _scrollBarV, _scrollRectV);
			
		}
		else if (_scrollContentType == MASK_MODE)
		{
			_scrollContentH = new ScrollMaskContent(contentObject, _scrollBarH, _scrollMask);
			_scrollContentV = new ScrollMaskContent(contentObject, _scrollBarV, _scrollMask);
		}
		
		
		_scrollBarH.slider.percent = 0;
		_scrollBarV.slider.percent = 0;
		
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
		
		shapeBlock.graphics.drawRect(0, 0, _scrollBarH.buttonWidth, _scrollBarH.buttonHeight);
		shapeBlock.graphics.endFill();
		
		_mask.graphics.clear();
		
		
		// Scroll mask if mode is enabled
		_scrollMask.graphics.clear();
		
		if (_scrollContentType == RECT_MODE)
		{
			// Over all mask
			_mask.graphics.beginFill();
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
			
			mask = _mask;
		}
		else if (_scrollContentType == MASK_MODE)
		{
			_scrollMask.graphics.beginFill(0, 1);
			_scrollMask.graphics.drawRect(UIStyleManager.SCROLLPANE_CONTENT_OFFSET_X, UIStyleManager.SCROLLPANE_CONTENT_OFFSET_Y, (_scrollBarH.visible) ? _width - shapeBlock.width : _width, (_scrollBarV.visible) ? _height : _height - _scrollBarV.buttonHeight);
			_scrollMask.graphics.endFill();
			
			mask = null;
		}
		
		
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
	* The settings are ScrollPolicy.AUTO, ScrollPolicy.VERTICAL_ONLY, ScrollPolicy.HORIZONTAL_ONLY, ScrollPolicy.ON or ScrollPolicy.OFF.
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
	
	public function get_mode() : String 
	{
		return _mode; 
	}
	
	
	
	private function updatePolicy(value : String = "auto") : Void 
	{
			// If nothing was setup then leave
			if(contentObject.numChildren == 0)
			return;
			
			
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
					shapeBlock.x = shapeBlock.y = 0;
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
					_scrollBarH.enabled = true;
				else
					_scrollBarH.enabled = false;
				
				// Check to see height of the s loaded width greather 
				if(_contentSizeBox.height > _height)
					_scrollBarV.enabled = true;
				else
					_scrollBarV.enabled = false;
				
				
			}
			else if (value == ScrollPolicy.ONLY_VERTICAL)
			{
				_scrollBarH.visible = false;
				_scrollBarV.visible = true;
				shapeBlock.visible = false;
				
				_scrollBarV.height = _height + UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				
				// Check to see height of the s loaded width greather 
				if(_contentSizeBox.height > _height)
					_scrollBarV.enabled = true;
				else
					_scrollBarV.enabled = false;
			}
			else if (value == ScrollPolicy.ONLY_HORIZONTAL)
			{
				_scrollBarV.visible = false;
				_scrollBarH.visible = true;
				shapeBlock.visible = false;
				
				_scrollBarH.width = _width + UIStyleManager.SCROLLPANE_CONTENT_WIDTH_OFFSET;
				
				// Check to see width of the content loaded width greather 
				if(_contentSizeBox.width > _width)
					_scrollBarH.enabled = true;
				else
					_scrollBarH.enabled = false;
			}
			else if(value == ScrollPolicy.OFF)
			{
				_scrollBarH.visible = false;
				_scrollBarV.visible = false;
				shapeBlock.visible = false;
			}
		
    }
	

}