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
	
	/**
	 * The scroll pane being used
	 */
	
    public var scrollPane(get, never) : IScrollPane;
    
	/**
	 * Close Button
	 */
	
    public var closeButton(get, never) : IButton;
	
	/**
	 * Min Button 
	 */
	
    public var minButton(get, never) : IButton;
	
	/**
	 * Max Button
	 */
	
    public var maxButton(get, never) : IButton;
	
	/**
	 * Text label being used
	 */
	
    public var textLabel(get, never) : ILabel;
	
	/**
	 * Set the minimize width of the of the Window over all size
	 */
	
    public var windowMinWidth(get, set) : Int;
	
	/**
	 * Set the minimize height of the of the Window over all size
	 */
	
    public var windowMinHeight(get, set) : Int;
	
	/**
	 * Set if the window is resizable or not.
	 */
	
    public var resize(get, set) : Bool;
	
	/**
	 * Set the color of the window title area once the user select
	 */
	
    public var windowTitleColor(get, set) : Int;
	
	/**
	 * Set the color of the window
	 */
	
    public var windowColor(get, set) : Int;
	
	/**
	 * Set the size of the top right area of the window
	 */
	
    public var windowTopRightSize(get, set) : Int;
	
	/**
	 * Set the top center block on the window.
	 */
	
    public var windowTopMiddleSize(get, set) : Int;
	
	/**
	 * Set the size of the top left area of the window
	 */
	
    public var windowTopLeftSize(get, set) : Int;
	
	/**
	 * Set the center block on the left and right side of the window
	 */
	
    public var windowMiddleSize(get, set) : Int;
	
	/**
	 * Set the size of the bottom right area of the window
	 */
	
    public var windowBottomRightSize(get, set) : Int;
	
	/**
	 * Set the size of the bottom middle area of the window
	 */
	
    public var windowBottomMiddleSize(get, set) : Int;
	
	/**
	 * Set the size of the bottom left area of the window
	 */
	
    public var windowBottomLeftSize(get, set) : Int;
	
	/**
	 * Set where the window icon will be placed. The icon can only be placed on the left or right side. If there are buttons on the side selected they'll be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side.
	 */
	
    public var iconLocation(get, set) : String;
	
	/**
	 * Set where to place the label on the window. The default is center but can be placed left or right as well.
	 */
	
    public var labelLocation(get, set) : String;
	
	/**
	 * Set where the buttons will be placed. The button(s) can only be placed on the left or right side. If there is a icon on the side selected it will be shift to the other side of the window.
	 * For example if you set the window icon to the left side the buttons will be displayed on the right side. Can only passed "left" or "right" as a value.
	 */
	
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
	public static var TEXT_OFFSET_Y : Int = 0;
	public static var DEFAULT_CLOSE_BTN_COLOR : Int = 0xFF0000;
	public static var DEFAULT_MAX_BTN_COLOR : Int = 0x00FF00;
	public static var DEFAULT_MIN_BTN_COLOR : Int = 0x00000FF;
	public static var BOTTOM_RIGHT_DRAG_OFFSET : Int = 10;
	
	// Initializes the Sprite that will be used to contain the window pieces  
	
	private var _windowTopLeft : Sprite = new Sprite();
	private var _windowTopMiddle : Sprite = new Sprite();
	private var _windowTopRight : Sprite = new Sprite();
	private var _windowMiddleLeft : Sprite = new Sprite();
	private var _windowMiddleRight : Sprite = new Sprite();
	private var _windowBottomLeft : Sprite = new Sprite();
	private var _windowBottomMiddle : Sprite = new Sprite();
	private var _windowBottomRight : Sprite = new Sprite();
	private var _windowButtonArea : Sprite = new Sprite();
	
	private var _imageTopPattern : Bitmap = null;
	private var _imageMiddlePattern : Bitmap = null;
	private var _imageBottomPattern : Bitmap = null;  
	
	// Texture Layer 
	private var _windowTopLeftTexture : Shape = new Shape();
	private var _windowTopMiddleTexture : Shape = new Shape();
	private var _windowTopRightTexture : Shape = new Shape();
	
	private var _windowMiddleLeftTexture : Shape = new Shape();
	private var _windowMiddleRightTexture : Shape = new Shape();
	
	private var _windowBottomLeftTexture : Shape = new Shape();
	private var _windowBottomMiddleTexture : Shape = new Shape();
	private var _windowBottomRightTexture : Shape = new Shape();
	
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
	
	private var _iconDisplay : Shape = new Shape();
	private var _iconLocation : String = "right";
	private var _buttonLocation : String = "left";
	private var _labelLocation : String = "center";
	
	
	private var _showImage : Bool = true;
	private var _resizeName : String = ""; 
	
	// This is to keep track of what was clicked on mouse down 
	private var _resizeWindow : Bool = false;
	private var _mouseDown : Bool = false;
	
	private var _bgShowImage : Bool = true;
	private var _enableResize : Bool = true;
	private var _contentMask : Sprite;
	
	private var _scrollPane : ScrollPane;
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
	
	private var _closeButtonData:Dynamic = null;
	private var _minButtonData:Dynamic = null;
	private var _maxButtonData:Dynamic = null;
	
	// Constructor.  Also assigns the window main variable and loads in the window's content  
	public function new(data:Dynamic = null)
    {
		
        super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		// Window Color
		if (Reflect.hasField(data, "windowColor"))
			_windowColor = Reflect.field(data, "windowColor");
			
		if (Reflect.hasField(data, "windowTitleColor"))
			_windowTitleColor = Reflect.field(data, "windowTitleColor");
			
		// Location of buttons and label	
		if (Reflect.hasField(data, "labelLocation"))
			_labelLocation = Reflect.field(data, "labelLocation");
			
		if (Reflect.hasField(data, "buttonLocation"))
			_buttonLocation = Reflect.field(data, "buttonLocation");
			
		if (Reflect.hasField(data, "iconLocation"))
			_iconLocation = Reflect.field(data, "iconLocation");
			
			
		// Min Size	
		if (Reflect.hasField(data, "windowMinWidth"))
			_windowMinWidth = Reflect.field(data, "windowMinWidth");
			
		if (Reflect.hasField(data, "windowMinHeight"))
			_windowMinHeight = Reflect.field(data, "windowMinHeight");
			
		if (Reflect.hasField(data, "resize"))
			_enableResize = Reflect.field(data, "resize");
			
			
		// Window Resize
		if (Reflect.hasField(data, "windowTopRightSize"))
			_windowTopRightSize = Reflect.field(data, "windowTopRightSize");
		
		if (Reflect.hasField(data, "windowTopMiddleSize"))
			_windowTopMiddleSize = Reflect.field(data, "windowTopMiddleSize");
			
		if (Reflect.hasField(data, "windowTopLeftSize"))
			_windowTopLeftSize = Reflect.field(data, "windowTopLeftSize");
		
			
		if (Reflect.hasField(data, "windowMiddleSize"))
			_windowMiddleSize = Reflect.field(data, "windowMiddleSize");
			
			
		if (Reflect.hasField(data, "windowBottomRightSize"))
			_windowBottomRightSize = Reflect.field(data, "windowBottomRightSize");
			
		if (Reflect.hasField(data, "windowBottomMiddleSize"))
			_windowBottomMiddleSize = Reflect.field(data, "windowBottomMiddleSize");
		
		if (Reflect.hasField(data, "windowBottomLeftSize"))
			_windowBottomLeftSize = Reflect.field(data, "windowBottomLeftSize");
		
		
		// Other Comonents 
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
		
		if (Reflect.hasField(data, "ScrollPanel"))
			_scrollPanelData = Reflect.field(data, "ScrollPanel");
			
			
		if (Reflect.hasField(data, "CloseButton"))
			_closeButtonData = Reflect.field(data, "CloseButton");
			
		if (Reflect.hasField(data, "MinButton"))
			_minButtonData = Reflect.field(data, "MinButton");
			
		if (Reflect.hasField(data, "MaxButton"))
			_maxButtonData = Reflect.field(data, "MaxButton");
			
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
		
		if (_scrollPanelData == null)
			_scrollPanelData = {"name":"windowScrollPane", "mode":ScrollPolicy.AUTO};
		
		// Setup scroll pane
		_scrollPane = new ScrollPane(_scrollPanelData);
		
		
		// Sets the window title textformat reference
		_windowTitle = new Label(_labelData);
		
		
		// Setup window buttons
		if (_closeButtonData == null)
			_closeButtonData = {"name":WindowEvent.WINDOW_CLOSE_BTN, "showLabel":false, "defaultColor":DEFAULT_CLOSE_BTN_COLOR};
		
		
		if (_minButtonData == null)
			_minButtonData = {"name":WindowEvent.WINDOW_MIN_BTN, "showLabel":false, "defaultColor":DEFAULT_MIN_BTN_COLOR};
			
			
		if (_maxButtonData == null)
			_maxButtonData = {"name":WindowEvent.WINDOW_MAX_BTN, "showLabel":false, "defaultColor":DEFAULT_MAX_BTN_COLOR};
			
		_closeButton = new Button(_closeButtonData);
		_minButton = new Button(_minButtonData);
		_maxButton = new Button(_maxButtonData);
		
		
		// Clear objects
		_maxButtonData = _minButtonData = _closeButtonData = _labelData = _scrollPanelData = null;
		
		
		super.initialize();
		
		
		_iconDisplay.name = "windowIcon";  
		
		//_windowTitle.textField.multiline = false;
		//_windowTitle.textField.wordWrap = false;  
		_windowTitle.textField.selectable = false;
		
		_windowTopLeft.name = "windowTopLeft";
		_windowTopMiddle.name = "windowTopMiddle";
		_windowTopRight.name = "windowTopRight";
		
		_windowMiddleLeft.name = "windowMiddleLeft";
		_windowMiddleRight.name = "windowMiddleRight";
		
		_windowBottomLeft.name = "windowBottomLeft";
		_windowBottomMiddle.name = "windowBottomMiddle";
		_windowBottomRight.name = "windowBottomRight";
		
		_windowButtonArea.name = "windowButtonArea";
		
		_closeButton.addEventListener(MouseEvent.CLICK, windowCloseButton, false, 0, true);
		_maxButton.addEventListener(MouseEvent.CLICK, windowMaxButton, false, 0, true);
		_minButton.addEventListener(MouseEvent.CLICK, windowMinButton, false, 0, true);  
		
		// Resize event 
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowMiddleRight.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowBottomMiddle.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_OVER, windowResizeOver);
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_OUT, windowResizeOut);
		_windowBottomRight.addEventListener(MouseEvent.MOUSE_UP, resizeBarMouseUp);
		
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
		addChild(_scrollPane);
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
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Events
		_windowTitle.removeEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		_windowTitle.removeEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopLeft.removeEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopLeft.removeEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopRight.removeEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopRight.removeEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		_windowTopMiddle.removeEventListener(MouseEvent.MOUSE_DOWN, dragMe);
		
		_windowTopMiddle.removeEventListener(MouseEvent.MOUSE_UP, dontDragMe);
		
		removeEventListener(Event.ADDED_TO_STAGE, windowStageInit);
		
		// Remove items into display
		removeChild(_windowTopLeft);
		removeChild(_windowTopMiddle);
		removeChild(_windowTopRight);
		removeChild(_windowMiddleLeft);
		removeChild(_windowMiddleRight);
		removeChild(_windowBottomLeft);
		removeChild(_windowBottomMiddle);
		removeChild(_windowBottomRight);
		removeChild(_windowMiddleLeftTexture);
		removeChild(_windowMiddleRightTexture);
		removeChild(_scrollPane);
		removeChild(_windowTopLeftTexture);
		removeChild(_windowTopMiddleTexture);
		removeChild(_windowTopRightTexture);
		removeChild(_windowBottomLeftTexture);
		removeChild(_windowBottomMiddleTexture);
		removeChild(_windowBottomRightTexture);
		
		
		removeChild(_windowTitle);
		removeChild(_windowButtonArea);
		removeChild(_iconDisplay);		
		
		// Remove buttons to button area 
		_windowButtonArea.removeChild(_closeButton);
		_windowButtonArea.removeChild(_maxButton);
		_windowButtonArea.removeChild(_minButton);
		
		_scrollPane.destroy();
		_windowTitle.destroy();
		
		_closeButton.destroy();
		_maxButton.destroy();
		_minButton.destroy();
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
    }
	
	private function initStyle() : Void 
	{
		if (null == _scrollPanelData)
			_scrollPanelData = {"name":"windowScrollPane", "mode":ScrollPolicy.AUTO};
		
		if (null == _labelData)
			_labelData = {};
		
			
		// Setup window buttons
		if (_closeButtonData == null)
			_closeButtonData = {"name":WindowEvent.WINDOW_CLOSE_BTN, "showLabel":false, "defaultColor":DEFAULT_CLOSE_BTN_COLOR};
		
		if (_minButtonData == null)
			_minButtonData = {"name":WindowEvent.WINDOW_MIN_BTN, "showLabel":false, "defaultColor":DEFAULT_MIN_BTN_COLOR};
			
		if (_maxButtonData == null)
			_maxButtonData = {"name":WindowEvent.WINDOW_MAX_BTN, "showLabel":false, "defaultColor":DEFAULT_MAX_BTN_COLOR};
			
			
		if ( -1 != UIStyleManager.WINDOW_BACKGROUND_COLOR) 
			Reflect.setField(_scrollPanelData, "backgroundColor", UIStyleManager.WINDOW_BACKGROUND_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_BORDER_ALPHA)   
			Reflect.setField(_scrollPanelData, "borderAlpha", UIStyleManager.WINDOW_BORDER_ALPHA);
		
		if ( -1 != UIStyleManager.WINDOW_BORDER_COLOR)   
			Reflect.setField(_scrollPanelData, "borderColor", UIStyleManager.WINDOW_BORDER_COLOR);
		
		
		Reflect.setField(_scrollPanelData, "border", UIStyleManager.WINDOW_BORDER);
		
		if ("" != UIStyleManager.WINDOW_ICON_LOCATION)       
			_iconLocation = UIStyleManager.WINDOW_ICON_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_BUTTON_LOCATION)    
			_buttonLocation = UIStyleManager.WINDOW_BUTTON_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_LABEL_LOCATION) 
			_labelLocation = UIStyleManager.WINDOW_LABEL_LOCATION;
		
		if ("" != UIStyleManager.WINDOW_TITLE_TEXT_FONT) 
			Reflect.setField(_labelData, "font", UIStyleManager.WINDOW_TITLE_TEXT_FONT);
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_SIZE)    
			Reflect.setField(_labelData, "size", UIStyleManager.WINDOW_TITLE_TEXT_SIZE);
		
		//if (null != UIStyleManager.WINDOW_TITLE_TEXT_EMBED)
		//_windowTitle.setEmbedFont(UIStyleManager.WINDOW_TITLE_TEXT_EMBED);
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_TEXT_COLOR)     
			Reflect.setField(_labelData, "textColor", UIStyleManager.WINDOW_TITLE_TEXT_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_AREA_COLOR)   
			_windowTitleColor = UIStyleManager.WINDOW_TITLE_AREA_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_FOCUS_COLOR)  
			_windowColor = UIStyleManager.WINDOW_FOCUS_COLOR;
		
		
		// Min Button
		if ( -1 != UIStyleManager.WINDOW_MIN_NORMAL_COLOR)
			Reflect.setField(_minButtonData, "defaultColor", UIStyleManager.WINDOW_MIN_NORMAL_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_MIN_OVER_COLOR)      
			Reflect.setField(_minButtonData, "overColor", UIStyleManager.WINDOW_MIN_OVER_COLOR);
		
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DOWN_COLOR)   
			Reflect.setField(_minButtonData, "downColor", UIStyleManager.WINDOW_MIN_DOWN_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DISABLE_COLOR)  
			Reflect.setField(_minButtonData, "disableColor", UIStyleManager.WINDOW_MIN_DISABLE_COLOR);
		
		// Max Button  
		if ( -1 != UIStyleManager.WINDOW_MAX_NORMAL_COLOR)    
			Reflect.setField(_maxButtonData, "defaultColor", UIStyleManager.WINDOW_MAX_NORMAL_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_MAX_OVER_COLOR)  
			Reflect.setField(_maxButtonData, "overColor", UIStyleManager.WINDOW_MAX_OVER_COLOR);
		
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DOWN_COLOR)        
			Reflect.setField(_maxButtonData, "downColor", UIStyleManager.WINDOW_MAX_DOWN_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DISABLE_COLOR)         
			Reflect.setField(_maxButtonData, "disableColor", UIStyleManager.WINDOW_MAX_DISABLE_COLOR);
		
		// Close Button  
		if ( -1 != UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR)  
			Reflect.setField(_closeButtonData, "defaultColor", UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_OVER_COLOR)   
			Reflect.setField(_closeButtonData, "overColor", UIStyleManager.WINDOW_CLOSE_OVER_COLOR);
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DOWN_COLOR)     
			Reflect.setField(_closeButtonData, "downColor", UIStyleManager.WINDOW_CLOSE_DOWN_COLOR);
        
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR)      
			Reflect.setField(_closeButtonData, "disableColor", UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR);
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
		_windowTopLeftSize = value;
		
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
		
		//_closeButton.draw();
		//_minButton.draw();
		//_maxButton.draw();
		
		//_windowTitle.draw();
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
    }
	
	/**
	 * This set an image to the left side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */  
	public function setWindowMiddleLeftImage(value : BitmapData) : Void
	{
		_windowMiddleLeftImage = value;
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
		
		_closeButton.draw();
		_minButton.draw();
		_maxButton.draw();
		
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
		
		//_windowTitle.width = _windowTopMiddle.width - _windowTitle.x;
		_windowTitle.height = _windowTopMiddle.height;
		
		
		
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
			_windowMiddleRightTexture.x = _windowMiddleRight.x = inWidth - _windowMiddleRight.width;
        else 
			_windowMiddleRightTexture.x = _windowMiddleRight.x = _windowMinWidth - _windowMiddleRight.width;
		
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
		if (_labelLocation == "left") 
		{  
			_windowTitle.align = "left"; 
			
			if (_buttonLocation == "left") 
			{
				_windowTitle.width = _windowTopMiddle.width - _windowButtonArea.width - TEXT_OFFSET_X;
				_windowTitle.x = _windowButtonArea.x + _windowButtonArea.width + TEXT_OFFSET_X;
			}
            else if (_iconLocation == "left") 
			{
				_windowTitle.width = _windowTopMiddle.width - _iconDisplay.width - TEXT_OFFSET_X;
				_windowTitle.x = _iconDisplay.x + _iconDisplay.width + TEXT_OFFSET_X;
			}
				
			_windowTitle.width = _windowTopMiddle.width - _windowButtonArea.width - TEXT_OFFSET_X;
        }
        else if (_labelLocation == "right") 
		{
			_windowTitle.align = "right";
			
			if (_buttonLocation == "right")
			{
				_windowTitle.width = _windowTopMiddle.width - _windowButtonArea.width - TEXT_OFFSET_X;
				_windowTitle.x = _windowButtonArea.width - TEXT_OFFSET_X;
			}
            else if (_iconLocation == "right")
			{
				_windowTitle.width = _windowTopMiddle.width - _iconDisplay.width - TEXT_OFFSET_X;
				_windowTitle.x = _iconDisplay.width - TEXT_OFFSET_X;
			}
				
			
        }
        else 
		{
			_windowTitle.width = _windowTopMiddle.width;
			_windowTitle.x = _windowTopLeft.x + _windowTopLeft.width;
        }
		
		
		_windowTitle.y = TEXT_OFFSET_Y; 
		_windowTitle.draw();
		
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
		
		inMovie.draw();
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
		//_resizeName = Std.string(cast(event.target, DisplayObject).name);
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