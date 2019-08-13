package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.event.SliderEvent;
import openfl.display.DisplayObject;
import openfl.geom.Rectangle;

/**
 * Apply scroll effect using scrollRect 
 * @author Erick Feiling
 */
class ScrollRectContent extends ScrollContentBase 
{

	private var _scrollRect : Rectangle;
	
	public function new(clip:DisplayObject, scroller:IScrollBar, scrollRect:Rectangle) 
	{
		_scrollRect = scrollRect;
		
		super(clip, scroller);
	}
	
	override public function attachContent(clip:DisplayObject, scroller:IScrollBar):Void
	{
		super.attachContent(clip, scroller);
		
		// If no scrollRect was passed in then create one 
		if (null == _scrollRect) 
			_scrollRect = new Rectangle(0, 0, clip.width, clip.height);
		
		
		if (_scrollRect != null) 
		{
			if (ScrollBarDirection.VERTICAL == scroller.slider.direction) 
				_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width, _scrollRect.height + scroller.buttonHeight);
            else 
				_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width + scroller.buttonWidth, _scrollRect.height);
        }
		
		
		
	}
	
	override public function unload():Void 
	{
		super.unload();
		
		_content.scrollRect = null;
	}
	
	override public function update():Void 
	{
		super.update();
		
		_content.scrollRect = null;
		
		contentWidth = _content.width;
		contentHeight = _content.height;
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
			_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width, _scrollRect.height + _scrollbar.buttonHeight);
		else 
			_content.scrollRect = new Rectangle(_scrollRect.x, _scrollRect.y, _scrollRect.width + _scrollbar.buttonWidth, _scrollRect.height);
	}
	
	override public function draw():Void 
	{
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
		{
			
			_scrollbar.x = _content.scrollRect.width - _scrollbar.width;
			_scrollbar.y = _content.scrollRect.y;
			
			_scrollbar.height = _content.scrollRect.height;
			
			var barSizeHeight : Int = Std.int((_content.scrollRect.height / 2) - (_scrollbar.buttonHeight / 2));
			
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
			
			if (_content.scrollRect != null) 
				_scrollbar.y = (_content.scrollRect.y + _content.scrollRect.height);
			
			_scrollbar.width =  _content.scrollRect.width;
			
			var barSizeWidth : Int = Std.int((_content.scrollRect.width / 2) - (_scrollbar.buttonWidth / 2));
			
			if (_sliderResize) 
			{
				if (barSizeWidth >= _sliderSize) 
					_scrollbar.sliderSize = barSizeWidth;
                else 
					_scrollbar.sliderSize = _sliderSize;
            }			
		}
		
		_scrollbar.draw();
		
		super.draw();
		
		
	}
	
	override private function updateContent(event:SliderEvent):Void 
	{
		super.updateContent(event);
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
		{
			var scrollable_v : Float = contentHeight - _content.scrollRect.height - _scrollbar.scrollAmount;
			var sr_v : Rectangle = _content.scrollRect.clone();
			
			sr_v.y = (scrollable_v * event.percent);
			_content.scrollRect = sr_v;
			
		}
		else 
		{
			var scrollable_h : Float = contentWidth - _content.scrollRect.width - _scrollbar.scrollAmount;
			var sr_h : Rectangle = _content.scrollRect.clone();
			
			sr_h.x = (scrollable_h * event.percent);
			
			_content.scrollRect = sr_h;
		}
		
	}
	
	
	
}