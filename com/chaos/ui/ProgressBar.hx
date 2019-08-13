package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IProgressBar;
import openfl.display.BitmapData;
import openfl.errors.Error;

import openfl.display.Shape;
import openfl.events.Event;
import openfl.text.Font;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.events.ProgressEvent;
import openfl.net.URLLoader;
import openfl.media.Sound;
import openfl.display.Loader;
import com.chaos.ui.Label;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

	/**
	 *
	 * Creates a ProgressBar
	 *
	 *  @author Erick Feiling
	 */
	class ProgressBar extends BaseUI implements IProgressBar implements IBaseUI
	{
		
		public static inline var TYPE : String = "ProgressBar";

		public var label(get, never) : ILabel;
		public var loadedLabel(get, never) : ILabel;
		public var border(get, set) : Bool;
		public var borderColor(get, set) : Int;
		public var borderThinkness(get, set) : Float;
		public var borderAlpha(get, set) : Float;
		public var backgroundColor(get, set) : Int;
		public var showLabel(get, set) : Bool;
		public var loadColor(get, set) : Int;
		public var textColor(get, set) : Int;
		public var textLoadColor(get, set) : Int;
		public var align(get, set) : String;
		public var percent(get, set) : Int;
		public var stopWatchAfterComplete(get, set) : Bool;


		private var _background : Bool = true;
		private var _backgroundAlpha : Float = 1;
		private var _loadedAlpha : Float = 1;
		private var _backgroundNormalColor : Int = 0xCCCCCC;
		private var _loadColor : Int = 0x666666;
		private var _textColor : Int = 0x000000;
		private var _textLoadedColor : Int = 0xFFFFFF;
		private var _outlineColor : Int = 0x000000;
		
		private var _border : Bool = UIStyleManager.PROGRESSBAR_BORDER;
		private var _thinkness : Float = 1;
		private var _outlineAlpha : Float = 1;
		private var _displayImage : Bool = false;
		private var _showImage : Bool = true;
		private var _smoothImage : Bool = true;
		
		private var _outline : Shape = new Shape();
		private var _backgroundNormal : Shape = new Shape();
		private var _loadedBar : Shape = new Shape();
		private var _mask : Shape = new Shape();
		private var _fontMask : Shape = new Shape(); 
		
		private var _backgroundImage : BitmapData;
		private var _loadedBarImage : BitmapData;
		private var _label : Label;
		private var _loadedLabel : Label;
		private var _align : String = TextFormatAlign.CENTER;
		private var _showLabel : Bool = true;
		private var _watchingFile : Bool = false;
		private var _urlFile : Dynamic;
		private var _percent : Int = 0;
		private var _stopWatchAfterComplete : Bool = false;
		
		private var _labelData : Dynamic;
		private var _loadedLabelData : Dynamic;
		
	
	public function new(data:Dynamic = null)
    {
		// progressBarWidth : Int = 100, progressBarHeight : Int = 15
        super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "background"))
			_background = Reflect.field(data, "background");
		
		if (Reflect.hasField(data, "backgroundAlpha"))
			_backgroundAlpha = Reflect.field(data, "backgroundAlpha");
			
		if (Reflect.hasField(data, "loadedAlpha"))
			_loadedAlpha = Reflect.field(data, "loadedAlpha");
			
		if (Reflect.hasField(data, "borderColor"))
			_outlineColor = Reflect.field(data, "borderColor");
		
		if (Reflect.hasField(data, "borderThinkness"))
			_thinkness = Reflect.field(data, "borderThinkness");
		
		if (Reflect.hasField(data, "borderAlpha"))
			_outlineAlpha = Reflect.field(data, "borderAlpha");
			
		if (Reflect.hasField(data, "backgroundColor"))
			_backgroundNormalColor = Reflect.field(data, "backgroundColor");
		
		if (Reflect.hasField(data, "showLabel"))
			_showLabel = Reflect.field(data, "showLabel");
		
		if (Reflect.hasField(data, "loadColor"))
			_loadColor = Reflect.field(data, "loadColor");
			
		if (Reflect.hasField(data, "textColor"))
			_textColor = Reflect.field(data, "textColor");
			
		if (Reflect.hasField(data, "textLoadColor"))
			_textLoadedColor = Reflect.field(data, "textLoadColor");
			
		if (Reflect.hasField(data, "align"))
			_align = Reflect.field(data, "align");
			
		if (Reflect.hasField(data, "percent"))
			_percent = Reflect.field(data, "percent");
			
		if (Reflect.hasField(data, "stopWatchAfterComplete"))
			_stopWatchAfterComplete = Reflect.field(data, "stopWatchAfterComplete");
			
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
			
		if (Reflect.hasField(data, "LoadedLabel"))
			_loadedLabelData = Reflect.field(data, "LoadedLabel");
			
		
	}
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	override public function initialize():Void 
	{
		
		// Add defautls to label	
		Reflect.setField(_labelData, "width", _width);
		Reflect.setField(_labelData, "height", _height);
		Reflect.setField(_labelData, "textColor", _textColor);
		
		Reflect.setField(_loadedLabelData, "width", _width);
		Reflect.setField(_loadedLabelData, "height", _height);
		Reflect.setField(_loadedLabelData, "textColor", _textLoadedColor);
		
		// Set label data
		_label = new Label(_labelData);
		_loadedLabel = new Label(_loadedLabelData);
		
		super.initialize();
		
		_labelData = null;
		
		// Add to display 
		addChild(_backgroundNormal);
		addChild(_loadedBar);
		addChild(_outline);
		addChild(_mask);
		addChild(_fontMask);
		addChild(_label);
		addChild(_loadedLabel);
		
	}
	
	private function initStyle() : Void 
	{
		_labelData = {};
		_loadedLabelData = {};
		
		// Set the style
		if ( -1 != UIStyleManager.PROGRESSBAR_COLOR)
			_backgroundNormalColor = UIStyleManager.PROGRESSBAR_COLOR;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_COLOR_LOADED)
			_loadColor = UIStyleManager.PROGRESSBAR_COLOR_LOADED;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_TEXT_COLOR)
			_textColor = UIStyleManager.PROGRESSBAR_TEXT_COLOR;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_COLOR_LOADED)
			_textLoadedColor = UIStyleManager.PROGRESSBAR_COLOR_LOADED;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_BORDER_THINKNESS) 
			_thinkness = UIStyleManager.PROGRESSBAR_BORDER_THINKNESS;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_BORDER_COLOR) 
			_outlineColor = UIStyleManager.PROGRESSBAR_BORDER_COLOR;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_BORDER_ALPHA) 
			_outlineAlpha = UIStyleManager.PROGRESSBAR_BORDER_ALPHA;
		
		// Set Label Style  
		if ( -1 != UIStyleManager.PROGRESSBAR_TEXT_SIZE)  
		{
			Reflect.setField(_labelData, "size", UIStyleManager.PROGRESSBAR_TEXT_SIZE);
			Reflect.setField(_loadedLabelData, "size", UIStyleManager.PROGRESSBAR_TEXT_SIZE);
		}
		
		
		Reflect.setField(_labelData, "italic", UIStyleManager.PROGRESSBAR_TEXT_ITALIC);
		Reflect.setField(_labelData, "bold", UIStyleManager.PROGRESSBAR_TEXT_BOLD);
		
		Reflect.setField(_loadedLabelData, "italic", UIStyleManager.PROGRESSBAR_TEXT_ITALIC);
		Reflect.setField(_loadedLabelData, "bold", UIStyleManager.PROGRESSBAR_TEXT_BOLD);
		
		
		if ("" != UIStyleManager.PROGRESSBAR_TEXT_FONT)  
		{
			Reflect.setField(_labelData, "font", UIStyleManager.PROGRESSBAR_TEXT_FONT);
			Reflect.setField(_loadedLabelData, "font", UIStyleManager.PROGRESSBAR_TEXT_FONT);
		}
		
		
		if ("" != UIStyleManager.PROGRESSBAR_TEXT_ALIGN)  
		{
			Reflect.setField(_labelData, "align", UIStyleManager.PROGRESSBAR_TEXT_ALIGN);
			Reflect.setField(_loadedLabelData, "align", UIStyleManager.PROGRESSBAR_TEXT_ALIGN);
		}
        
		//TODO: Look into embed font with asset manager 
		//if (null != UIStyleManager.PROGRESSBAR_TEXT_EMBED)
		//{
		//	_label.setEmbedFont(UIStyleManager.PROGRESSBAR_TEXT_EMBED);
		//	_loadedLabel.setEmbedFont(UIStyleManager.PROGRESSBAR_TEXT_EMBED);
        //}
    }
	
	private function initBitmap() : Void 
	{
		// UI Skinning
		if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_BACKGROUND))  
		setBackgroundImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_BACKGROUND));
		
		if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_LOADED_BACKGROUND))     
        setLoadBarImage(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_LOADED_BACKGROUND));
    }
	
	override public function destroy():Void 
	{
		super.destroy();
		
		_backgroundNormal.graphics.clear();
		_loadedBar.graphics.clear();
		_outline.graphics.clear();
		_mask.graphics.clear();
		_fontMask.graphics.clear();
		
		removeChild(_backgroundNormal);
		removeChild(_loadedBar);
		removeChild(_outline);
		removeChild(_mask);
		removeChild(_fontMask);
		removeChild(_label);
		removeChild(_loadedLabel);
		
		_label.destroy();
		_loadedLabel.destroy();
		
		// Clear objects from memory
		_label = _loadedLabel = null;
		_backgroundNormal = _loadedBar = _outline = _mask = _fontMask = null;
		_loadedLabelData = _labelData = null;
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
	
	private function set_stopWatchAfterComplete(value:Bool) : Bool
	{
		_stopWatchAfterComplete = value;
		return value;
	}
	
	private function get_stopWatchAfterComplete() : Bool
	{
		return _stopWatchAfterComplete;
	}
	
	/**
	 * Returns the label being used in ProgressBar
	 */
	
	private function get_label() : Label { return _label; } 
		
	
	/**
	 * Returns the loaded label being used in the ProgressBar
	 */
	
	private function get_loadedLabel() : Label { return _loadedLabel; } 

	
	/**
	 * Toggle on and off border
	 */
	
	private function set_border(value : Bool) : Bool 
	{
		_border = value;
		
		return value;
	}
	
	
	/**
	 * Returns true if the border is on and false if not
	 */
	
	private function get_border() : Bool { return _border; }
	
	
	/**
	 * The ProgressBar border color that is to
	 */
	
	private function set_borderColor(value : Int) : Int
	{ 
		_outlineColor = value;
		
		return value;
	}
	
	/**
	 * Returns the color
	 */
	private function get_borderColor() : Int { return _outlineColor; } 
	
	
	/**
	 * Specifies the border thinkness
	 */
	
	private function set_borderThinkness(value : Float) : Float 
	{
		_thinkness = value; 
		
		
		return value;
	}
	
	/**
	 * Returns the border thinkness
	 */
	
	private function get_borderThinkness() : Float { return _thinkness; }
	
	
	/**
	 * Specifies the border alpha
	 */
	
	private function set_borderAlpha(value : Float) : Float
	{ 
		_outlineAlpha = value; 
		
		
		return value; 
	}
	
	/**
	 * Returns the boarder alpha
	 */ 
	
	private function get_borderAlpha() : Float { return _outlineAlpha; }
	
	/**
	 * Set the color of the ProgressBar background
	 */
	
	private function set_backgroundColor(value : Int) : Int 
	{ 
		_backgroundNormalColor = value;
		
		
		return value;
	}
	
	
	/**
	 * Returns the color
	 */
	
	private function get_backgroundColor() : Int { return _backgroundNormalColor; }
		
	
	/**
	 * Set this if you want to show the ProgressBar label used to show the amount of data loaded
	 */
	
	private function set_showLabel(value : Bool) : Bool 
	{ 
		_showLabel = _label.visible = _loadedLabel.visible = value; 
		
		return value;
	}
	
	/**
	 * Returns true if the label is been displayed and false if not
	 */
	
	private function get_showLabel() : Bool { return _showLabel; }
		 
	/**
	 * Configure and setup the label to handle embedded fonts
	 *
	 * @param value The font you want to use.
	 *
	 */
	
	public function setEmbedFont(value : Font) : Void 
	{
		_label.setEmbedFont(value);
		_loadedLabel.setEmbedFont(value); 
	}
	
	
	/**
	 * Unload the font that was set by using the setEmbedFont
	 */
	
	 public function unloadEmbedFont() : Void 
	 {
		_label.unloadEmbedFont();
		_loadedLabel.unloadEmbedFont();
	 }
	
	/**
	 * The color that is used once progress has been made
	 */
	
	private function set_loadColor(value : Int) : Int 
	{ 
		_loadColor = value;
		return value;
	}
	
	/**
	 * Return the loaded color being used
	 */
	
	private function get_loadColor() : Int { return _loadColor; }
	
	/**
	 * The color of the text in a label, in hexadecimal format.
	 */
	private function set_textColor(value : Int) : Int 
	{ 
		_label.textColor = _textColor = value; 
		return value;
	}
	
	
	/**
	 * Return the label color
	 */
	private function get_textColor() : Int { return _label.textColor; } 
	
	/**
	 * The color of the text in a loaded label, in hexadecimal format.
	 */
	
	private function set_textLoadColor(value : Int) : Int 
	{
		_loadedLabel.textColor = _textLoadedColor = value;
		return value; 
	}
	
	/**
	 * Return the label color
	 */
	
	private function get_textLoadColor() : Int { return _loadedLabel.textColor; }
	

	/**
	 * This is for setting an image to the ProgressBar. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setBackgroundImage(value : BitmapData) : Void 
	{
		_backgroundImage = value;
	}
	

	
	/**
	 * This is for setting an image to the ProgressBar loaded background. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setLoadBarImage(value : BitmapData) : Void 
	{
		_loadedBarImage = value;
	}
	
	/**
	 * The object you want the ProgressBar to use when it comes to showing how much of the file is loaded.
	 * This value goes from 0 to 100 and can only be linked to one file.
	 *
	 * Support Types are: Sound, URLLoader, Loader and XML
	 *
	 * @param value The object you want to apply the watcher for updated the ProgressBar
	 *
	 */
	
	public function watchObject(value : Dynamic) : Void
	{
		var blnStremClass : Bool = false;
		
		if (Std.is(value, Sound) || Std.is(value, URLLoader) || Std.is(value, Loader))
			blnStremClass = true;
		
		// Add in events and set flag 
		_urlFile = value;
		
		// Stop old file watch if there is one
		stopWatchObject();
		
		if (_urlFile == Loader) 
		{
			_urlFile.loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressCheck);
			_urlFile.loaderInfo.addEventListener(Event.COMPLETE, progressComplete);
		}
		else 
		{
			_urlFile.addEventListener(ProgressEvent.PROGRESS, progressCheck);
			_urlFile.addEventListener(Event.COMPLETE, progressComplete);
		}
		
		_watchingFile = true;
	}
	
	
	/**
	 * Stop ProgressBar from keeping track of how much of a file is loaded
	 */  
	public function stopWatchObject() : Void
	{
		// If already been flag then remove old listen
		if (_watchingFile) 
		{
			if (_urlFile == Loader) 
			{
				try
				{
					_urlFile.loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressCheck);
					_urlFile.loaderInfo.removeEventListener(Event.COMPLETE, progressComplete);
				}
				catch (error : Error)
				{
					trace("Having problem removing events");
				}
				
			}
		}
		else 
		{
			try
			{
				_urlFile.removeEventListener(ProgressEvent.PROGRESS, progressCheck);
				_urlFile.removeEventListener(Event.COMPLETE, progressComplete);
			}                
			catch (error : Error)
			{
				trace("Having problem removing events");
			}
		}
		
		_watchingFile = false;
	}
	
	/**
	 * Set the alignment of the label text
	 *
	 * @param value The text that you want to set on the label
	 */
	
	private function set_align(value : String) : String
	{
		if (TextFormatAlign.LEFT == value || TextFormatAlign.CENTER == value || TextFormatAlign.JUSTIFY == value || TextFormatAlign.RIGHT == value) 
			_align = value;
		else 
			_align = TextFormatAlign.LEFT;
		
		return value;
	} 
	
	/**
	 * Return the alignment that is being used
	 */
	private function get_align() : String 
	{
		return _align; 
	} 

	/**
	 * Set how much of the ProgressBar is loaded or complete. This is another way of showing how much data is loaded without using the watchURL method.
	 */
	
	private function set_percent(value : Int) : Int 
	{ 
		_percent = value;
		draw();
		
		return value;
	}
	
	/**
	 * Return value from 0 to 100
	 */
	
	private function get_percent() : Int { return _percent; }
	
	
	 /**
	 * Draw the ProgressBar and all the UI classes it's using
	 *
	 */
	 
	override public function draw() : Void
	{ 
		// Get ready to draw background and border
		_outline.graphics.clear();
		_backgroundNormal.graphics.clear();
		_loadedBar.graphics.clear(); 
		
		// Set alignment percent text
		_label.align = _align;
		_loadedLabel.align = _align;
		_label.width = _loadedLabel.width = _width;
		_label.height = _loadedLabel.height = _height;
		_label.visible = _showLabel;
		_loadedLabel.visible = _showLabel;
		
		if (_showImage) 
		{
			if (null != _backgroundImage)
				_backgroundNormal.graphics.beginBitmapFill(_backgroundImage, null, true, _smoothImage)
			else
				_backgroundNormal.graphics.beginFill(_backgroundNormalColor, _backgroundAlpha);
				
				
			if (null != _loadedBarImage)
				_loadedBar.graphics.beginBitmapFill(_loadedBarImage, null, true, _smoothImage);
			else
				_loadedBar.graphics.beginFill(_loadColor, _loadedAlpha);
		}
		else 
		{
			_backgroundNormal.graphics.beginFill(_backgroundNormalColor, _backgroundAlpha);
			_loadedBar.graphics.beginFill(_loadColor, _loadedAlpha);
		} 
		
		// First set draw normal size 
		_backgroundNormal.graphics.drawRect(0, 0, _width, _height);
		_backgroundNormal.graphics.endFill();
		
		_loadedBar.graphics.drawRect(0, 0, _width, _height);
		_loadedBar.graphics.endFill();
		
		_mask.graphics.beginFill(_loadColor, _backgroundAlpha);
		_mask.graphics.drawRect(0, 0, _width, _height);
		_mask.graphics.endFill();
		
		_fontMask.graphics.beginFill(_loadColor, _backgroundAlpha);
		_fontMask.graphics.drawRect(0, 0, _width, _height);
		_fontMask.graphics.endFill(); 
		
		
		// Set loading text 
		_label.text = _loadedLabel.text = Std.string(_percent);
		_label.draw();
		
		// Set Mask area 
		_loadedBar.mask = _mask;
		_loadedLabel.mask = _fontMask; 
		
		// Take the percent and scale back the loader bar
		_mask.scaleX = _fontMask.scaleX = (_percent * .01);
		
		
		// Setup for border if need be 
		if (_border) 
		{
			_outline.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
			_outline.graphics.drawRect(0, 0, _width, _height);
		}
    }
	

	
	private function progressCheck(event : Event) : Void 
	{ 
		if (Std.is(event.currentTarget, Sound))
			_percent = Std.int(( cast(event.currentTarget, Sound).bytesLoaded /  cast(event.currentTarget, Sound).bytesTotal) * 100);
		else if (Std.is(event.currentTarget, URLLoader))
			_percent = Std.int(( cast(event.currentTarget, URLLoader).bytesLoaded /  cast(event.currentTarget, URLLoader).bytesTotal) * 100);
		else if (Std.is(event.currentTarget, Loader))
			_percent = Std.int(( cast(event.currentTarget, Loader).contentLoaderInfo.bytesLoaded /  cast(event.currentTarget, Loader).contentLoaderInfo.bytesTotal) * 100);
		
		draw();
	}
	
	private function progressComplete(event : Event) : Void
	{
		draw();
		
		if (_stopWatchAfterComplete)
			stopWatchObject();
	}
}
