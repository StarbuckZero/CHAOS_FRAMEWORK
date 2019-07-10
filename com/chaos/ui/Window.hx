package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IWindow;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.MouseEvent;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;


import com.chaos.ui.event.WindowEvent;

import com.chaos.ui.Label;

import com.chaos.ui.ScrollPolicy;
import openfl.utils.Object;

/**
 * Basic window that can display objects
 *
 * @author Erick Feiling
 * @date 5-24-19
 */

class Window extends BaseUI implements IWindow implements IBaseUI
{
	
	/** The type of UI Element */ 
	public static inline var TYPE : String = "Window";
	
    public var scrollPane(get, never) : IScrollPane;
    
    public var textLabel(get, never) : ILabel;
    public var windowMinWidth(get, set) : Int;
    public var windowMinHeight(get, set) : Int;
    public var resize(get, set) : Bool;
	
    public var closeButton(get, never) : IButton;
    public var minButton(get, never) : IButton;
    public var maxButton(get, never) : IButton;
	
    public var windowTitleColor(get, set) : Int;
    public var windowColor(get, set) : Int;
    public var windowTopRightSize(get, set) : Int;
    public var windowTopMiddleSize(get, set) : Int;
    public var windowTopLeftSize(get, set) : Int;
    public var windowMiddleSize(get, set) : Int;
    public var windowBottomRightSize(get, set) : Int;
    public var windowBottomMiddleSize(get, set) : Int;
    public var windowBottomLeftSize(get, set) : Int;
    public var iconLocation(get, set) : String;
    public var labelLocation(get, set) : String;
    public var buttonLocation(get, set) : String;
	
	public static var WINDOW_DEFAULT_WIDTH : Int = 320;
	public static var WINDOW_DEFAULT_HEIGHT : Int = 320;
	public static var WINDOW_MIN_WIDTH : Int = 100;
	public static var WINDOW_MIN_HEIGHT : Int = 100;
	public static var WINDOW_SQUARE_SIZE : Int = 100;
	public static var WINDOW_BUTTON_SIZE : Int = 15;
	public static var WINDOW_BUTTON_OFFSET_X : Float = 2;
	public static var WINDOW_BUTTON_OFFSET_Y : Float = 2;
	public static var WINDOW_TOP_RIGHT_SIZE : Int = 20;
	public static var WINDOW_TOP_MIDDLE_SIZE : Int = 20;
	public static var WINDOW_TOP_LEFT_SIZE : Int = 20;
	public static var WINDOW_ICON_OFFSET_X : Float = 2;
	public static var WINDOW_ICON_OFFSET_Y : Float = 2;
	public static var WINDOW_MIDDLE_SIZE : Int = 5;
	public static var WINDOW_BUTTON_OFFSET : Int = 2;
	public static var WINDOW_BOTTOM_RIGHT_SIZE : Int = 20;
	public static var WINDOW_BOTTOM_MIDDLE_SIZE : Int = 20;
	public static var WINDOW_BOTTOM_LEFT_SIZE : Int = 20;
	public static var TEXT_OFFSET_X : Int = 0;
	public static var TEXT_OFFSET_Y : Int = 7;
	public static var DEFAULT_CLOSE_BTN_COLOR : Int = 0xFF0000;
	public static var DEFAULT_MAX_BTN_COLOR : Int = 0x00FF00;
	public static var DEFAULT_MIN_BTN_COLOR : Int = 0x00000FF;
	public static var BOTTOM_RIGHT_DRAG_OFFSET : Int = 10;
	
	// Initializes the Sprite that will be used to contain the window pieces  
	
	private var _windowTopLeft : Sprite;
	private var _windowTopMiddle : Sprite;
	private var _windowTopRight : Sprite;
	private var _windowMiddleLeft : Sprite;
	private var _windowMiddleRight : Sprite;
	private var _windowBottomLeft : Sprite;
	private var _windowBottomMiddle : Sprite;
	private var _windowBottomRight : Sprite;
	private var _windowButtonArea : Sprite; 
	
	private var _imageTopPattern : Bitmap = null;
	private var _imageMiddlePattern : Bitmap = null;
	private var _imageBottomPattern : Bitmap = null;  
	
	// Texture Layer 
	private var _windowTopLeftTexture : Shape;
	private var _windowTopMiddleTexture : Shape;
	private var _windowTopRightTexture : Shape;
	
	private var _windowMiddleLeftTexture : Shape;
	private var _windowMiddleRightTexture : Shape;
	
	private var _windowBottomLeftTexture : Shape;
	private var _windowBottomMiddleTexture : Shape;
	private var _windowBottomRightTexture : Shape;
	
	private var _closeButton : Button;
	private var _minButton : Button;
	private var _maxButton : Button;
	
	private var _windowTopLeftImage : BitmapData;
	private var _windowTopMiddleImage : BitmapData;
	private var _windowTopRightImage : BitmapData;
	
	private var _windowMiddleLeftImage : BitmapData;
	private var _windowMiddleRightImage : BitmapData;
	
	private var _windowBottomLeftImage : BitmapData;
	private var _windowBottomMiddleImage : BitmapData;
	private var _windowBottomRightImage : BitmapData;
	
	private var _windowTopLeftUnFocusImage : BitmapData;
	private var _windowTopMiddleUnFocusImage : BitmapData;
	private var _windowTopRightUnFocusImage : BitmapData;
	
	private var _windowMiddleLeftUnFocusImage : BitmapData;
	private var _windowMiddleRightUnFocusImage : BitmapData;
	
	private var _windowBottomLeftUnFocusImage : BitmapData;
	private var _windowBottomMiddleUnFocusImage : BitmapData;
	private var _windowBottomRightUnFocusImage : BitmapData;
	
	private var _iconDisplay : Shape;
	private var _iconLocation : String = "right";
	private var _buttonLocation : String = "left";
	private var _labelLocation : String = "center";
	
	
	private var _smoothImage : Bool = true;
	private var _showImage : Bool = true;
	private var _resizeName : String = ""; 
	
	// This is to keep track of what was clicked on mouse down 
	private var _resizeWindow : Bool = false;
	private var _mouseDown : Bool = false;
	
	private var _bgShowImage : Bool = true;
	private var _enableResize : Bool = true;
	private var _contentMask : Sprite;
	
	private var _scrollPane : IScrollPane;
	private var _windowTitle : Label;
	private var _eventDispatcher : EventDispatcher;
	
	// Initializes the vars that are used to constrain the window to a certain minimum width and height  
	private var _windowWidth : Float;
	private var _windowHeight : Float;
	
	private var _windowMinWidth : Int = WINDOW_MIN_WIDTH;
	private var _windowMinHeight : Int = WINDOW_MIN_HEIGHT;
	
	private var _windowTitleColor : Int = 0xFFFFFF;
	private var _windowColor : Int = 0xFFFFFF;
	
	
	// Default size for window
	private var _windowTopRightSize : Int = WINDOW_TOP_RIGHT_SIZE;
	private var _windowTopMiddleSize : Int = WINDOW_TOP_MIDDLE_SIZE;
	private var _windowTopLeftSize : Int = WINDOW_TOP_LEFT_SIZE;
	private var _windowMiddleSize : Int = WINDOW_MIDDLE_SIZE;
	private var _windowBottomRightSize : Int = WINDOW_BOTTOM_RIGHT_SIZE;
	private var _windowBottomMiddleSize : Int = WINDOW_BOTTOM_MIDDLE_SIZE;
	private var _windowBottomLeftSize : Int = WINDOW_BOTTOM_LEFT_SIZE; 
	
	private var _labelData:Dynamic = null;
	private var _scrollPanelData:Dynamic = null;
	
	// Constructor.  Also assigns the window main variable and loads in the window's content  
	public function new(data:Dynamic = null)
    {
		// winWidth : Int = 320, winHeight : Int = 320
        super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "windowColor"))
			_windowColor = Reflect.field(data, "windowColor");
			
		if (Reflect.hasField(data, "windowTitleColor"))
			_windowTitleColor = Reflect.field(data, "windowTitleColor");
			
		if (Reflect.hasField(data, "labelLocation"))
			_labelLocation = Reflect.field(data, "labelLocation");
			
		if (Reflect.hasField(data, "buttonLocation"))
			_buttonLocation = Reflect.field(data, "buttonLocation");
			
		if (Reflect.hasField(data, "iconLocation"))
			_iconLocation = Reflect.field(data, "iconLocation");
			
			
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
		
		if (Reflect.hasField(data, "ScrollPanel"))
			_scrollPanelData = Reflect.field(data, "ScrollPanel");
	}
	
	private function onStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(TYPE, this);
    }
	
	private function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
    }
	
	override public function initialize():Void 
	{
		// Send instance of self to the Event Dispatcher 
		_eventDispatcher = new EventDispatcher();
		
		// Setup scroll pane
		_scrollPane = new ScrollPane({"name":"windowScrollPane", "mode":ScrollPolicy.AUTO});
		
		// Window Display Icon
		_iconDisplay = new Shape();
		
		// Sets the window title textformat reference
		_windowTitle = new Label();
		
		// Init sprites/clips for window 
		_windowTopLeft = new Sprite();
		_windowTopMiddle = new Sprite();
		_windowTopRight = new Sprite();
		
		_windowMiddleLeft = new Sprite();
		_windowMiddleRight = new Sprite();
		
		_windowBottomLeft = new Sprite();
		_windowBottomMiddle = new Sprite();
		_windowBottomRight = new Sprite();
		
		_windowButtonArea = new Sprite();
		
		_windowTopLeftTexture = new Shape();
		_windowTopMiddleTexture = new Shape();
		_windowTopRightTexture = new Shape();
		
		_windowMiddleLeftTexture = new Shape();
		_windowMiddleRightTexture = new Shape();
		_windowBottomLeftTexture = new Shape();
		
		_windowBottomMiddleTexture = new Shape();
		_windowBottomRightTexture = new Shape(); 
		
		// Setup window buttons
		_closeButton = new Button({"name":WindowEvent.WINDOW_CLOSE_BTN, "showLabel":false, "defaultColor":DEFAULT_CLOSE_BTN_COLOR});
		_minButton = new Button({"name":WindowEvent.WINDOW_MIN_BTN, "showLabel":false, "defaultColor":DEFAULT_MAX_BTN_COLOR});
		_maxButton = new Button({"name":WindowEvent.WINDOW_MAX_BTN, "showLabel":false, "defaultColor":DEFAULT_MIN_BTN_COLOR});
		
		super.initialize();
		
		
		//_scrollPane.name = "windowScrollPane";
		//_scrollPane.mode = ScrollPolicy.AUTO;
		
		_iconDisplay.name = "windowIcon";  
		
		_windowTitle.textField.multiline = false;
		_windowTitle.textField.wordWrap = false;  
		
		_windowTopLeft.name = "windowTopLeft";
		_windowTopMiddle.name = "windowTopMiddle";
		_windowTopRight.name = "windowTopRight";
		
		_windowMiddleLeft.name = "windowMiddleLeft";
		_windowMiddleRight.name = "windowMiddleRight";
		
		
		_windowBottomLeft.name = "windowBottomLeft";
		_windowBottomMiddle.name = "windowBottomMiddle";
		_windowBottomRight.name = "windowBottomRight";
		
		
		_windowButtonArea.name = "windowButtonArea";
		
		//_closeButton.name = WindowEvent.WINDOW_CLOSE_BTN;
		//_minButton.name = WindowEvent.WINDOW_MIN_BTN;
		//_maxButton.name = WindowEvent.WINDOW_MAX_BTN;
		
		//_closeButton.defaultColor = DEFAULT_CLOSE_BTN_COLOR;
		//_maxButton.defaultColor = DEFAULT_MAX_BTN_COLOR;
		//_minButton.defaultColor = DEFAULT_MIN_BTN_COLOR;
		
		//_closeButton.text = "";
		//_maxButton.text = "";
		//_minButton.text = "";
		
		_closeButton.addEventListener(MouseEvent.CLICK, windowCloseButton, false, 0, true);
		_maxButton.addEventListener(MouseEvent.CLICK, windowMaxButton, false, 0, true);
		_minButton.addEventListener(MouseEvent.CLICK, windowMinButton, false, 0, true);  
		
		// Resize event 
		//_windowMiddleRight.addEventListener( MouseEvent.MOUSE_MOVE, windowEventResize ); 
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		_windowMiddleRight.name = "windowMiddleRight";
		
		//_windowBottomMiddle.addEventListener( MouseEvent.MOUSE_MOVE, windowEventResize );
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		_windowBottomMiddle.name = "windowBottomMiddle";  
		
		//_windowBottomRight.addEventListener( MouseEvent.MOUSE_MOVE, windowEventResize );
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		_windowBottomRight.name = "windowBottomRight";  
		
		// Add items into display
		addChild(_windowTopLeft);
		addChild(_windowTopMiddle);
		addChild(_windowTopRight);
		addChild(_windowMiddleLeft);
		addChild(_windowMiddleRight);
		addChild(_windowBottomLeft);
		addChild(_windowBottomMiddle);
		addChild(_windowBottomRight);
		addChild(_windowMiddleLeftTexture);
		addChild(_windowMiddleRightTexture);
		addChild(_scrollPane.displayObject);
		addChild(_windowTopLeftTexture);
		addChild(_windowTopMiddleTexture);
		addChild(_windowTopRightTexture);
		addChild(_windowBottomLeftTexture);
		addChild(_windowBottomMiddleTexture);
		addChild(_windowBottomRightTexture);
		
		
		addChild(_windowTitle);
		addChild(_windowButtonArea);
		addChild(_iconDisplay);
		
		// Add buttons to button area 
		_windowButtonArea.addChild(_closeButton);
		_windowButtonArea.addChild(_maxButton);
		_windowButtonArea.addChild(_minButton);
		
		_windowTitle.addEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		_windowTitle.addEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopLeft.addEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopLeft.addEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopRight.addEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopRight.addEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopMiddle.addEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopMiddle.addEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		
		addEventListener(Event.ADDED_TO_STAGE, windowStageInit);
		
	}
	

	private function initSkin() : Void 
	{  
		// Background  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BACKGROUND))   
			_scrollPane.setBackgroundImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BACKGROUND));
		
		// Top  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_LEFT)) 
			setWindowTopLeftImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_MIDDLE)) 
			setWindowTopMiddleImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_MIDDLE));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_RIGHT))
			setWindowTopRightImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_RIGHT));
			
		// Middle  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_LEFT))  
			setWindowMiddleLeftImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_RIGHT)) 
			setWindowMiddleRightImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_RIGHT));
		
		// Bottom  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_LEFT)) 
			setWindowBottomLeftImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_LEFT));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_MIDDLE))    
			setWindowBottomMiddleImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_MIDDLE));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_RIGHT))       
			setWindowBottomRightImage(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_RIGHT));
		
		// Min Button  
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_NORMAL))   
		//	setMinButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_NORMAL));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_OVER))  
		//	setMinOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_OVER));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DOWN))       
		//	setMinDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DOWN));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DISABLE))   
		//	setMinDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DISABLE));
		
		// Max Button  
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_NORMAL))       
		//	setMaxButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_NORMAL));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_OVER))   
		//	setMaxOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_OVER));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DOWN)) 
		//	setMaxDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DOWN));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DISABLE)) 
		//	setMaxDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DISABLE));
		
		// Close Button  
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_NORMAL))   
		//	setCloseButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_NORMAL));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_OVER))    
		//	setCloseOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_OVER));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DOWN))      
		//	setCloseDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DOWN));
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DISABLE))     
		//	setCloseDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DISABLE));
		
    }
	
	private function initStyle() : Void 
	{ 
		if ( -1 != UIStyleManager.WINDOW_BACKGROUND_COLOR) 
		_scrollPane.backgroundColor = UIStyleManager.WINDOW_BACKGROUND_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_BORDER_ALPHA)   
		_scrollPane.borderAlpha = UIStyleManager.WINDOW_BORDER_ALPHA;
		
		if ( -1 != UIStyleManager.WINDOW_BORDER_COLOR)   
		_scrollPane.borderColor = UIStyleManager.WINDOW_BORDER_COLOR;
		
		_scrollPane.border = UIStyleManager.WINDOW_BORDER;
		
		if ("" != UIStyleManager.WINDOW_ICON_LOCATION)       
		iconLocation = UIStyleManager.WINDOW_ICON_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_BUTTON_LOCATION)    
		buttonLocation = UIStyleManager.WINDOW_BUTTON_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_LABEL_LOCATION) 
		labelLocation = UIStyleManager.WINDOW_LABEL_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_TITLE_TEXT_FONT)      
		_windowTitle.font = UIStyleManager.WINDOW_TITLE_TEXT_FONT;
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_SIZE)    
		_windowTitle.size = UIStyleManager.WINDOW_TITLE_TEXT_SIZE;
		
		if (null != UIStyleManager.WINDOW_TITLE_TEXT_EMBED)       
		_windowTitle.setEmbedFont(UIStyleManager.WINDOW_TITLE_TEXT_EMBED);
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_COLOR)     
        _windowTitle.textColor = UIStyleManager.WINDOW_TITLE_TEXT_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_AREA_COLOR)   
		_windowTitleColor = UIStyleManager.WINDOW_TITLE_AREA_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_FOCUS_COLOR)  
		_windowColor = UIStyleManager.WINDOW_FOCUS_COLOR;
		
		
		// Min Button
		if ( -1 != UIStyleManager.WINDOW_MIN_NORMAL_COLOR)
		_minButton.defaultColor = UIStyleManager.WINDOW_MIN_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_OVER_COLOR)      
		_minButton.overColor = UIStyleManager.WINDOW_MIN_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DOWN_COLOR)   
		_minButton.downColor = UIStyleManager.WINDOW_MIN_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DISABLE_COLOR)  
		_minButton.disableColor = UIStyleManager.WINDOW_MIN_DISABLE_COLOR;
		
		// Max Button  
		if ( -1 != UIStyleManager.WINDOW_MAX_NORMAL_COLOR)    
		_maxButton.defaultColor = UIStyleManager.WINDOW_MAX_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_OVER_COLOR)  
		_maxButton.overColor = UIStyleManager.WINDOW_MAX_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DOWN_COLOR)        
		_maxButton.downColor = UIStyleManager.WINDOW_MAX_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DISABLE_COLOR)         
		_maxButton.disableColor = UIStyleManager.WINDOW_MAX_DISABLE_COLOR;
		
		// Close Button  
		if ( -1 != UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR)  
		_closeButton.defaultColor = UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_OVER_COLOR)   
		_closeButton.overColor = UIStyleManager.WINDOW_CLOSE_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DOWN_COLOR)     
        _closeButton.downColor = UIStyleManager.WINDOW_CLOSE_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR)      
		_closeButton.disableColor = UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR;
    }
	
	/* Properties */  
	
	/**
	 * The scroll pane being used
	 */  
	
	private function get_scrollPane() : IScrollPane 
	{
		return _scrollPane;
	}
	
	/**
	 * Return the text label being used
	 */
	private function get_textLabel() : ILabel 
	{
		return _windowTitle;
    }
	 
	/**
	 * Set the minimize width of the of the Window over all size
	 */
	
	private function set_windowMinWidth(value : Int) : Int 
	{
		_windowMinWidth = value;
		draw();
		
        return value;
    }
	
	/**
	 * Returns the minimize width the window can be set to
	 */
	
	private function get_windowMinWidth() : Int 
	{
		return _windowMinWidth;
    }
	
	/**
	 * Set the minimize height of the of the Window over all size
	 */
	
	private function set_windowMinHeight(value : Int) : Int 
	{
		_windowMinHeight = value;
		draw();
		
        return value;
    }
	
	/**
	 * Returns the minimize height the window can be set to
	 */  
	private function get_windowMinHeight() : Int 
	{
		return _windowMinHeight;
    } 
	
	/**
	 * Set if the window is resizable or not.
	 */
	private function set_resize(value : Bool) : Bool
	{
		_enableResize = value;
        return value;
    }
	
	/**
	 * Return if the window is resizable or not
	 */
	private function get_resize() : Bool
	{
		return _enableResize;
    }
	
	private function get_closeButton():IButton
	{
		return _closeButton;
	}
	
	private function get_minButton():IButton
	{
		return _minButton;
	}
	
	private function get_maxButton():IButton
	{
		return _maxButton;
	}
	
	
	/**
	 * Set the color of the window title area once the user select
	 */
	private function set_windowTitleColor(value : Int) : Int 
	{
		_windowTitleColor = value;
		draw();
		
        return value;
	}
	
	/**
	 * Return the color of the window
	 */  
	
	private function get_windowTitleColor() : Int
	{
		return _windowTitleColor;
    }
	

	
	/**
	 * Set the color of the window which is
	 */  
	
	private function set_windowColor(value : Int) : Int 
	{
		_windowColor = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return the color of the window
	 */
	
	private function get_windowColor() : Int
	{
		return _windowColor;
    }
	

	
	/**
	 * Set the size of the top right area of the window.
	 */
	
	private function set_windowTopRightSize(value : Int) : Int
	{
		_windowTopRightSize = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return the window top right size.
	 */  
	
	private function get_windowTopRightSize() : Int 
	{
		return _windowTopRightSize;
    }
	
	/**
	 * Set the top center block on the window.
	 */  
	
	private function set_windowTopMiddleSize(value : Int) : Int
	{
		_windowTopMiddleSize = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return the window top right size.
	 */
	
	private function get_windowTopMiddleSize() : Int 
	{
		return _windowTopMiddleSize;
    }
	
	/**
	 * Set the size of the top left area of the window
	 */ 
	
	private function set_windowTopLeftSize(value : Int) : Int 
	{
		_windowTopLeftSize = value;draw();
        return value;
    }
	
	/**
	 * Return the window top left size.
	 */ 
	
	private function get_windowTopLeftSize() : Int 
	{
		return _windowTopLeftSize;
    }
	
	/**
	 * Set the center block on the left and right side of the window
	 */ 
	private function set_windowMiddleSize(value : Int) : Int
	{
		_windowMiddleSize = value;
		draw();
		
        return value;
    } 
	
	/**
	 * Return the window middle block size. This is the size for both the left and right side of the window.
	 */ 
	
	private function get_windowMiddleSize() : Int
	{
		return _windowMiddleSize;
    }
	
	/**
	 * Set the size of the bottom right area of the window
	 */
	
	private function set_windowBottomRightSize(value : Int) : Int 
	{
		_windowBottomRightSize = value;
		draw();
		
        return value;
    }  
	
	/**
	 * Return the window bottom right size.
	 */
	
	private function get_windowBottomRightSize() : Int 
	{
		return _windowBottomRightSize;
    }  
	
	/**
	 * Set the size of the bottom middle area of the window
	 */ 
	
	private function set_windowBottomMiddleSize(value : Int) : Int 
	{
		_windowBottomMiddleSize = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return the window bottom middle size
	 */  
	private function get_windowBottomMiddleSize() : Int
	{
		return _windowBottomMiddleSize;
    }  
	
	/**
	 * Set the size of the bottom left area of the window
	 */  
	private function set_windowBottomLeftSize(value : Int) : Int 
	{
		_windowBottomLeftSize = value;
		draw();
		
        return value;
    } 
	
	/**
	 * Return the window bottom middle size.
	 */  
	private function get_windowBottomLeftSize() : Int
	{
		return _windowBottomLeftSize;
    }
	
	/**
	 * Set where the window icon will be placed. The icon can only be placed on the left or right side. If there are buttons on the side selected they'll be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side.
	 */
	
	private function set_iconLocation(value : String) : String 
	{  
		// Check to see where to put the window icon  
		if (value.toLowerCase() == "left" || value.toLowerCase() == "right") 
		{
			_iconLocation = value;
			_buttonLocation = (value.toLowerCase() == "left") ? "right" : "left";
        }
        else 
		{
			_iconLocation = "left";
			_buttonLocation = "right";
        }
		
		draw();
        return value;
    }
	
	/**
	 * Return where the icon is or will be placed on the window
	 */
	
	private function get_iconLocation() : String 
	{
		return _iconLocation;
    }
	
	/**
	 * Set where to place the label on the window. The default is center but can be placed left or right as well.
	 */ 
	private function set_labelLocation(value : String) : String 
	{
		_labelLocation = value;
		draw();
		
        return value;
    }
	
	/**
	 * Return where the label is being placed
	 */
	private function get_labelLocation() : String 
	{
		return _labelLocation;
    } 
	
	/**
	 * Set where the buttons will be placed. The button(s) can only be placed on the left or right side. If there is a icon on the side selected it will be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side. Can only passed "left" or "right" as a value.
	 */  
	private function set_buttonLocation(value : String) : String
	{  
		// Check to see where to put the buttons  
		if (value.toLowerCase() == "left" || value.toLowerCase() == "right") 
		{
			_buttonLocation = value; 
			_iconLocation = ((value.toLowerCase() == "left")) ? "right" : "left";
        }
        else 
		{
			_buttonLocation = "left";
			_iconLocation = "right";
        }
		
		draw();
        return value;
    }
	
	/**
	 * Return where the button(s) are or will be placed on the window
	 */
	private function get_buttonLocation() : String
	{
		return _buttonLocation;
    } 
	

	/**
	 * Set the window icon by using an image based on a URL
	 *
	 * @param value The bitmap you want to use for the icon
	 *
	 * @example myWindow.setIconBitmap("myIcon", "left");
	 *
	 */ 
	
	public function setIcon(image : BitmapData, location : String = "left") : Void 
	{ 
		// Set location
		iconLocation = location;
		
		_iconDisplay.graphics.clear();
		
		if (image != null)
		{
			_iconDisplay.graphics.beginBitmapFill(image, null, false, _smoothImage);
			_iconDisplay.graphics.drawRect(0, 0, image.width, image.height);
			_iconDisplay.graphics.endFill();
		}
		
		draw();
		
    }
	
	/* Setup and draw window on stage */ 
	override public function draw() : Void 
	{ 
		super.draw();  
		
		// Drawing basic squares  
		drawSquareIn(_windowTopLeft, _windowTitleColor, _windowTopLeftSize, (_windowTopLeftImage != null)  );
		drawSquareIn(_windowTopMiddle, _windowTitleColor, _windowTopMiddleSize, (_windowTopMiddleImage != null) );
		drawSquareIn(_windowTopRight, _windowTitleColor, _windowTopRightSize, (_windowTopRightImage != null) );
		drawSquareIn(_windowMiddleLeft, _windowColor, _windowMiddleSize, (_windowMiddleLeftImage != null) );
		drawSquareIn(_windowMiddleRight, _windowColor, _windowMiddleSize, (_windowMiddleRightImage != null) );
		drawSquareIn(_windowBottomLeft, _windowColor, _windowBottomLeftSize, (_windowBottomLeftImage != null) );
		drawSquareIn(_windowBottomMiddle, _windowColor, _windowBottomMiddleSize, (_windowBottomMiddleImage != null) );
		drawSquareIn(_windowBottomRight, _windowColor, _windowBottomRightSize, (_windowBottomRightImage != null) );
		
		// Line up square 
		setWindowSize(Std.int(_width), Std.int(_height), _windowMinWidth, _windowMinHeight);
		
		applyWindowImage();
    } 
	

	/**
	 * Set if the ScrollPane is enabled
	 *
	 * @param value Set to true if you want the ScrollPane to be enabled and false if not
	 */
	
	override function set_enabled(value : Bool) : Bool
	{
		_maxButton.enabled = _minButton.enabled = _closeButton.enabled = _scrollPane.enabled = value;
        return value;
    }
	
	/**
	 * @inheritDoc
	 */
	override public function reskin() : Void 
	{
		super.reskin();
		
		initSkin();
		initStyle();
    }
	

	
	/**
	 * This set an image to the upper top left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	
	public function setWindowTopLeftImage(value : BitmapData) : Void 
	{
		_windowTopLeftImage = value;
		draw();
    }
	
	/**
	 * This set an image to the middle of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */ 
	public function setWindowTopMiddleImage(value : BitmapData) : Void 
	{
		_windowTopMiddleImage = value;
		draw();
    }
	
	/**
	 * This set an image to the upper top right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */
	public function setWindowTopRightImage(value : BitmapData) : Void
	{
		_windowTopRightImage = value;
		draw();
    } 

	
	/**
	 * This set an image to the right side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 *
	 */
	
	public function setWindowMiddleRightImage(value : BitmapData) : Void
	{
		_windowMiddleRightImage = value;
		draw();
    }
	
	/**
	 * This set an image to the left side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */  
	public function setWindowMiddleLeftImage(value : BitmapData) : Void
	{
		_windowMiddleLeftImage = value;
		draw();
    }
	
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	
	public function setWindowBottomLeftImage(value : BitmapData) : Void 
	{
		_windowBottomLeftImage = value;
		draw();
    }
	
	/**
	 * This set an image to the bottom mid area of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	public function setWindowBottomMiddleImage(value : BitmapData) : Void 
	{
		_windowBottomMiddleImage = value;
		draw();
    }
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */ 
	public function setWindowBottomRightImage(value : BitmapData) : Void 
	{
		_windowBottomRightImage = value;
		draw();
    }
	
	private function addDrag() : Void
	{
		startDrag();
    }
	
	private function removeDrag() : Void 
	{
		stopDrag();
    } 
	
	/* Scales and sizes the window
	 *
	 * @param inWidth The width of the window
	 * @param inHeight The height of the window
	 *
	 * @param minWidth The smallest the user can resize the window to when it comes to the width
	 * @param minHeight The smallest the user can resize the window to when it comes to the height
	 *
	 * @example myWindow.setWindowSize(myWidth, myHeight);
	 *
	 */  
	
	public function setWindowSize(inWidth : Int, inHeight : Int, minWidth : Int = 0, minHeight : Int = 0) : Void
	{
		var buttonCount : Int = 0;
		
		// Check to see the new widnow width and height lowest point  
		if (minWidth > WINDOW_MIN_WIDTH)        
		_windowMinWidth = minWidth; 
		
		if (_windowMinHeight > WINDOW_MIN_WIDTH)     
		_windowMinHeight = minHeight;
		
		// Resize Button  
		_closeButton.width = WINDOW_BUTTON_SIZE;
		_closeButton.height = WINDOW_BUTTON_SIZE;
		_minButton.width = WINDOW_BUTTON_SIZE;
		_minButton.height = WINDOW_BUTTON_SIZE;
		_maxButton.width = WINDOW_BUTTON_SIZE;
		_maxButton.height = WINDOW_BUTTON_SIZE;
		
		_windowWidth = inWidth;
		_windowHeight = inHeight; 

		
		// Update button count 
		if (_closeButton.visible)   
			buttonCount++;
		
		if (_minButton.visible)     
			buttonCount++;
		
		if (_maxButton.visible)  
			buttonCount++;
		
		_windowTopLeftTexture.x = _windowTopLeft.x = 0;
		
		if (_scrollPane.x == 0 && _scrollPane.y == 0) 
		{
			var temp1X : Float = _windowTopLeft.x + _windowTopLeft.width;
			
			if (_windowMiddleLeft.x + _windowMiddleLeft.width < temp1X)                 
			temp1X = _windowMiddleLeft.x + _windowMiddleLeft.width;
			
			if (_windowBottomLeft.x + _windowBottomLeft.width < temp1X)   
			temp1X = _windowBottomLeft.x + _windowBottomLeft.width;
			
			_scrollPane.x = temp1X;
			_scrollPane.y = _windowTopLeft.height;
		}
        
		
		if (_scrollPane.x == 0 && _scrollPane.y == 0) 
		{
			var temp2X : Float = _windowTopLeft.x + _windowTopLeft.width;
			
			if (_windowMiddleLeft.x + _windowMiddleLeft.width < temp2X)         
			temp2X = _windowMiddleLeft.x + _windowMiddleLeft.width;
			
			if (_windowBottomLeft.x + _windowBottomLeft.width < temp2X) 
			temp2X = _windowBottomLeft.x + _windowBottomLeft.width;
        }
		
		if (inWidth > _windowMinWidth) 
			_windowTopRightTexture.x = _windowTopRight.x = inWidth - _windowTopRight.width;
        else 
			_windowTopRightTexture.x = _windowTopRight.x = _windowMinWidth - _windowTopRight.width;
		
		_windowTopRightTexture.y = _windowTopRight.y = _windowTopLeft.y;
		
		_windowTopMiddleTexture.x = _windowTopMiddle.x = _windowTopLeft.x + _windowTopLeft.width;
		_windowTopMiddleTexture.y = _windowTopMiddle.y = _windowTopLeft.y;
		_windowTopMiddle.width = _windowTopRight.x - _windowTopLeft.width;
		
		_windowTitle.height = _windowTopMiddle.height;
		_windowTitle.width = _windowTopMiddle.width - _windowTitle.x;
		_windowTitle.textField.selectable = false;
		
		_windowBottomLeftTexture.x = _windowBottomLeft.x = _windowTopLeft.x;
		
		if (inHeight > _windowMinHeight) 
			_windowBottomLeftTexture.y = _windowBottomLeft.y = inHeight - _windowBottomLeft.height;
        else 
			_windowBottomLeftTexture.y = _windowBottomLeft.y = _windowMinHeight - _windowBottomLeft.height;
		
		if (inWidth > _windowMinWidth) 
			_windowBottomRightTexture.x = _windowBottomRight.x = inWidth - _windowBottomRight.width;
        else 
			_windowBottomRightTexture.x = _windowBottomRight.x = _windowMinWidth - _windowBottomRight.width;
		
		if (inHeight > _windowMinHeight) 
			_windowBottomRightTexture.y = _windowBottomRight.y = inHeight - _windowBottomRight.height;
        else
			_windowBottomRightTexture.y = _windowBottomRight.y = _windowMinHeight - _windowBottomRight.height;
		
		_windowBottomMiddleTexture.x = _windowBottomMiddle.x = _windowBottomLeft.x + _windowBottomLeft.width;
		
		if (inHeight > _windowMinHeight) 
			_windowBottomMiddleTexture.y = _windowBottomMiddle.y = inHeight - _windowBottomMiddle.height;
        else 
			_windowBottomMiddleTexture.y = _windowBottomMiddle.y = _windowMinHeight - _windowBottomMiddle.height;
		
		_windowBottomMiddle.width = _windowBottomRight.x - _windowBottomLeft.width;
		_windowMiddleLeftTexture.x = _windowMiddleLeft.x = _windowTopLeft.x;
		_windowMiddleLeftTexture.y = _windowMiddleLeft.y = _windowTopLeft.y + _windowTopLeft.height;
		_windowMiddleLeft.height = _windowBottomLeft.y - _windowTopLeft.height;
		
		if (inWidth > _windowMinWidth) 
		{
			_windowMiddleRightTexture.x = _windowMiddleRight.x = inWidth - _windowMiddleRight.width;
		}
        else 
		{
			_windowMiddleRightTexture.x = _windowMiddleRight.x = _windowMinWidth - _windowMiddleRight.width;
        }
		
		_windowMiddleRightTexture.y = _windowMiddleRight.y = _windowTopRight.y + _windowTopRight.height;
		_windowMiddleRight.height = _windowBottomRight.y - _windowTopRight.height;
		
		// Set Icon location  
		if (_iconLocation.toLowerCase() == "right") 
		{
			_iconDisplay.x = _windowTopRight.x + WINDOW_ICON_OFFSET_X;
			_iconDisplay.y = WINDOW_ICON_OFFSET_Y;
        }
        else 
		{
			_iconDisplay.x = WINDOW_ICON_OFFSET_X;
			_iconDisplay.y = WINDOW_ICON_OFFSET_Y;
        }  
		
		// Button Location  
		if (_buttonLocation.toLowerCase() == "right") 
		{
			_windowButtonArea.x = _windowTopRight.x + WINDOW_BUTTON_OFFSET_X;
			_windowButtonArea.y = WINDOW_BUTTON_OFFSET_Y; _closeButton.x = 0;
			
			_minButton.x = 0;
			_maxButton.x = 0;
			_maxButton.x = _closeButton.x - WINDOW_BUTTON_SIZE - WINDOW_BUTTON_OFFSET;
			_minButton.x = _maxButton.x - WINDOW_BUTTON_SIZE - WINDOW_BUTTON_OFFSET;
			_maxButton.x = ((_maxButton.visible)) ? (buttonCount - 2) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
			_minButton.x = ((_minButton.visible)) ? (buttonCount - 1) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
        }
        else 
		{
			_windowButtonArea.x = WINDOW_BUTTON_OFFSET_X;
			_windowButtonArea.y = WINDOW_BUTTON_OFFSET_Y;
			
			_closeButton.x = 0;
			_minButton.x = 0;
			_maxButton.x = 0;
			
			_minButton.x = ((_minButton.visible)) ? (buttonCount - 2) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
			_maxButton.x = ((_maxButton.visible)) ? (buttonCount - 1) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
        } 
		
		// Adjust the Title area based on  
		if ("left" == _labelLocation) 
		{  
			//_windowTitle.align = "left"; 
			if (_buttonLocation == "left") 
				_windowTitle.x = _windowButtonArea.x + TEXT_OFFSET_X;
            else if (_iconLocation == "left") 
				_windowTitle.x = _iconDisplay.x + TEXT_OFFSET_X;
				
        }
        else if ("right" == _labelLocation) 
		{
			//_windowTitle.align = "right"
			if (_buttonLocation == "right") 
				_windowTitle.x = _windowButtonArea.width - TEXT_OFFSET_X;
            else if (_iconLocation == "right")
				_windowTitle.x = _iconDisplay.width - TEXT_OFFSET_X;
        }
        else 
		{
			_windowTitle.x = Std.int(_windowTopMiddle.width / 2) - TEXT_OFFSET_X;
        }
		
		_windowTitle.y = Std.int((_windowTopMiddle.height / 2) - TEXT_OFFSET_Y); 
		
		
		// Resise scroll pane
		sizeInsideWindow(_scrollPane);
		dispatchEvent(new Event(WindowEvent.WINDOW_RESIZE));
    }
	
	/*
	 * Returns the size of the window's interior width and height
	 *
	 * @return An object with the width and height
	 */ 
	public function getInsideWindowSize() : Object 
	{  
		var returnObj : Object = new Object();
		var widthVal : Float = _windowTopRight.x - _scrollPane.x;

		if (_windowMiddleRight.x - _scrollPane.x > widthVal) 
			widthVal = _windowMiddleRight.x - _scrollPane.x;


		if (_windowBottomRight.x - _scrollPane.x > widthVal) 
			widthVal = _windowBottomRight.x - _scrollPane.x;

		returnObj.width = widthVal;

		var heightVal : Float = _windowBottomLeft.y - _scrollPane.y;
		
		if (_windowBottomMiddle.y - _scrollPane.y > heightVal) 
			heightVal = _windowBottomMiddle.y - _scrollPane.y;
		
		if (_windowBottomRight.y - _scrollPane.y > heightVal) 
			heightVal = _windowBottomRight.y - _scrollPane.y;
		
		returnObj.height = heightVal;
		
		return returnObj;
	} 

	
	// Resizes a passed in movie clip to the size of the window's interior 
	private function sizeInsideWindow(inMovie : IBaseUI, inAxis : String = "scaleAll") : Void 
	{ 
		if (inAxis == "scaleX" || inAxis == "scaleAll") 
		{
			var xVal : Int = Std.int(_windowTopLeft.x + _windowTopLeft.width);
			
			if (_windowMiddleLeft.x + _windowMiddleLeft.width < xVal) 
				xVal = Std.int(_windowMiddleLeft.x + _windowMiddleLeft.width);
			
			if (_windowBottomLeft.x + _windowBottomLeft.width < xVal) 
				xVal = Std.int(_windowBottomLeft.x + _windowBottomLeft.width);
			
			inMovie.x = xVal;
			
			var widthVal : Int = Std.int(_windowTopRight.x - inMovie.x);
			
			if (_windowMiddleRight.x - inMovie.x > widthVal) 
				widthVal = Std.int(_windowMiddleRight.x - inMovie.x);
			
			if (_windowBottomRight.x - inMovie.x > widthVal) 
				widthVal = Std.int(_windowBottomRight.x - inMovie.x);
			
			inMovie.width = widthVal;
			
        }
		
		if (inAxis == "scaleY" || inAxis == "scaleAll") 
		{
			var yVal : Int = Std.int(_windowTopLeft.y + _windowTopLeft.height);
			
			if (_windowTopMiddle.y + _windowTopMiddle.height < yVal) 
				yVal = Std.int(_windowTopMiddle.y + _windowTopMiddle.height);
				
			if (_windowTopRight.y + _windowTopRight.height < yVal) 
				yVal = Std.int(_windowTopRight.y + _windowTopRight.height);
			
			inMovie.y = yVal;
			
			var heightVal : Int = Std.int(_windowBottomLeft.y - inMovie.y);
			
			if (_windowBottomMiddle.y - inMovie.y > heightVal) 
				heightVal = Std.int(_windowBottomMiddle.y - inMovie.y);
			
			if (_windowBottomRight.y - inMovie.y > heightVal) 
				heightVal = Std.int(_windowBottomRight.y - inMovie.y);
			
			inMovie.height = heightVal;
		}
    }
	
	// End sizeInsideWindow 
	
	// Draws a 20x20 colored squared inside of a Sprite  
	// This is usually used for new movie clips that will later be resized such as the background color.
	private function drawSquareIn(inMovie : Sprite, inColor : Int, squareSize : Int = 0, hasImage : Bool = false) : Void
	{
		inMovie.graphics.clear();
		inMovie.graphics.beginFill(inColor);
		inMovie.graphics.drawRect(0, 0, squareSize, squareSize);
		inMovie.graphics.endFill(); 
		
		// If it has an image then hide it  
		inMovie.alpha = ((hasImage)) ? 0 : 1;
    }
	
	private function applyWindowImage() : Void
	{  
		// Show Image
		if (!_showImage)
		return;
		
		// Clear texture before hand
		_windowTopLeftTexture.graphics.clear();
		_windowTopMiddleTexture.graphics.clear();
		_windowTopRightTexture.graphics.clear();
		
		_windowMiddleLeftTexture.graphics.clear();
		_windowMiddleRightTexture.graphics.clear();
		
		_windowBottomLeftTexture.graphics.clear();
		_windowBottomMiddleTexture.graphics.clear();
		_windowBottomRightTexture.graphics.clear();
		
		
		// Top Area 
		if (_windowTopLeftImage != null && _windowTopLeftSize > 0)       
			textureShape(_windowTopLeftTexture, _windowTopLeft.width, _windowTopLeft.height, _windowTopLeftImage);
		
		if (_windowTopMiddleImage != null && _windowTopMiddleSize > 0)      
			textureShape(_windowTopMiddleTexture, _windowTopMiddle.width, _windowTopMiddle.height, _windowTopMiddleImage);
		
		if (_windowTopRightImage != null && _windowTopRightSize > 0)             
			textureShape(_windowTopRightTexture, _windowTopRight.width, _windowTopRight.height, _windowTopRightImage);
		
		// Mid Area  
		if (_windowMiddleLeftImage != null && _windowMiddleSize > 0)    
			textureShape(_windowMiddleLeftTexture, _windowMiddleLeft.width, _windowMiddleLeft.height, _windowMiddleLeftImage);
		
		if (_windowMiddleRightImage != null && _windowMiddleSize > 0)    
			textureShape(_windowMiddleRightTexture, _windowMiddleRight.width, _windowMiddleRight.height, _windowMiddleRightImage);
		
		// Bottom Area  
		if (_windowBottomLeftImage != null && _windowBottomLeftSize > 0)   
			textureShape(_windowBottomLeftTexture, _windowBottomLeft.width, _windowBottomLeft.height, _windowBottomLeftImage);
		
		if (_windowBottomMiddleImage != null && _windowBottomMiddleSize > 0)        
			textureShape(_windowBottomMiddleTexture, _windowBottomMiddle.width, _windowBottomMiddle.height, _windowBottomMiddleImage);
		
		if (_windowBottomRightImage != null && _windowBottomRightSize > 0)  
			textureShape(_windowBottomRightTexture, _windowBottomRight.width, _windowBottomRight.height, _windowBottomRightImage);
    }
	
	private function textureShape(shape : Shape, imageWidth : Float, imageHeight : Float, image : BitmapData = null) : Void 
	{
		shape.graphics.clear();
		
		if (null == image)
		return;
		
		shape.graphics.beginBitmapFill(image, null, true, _smoothImage);
		shape.graphics.drawRect(0, 0, imageWidth, imageHeight);
		shape.graphics.endFill();
    }
	
	/* Mouse Events */ 
	
	/*Handles the Dragging of the windows
	 *
	 * iMovie:MovieClip - The instance name of the movie to drag
	 * scale:Boolean - Specifies whether of not the clip being dragged will scal the window
	 *
	 * Usage: this.windowMaker.dragMe(this);
	 *
	 * @private
	 */ 
	
	private function dragMe(event : MouseEvent) : Void
	{
		addDrag();
    }
	
	/*Stops Dragging
	 *
	 * inMovie: MovieClip - The instance name of the MovieClip to stop Dragging
	 *
	 */  
	
	private function dontDragMe(event : MouseEvent) : Void 
	{
		removeDrag();
    } 
	
	/* Window Event */ 
	
	private function windowCloseButton(event : Event) : Void 
	{
		dispatchEvent(new WindowEvent(WindowEvent.WINDOW_CLOSE_BTN));
	}
	
	private function windowMinButton(event : Event) : Void 
	{ 
		dispatchEvent(new WindowEvent(WindowEvent.WINDOW_MIN_BTN));
	}
	
	private function windowMaxButton(event : Event) : Void 
	{
		dispatchEvent(new WindowEvent(WindowEvent.WINDOW_MAX_BTN));
	}
	

	
	private function windowResizeOver(event : Event) : Void
	{
		_resizeWindow = true;
    }
	
	private function windowResizeOut(event : Event) : Void 
	{
		if (!_mouseDown)
			_resizeWindow = false;
    }
	
	private function windowEventResize(event : MouseEvent) : Void
	{
		if (_mouseDown && _enableResize) 
		{
			if (_resizeName == "windowBottomMiddle") 
				setWindowSize(Std.int(_windowWidth), Std.int(_windowHeight + _windowBottomMiddle.mouseY - _windowBottomMiddle.mouseX));
            else if (_resizeName == "windowMiddleRight") 
				setWindowSize(Std.int(_windowWidth + _windowMiddleRight.mouseX - _windowMiddleRight.mouseY), Std.int(_windowHeight));
            else if (_resizeName == "windowBottomRight") 
				setWindowSize(Std.int(_windowWidth + _windowMiddleRight.mouseX - _windowMiddleRight.mouseY) + BOTTOM_RIGHT_DRAG_OFFSET, Std.int(_windowHeight + _windowBottomMiddle.mouseY - _windowBottomMiddle.mouseX) + BOTTOM_RIGHT_DRAG_OFFSET);
        }
    }
	
	private function windowMouseDown(event : Event) : Void
	{
		_mouseDown = true;
		_resizeName = Std.string(cast(event.target, DisplayObject).name);
    }
	
	private function windowMouseUp(event : Event) : Void
	{
		_resizeWindow = false;
		_mouseDown = false;
		_resizeName = "";
    }
	
	private function resizeBarMouseUp(event : Event) : Void 
	{
		_scrollPane.refreshPane();
    }
	
	private function windowStageInit(event : Event) : Void 
	{
		stage.addEventListener(MouseEvent.MOUSE_MOVE, windowEventResize, false, 0, true);
		stage.addEventListener(MouseEvent.MOUSE_DOWN, windowMouseDown, false, 0, true);
		stage.addEventListener(MouseEvent.MOUSE_UP, windowMouseUp, false, 0, true);  
		
		// NOTE: Failsafe - I don't know if this out outside of the window  
		stage.addEventListener(Event.MOUSE_LEAVE, windowMouseUp, false, 0, true);
    }
}