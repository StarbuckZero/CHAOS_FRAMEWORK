package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.event.SliderEvent;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;


/**
 * Scroll content in mask
 * @author Erick Feiling
 */
class ScrollMaskContent extends ScrollContentBase 
{
	private var _mask:Shape;
	
	private var _contentHolder:Sprite;
	
	private var _defaultContextLoc:Point;
	


	public function new(clip:DisplayObject, scroller:IScrollBar, mask:Shape ) 
	{
		_mask = mask;
		_contentHolder = new Sprite();
		_defaultContextLoc = new Point(clip.x, clip.y);
		
		super(clip, scroller);
		
		
	}
	

	
	override public function attachContent(clip:DisplayObject, scroller:IScrollBar):Void 
	{
		super.attachContent(clip, scroller);
			
		if (_content.parent != null)
		{
			// Place content holder where the content current X and Y location is
			_contentHolder.x = _defaultContextLoc.x;
			_contentHolder.y = _defaultContextLoc.y;
			
			// Add mask and content holder to stage
			_content.parent.addChild(_mask);
			_content.parent.addChild(_contentHolder);
			
			// Set the location of the content to 0
			_content.x = _content.y = 0;
			
			// Move the content inside the holder
			_contentHolder.addChild(_content);
			
			// Apply mask to holder
			if(_contentHolder.mask == null)
				_contentHolder.mask = _mask;
		}
		else
			clip.addEventListener(Event.ADDED, onAddToObject, false, 0, true);
		
		
	}
	
	override public function unload():Void 
	{
		super.unload();
		
		if(_content.hasEventListener(Event.ADDED))
			_content.removeEventListener(Event.ADDED, onAddToObject);
			
		_mask.graphics.clear();
		
		if (_content.parent != null)
			_content.parent.removeChild(_content);
		
		if (_contentHolder.parent != null)
			_contentHolder.parent.removeChild(_contentHolder);
		
		
		if (_mask.parent != null)
			_mask.parent.removeChild(_mask);
		
		_contentHolder.mask = null;
		
		
	}
	
	
	private function onAddToObject(event:Event):Void 
	{
		_content.removeEventListener(Event.ADDED, onAddToObject);
	
		// Place content holder where the content current X and Y location is
		_mask.x = _contentHolder.x = _defaultContextLoc.x;
		_mask.y = _contentHolder.y = _defaultContextLoc.y;
		
		// Add mask and content holder to stage
		_content.parent.addChild(_mask);
		_content.parent.addChild(_contentHolder);
		
		// Set the location of the content to 0
		_content.x = _content.y = 0;
			
		// Move the content inside the holder
		_contentHolder.addChild(_content);
		
		// Apply mask to holder
		_contentHolder.mask = _mask;
	}
	
	override public function draw():Void 
	{
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
		{
			
			_scrollbar.x = _content.width - _scrollbar.width;
			_scrollbar.y = _content.y;
			_scrollbar.height = _mask.height;
			
			
			var barSizeHeight : Int = Std.int((_scrollbar.height / 2) - (_scrollbar.buttonHeight / 2));
			
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
			
			
			_scrollbar.y = (_content.y + _content.height);
			_scrollbar.width =  _mask.width;
			
			var barSizeWidth : Int = Std.int((_content.width / 2) - (_scrollbar.buttonWidth / 2));
			
			if (_sliderResize) 
			{
				if (barSizeWidth >= _sliderSize) 
					_scrollbar.sliderSize = barSizeWidth;
                else 
					_scrollbar.sliderSize = _sliderSize;
            }			
		}
		
		super.draw();
	}
	
	override function updateContent(event:SliderEvent):Void 
	{
		super.updateContent(event);
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
		{
			var scrollable_v : Float = _content.height - _mask.height - _scrollbar.scrollAmount;
			_content.y = -(scrollable_v * event.percent);
		}
		else 
		{
			var scrollable_h : Float = _content.width - _mask.width - _scrollbar.scrollAmount;
			_content.x = -(scrollable_h * event.percent);
		}
	}
	
}