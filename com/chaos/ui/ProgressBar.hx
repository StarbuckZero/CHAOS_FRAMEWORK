package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IProgressBar;
import openfl.errors.Error;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.filters.BitmapFilter;
import openfl.text.Font;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.LoaderInfo;
import openfl.events.ProgressEvent;
import openfl.net.URLLoader;
import openfl.media.Sound;
import openfl.display.Loader;
//import openfl.filters.BevelFilter;
import com.chaos.ui.Label;
import com.chaos.media.DisplayImage;
import com.chaos.ui.UIDetailLevel;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
//import com.chaos.ui.interface.IProgressBar;
//import com.chaos.ui.interface.IBaseUI;  

	/**
	 *
	 * Creates a ProgressBar on the fly
	 *
	 *  @author Erick Feiling
	 */
	class ProgressBar extends BaseUI implements IProgressBar implements IBaseUI
	{
		
		public static inline var TYPE : String = "ProgressBar";
		
		public var label(get, never) : Label;
		public var loadedLabel(get, never) : Label;
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
		public var filterMode(get, set) : Bool;
		
		private var _background : Bool = true;
		private var _backgroundAlpha : Float = 1;
		private var _loadedAlpha : Float = 1;
		private var _backgroundNormalColor : Int = 0xCCCCCC;
		private var _loadColor : Int = 0x666666;
		private var _border : Bool = true;
		private var _borderColor : Int = 0x000000;
		private var _textColor : Int = 0x000000;
		private var _textLoadedColor : Int = 0xFFFFFF;
		private var _width : Float = 100;
		private var _height : Float = 15;
		private var _font : Font;
		private var _textFormat : TextFormat;
		private var _textLoadedFormat : TextFormat;
		private var _thinkness : Float = 1;
		private var _outlineColor : Int = 0x000000;
		private var _outlineAlpha : Float = 1;
		private var _displayImage : Bool = false;
		private var _showImage : Bool = true;
		private var _smoothImage : Bool = true;
		private var _bgDisplayNormalImage : Bool = false;
		private var _bgDisplayLoadedImage : Bool = false;
		private var _outline : Shape;
		private var _backgroundNormal : Shape;
		private var _loadedBar : Shape;
		private var _mask : Shape;
		private var _fontMask : Shape;
		private var _backgroundImage : DisplayImage;
		private var _loadedBarImage : DisplayImage;
		private var _label : Label;
		private var _loadedLabel : Label;
		private var _align : String = TextFormatAlign.CENTER;
		private var _showLabel : Bool = true;
		private var _watchingFile : Bool = false;
		private var _urlFile : Dynamic;
		private var _percent : Int = 0;
		private var _filterMode : Bool = true;
	
	private function new(progressBarWidth : Int = 100, progressBarHeight : Int = 15)
    {
        super();
		
		_width = progressBarWidth;
		_height = progressBarHeight;
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		init();
    }
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	private function init() : Void
	{
		// Text Format
		_textFormat = new TextFormat();
		_textLoadedFormat = new TextFormat();
		
		// Setup core fonts
		_font = new Font(); 
		
		// Draw border
		_outline = new Shape();
		
		// Setup up loader shapes
		_backgroundNormal = new Shape();
		_loadedBar = new Shape();
		_mask = new Shape();
		_fontMask = new Shape(); 
		
		// Setup Image holders
		_backgroundImage = new DisplayImage();
		_loadedBarImage = new DisplayImage();
		_backgroundImage.onImageComplete = onBackgroundComplete;
		_loadedBarImage.onImageComplete = onBackgroundLoadedComplete;
		
		// Setup percent text
		_label = new Label();
		_label.width = _width;
		_label.height = _height;
		_label.textColor = _textColor;
		
		_loadedLabel = new Label();
		_loadedLabel.width = _width;
		_loadedLabel.height = _height;
		_loadedLabel.textColor = _textLoadedColor;
		
		// Add to display 
		addChild(_backgroundNormal);
		addChild(_loadedBar);
		addChild(_outline);
		addChild(_mask);
		addChild(_fontMask);
		addChild(_label);
		addChild(_loadedLabel);
		
		reskin();
    }
	
	
	private function initStyle() : Void 
	{
		// Set the style
		if ( -1 != UIStyleManager.PROGRESSBAR_COLOR)
		_backgroundNormalColor = UIStyleManager.PROGRESSBAR_COLOR;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_COLOR_LOADED)
		_loadColor = UIStyleManager.PROGRESSBAR_COLOR_LOADED;
		
		_border = UIStyleManager.PROGRESSBAR_BORDER;
		
		if ( -1 != UIStyleManager.PROGRESSBAR_BORDER_COLOR)
		_borderColor = UIStyleManager.PROGRESSBAR_BORDER_COLOR;
		
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
		_label.size = _loadedLabel.size = UIStyleManager.PROGRESSBAR_TEXT_SIZE;
		
		_label.textFormat.italic = _loadedLabel.textFormat.italic = UIStyleManager.PROGRESSBAR_TEXT_ITALIC;
		
		_label.textFormat.bold = _loadedLabel.textFormat.bold = UIStyleManager.PROGRESSBAR_TEXT_BOLD;
		if ("" != UIStyleManager.PROGRESSBAR_TEXT_FONT)   
		_label.font = _loadedLabel.font = UIStyleManager.PROGRESSBAR_TEXT_FONT;
		
		if ("" != UIStyleManager.PROGRESSBAR_TEXT_ALIGN)     
        _label.align = _loadedLabel.align = UIStyleManager.PROGRESSBAR_TEXT_ALIGN;
		
		if (null != UIStyleManager.PROGRESSBAR_TEXT_EMBED)
		{
			_label.setEmbedFont(UIStyleManager.PROGRESSBAR_TEXT_EMBED);
			_loadedLabel.setEmbedFont(UIStyleManager.PROGRESSBAR_TEXT_EMBED);
        }
    }
	
	private function initBitmap() : Void 
	{
		// UI Skinning
		if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_BACKGROUND))  
		setBackgroundBitmap(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_BACKGROUND));
		
		if (null != UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_LOADED_BACKGROUND))     
        setLoadBarBitmap(UIBitmapManager.getUIElement(ProgressBar.TYPE, UIBitmapManager.PROGRESSBAR_LOADED_BACKGROUND));
    }
	
	/**
	 * @inheritDoc
	 */
	
	override public function reskin() : Void
	{
		super.reskin();
		initBitmap();
		initStyle();
		
		draw();
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
	 * Set the width of the ProgressBar
	 *
	 * @param value Set the width of the ProgressBar
	 *
	 */
	#if flash @:getter(width) #else override #end
	private function set_width(value : Float) : Float 
	{ 
		_width = value;
		draw(); 
		
		return value; 
	}  
	
	/**
	 *
	 * @return Returns the width
	 */
	#if flash @:getter(width) #else override #end
	private function get_width() : Float { return _width; }
	
	
	/**
	 * Set the height of the ProgressBar
	 *
	 * @param value Set the height of the list
	 *
	 */
	#if flash @:getter(width) #else override #end
	private function set_height(value : Float) : Float 
	{
		_height = value; 
		draw(); 
		
		return value; 
	} 
	
	
	/**
	 *
	 * @return Returns the height
	 */
	#if flash @:getter(width) #else override #end
	private function get_height() : Float { return _height; }
		
	
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
	 * The ProgressBar border color that is to
	 */
	
	private function set_borderColor(value : Int) : Int
	{ 
		_outlineColor = value;
		draw();
		
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
		draw();
		
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
		draw();
		
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
		draw(); 
		
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
	 * This is for setting an image to the ProgressBar background.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	public function setBackgroundImage(value : String) : Void { _backgroundImage.load(value); }
		 
	/**
	 * This is for setting an image to the ProgressBar. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setBackgroundBitmap(value : Bitmap) : Void { _backgroundImage.setImage(value); _bgDisplayNormalImage = true; }
	
	
	/**
	 * This is for setting an image to the ProgressBar loaded background.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	public function setLoadBarImage(value : String) : Void { _loadedBarImage.load(value); }
	
	/**
	 * This is for setting an image to the ProgressBar loaded background. It is best to set an image that can be tile.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setLoadBarBitmap(value : Bitmap) : Void { _loadedBarImage.setImage(value); _bgDisplayLoadedImage = true; }
	
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
			_urlFile.addEventListener(ProgressEvent.PROGRESS, progressCheck);_urlFile.addEventListener(Event.COMPLETE, progressComplete);
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
		{
			_align = value;
		}
		else 
		{
			_align = TextFormatAlign.LEFT;
		}
		
		return value;
	} 
	
	/**
	 * Return the alignment that is being used
	 */
	private function get_align() : String { return _align; } 

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
	 * Set the level of detail on the ProgressBar. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 * @see com.chaos.ui.UIDetailLevel
	 */
	
	override private function set_detail(value : String) : String
	{
		// Only turn off filter if medium and low  
		if (value.toLowerCase() == UIDetailLevel.HIGH) 
		{
			super.detail = value.toLowerCase();
			
			_showImage = true;
			_smoothImage = true;
			_filterMode = true;
		}
		else if (value.toLowerCase() == UIDetailLevel.MEDIUM) 
		{
			super.detail = value.toLowerCase();
			
			_showImage = true;
			_smoothImage = false;
			_filterMode = true;
		}
		else if (value.toLowerCase() == UIDetailLevel.LOW) 
		{
			super.detail = value.toLowerCase();
			_showImage = false;
			_smoothImage = false;
			_filterMode = false;
			_filterMode = false;
		}
		else 
		{
			super.detail = UIDetailLevel.LOW;
			_showImage = false;
			_smoothImage = false;
			_filterMode = false;
		}
		
		super.detail = _label.detail = _loadedLabel.detail = value;
		
		draw();
		
		return value;
	}

		/**
		 * Enable or Disable filters
		 */
		
		private function set_filterMode(value : Bool) : Bool { _filterMode = value; return value; }
		 
	
		/**
		 * @private
		 */
		private function get_filterMode() : Bool { return _filterMode; }
		 
		 
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
				((_bgDisplayNormalImage)) ? _backgroundNormal.graphics.beginBitmapFill(_backgroundImage.image.bitmapData, null, true, _smoothImage) : _backgroundNormal.graphics.beginFill(_backgroundNormalColor, _backgroundAlpha);
				((_bgDisplayLoadedImage)) ? _loadedBar.graphics.beginBitmapFill(_loadedBarImage.image.bitmapData, null, true, _smoothImage) : _loadedBar.graphics.beginFill(_loadColor, _loadedAlpha);
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
			
			// NOTE: On 2nd pass place make sure not usign magic numbe and place this in pre set values
			
			// Setup Flitler
			//var loaderFilters : Array<BitmapFilter> = new Array<BitmapFilter>();
			//var loaderBevel : BevelFilter = new BevelFilter(2.0, 45, 0xFFFFFF, 1.0, 0x000000, 1.0, 2, 2, .5, 1, "inner");
			
			//if (_filterMode)
			//loaderFilters.push(loaderBevel);
			
			//_loadedBar.filters = loaderFilters; 
			
			// Set loading text 
			_label.text = _loadedLabel.text = Std.string(_percent);
			
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
	
	private function onBackgroundComplete(event : Event) : Void 
	{
		_bgDisplayNormalImage = true; 
		draw();
	}
	
	private function onBackgroundLoadedComplete(event : Event) : Void 
	{ 
		_bgDisplayLoadedImage = true; 
		draw(); 
	}
	
	private function progressCheck(event : Event) : Void 
	{ 
		_percent = Std.int((event.currentTarget.bytesLoaded / event.currentTarget.bytesTotal) * 100);
		draw();
	}
	
	private function progressComplete(event : Event) : Void
	{
		// NOTE: Might want to stop watching once done 
		draw();
	}
}