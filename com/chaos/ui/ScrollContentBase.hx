package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;

import openfl.display.DisplayObject;
import com.chaos.ui.event.SliderEvent; 

/**
 * Attach scrollbar content
*/ 

class ScrollContentBase
{
    public var sliderSize(get, set) : Int;
    public var sliderActiveResize(get, set) : Bool;
    public var active(get, never) : Bool;
    public var content(get, never) : DisplayObject;
    public var scrollbar(get, never) : IScrollBar;
	
	private var _sliderSize : Int = 10;
	
	// elements 
	private var _content : DisplayObject;
	private var _scrollbar : IScrollBar;
	
	private var _sliderResize : Bool = true;
	private var _active : Bool = false;
	private var contentHeight : Float;
	private var contentWidth : Float;
	
	/**
	 * Attach scrollbar to object
	 * @param	clip The DisplayObject
	 * @param	scroller The scrollbar
	 */
	public function new(clip : DisplayObject, scroller : IScrollBar)
    {
		if (clip == null || scroller == null)
		return;
		
		// When true content can be unloaded using the "unload" method
		_active = false;
		
		// Set slider resize state based on what was passed in
		_sliderResize = scroller.sliderActiveResize;
		
		// Setup content
		attachContent(clip, scroller);
		
		// Draw scroll bar
		update();
		
		draw();
    }
	
	/**
	 * The smallest the slider will go
	 **/
	
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
	* @return Returns true if the slider will resize once attached to some form of content and false if not.
	*/ 
	
	private function get_sliderActiveResize() : Bool
	{
		return _sliderResize;
    }
	
	/**
	* Draw all elements being used on
	*/ 
	
	public function draw() : Void
	{
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
	
	public function attachContent(clip : DisplayObject, scroller : IScrollBar) : Void
	{
		
		_scrollbar = scroller;
		_scrollbar.slider.addEventListener(SliderEvent.CHANGE, updateContent, false, 0, true);
		
		// Setup Content Area 
		_content = clip;
		
		contentWidth = _content.width;
		contentHeight = _content.height;

		
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
	* @return Returns the DisplayObject has been linked
	*/
	private function get_content() : Dynamic { return _content; }  
	
	/**
	* @return Returns the ScrollBar that is being used
	*/
	
	private function get_scrollbar() : IScrollBar { return _scrollbar; }

	
	/**
	* Deattach and unlink everything being used.
	*/
	
	public function unload() : Void
	{
		// Do nothing if content is not actived  
		if (!_active) 
		return;
		
		_scrollbar.slider.removeEventListener(SliderEvent.CHANGE, updateContent);
		_scrollbar.slider.stop();
		
		// Set flag back so content doesn't udpate
		_active = false;
		
		contentWidth = 0;
		contentHeight = 0;
		
    } 
	
	/**
	* Updated ScrollRect and ScrollBar Direction.
	*/
	
	public function update() : Void
	{
		if (!_active)
		return;
		
		
    }
	
	private function updateContent(event : SliderEvent) : Void
	{
        
    }
}