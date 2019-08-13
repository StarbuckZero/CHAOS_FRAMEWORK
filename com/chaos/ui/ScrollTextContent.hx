package com.chaos.ui;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.event.SliderEvent;

import openfl.text.TextField;

/**
 * For scrolling text with scrollbar
 * @author Erick Feiling
 * 
 */
class ScrollTextContent extends ScrollContentBase 
{
	private var _textField:TextField;

	public function new(textField:TextField, scroller:IScrollBar) 
	{
		_textField = textField;
		
		super(textField, scroller);
		
		
	}
	
	override public function unload():Void 
	{
		super.unload();
		
		// Remove Scroll Rect  
		_content.scrollRect = null;
		
	}
	
	
	override public function update():Void 
	{
		super.update();
		
		if (!_active)
		return;
		
		contentWidth = _textField.width;
		contentHeight = _textField.textHeight;
	}
	
	override public function draw():Void 
	{
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
		{
			_scrollbar.x = (_content.x + _content.width);
			_scrollbar.y = _content.y;
			_scrollbar.height = _content.height;
			
			if (_sliderResize) 
			{
				var barSizeHeight : Int = Std.int(_textField.height / 2);
				
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
			
			_scrollbar.width = _content.width;
			
			if (_sliderResize) 
			{
				var barSizeWidth : Int = Std.int(_content.width / 2);
				
				if (barSizeWidth >= _sliderSize) 
					_scrollbar.sliderSize = barSizeWidth;
                else 
					_scrollbar.sliderSize = barSizeWidth;
            }
			
		}
		
		_scrollbar.draw();
		
		super.draw();
		
		
	}
	
	override private function updateContent(event:SliderEvent):Void 
	{
		super.updateContent(event);
		
		if (ScrollBarDirection.VERTICAL == _scrollbar.slider.direction) 
			_textField.scrollV = Std.int(_textField.maxScrollV * event.percent);
		else 
			_textField.scrollH = Std.int(_textField.maxScrollH * event.percent);
		
	}
	
}