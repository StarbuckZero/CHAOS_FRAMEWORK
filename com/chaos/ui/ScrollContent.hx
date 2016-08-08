package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.text.TextField;
import openfl.geom.Rectangle;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.ui.event.SliderEvent; 

/* Attach scrollbar to display object or textfield
*
*  @author Erick Feiling
*  @date 11-15-09  
*  
*/ 

class ScrollContent
{
    public var sliderSize(get, set) : Int;
    public var sliderActiveResize(get, set) : Bool;
    public var active(get, never) : Bool;
    public var content(get, never) : Dynamic;
    public var scrollbar(get, never) : IScrollBar;
	
	private var _sliderSize : Int = 10;
	
	// elements 
	private var _content : DisplayObject;
	private var _scrollbar : IScrollBar;
	private var _scrollRect : Rectangle;
	private var _textMode : Bool;
	private var _sliderResize : Bool = true;
	private var _active : Bool = false;
	private var contentHeight : Float;
	private var contentWidth : Float;
	
	public function new(clip : DisplayObject = null, scroller : IScrollBar = null, scrollRect : Rectangle = null)
    {
		if (clip == null || scroller == null)
		return;
		
		// When true content can be unloaded using the "unload" method
		_active = false;
		
		// Set slider resize state based on what was passed in
		_sliderResize = scroller.sliderActiveResize;
		
		// Setup content
		attachContent(clip, scroller, scrollRect);
		
		// Draw scroll bar
		update();
		
		draw();
    }
	
	/**
	 * The smallest the slider will go
	 * 
	 * 
	 * */
	private function set_sliderSize(value : Int) : Int { _sliderSize = value; return value; } 
	
	/**
	 * Return the slider default size
	 */
		
	private function get_sliderSize() : Int { return _sliderSize; }
	
	/**
		* Set if the slider will resize itself based on the content size
		* 
		* @param value If true the slider will resize, if false it will not
		* @default true
		*/
	private function set_sliderActiveResize(value : Bool) : Bool
	{
		_sliderResize = _scrollbar.sliderActiveResize = value;
        return value;
    }
	
	/**
	*
	* @return Returns true if the slider will resize once attached to some form of content and false if not.
	*/ 
	
	private function get_sliderActiveResize() : Bool
	{
		return _sliderResize;
    }
	
	/**
	* Draw all elements being used on
	*
	*/ 
	public function draw() : Void
	{
		// Set location of scrollbar  
		if (ScrollBarDirection.VERTICAL == _scrollbar.direction) 
		{ 
			// If text field then resize
			if (_textMode)
			_content.width = contentWidth - _scrollbar.width;
			
			_scrollbar.x = ((_textMode)) ? (_content.x + contentWidth) + _scrollbar.width : _content.scrollRect.width - _scrollbar.width;
			_scrollbar.y = ((_textMode)) ? _content.y : _content.scrollRect.y;
			_scrollbar.height = ((_textMode)) ? _content.height : _content.scrollRect.height;
			
			var barSizeHeight : Int;
			
			if (_textMode)
				barSizeHeight = Std.int(cast(_content, TextField).height / 2);
			else
				barSizeHeight = Std.int((_content.scrollRect.height / 2) - (_scrollbar.buttonHeight / 2));
			
			if (_sliderResize) 
			{
				if (barSizeHeight >= _sliderSize) 
					_scrollbar.sliderSize = barSizeHeight;
                else 
					_scrollbar.sliderSize = _sliderSize;
            }
			
        }
		
        else 
		{
			_scrollbar.x = _content.x;
			
			if (_content.scrollRect != null && !_textMode) 
				_scrollbar.y = (_content.scrollRect.y + _content.scrollRect.height);
            else 
				_scrollbar.y = (_content.y + _content.height);
			
			_scrollbar.width = ((_textMode)) ? _content.width : _content.scrollRect.width;
			
			var barSizeWidth : Int;
			
			
			if (_textMode)
				barSizeWidth = Std.int((_content.width / 2));
			else
				barSizeWidth = Std.int((_content.scrollRect.width / 2) - (_scrollbar.buttonWidth / 2));
			
			if (_sliderResize) 
			{
				if (barSizeWidth >= _sliderSize) 
					_scrollbar.sliderSize = barSizeWidth;
                else 
					_scrollbar.sliderSize = _sliderSize;
            }
        }
		
		_scrollbar.scrollAmount = _content.width * .0001;
    }
	
	/**
	* Links a DisplayObject
	* 
	* @param clip The DisplayObject or MovieClip
	* @param scroller The scrollbar that will be attached to the object being passed in
	* @param scrollRect The size of the area that will be used. Don't pass anything if using in text field
	* 
	* @see openfl.display.DisplayObject
	* @see com.chaos.ui.ScrollBar
	* @see openfl.geom.Rectangle
	*/
	public function attachContent(clip : DisplayObject, scroller : IScrollBar, scrollRect : Rectangle = null) : Void
	{
		// Check to see if text field  
		if (Std.is(clip, TextField)) 
		{
			_textMode = true;
		}
		else if (Std.is(clip, DisplayObject)) // Setup ScrollBar
		{
			
			// If no scrollRect was passed in then create one 
			if (null == scrollRect) 
			scrollRect = new Rectangle(0, 0, clip.width, clip.height);
			
			_textMode = false;
		}
		else 
		{
			trace("Pass in a TextField or some form of an DisplayObject");
			return;
		}
		
		_scrollbar = scroller;
		_scrollbar.addEventListener(SliderEvent.CHANGE, updateContent, false, 0, false);
		
		// Setup Content Area 
		_content = clip;
		
		contentHeight = _content.height;
		contentWidth = _content.width;
		
		_scrollRect = scrollRect;
		
		if (!_textMode && scrollRect != null) 
		{
			if (ScrollBarDirection.VERTICAL == scroller.direction) 
				_content.scrollRect = new Rectangle(scrollRect.x, scrollRect.y, scrollRect.width, scrollRect.height + scroller.buttonHeight);
            else 
				_content.scrollRect = new Rectangle(scrollRect.x, scrollRect.y, scrollRect.width + scroller.buttonWidth, scrollRect.height);
			
        }
		
		// Set active flag so content can be unloaded
		_active = true;
    }
	
	/**
	*
	* @return Return true if class is attached to DisplayObject and false if not
	*
	*/
	private function get_active() : Bool { return _active; }
		
	
	/**
	*
	* @return Returns the DisplayObject has been linked
	*
	*/
	private function get_content() : Dynamic { return _content; }  
	
	/**
	*
	* @return Returns the ScrollBar that is being used
	*
	*/
	
	private function get_scrollbar() : IScrollBar { return _scrollbar; }

	
	/**
	* Deattach and unlink everything being used.
	* 
	*/
	public function unload() : Void
	{
		// Do nothing if content is not actived  
		if (!_active) 
		return;
		
		_scrollbar.removeEventListener(SliderEvent.CHANGE, updateContent);
		_scrollbar.stop();
		
		// Set flag back so content doesn't udpate
		_active = false;
		
		contentWidth = 0;
		contentHeight = 0;
		
		// Remove Scroll Rect  
		if (!_textMode)
		_content.scrollRect = null;
    } 
	
	/**
	* Updated ScrollRect and ScrollBar Direction.
	* 
	*/
	public function update() : Void
	{
		if (!_active)
		return;
		
		if (!_textMode)  
		_content.scrollRect = null;
		
		contentHeight = ((_textMode)) ? cast(_content, TextField).textHeight : _content.height; contentWidth = _content.width;
		if (!_textMode) 
		{
			if (ScrollBarDirection.VERTICAL == _scrollbar.direction) 
				_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width, _scrollRect.height + _scrollbar.buttonHeight);
            else 
				_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width + _scrollbar.buttonWidth, _scrollRect.height);
        }
    }
	
	private function updateContent(event : SliderEvent) : Void
	{
		// Check for the text mode 
		if (_textMode) 
		{
			if (ScrollBarDirection.VERTICAL == _scrollbar.direction) 
				cast(_content, TextField).scrollV = Std.int(cast(_content, TextField).maxScrollV * Std.int(event.percent));
            else 
				cast(_content, TextField).scrollH = Std.int(cast(_content, TextField).maxScrollH * Std.int(event.percent));
        }
        else 
		{
			if (ScrollBarDirection.VERTICAL == _scrollbar.direction) 
			{
				var scrollable_v : Float = contentHeight - _content.scrollRect.height - _scrollbar.scrollAmount;
				var sr_v : Rectangle = _content.scrollRect.clone();
				sr_v.y = scrollable_v * event.percent;
				_content.scrollRect = sr_v;
            }
            else 
			{
				var scrollable_h : Float = contentWidth - _content.scrollRect.width - _scrollbar.scrollAmount;
				var sr_h : Rectangle = _content.scrollRect.clone();
				sr_h.x = scrollable_h * event.percent;
				_content.scrollRect = sr_h;
            }
        }
    }
}