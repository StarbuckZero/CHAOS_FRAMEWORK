package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IWindow;
import openfl.events.EventDispatcher;
import com.chaos.utils.Utils;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.events.*;
import openfl.text.TextField;
import openfl.text.TextFormat;
import com.chaos.ui.event.WindowEvent;
import com.chaos.ui.Window;
import com.chaos.ui.Label;
import com.chaos.media.DisplayImage;
import com.chaos.ui.UIDetailLevel;
import com.chaos.ui.ScrollPolicy;
import openfl.utils.Object;

/**
 * Basic window that can display objects
 *
 * @author Erick Feiling
 * @date 1-22-10
 */

class Window extends BaseUI implements IWindow implements IBaseUI
{
	
	/** The type of UI Element */ 
	public static inline var TYPE : String = "Window";
	
    public var scrollPane(get, never) : IScrollPane;
    public var windowBackDrop(get, never) : Sprite;
    public var windowFrontOverlay(get, never) : Sprite;
    public var textLabel(get, never) : Label;
    public var windowMinWidth(get, set) : Int;
    public var windowMinHeight(get, set) : Int;
    public var resize(get, set) : Bool;
    public var closeButtonNormalColor(get, set) : Int;
    public var closeButtonOverColor(get, set) : Int;
    public var closeButtonDownColor(get, set) : Int;
    public var closeButtonDisableColor(get, set) : Int;
    public var closeButtonUnFocusColor(get, set) : Int;
    public var minButtonNormalColor(get, set) : Int;
    public var minButtonOverColor(get, set) : Int;
    public var minButtonDownColor(get, set) : Int;
    public var minButtonDisableColor(get, set) : Int;
    public var minButtonUnFocusColor(get, set) : Int;
    public var maxButtonNormalColor(get, set) : Int;
    public var maxButtonOverColor(get, set) : Int;
    public var maxButtonDownColor(get, set) : Int;
    public var maxButtonDisableColor(get, set) : Int;
    public var maxButtonUnFocusColor(get, set) : Int;
    public var showCloseButton(get, set) : Bool;
    public var showMinButton(get, set) : Bool;
    public var showMaxButton(get, set) : Bool;
    public var enabledCloseButton(get, set) : Bool;
    public var enabledMinButton(get, set) : Bool;
    public var enabledMaxButton(get, set) : Bool;
    public var windowTitleFocusColor(get, set) : Int;
    public var windowTitleUnFocusColor(get, set) : Int;
    public var windowFocusColor(get, set) : Int;
    public var windowUnFocusColor(get, set) : Int;
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
	
	// Initializes the movies that will be used to contain the window pieces  
	private var _windowBackDrop : Sprite;
	private var _windowFrontOverlay : Sprite;
	private var _windowTopLeft : Sprite;
	private var _windowTopMiddle : Sprite;
	private var _windowTopRight : Sprite;
	private var _windowMiddleLeft : Sprite;
	private var _windowMiddleRight : Sprite;
	private var _windowBottomLeft : Sprite;
	private var _windowBottomMiddle : Sprite;
	private var _windowBottomRight : Sprite;
	private var _windowButtonArea : Sprite; 
	
	// Overlay Pattern Texture Mask 
	private var _windowTopPatternMask : Sprite;
	private var _windowMiddlePatternMask : Sprite;
	private var _windowBottomPatternMask : Sprite; 
	
	// Overlay Pattern Texture 
	private var _windowTopPattern : Shape;
	private var _windowMiddlePattern : Shape;
	private var _windowBottomPattern : Shape;
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
	
	private var _windowTopLeftImage : DisplayImage;
	private var _windowTopMiddleImage : DisplayImage;
	private var _windowTopRightImage : DisplayImage;
	
	private var _windowMiddleLeftImage : DisplayImage;
	private var _windowMiddleRightImage : DisplayImage;
	
	private var _windowBottomLeftImage : DisplayImage;
	private var _windowBottomMiddleImage : DisplayImage;
	private var _windowBottomRightImage : DisplayImage;
	
	private var _windowTopLeftUnFocusImage : DisplayImage;
	private var _windowTopMiddleUnFocusImage : DisplayImage;
	private var _windowTopRightUnFocusImage : DisplayImage;
	
	private var _windowMiddleLeftUnFocusImage : DisplayImage;
	private var _windowMiddleRightUnFocusImage : DisplayImage;
	
	private var _windowBottomLeftUnFocusImage : DisplayImage;
	private var _windowBottomMiddleUnFocusImage : DisplayImage;
	private var _windowBottomRightUnFocusImage : DisplayImage;
	
	private var _iconDisplay : DisplayImage;
	private var _iconLocation : String = "right";
	private var _buttonLocation : String = "left";
	private var _labelLocation : String = "center";
	
	private var _blnWindowTopLeft : Bool = false;
	private var _blnWindowTopMiddle : Bool = false;
	private var _blnWindowTopRight : Bool = false;
	
	private var _blnWindowMiddleLeft : Bool = false;
	private var _blnWindowMiddleRight : Bool = false;
	
	private var _blnWindowBottomLeft : Bool = false;
	private var _blnWindowBottomMiddle : Bool = false;
	private var _blnWindowBottomRight : Bool = false;
	
	private var _blnWindowTopLeftUnFocus : Bool = false;
	private var _blnWindowTopMiddleUnFocus : Bool = false;
	private var _blnWindowTopRightUnFocus : Bool = false;
	
	private var _blnWindowMiddleLeftUnFocus : Bool = false;
	private var _blnWindowMiddleRightUnFocus : Bool = false;
	
	private var _blnWindowBottomLeftUnFocus : Bool = false;
	private var _blnWindowBottomMiddleUnFocus : Bool = false;
	private var _blnWindowBottomRightUnFocus : Bool = false;
	
	private var _scaleBgImage : Bool = false;
	private var _smoothImage : Bool = true;
	private var _showImage : Bool = true;
	private var _resizeName : String = ""; 
	
	// This is to keep track of what was clicked on mouse down 
	private var _resizeWindow : Bool = false;
	private var _mouseDown : Bool = false;
	
	private var _closeUnFocusColor : Int = 0x999999;
	private var _maxUnFocusColor : Int = 0x999999;
	private var _minUnFocusColor : Int = 0x999999;
	
	private var _showCloseButton : Bool = true;
	private var _showMinButton : Bool = true;
	private var _showMaxButton : Bool = true;
	
	private var _enabledCloseButton : Bool = true;
	private var _enabledMinButton : Bool = true;
	private var _enabledMaxButton : Bool = true;
	
	//private var _enabled : Bool = true;
	
	private var _bgShowImage : Bool = true;
	private var _enableResize : Bool = true;
	private var _contentMask : Sprite;
	
	private var _scrollPane : IScrollPane;
	private var _windowTitle : Label;
	private var _eventDispatcher : EventDispatcher;
	private var _windowFocus : Bool = true; 
	
	// Initializes the vars that are used to constrain the window to a certain minimum width and height  
	private var _windowWidth : Float;
	private var _windowHeight : Float;
	
	private var _windowMinWidth : Int = WINDOW_MIN_WIDTH;
	private var _windowMinHeight : Int = WINDOW_MIN_HEIGHT;
	
	private var _windowTitleFocusColor : Int = 0xFFFFFF;
	private var _windowTitleUnFocusColor : Int = 0x333333;
	private var _windowFocusColor : Int = 0xFFFFFF;
	private var _windowUnFocusColor : Int = 0xCCCCCC;
	
	// Default size for window
	private var _windowTopRightSize : Int = WINDOW_TOP_RIGHT_SIZE;
	private var _windowTopMiddleSize : Int = WINDOW_TOP_MIDDLE_SIZE;
	private var _windowTopLeftSize : Int = WINDOW_TOP_LEFT_SIZE;
	private var _windowMiddleSize : Int = WINDOW_MIDDLE_SIZE;
	private var _windowBottomRightSize : Int = WINDOW_BOTTOM_RIGHT_SIZE;
	private var _windowBottomMiddleSize : Int = WINDOW_BOTTOM_MIDDLE_SIZE;
	private var _windowBottomLeftSize : Int = WINDOW_BOTTOM_LEFT_SIZE; 
	
	// Constructor.  Also assigns the window main variable and loads in the window's content  
	public function new(winWidth : Int = 320, winHeight : Int = 320)
    {
        super();
		
		_windowWidth = winWidth;
		_windowHeight = winHeight;
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);init();
    }
	
	private function onStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(TYPE, this);
    }
	
	private function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
    }
	
	private function init() : Void 
	{  
		// Send instance of self to the Event Dispatcher 
		_eventDispatcher = new EventDispatcher();
		
		// Setup scroll pane
		_scrollPane = new ScrollPane();
		_scrollPane.name = "windowScrollPane";
		_scrollPane.mode = ScrollPolicy.AUTO;
		
		// Window Display Icon
		_iconDisplay = new DisplayImage();
		_iconDisplay.name = "windowIcon";  
		
		// Sets the window title textformat reference
		_windowTitle = new Label();
		_windowTitle.textField.multiline = false;
		_windowTitle.textField.wordWrap = false;  
		
		// Window back-end layer which 
		_windowBackDrop = new Sprite();
		_windowFrontOverlay = new Sprite();
		
		// Init sprites/clips for window 
		_windowTopLeft = new Sprite();
		_windowTopMiddle = new Sprite();
		_windowTopRight = new Sprite();
		
		_windowTopLeft.name = "windowTopLeft";
		_windowTopMiddle.name = "windowTopMiddle";
		_windowTopRight.name = "windowTopRight";
		
		_windowMiddleLeft = new Sprite();
		_windowMiddleRight = new Sprite();
		
		_windowMiddleLeft.name = "windowMiddleLeft";
		_windowMiddleRight.name = "windowMiddleRight";
		_windowBottomLeft = new Sprite();
		_windowBottomMiddle = new Sprite();
		_windowBottomRight = new Sprite();
		
		_windowBottomLeft.name = "windowBottomLeft";
		_windowBottomMiddle.name = "windowBottomMiddle";
		_windowBottomRight.name = "windowBottomRight";
		
		_windowButtonArea = new Sprite();
		_windowButtonArea.name = "windowButtonArea";
		
		_windowTopLeftTexture = new Shape();
		_windowTopMiddleTexture = new Shape();
		_windowTopRightTexture = new Shape();
		
		_windowMiddleLeftTexture = new Shape();
		_windowMiddleRightTexture = new Shape();
		_windowBottomLeftTexture = new Shape();
		
		_windowBottomMiddleTexture = new Shape();
		_windowBottomRightTexture = new Shape(); 
		
		// Mask for the pattern
		_windowTopPatternMask = new Sprite();
		_windowMiddlePatternMask = new Sprite();
		_windowBottomPatternMask = new Sprite();
		
		_windowTopPattern = new Shape();
		_windowMiddlePattern = new Shape();
		_windowBottomPattern = new Shape();
		
		// Setup window buttons
		_closeButton = new Button();
		_minButton = new Button();
		_maxButton = new Button();
		
		_closeButton.name = WindowEvent.WINDOW_CLOSE_BTN;
		_minButton.name = WindowEvent.WINDOW_MIN_BTN;
		_maxButton.name = WindowEvent.WINDOW_MAX_BTN;
		
		_closeButton.buttonColor = DEFAULT_CLOSE_BTN_COLOR;
		_maxButton.buttonColor = DEFAULT_MAX_BTN_COLOR;
		_minButton.buttonColor = DEFAULT_MIN_BTN_COLOR;
		
		_closeButton.label = "";
		_maxButton.label = "";
		_minButton.label = "";
		
		_closeButton.addEventListener(MouseEvent.CLICK, windowCloseButton, false, 0, true);
		_maxButton.addEventListener(MouseEvent.CLICK, windowMaxButton, false, 0, true);
		_minButton.addEventListener(MouseEvent.CLICK, windowMinButton, false, 0, true);  
		
		// Setting up call back for loader images
		_windowTopLeftImage = new DisplayImage();
		_windowTopMiddleImage = new DisplayImage();
		_windowTopRightImage = new DisplayImage();
		
		_windowMiddleLeftImage = new DisplayImage();
		_windowMiddleRightImage = new DisplayImage();
		
		_windowBottomLeftImage = new DisplayImage();
		_windowBottomMiddleImage = new DisplayImage();
		_windowBottomRightImage = new DisplayImage();
		
		_windowTopLeftUnFocusImage = new DisplayImage();
		_windowTopMiddleUnFocusImage = new DisplayImage();
		_windowTopRightUnFocusImage = new DisplayImage();
		
		_windowMiddleLeftUnFocusImage = new DisplayImage();
		_windowMiddleRightUnFocusImage = new DisplayImage();
		
		_windowBottomLeftUnFocusImage = new DisplayImage();
		_windowBottomMiddleUnFocusImage = new DisplayImage();
		_windowBottomRightUnFocusImage = new DisplayImage();
		
		_windowTopLeftImage.onImageComplete = windowTopLeftLoaded;
		_windowTopMiddleImage.onImageComplete = windowTopMiddleLoaded;
		_windowTopRightImage.onImageComplete = windowTopRightLoaded;
		
		_windowMiddleLeftImage.onImageComplete = windowMiddleLeftLoaded;
		_windowMiddleRightImage.onImageComplete = windowMiddleRightLoaded;
		
		_windowBottomLeftImage.onImageComplete = windowBottomLeftLoaded;
		_windowBottomMiddleImage.onImageComplete = windowBottomMiddleLoaded;
		_windowBottomRightImage.onImageComplete = windowBottomRightLoaded;
		
		_windowTopLeftUnFocusImage.onImageComplete = windowTopLeftUnFocusLoaded;
		_windowTopMiddleUnFocusImage.onImageComplete = windowTopMiddleUnFocusLoaded;
		_windowTopRightUnFocusImage.onImageComplete = windowTopRightUnFocusLoaded;
		
		_windowMiddleLeftUnFocusImage.onImageComplete = windowMiddleLeftUnFocusLoaded;
		_windowMiddleRightUnFocusImage.onImageComplete = windowMiddleRightUnFocusLoaded;
		_windowBottomLeftUnFocusImage.onImageComplete = windowBottomLeftUnFocusLoaded;
		
		_windowBottomMiddleUnFocusImage.onImageComplete = windowBottomMiddleUnFocusLoaded;
		_windowBottomRightUnFocusImage.onImageComplete = windowBottomRightUnFocusLoaded; 
		
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
		addChild(_windowBackDrop);
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
		addChild(_windowMiddlePattern);
		addChild(_scrollPane.displayObject);
		addChild(_windowTopLeftTexture);
		addChild(_windowTopMiddleTexture);
		addChild(_windowTopRightTexture);
		addChild(_windowBottomLeftTexture);
		addChild(_windowBottomMiddleTexture);
		addChild(_windowBottomRightTexture);
		addChild(_windowTopPattern);
		addChild(_windowBottomPattern);
		addChild(_windowTitle);
		addChild(_windowButtonArea);
		addChild(_iconDisplay);
		addChild(_windowTopPatternMask);
		addChild(_windowMiddlePatternMask);
		addChild(_windowBottomPatternMask);
		addChild(_windowFrontOverlay);
		
		// Set Theme 
		initStyle();
		initSkin(); 
		
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
		
		addEventListener(Event.ADDED_TO_STAGE, windowStageInit); draw();
		
    }
	
	private function initSkin() : Void {  
		// Background  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BACKGROUND))   
		_scrollPane.setBackgroundBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BACKGROUND));
		
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
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_NORMAL))   
		setMinButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_OVER))  
		setMinOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DOWN))       
		setMinDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DISABLE))   
		setMinDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIN_BUTTON_DISABLE));
		
		// Max Button  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_NORMAL))       
		setMaxButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_OVER))   
		setMaxOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DOWN)) 
		setMaxDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DISABLE)) 
		setMaxDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MAX_BUTTON_DISABLE));
		
		// Close Button  
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_NORMAL))   
		setCloseButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_OVER))    
		setCloseOverButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DOWN))      
		setCloseDownButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DISABLE))     
        setCloseDisableButtonBitmap(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_CLOSE_BUTTON_DISABLE));
		
		// Pattern Overlay - Every mask layer has to be cloned because you can't use the same display object.  
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_CENTER_MASK) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_RIGHT_MASK)) 
		//{
		//	var topLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_LEFT_MASK));
		//	var topCenterMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_CENTER_MASK));
		//	var topRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_RIGHT_MASK));
		//	
		//	setWindowTopPattern(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_TOP_PATTERN_OVERLAY), topLeftMask, topCenterMask, topRightMask);
		//	
        //}
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_RIGHT_MASK)) 
		//{
		//	var middleLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_LEFT_MASK));
		//	var middleRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_RIGHT_MASK));
		//	
		//	setWindowMiddlePattern(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_MIDDLE_PATTERN_OVERLAY), middleLeftMask, middleRightMask);
		//	
        //}
		//
		//if (null != UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_OVERLAY) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_LEFT_MASK) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_CENTER_MASK) && null != UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_RIGHT_MASK)) 
		//{
		//	var bottomLeftMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_LEFT_MASK));
		//	var bottomCenterMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_CENTER_MASK));
		//	var bottomRightMask : DisplayObject = Utils.duplicateDisplayObject(UIBitmapManager.getUIElementMask(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_RIGHT_MASK));
		//	
		//	setWindowBottomPattern(UIBitmapManager.getUIElement(Window.TYPE, UIBitmapManager.WINDOW_BOTTOM_PATTERN_OVERLAY), bottomLeftMask, bottomCenterMask, bottomRightMask);
        //}
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
		_windowTitleFocusColor = UIStyleManager.WINDOW_TITLE_AREA_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR)    
		_windowTitleUnFocusColor = UIStyleManager.WINDOW_TITLE_AREA_UNFOCUS_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_FOCUS_COLOR)  
		_windowFocusColor = UIStyleManager.WINDOW_FOCUS_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_UNFOCUS_COLOR)       
		_windowUnFocusColor = UIStyleManager.WINDOW_UNFOCUS_COLOR;
		
		// Min Button
		if ( -1 != UIStyleManager.WINDOW_MIN_NORMAL_COLOR)
		_minButton.buttonColor = UIStyleManager.WINDOW_MIN_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_OVER_COLOR)      
		_minButton.buttonOverColor = UIStyleManager.WINDOW_MIN_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DOWN_COLOR)   
		_minButton.buttonDownColor = UIStyleManager.WINDOW_MIN_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MIN_DISABLE_COLOR)  
		_minButton.buttonDownColor = UIStyleManager.WINDOW_MIN_DISABLE_COLOR;
		
		// Max Button  
		if ( -1 != UIStyleManager.WINDOW_MAX_NORMAL_COLOR)    
		_maxButton.buttonColor = UIStyleManager.WINDOW_MAX_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_OVER_COLOR)  
		_maxButton.buttonOverColor = UIStyleManager.WINDOW_MAX_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DOWN_COLOR)        
		_maxButton.buttonDownColor = UIStyleManager.WINDOW_MAX_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_MAX_DISABLE_COLOR)         
		_maxButton.buttonDownColor = UIStyleManager.WINDOW_MAX_DISABLE_COLOR;
		
		// Close Button  
		if ( -1 != UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR)  
		_closeButton.buttonColor = UIStyleManager.WINDOW_CLOSE_NORMAL_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_OVER_COLOR)   
		_closeButton.buttonOverColor = UIStyleManager.WINDOW_CLOSE_OVER_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DOWN_COLOR)     
        _closeButton.buttonDownColor = UIStyleManager.WINDOW_CLOSE_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR)      
		_closeButton.buttonDownColor = UIStyleManager.WINDOW_CLOSE_DISABLE_COLOR;
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
	 * Anything that is added to this sprite goes in back of the window. All objects start at top left hand side of the window.
	 */  
	
	private function get_windowBackDrop() : Sprite 
	{
		return _windowBackDrop; 
	}  
	
	/**
	 * Anything that is added to this sprite goes in front of the window. All objects start at top left hand side of the window.
	 */
	
	private function get_windowFrontOverlay() : Sprite 
	{
		return _windowFrontOverlay; 
	}
	
	
	/**
	 * Return the text label being used
	 */
	private function get_textLabel() : Label 
	{
		return _windowTitle;
    }
	
	/**
	 * Set the width of the Window
	 *
	 * @param value Set the width of the Window
	 *
	 */ 
	
	 #if flash @:getter(width) #else override #end
	private function set_width(value : Float) : Float
	{
		_windowWidth = value;
		draw();
        return value;
    }
	
	/**
	 *
	 * @return Returns the width
	 */
	
	#if flash @:getter(width) #else override #end
	private function get_width() : Float
	{
		return _windowWidth;
    }
	
	/**
	 * Set the height of the Window
	 *
	 * @param value Set the width of the Window
	 *
	 */ 
	
	#if flash @:getter(width) #else override #end
	private function set_height(value : Float) : Float
	{
		_windowHeight = value;
		draw();
		
        return value;
    } 
	
	/**
	 *
	 * @return Returns the height
	 */ 
	
	#if flash @:getter(width) #else override #end
	private function get_height() : Float
	{
		return _windowHeight;
    }
	
	/**
	 * Set the minimize width of the of the Window over all size
	 */
	
	private function set_windowMinWidth(value : Int) : Int 
	{
		_windowWidth = value;draw();
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
		_windowMinHeight = value;draw();
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
	
	/**
	 * Set the close button default color
	 */ 
	private function set_closeButtonNormalColor(value : Int) : Int
	{
		_closeButton.buttonColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */ 
	private function get_closeButtonNormalColor() : Int
	{
		return _closeButton.buttonColor;
    }  
	
	/**
	 * Set the close button over state color
	 */
	
	private function set_closeButtonOverColor(value : Int) : Int 
	{
		_closeButton.buttonOverColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */
	
	private function get_closeButtonOverColor() : Int 
	{
		return _closeButton.buttonOverColor;
    }  
	
	/**
	 * Set the close button down state color
	 */  
	
	private function set_closeButtonDownColor(value : Int) : Int 
	{
		_closeButton.buttonDownColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */
	
	private function get_closeButtonDownColor() : Int 
	{
		return _closeButton.buttonDownColor;
    }
	
	/**
	 * Set the close button disable state color on the button
	 */  
	private function set_closeButtonDisableColor(value : Int) : Int 
	{
		_closeButton.buttonDisableColor = value;
        return value;
    } 
	
	/**
	 * Return the button color
	 */
	private function get_closeButtonDisableColor() : Int
	{
		return _closeButton.buttonDisableColor;
    }
	
	/**
	 * Set the close button unfocus state color.
	 */ 
	
	private function set_closeButtonUnFocusColor(value : Int) : Int
	{
		_closeUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	private function get_closeButtonUnFocusColor() : Int 
	{
		return _closeUnFocusColor;
    } 
	
	/**
	 * Set the minimize button default color
	 */  
	
	private function set_minButtonNormalColor(value : Int) : Int 
	{
		_minButton.buttonColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */ 
	
	private function get_minButtonNormalColor() : Int 
	{
		return _minButton.buttonColor;
    }  
	
	/**
	 * Set the minimize button over state color
	 */  
	
	private function set_minButtonOverColor(value : Int) : Int
	{
		_minButton.buttonOverColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */  
	
	private function get_minButtonOverColor() : Int
	{
		return _minButton.buttonOverColor;
    } 
	
	/**
	 * Return the button color
	 */
	
	private function set_minButtonDownColor(value : Int) : Int 
	{
		_minButton.buttonDownColor = value;
        return value;
    }
	
	/**
	 * Set the minimize button down state color
	 */
	private function get_minButtonDownColor() : Int 
	{
		return _minButton.buttonDownColor;
    }
	
	/**
	 * Set the minimize button disable state color
	 */ 
	private function set_minButtonDisableColor(value : Int) : Int 
	{
		_minButton.buttonDisableColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */ 
	private function get_minButtonDisableColor() : Int 
	{
		return _minButton.buttonDisableColor;
    } 
	
	/**
	 * Set the minimize button unfocus state color.
	 */
	private function set_minButtonUnFocusColor(value : Int) : Int
	{
		_minUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	
	private function get_minButtonUnFocusColor() : Int 
	{
		return _minUnFocusColor;
    } 
	
	/**
	 * Set the maximize button default color
	 */
	
	private function set_maxButtonNormalColor(value : Int) : Int 
	{
		_maxButton.buttonColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */ 
	
	private function get_maxButtonNormalColor() : Int
	{
		return _maxButton.buttonColor;
    }
	
	/**
	 * Set the maximize button over state color
	 */ 
	
	private function set_maxButtonOverColor(value : Int) : Int 
	{
		_maxButton.buttonOverColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */ 
	private function get_maxButtonOverColor() : Int 
	{
		return _maxButton.buttonOverColor;
    }
	
	/**
	 * Set the maximize button down state color
	 */
	private function set_maxButtonDownColor(value : Int) : Int
	{
		_maxButton.buttonDownColor = value;
        return value;
    }
	
	/**
	 * Return the button color
	 */
	
	private function get_maxButtonDownColor() : Int 
	{
		return _maxButton.buttonDownColor;
    }
	
	/**
	 * Set the maximize button disable state color
	 */ 
	
	private function set_maxButtonDisableColor(value : Int) : Int 
	{
		_maxButton.buttonDisableColor = value;
        return value;
    } 
	
	/**
	 * Return the button color
	 */ 
	
	private function get_maxButtonDisableColor() : Int 
	{
		return _maxButton.buttonDisableColor;
    }
	
	/**
	 * Set the maximize button unfocus state color.
	 */
	
	private function set_maxButtonUnFocusColor(value : Int) : Int 
	{
		_maxUnFocusColor = value;
        return value;
    }
	
	/**
	 * Return the button unfocus color
	 */
	private function get_maxButtonUnFocusColor() : Int
	{
		return _maxUnFocusColor;
    }
	
	/**
	 * Hide or Show the close button on the window
	 */  
	
	private function set_showCloseButton(value : Bool) : Bool 
	{
		_showCloseButton = value;draw();
        return value;
    }
	
	/**
	 * Return true if the button is being shown and false if not
	 */ 
	
	private function get_showCloseButton() : Bool 
	{
		return _showCloseButton;
    } 
	
	/**
	 * Hide or Show the minimize button on the window
	 */ 
	
	private function set_showMinButton(value : Bool) : Bool 
	{
		_showMinButton = value;
		draw();
		
        return value;
    } 
	
	/**
	 * Return true if the button is being shown and false if not
	 */ 
	
	private function get_showMinButton() : Bool
	{
		return _showMinButton;
    }
	
	/**
	 * Hide or Show the maximize button on the window
	 */ 
	
	private function set_showMaxButton(value : Bool) : Bool 
	{
		_showMaxButton = value;draw();
        return value;
    }
	
	/**
	 * Return true if the button is being shown and false if not
	 */ 
	
	private function get_showMaxButton() : Bool
	{
		return _showMaxButton;
    }
	
	/**
	 * Enable or disable the close button on the window
	 */
	
	private function set_enabledCloseButton(value : Bool) : Bool
	{
		_enabledCloseButton = value;draw();
        return value;
    }
	
	/**
	 * Return true if the button is being shown and false if not
	 */ 
	
	private function get_enabledCloseButton() : Bool
	{
		return _enabledCloseButton;
    }
	
	/**
	 * Enable or disable the minimize button on the window
	 */
	private function set_enabledMinButton(value : Bool) : Bool 
	{
		_enabledMinButton = value;draw();
        return value;
    }
	
	/**
	 * Return true if the button is being shown and false if not
	 */ 
	
	private function get_enabledMinButton() : Bool 
	{
		return _enabledMinButton;
    }
	
	/**
	 * Enable or disable the maximize button on the window
	 */ 
	private function set_enabledMaxButton(value : Bool) : Bool 
	{
		_enabledMaxButton = value;draw();
        return value;
    }
	
	/**
	 * Return true if the button is being shown and false if not
	 */
	private function get_enabledMaxButton() : Bool
	{
		return _enabledMaxButton;
	}
    
	
	/**
	 * Set the color of the window title area once the user select
	 */
	private function set_windowTitleFocusColor(value : Int) : Int 
	{
		_windowTitleFocusColor = value;draw();
        return value;
	}
	
	/**
	 * Return the color of the window
	 */  
	
	private function get_windowTitleFocusColor() : Int
	{
		return _windowTitleFocusColor;
    }
	
	/**
	 * Set the color of the window title area once it is unfocused
	 */  
	
	private function set_windowTitleUnFocusColor(value : Int) : Int
	{
		_windowTitleUnFocusColor = value;draw();
        return value;
    } 
	
	/**
	 * Return the color of the window title area for it's unfocus state
	 */
	
	private function get_windowTitleUnFocusColor() : Int 
	{
		return _windowTitleUnFocusColor;
    }
	
	/**
	 * Set the color of the window which is
	 */  
	
	private function set_windowFocusColor(value : Int) : Int 
	{
		_windowFocusColor = value;draw();
        return value;
    }
	
	/**
	 * Return the color of the window
	 */
	
	private function get_windowFocusColor() : Int
	{
		return _windowFocusColor;
    }
	
	/**
	 * Set the color of the window once it is unfocused which is everywhere but the title area
	 */
	
	private function set_windowUnFocusColor(value : Int) : Int
	{
		_windowUnFocusColor = value;draw();
        return value;
    }
	
	/**
	 * Return the color of the window for it's unfocus state
	 */ 
	
	private function get_windowUnFocusColor() : Int 
	{
		return _windowUnFocusColor;
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
		_labelLocation = value;draw();
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
	 *
	 * Set a pattern overlay to the top part of the window. This convers the title area of the window.
	 *
	 * @param	imagePattern The left patten
	 * @param	leftMask The mask you want to use
	 * @param	centerMask The mask you want to use
	 * @param	rightMask The mask you want to use
	 *
	 */
	public function setWindowTopPattern(imagePattern : Bitmap, leftMask : DisplayObject, centerMask : DisplayObject, rightMask : DisplayObject) : Void 
	{
		// Putting together mask  
		leftMask.name = "leftMask";
		_windowTopPatternMask.addChild(leftMask);
		
		centerMask.name = "centerMask";
		_windowTopPatternMask.addChild(centerMask);
		
		rightMask.name = "rightMask";
		_windowTopPatternMask.addChild(rightMask); 
		
		// Place the mask on the shape
		_windowTopPattern.mask = _windowTopPatternMask;  
		
		// Set the bitmap
		_imageTopPattern = imagePattern;draw();
    }
	
	/**
	 *
	 * Set a pattern overlay to the center part of the window. If you don't want to apply a mask send a null.
	 *
	 * @param	imagePattern The left patten
	 * @param	leftMask The mask you want to use
	 * @param	rightMask The mask you want to use
	 *
	 */  
	
	public function setWindowMiddlePattern(imagePattern : Bitmap, leftMask : DisplayObject, rightMask : DisplayObject) : Void 
	{
		// Putting together mask  
		leftMask.name = "leftMask";
		_windowMiddlePatternMask.addChild(leftMask);
		
		rightMask.name = "rightMask";
		_windowMiddlePatternMask.addChild(rightMask); 
		
		// Place the mask on the shape 
		_windowMiddlePattern.mask = _windowMiddlePatternMask;  
		
		// Set the bitmap
		_imageMiddlePattern = imagePattern;
		
		draw();
    }  
	
	/**
	 *
	 * Set a pattern overlay to the bottom part of the window. If you don't want to apply a mask send a null.
	 *
	 * @param	imagePattern The left patten
	 * @param	leftMask The mask you want to use
	 * @param	centerMask The mask you want to use
	 * @param	rightMask The mask you want to use
	 *
	 */
	
	public function setWindowBottomPattern(imagePattern : Bitmap, leftMask : DisplayObject, centerMask : DisplayObject, rightMask : DisplayObject) : Void
	{  
		// Putting together mask 
		leftMask.name = "leftMask";
		_windowBottomPatternMask.addChild(leftMask);
		
		centerMask.name = "centerMask";
		_windowBottomPatternMask.addChild(centerMask);
		
		rightMask.name = "rightMask";
		_windowBottomPatternMask.addChild(rightMask); 
		
		// Place the mask on the shape
		_windowBottomPattern.mask = _windowBottomPatternMask;
		
		// Set the bitmap 
		_imageBottomPattern = imagePattern;
		
		draw();
    }
	
	/**
	 * Sets the title of the window
	 *
	 * @param value The name of what you want to set the window to
	 *
	 * @example myWindow.setTitle("My Window");
	 *
	 */  
	
	public function setWindowTitle(value : String) : Void
	{
		
		var titleX : Float = _windowTopMiddle.x;
		var titleY : Float = _windowTopMiddle.y;
		var titleWidth : Float = _windowTopMiddle.width;
		
		var titleHeight : Float = _windowTopMiddle.height;
		
		_windowTitle.textField.autoSize = "left";
		_windowTitle.text = value;
		
		_windowTitle.textField.selectable = false;
    }
	
	
	/**
	 * Return the Window title
	 *
	 * @return Return the text that inside the label
	 *
	 */
	
	public function getWindowTitle() : String 
	{
		return _windowTitle.text;
    }
	
	/**
	 * Set the window icon by using an image based on a bitmap
	 *
	 * @param value The URL to the image you want to use for the icon
	 *
	 * @example myWindow.setIcon("myIcon", "left");
	 *
	 */ 
	public function setIcon(value : String, location : String = "left") : Void 
	{
		// Set location
		iconLocation = location;
		_iconDisplay.load(value);
    }
	
	/**
	 * Set the window icon by using an image based on a URL
	 *
	 * @param value The bitmap you want to use for the icon
	 *
	 * @example myWindow.setIconBitmap("myIcon", "left");
	 *
	 */ 
	public function setIconBitmap(displayBitmap : Bitmap, location : String = "left") : Void 
	{ 
		// Set location
		iconLocation = location;
		_iconDisplay.setImage(displayBitmap);
		
		draw();
    }
	
	/* Setup and draw window on stage */ 
	override public function draw() : Void 
	{ 
		super.draw();  
		// Enable or Disable buttons
		_closeButton.enabled = _enabledCloseButton;
		_minButton.enabled = _enabledMinButton;
		_maxButton.enabled = _enabledMaxButton;
		
		// Set name again
		_closeButton.name = WindowEvent.WINDOW_CLOSE_BTN;
		_minButton.name = WindowEvent.WINDOW_MIN_BTN;
		_maxButton.name = WindowEvent.WINDOW_MAX_BTN;
		
		// Drawing basic squares  
		if (_windowFocus) 
		{
			drawSquareIn(_windowTopLeft, _windowTitleFocusColor, _windowTopLeftSize, _windowTopLeftImage.loaded);
			drawSquareIn(_windowTopMiddle, _windowTitleFocusColor, _windowTopMiddleSize, _windowTopMiddleImage.loaded);
			drawSquareIn(_windowTopRight, _windowTitleFocusColor, _windowTopRightSize, _windowTopRightImage.loaded);drawSquareIn(_windowMiddleLeft, _windowFocusColor, _windowMiddleSize, _windowMiddleLeftImage.loaded);drawSquareIn(_windowMiddleRight, _windowFocusColor, _windowMiddleSize, _windowMiddleRightImage.loaded);drawSquareIn(_windowBottomLeft, _windowFocusColor, _windowBottomLeftSize, _windowBottomLeftImage.loaded);drawSquareIn(_windowBottomMiddle, _windowFocusColor, _windowBottomMiddleSize, _windowBottomMiddleImage.loaded);drawSquareIn(_windowBottomRight, _windowFocusColor, _windowBottomRightSize, _windowBottomRightImage.loaded);
        }
        else 
		{
			drawSquareIn(_windowTopLeft, _windowTitleUnFocusColor, _windowTopLeftSize, _windowTopLeftUnFocusImage.loaded); drawSquareIn(_windowTopMiddle, _windowTitleUnFocusColor, _windowTopMiddleSize, _windowTopMiddleUnFocusImage.loaded); drawSquareIn(_windowTopRight, _windowTitleUnFocusColor, _windowTopRightSize, _windowTopRightUnFocusImage.loaded); drawSquareIn(_windowMiddleLeft, _windowUnFocusColor, _windowMiddleSize, _windowMiddleLeftUnFocusImage.loaded); 
			drawSquareIn(_windowMiddleRight, _windowUnFocusColor, _windowMiddleSize, _windowMiddleRightUnFocusImage.loaded);
			drawSquareIn(_windowBottomLeft, _windowUnFocusColor, _windowBottomLeftSize, _windowBottomLeftUnFocusImage.loaded);drawSquareIn(_windowBottomMiddle, _windowUnFocusColor, _windowBottomMiddleSize, _windowBottomMiddleUnFocusImage.loaded);drawSquareIn(_windowBottomRight, _windowUnFocusColor, _windowBottomRightSize, _windowBottomRightUnFocusImage.loaded);
        }
		
		// Line up square 
		setWindowSize(Std.int(_windowWidth), Std.int(_windowHeight), _windowMinWidth, _windowMinHeight);
		
		applyWindowImage();
    } 
	
	/**
	 * Set the level of detail on the Window. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 * @see com.chaos.ui.UIDetailLevel
	 */ 
	
	override function set_detail(value : String) : String
	{  
		// Set detail settings  
		if (UIDetailLevel.HIGH == value) 
		{
			_showImage = true;
			_smoothImage = true;
        }
        else if (UIDetailLevel.MEDIUM == value) 
		{
			_showImage = true;
			_smoothImage = false;
        }
        else if (UIDetailLevel.LOW == value) 
		{
			_showImage = false;
			_smoothImage = false;
        }
        else 
		{
			_showImage = false;
			_smoothImage = false;
			super.detail = UIDetailLevel.LOW;
        }
		
		super.detail = _maxButton.detail = _minButton.detail = _closeButton.detail = _scrollPane.detail = value;
		
		draw();
		
        return value;
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
	 * This is for setting an image to the close button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	
	public function setCloseButtonImage(value : String) : Void
	{
		_closeButton.setBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the close button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setCloseButtonBitmap(value : Bitmap) : Void 
	{ 
		_closeButton.setBackgroundBitmap(value); 
		
	} 
	
	/**
	 * This is for setting an image to the close button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	public function setCloseOverButtonImage(value : String) : Void
	{
		_closeButton.setOverBackgroundImage(value);
    } 
	
	/**
	 * This is for setting an image to the close button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setCloseOverButtonBitmap(value : Bitmap) : Void
	{
		_closeButton.setOverBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the close button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	public function setCloseDownButtonImage(value : String) : Void
	{
		_closeButton.setDownBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the close button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setCloseDownButtonBitmap(value : Bitmap) : Void
	{
		_closeButton.setDownBackgroundBitmap(value);
    } 
	/**
	 * This is for setting an image to the close button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	public function setCloseDisableButtonImage(value : String) : Void 
	{
		_closeButton.setDisableBackgroundImage(value);
    }
	/**
	 * This is for setting an image to the button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	public function setCloseDisableButtonBitmap(value : Bitmap) : Void
	{
		_closeButton.setDisableBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the minimize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */  
	
	public function setMinButtonImage(value : String) : Void
	{
		_minButton.setBackgroundImage(value);
    } 
	
	/**
	 * This is for setting an image to the minimize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setMinButtonBitmap(value : Bitmap) : Void
	{
		_minButton.setBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the minimize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */  
	
	public function setMinOverButtonImage(value : String) : Void 
	{
		_minButton.setOverBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the minimize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setMinOverButtonBitmap(value : Bitmap) : Void 
	{
		_minButton.setOverBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the minimize button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	
	public function setMinDownButtonImage(value : String) : Void 
	{
		_minButton.setDownBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the minimize button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	
	public function setMinDownButtonBitmap(value : Bitmap) : Void
	{
		_minButton.setDownBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the minimize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	public function setMinDisableButtonImage(value : String) : Void
	{
		_minButton.setDisableBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the minimize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setMinDisableButtonBitmap(value : Bitmap) : Void
	{
		_minButton.setDisableBackgroundBitmap(value);
    }
	/**
	 * This is for setting an image to the maximize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */
	public function setMaxButtonImage(value : String) : Void 
	{
		_maxButton.setBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the maximize button default state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setMaxButtonBitmap(value : Bitmap) : Void 
	{
		_maxButton.setBackgroundBitmap(value);
    }
	
	/**
	 * This is for setting an image to the maximize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	
	public function setMaxOverButtonImage(value : String) : Void
	{
		_maxButton.setOverBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the maximize button roll over state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	public function setMaxOverButtonBitmap(value : Bitmap) : Void
	{
		_maxButton.setOverBackgroundBitmap(value);
    } 
	
	/**
	 * This is for setting an image to the maximize button press down state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	public function setMaxDownButtonImage(value : String) : Void
	{
		_maxButton.setDownBackgroundImage(value);
    } 
	
	/**
	 * This is for setting an image to the maximize button roll press state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setMaxDownButtonBitmap(value : Bitmap) : Void
	{
		_maxButton.setDownBackgroundBitmap(value);
    } 
	
	/**
	 * This is for setting an image to the maximize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a URL file path.
	 *
	 */ 
	public function setMaxDisableButtonImage(value : String) : Void 
	{
		_maxButton.setDisableBackgroundImage(value);
    }
	
	/**
	 * This is for setting an image to the maximize button disable state. It is best to set an image that can be tiled.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	public function setMaxDisableButtonBitmap(value : Bitmap) : Void 
	{
		_maxButton.setDisableBackgroundBitmap(value);
    }
	/**
	 * This set an image to the upper top left corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */ 
	public function setWindowTopLeft(value : String) : Void 
	{
		_windowTopLeftImage.load(value);
    }
	/**
	 * This set an image to the middle of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */ 
	public function setWindowTopMiddle(value : String) : Void 
	{
		_windowTopMiddleImage.load(value);
    } 
	
	/**
	 * This set an image to the upper top right corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */ 
	public function setWindowTopRight(value : String) : Void 
	{
		_windowTopRightImage.load(value);
    }
	
	/**
	 * This set an image to the upper top left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	public function setWindowTopLeftImage(value : Bitmap) : Void 
	{
		_windowTopLeftImage.setImage(value);draw();
    }
	
	/**
	 * This set an image to the middle of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */ 
	public function setWindowTopMiddleImage(value : Bitmap) : Void 
	{
		_windowTopMiddleImage.setImage(value);draw();
    }
	
	/**
	 * This set an image to the upper top right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	public function setWindowTopRightImage(value : Bitmap) : Void
	{
		_windowTopRightImage.setImage(value);draw();
    } 
	
	/**
	 * This set an image to the right side of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */  
	public function setWindowMiddleRight(value : String) : Void 
	{
		_windowMiddleRightImage.load(value);
    }
	/**
	 * This set an image to the left side of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */ 
	public function setWindowMiddleLeft(value : String) : Void
	{
		_windowMiddleLeftImage.load(value);
    }
	
	/**
	 * This set an image to the right side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 *
	 */
	
	public function setWindowMiddleRightImage(value : Bitmap) : Void
	{
		_windowMiddleRightImage.setImage(value);draw();
    }
	
	/**
	 * This set an image to the left side of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 */  
	public function setWindowMiddleLeftImage(value : Bitmap) : Void
	{
		_windowMiddleLeftImage.setImage(value);draw();
    }
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */  
	public function setWindowBottomLeft(value : String) : Void
	{
		_windowBottomLeftImage.load(value);
    }
	
	/**
	 * This set an image to the bottom mid area of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */ 
	public function setWindowBottomMiddle(value : String) : Void 
	{
		_windowBottomMiddleImage.load(value);
    }
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a URL
	 *
	 * @param value The URL path to the image you want to use
	 *
	 */
	public function setWindowBottomRight(value : String) : Void 
	{
		_windowBottomRightImage.load(value);
    }
	
	/**
	 * This set an image to the bottom lower left corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	public function setWindowBottomLeftImage(displayBitmap : Bitmap) : Void 
	{
		_windowBottomLeftImage.setImage(displayBitmap);draw();
    }
	
	/**
	 * This set an image to the bottom mid area of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */  
	public function setWindowBottomMiddleImage(value : Bitmap) : Void 
	{
		_windowBottomMiddleImage.setImage(value);draw();
    }
	
	/**
	 * This set an image to the bottom lower right corner of the window based on a bitmap
	 *
	 * @param value The bitmap image you want to use
	 *
	 */ 
	public function setWindowBottomRightImage(value : Bitmap) : Void 
	{
		_windowBottomRightImage.setImage(value);
		draw();
    }
	
	private function addDrag() : Void
	{
		this.startDrag();
    }
	
	private function removeDrag() : Void 
	{
		this.stopDrag();
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
			
			// Hide or show buttons based on what use set
			_closeButton.visible = _showCloseButton;
			_minButton.visible = _showMinButton;
			_maxButton.visible = _showMaxButton;
			
			// Update button count 
			if (_showCloseButton)   
			buttonCount++;
			
			if (_showMinButton)     
			buttonCount++;
			
			if (_maxButton != null)  
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
		{
			_windowTopRightTexture.x = _windowTopRight.x = inWidth - _windowTopRight.width;
        }
        else 
		{
			_windowTopRightTexture.x = _windowTopRight.x = _windowMinWidth - _windowTopRight.width;
        }
		
		_windowTopRightTexture.y = _windowTopRight.y = _windowTopLeft.y;
		
		_windowTopMiddleTexture.x = _windowTopMiddle.x = _windowTopLeft.x + _windowTopLeft.width;
		_windowTopMiddleTexture.y = _windowTopMiddle.y = _windowTopLeft.y;
		_windowTopMiddle.width = _windowTopRight.x - _windowTopLeft.width;
		
		_windowTitle.height = _windowTopMiddle.height;
		_windowTitle.width = _windowTopMiddle.width - _windowTitle.x;
		_windowTitle.textField.selectable = false;
		
		_windowBottomLeftTexture.x = _windowBottomLeft.x = _windowTopLeft.x;
		
		if (inHeight > _windowMinHeight) 
		{
			_windowBottomLeftTexture.y = _windowBottomLeft.y = inHeight - _windowBottomLeft.height;
        }
        else 
		{
			_windowBottomLeftTexture.y = _windowBottomLeft.y = _windowMinHeight - _windowBottomLeft.height;
        }
		
		if (inWidth > _windowMinWidth) 
		{
			_windowBottomRightTexture.x = _windowBottomRight.x = inWidth - _windowBottomRight.width;
        }
        else 
		{
			_windowBottomRightTexture.x = _windowBottomRight.x = _windowMinWidth - _windowBottomRight.width;
        }
		
		if (inHeight > _windowMinHeight) 
		{
			_windowBottomRightTexture.y = _windowBottomRight.y = inHeight - _windowBottomRight.height;
        }
        else
		{
			_windowBottomRightTexture.y = _windowBottomRight.y = _windowMinHeight - _windowBottomRight.height;
        }
		
		_windowBottomMiddleTexture.x = _windowBottomMiddle.x = _windowBottomLeft.x + _windowBottomLeft.width;
		
		if (inHeight > _windowMinHeight) 
		{
			_windowBottomMiddleTexture.y = _windowBottomMiddle.y = inHeight - _windowBottomMiddle.height;
        }
        else 
		{
			_windowBottomMiddleTexture.y = _windowBottomMiddle.y = _windowMinHeight - _windowBottomMiddle.height;
        }
		
		_windowBottomMiddle.width = _windowBottomRight.x - _windowBottomLeft.width; _windowMiddleLeftTexture.x = _windowMiddleLeft.x = _windowTopLeft.x;
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
			_iconDisplay.x = _windowTopRight.x + WINDOW_ICON_OFFSET_X;_iconDisplay.y = WINDOW_ICON_OFFSET_Y;
        }
        else 
		{
			_iconDisplay.x = WINDOW_ICON_OFFSET_X;_iconDisplay.y = WINDOW_ICON_OFFSET_Y;
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
			_maxButton.x = ((_showMaxButton)) ? (buttonCount - 2) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;_minButton.x = ((_showMinButton)) ? (buttonCount - 1) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
        }
        else 
		{
			_windowButtonArea.x = WINDOW_BUTTON_OFFSET_X;_windowButtonArea.y = WINDOW_BUTTON_OFFSET_Y;_closeButton.x = 0;_minButton.x = 0;_maxButton.x = 0;_minButton.x = ((_showMinButton)) ? (buttonCount - 2) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;_maxButton.x = ((_showMaxButton)) ? (buttonCount - 1) * (WINDOW_BUTTON_SIZE + WINDOW_BUTTON_OFFSET) : 0;
        } 
		
		// Adjust the Title area based on  
		if ("left" == _labelLocation) 
		{  
			//_windowTitle.align = "left"; 
			if (_buttonLocation == "left") 
			{
				_windowTitle.x = _windowButtonArea.x + TEXT_OFFSET_X;
            }
            else if (_iconLocation == "left") 
			{
				_windowTitle.x = _iconDisplay.x + TEXT_OFFSET_X;
            }
        }
        else if ("right" == _labelLocation) 
		{
			//_windowTitle.align = "right"
			if (_buttonLocation == "right") 
			{
				_windowTitle.x = _windowButtonArea.width - TEXT_OFFSET_X;
            }
            else if (_iconLocation == "right")
			{
				_windowTitle.x = _iconDisplay.width - TEXT_OFFSET_X;
            }
        }
        else 
		{
			_windowTitle.x = Std.int(_windowTopMiddle.width / 2);
        }
		
		_windowTitle.y = Std.int((_windowTopMiddle.height / 2) - TEXT_OFFSET_Y); 
		
		// Top  
		if (null != _imageTopPattern) 
		{
			_windowTopPattern.x = _windowTopLeft.x;_windowTopPattern.y = _windowTopLeft.y;
        }
		
		// Mid
		if (null != _imageMiddlePattern) 
		{  
			//_windowMiddlePattern.x = _windowMiddleLeft.x;
			_windowMiddlePattern.y = _windowMiddleLeft.y;
        }
		
		// Bottom 
		if (null != _imageBottomPattern) 
		{ 
			//_windowBottomPattern.x = _windowBottomLeft.x;
			_windowBottomPattern.y = _windowBottomLeft.y;
        }
		
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
	
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The icon you want to set
	 */  
	public function setButtonIcon(buttonName : String, displayObj : DisplayObject) : Void 
	{ 
		if (buttonName == "min") 
		_minButton.setIcon(displayObj);
        else if (buttonName == "max") 
			_maxButton.setIcon(displayObj);
        else if (buttonName == "clse")
			_closeButton.setIcon(displayObj);
    } 
	
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The bitmap that will be used for the icon
	 */  
	public function setButtonIconBitmap(buttonName : String, bitmap : Bitmap) : Void 
	 {
		if (buttonName == "min") 
			_minButton.setIconBitmap(bitmap);
		else if (buttonName == "max") 
			_maxButton.setIconBitmap(bitmap);
		else if (buttonName == "clse") 
			_closeButton.setIconBitmap(bitmap);
	 }
     
	/**
	 * Set the icon on a button
	 *
	 * @param	buttonName The button you want to apply the setting to min, max or close
	 * @param	displayObj The url location of the image file
	 */ 
	
	public function setButtonIconURL(buttonName : String, fileURL : String) : Void 
	{ 
		if (buttonName == "min") 
			_minButton.setIconImage(fileURL);
		else if (buttonName == "max")
			_maxButton.setIconImage(fileURL);
		else if (buttonName == "clse") 
			_closeButton.setIconImage(fileURL);
	}
	
	// Resizes a passed in movie clip to the size of the window's interior 
	private function sizeInsideWindow(inMovie : IBaseUI, inAxis : String = "scaleAll") : Void 
	{ 
		if (inAxis == "scaleX" || inAxis == "scaleAll") 
		{
			var xVal : Int = Std.int(_windowTopLeft.x + _windowTopLeft.width);
			
			if (_windowMiddleLeft.x + _windowMiddleLeft.width < xVal) 
			{
				xVal = Std.int(_windowMiddleLeft.x + _windowMiddleLeft.width);
            }
			
			if (_windowBottomLeft.x + _windowBottomLeft.width < xVal) 
			{
				xVal = Std.int(_windowBottomLeft.x + _windowBottomLeft.width);
            }
			
			inMovie.x = xVal;
			
			var widthVal : Int = Std.int(_windowTopRight.x - inMovie.x);
			
			if (_windowMiddleRight.x - inMovie.x > widthVal) 
			{
				widthVal = Std.int(_windowMiddleRight.x - inMovie.x);
            }
			
			if (_windowBottomRight.x - inMovie.x > widthVal) 
			{
				widthVal = Std.int(_windowBottomRight.x - inMovie.x);
            }
			
			inMovie.width = widthVal;
			
        }
		
		if (inAxis == "scaleY" || inAxis == "scaleAll") 
		{
			var yVal : Int = Std.int(_windowTopLeft.y + _windowTopLeft.height);
			if (_windowTopMiddle.y + _windowTopMiddle.height < yVal) 
			{
				yVal = Std.int(_windowTopMiddle.y + _windowTopMiddle.height);
			}
			if (_windowTopRight.y + _windowTopRight.height < yVal) 
			{
				yVal = Std.int(_windowTopRight.y + _windowTopRight.height);
			}
			
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
	
	// Draws a 20x20 colored squared inside of a movie clip  
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
	
	private function applyWindowImage() : Void{  
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
		var leftMask : DisplayObject;
		var centerMask : DisplayObject;
		var rightMask : DisplayObject;
		
		// Top
		if (null != _imageTopPattern) {textureShape(_windowTopPattern, _windowWidth, _imageTopPattern.bitmapData.height, _imageTopPattern.bitmapData);leftMask = _windowTopPatternMask.getChildByName("leftMask");centerMask = _windowTopPatternMask.getChildByName("centerMask");rightMask = _windowTopPatternMask.getChildByName("rightMask");leftMask.x = _windowTopLeft.x;leftMask.y = _windowTopLeft.y;centerMask.x = _windowTopLeft.x + _windowTopLeft.width;centerMask.y = _windowTopLeft.y;centerMask.width = _windowTopMiddle.width;rightMask.x = _windowTopRight.x;rightMask.y = _windowTopLeft.y;
        }
		
		// Mid 
		if (null != _imageMiddlePattern) {textureShape(_windowMiddlePattern, _windowWidth, _windowMiddleLeft.height, _imageMiddlePattern.bitmapData);leftMask = _windowMiddlePatternMask.getChildByName("leftMask");rightMask = _windowMiddlePatternMask.getChildByName("rightMask");leftMask.x = _windowMiddleLeft.x;leftMask.y = _windowMiddleLeft.y;leftMask.height = _scrollPane.height;rightMask.x = _windowMiddleRight.x;rightMask.y = _windowMiddleRight.y;rightMask.height = _scrollPane.height;
        } 
		
		// Bottom 
		if (null != _imageBottomPattern) 
		{
			textureShape(_windowBottomPattern, _windowWidth, _imageBottomPattern.bitmapData.height, _imageBottomPattern.bitmapData);
			
			leftMask = _windowBottomPatternMask.getChildByName("leftMask");
			centerMask = _windowBottomPatternMask.getChildByName("centerMask");
			rightMask = _windowBottomPatternMask.getChildByName("rightMask");
			
			leftMask.x = _windowBottomLeft.x;
			leftMask.y = _windowBottomLeft.y; centerMask.x = _windowBottomLeft.x + _windowBottomLeft.width;
			centerMask.y = _windowBottomLeft.y;
			
			centerMask.width = _windowBottomMiddle.width;
			rightMask.x = _windowBottomRight.x;
			rightMask.y = _windowBottomRight.y;
        }
		if (_windowFocus) 
		{  // Top Area 
			if (_windowTopLeftImage.loaded && _windowTopLeftSize > 0)       
			textureShape(_windowTopLeftTexture, _windowTopLeft.width, _windowTopLeft.height, _windowTopLeftImage.image.bitmapData);
			
			if (_windowTopMiddleImage.loaded && _windowTopMiddleSize > 0)      
			textureShape(_windowTopMiddleTexture, _windowTopMiddle.width, _windowTopMiddle.height, _windowTopMiddleImage.image.bitmapData);
			
			if (_windowTopRightImage.loaded && _windowTopRightSize > 0)             
			textureShape(_windowTopRightTexture, _windowTopRight.width, _windowTopRight.height, _windowTopRightImage.image.bitmapData);
			
			// Mid Area  
			if (_windowMiddleLeftImage.loaded && _windowMiddleSize > 0)    
			textureShape(_windowMiddleLeftTexture, _windowMiddleLeft.width, _windowMiddleLeft.height, _windowMiddleLeftImage.image.bitmapData);
			
			if (_windowMiddleRightImage.loaded && _windowMiddleSize > 0)    
			textureShape(_windowMiddleRightTexture, _windowMiddleRight.width, _windowMiddleRight.height, _windowMiddleRightImage.image.bitmapData);
			
			// Bottom Area  
			if (_windowBottomLeftImage.loaded && _windowBottomLeftSize > 0)   
			textureShape(_windowBottomLeftTexture, _windowBottomLeft.width, _windowBottomLeft.height, _windowBottomLeftImage.image.bitmapData);
			
			if (_windowBottomMiddleImage.loaded && _windowBottomMiddleSize > 0)        
			textureShape(_windowBottomMiddleTexture, _windowBottomMiddle.width, _windowBottomMiddle.height, _windowBottomMiddleImage.image.bitmapData);
			
			if (_windowBottomRightImage.loaded && _windowBottomRightSize > 0)  
			textureShape(_windowBottomRightTexture, _windowBottomRight.width, _windowBottomRight.height, _windowBottomRightImage.image.bitmapData);
        }
        else 
		{  
			// Top Area  
			if (_windowTopLeftUnFocusImage.loaded && _windowTopLeftSize > 0)    
			textureShape(_windowTopLeftTexture, _windowTopLeft.width, _windowTopLeft.height, _windowTopLeftUnFocusImage.image.bitmapData);
			
			if (_windowTopMiddleUnFocusImage.loaded && _windowTopMiddleSize > 0)       
			textureShape(_windowTopMiddleTexture, _windowTopMiddle.width, _windowTopMiddle.height, _windowTopMiddleUnFocusImage.image.bitmapData);
			
			if (_windowTopRightUnFocusImage.loaded && _windowTopRightSize > 0)         
			textureShape(_windowTopRightTexture, _windowTopRight.width, _windowTopRight.height, _windowTopRightUnFocusImage.image.bitmapData);  
			
			// Mid Area  
			if (_windowMiddleLeftUnFocusImage.loaded && _windowMiddleSize > 0)      
			textureShape(_windowMiddleLeftTexture, _windowMiddleLeft.width, _windowMiddleLeft.height, _windowMiddleLeftUnFocusImage.image.bitmapData);
			
			if (_windowMiddleRightUnFocusImage.loaded && _windowMiddleSize > 0)  
			textureShape(_windowMiddleRightTexture, _windowMiddleRight.width, _windowMiddleRight.height, _windowMiddleRightUnFocusImage.image.bitmapData);
			
			// Bottom Area  
			if (_windowBottomLeftUnFocusImage.loaded && _windowBottomLeftSize > 0)       
			textureShape(_windowBottomLeftTexture, _windowBottomLeft.width, _windowBottomLeft.height, _windowBottomLeftUnFocusImage.image.bitmapData);
			
			if (_windowBottomMiddleUnFocusImage.loaded && _windowBottomMiddleSize > 0)        
			textureShape(_windowBottomMiddleTexture, _windowBottomMiddle.width, _windowBottomMiddle.height, _windowBottomMiddleUnFocusImage.image.bitmapData);
			
			if (_windowBottomRightUnFocusImage.loaded && _windowBottomRightSize > 0)           
			textureShape(_windowBottomRightTexture, _windowBottomRight.width, _windowBottomRight.height, _windowBottomRightUnFocusImage.image.bitmapData);
        }
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
	 * inMovie:MovieClip - The instance name of the MovieClip to stop Dragging
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
	
	private function windowMaxButton(event : Event) : Void { dispatchEvent(new WindowEvent(WindowEvent.WINDOW_MAX_BTN)); }
	
	private function windowTopLeftLoaded(event : Event) : Void
	{
		_blnWindowTopLeft = true;
		draw();
    }
	
	private function windowTopMiddleLoaded(event : Event) : Void
	{
		_blnWindowTopMiddle = true;
		draw();
    }
	
	private function windowTopRightLoaded(event : Event) : Void
	{
		_blnWindowTopRight = true;
		draw();
    }
	
	private function windowMiddleLeftLoaded(event : Event) : Void
	{
		_blnWindowMiddleLeft = true;
		draw();
    }
	
	private function windowMiddleRightLoaded(event : Event) : Void
	{
		_blnWindowMiddleRight = true;
		draw();
    }
	
	private function windowBottomLeftLoaded(event : Event) : Void
	{
		_blnWindowBottomLeft = true;
		draw();
    }
	
	private function windowBottomMiddleLoaded(event : Event) : Void
	{
		_blnWindowBottomMiddle = true;
		draw();
    }
	
	private function windowBottomRightLoaded(event : Event) : Void
	{
		_blnWindowBottomRight = true;
		draw();
    }
	
	private function windowTopLeftUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowTopLeftUnFocus = true;
		draw();
    }
	
	private function windowTopMiddleUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowTopMiddleUnFocus = true;draw();
    }
	
	private function windowTopRightUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowTopRightUnFocus = true;draw();
    }
	
	private function windowMiddleLeftUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowMiddleLeftUnFocus = true;draw();
    }
	
	private function windowMiddleRightUnFocusLoaded(event : Event) : Void
	{
		_blnWindowMiddleRightUnFocus = true;draw();
    }
	
	private function windowBottomLeftUnFocusLoaded(event : Event) : Void
	{
		_blnWindowBottomLeftUnFocus = true;draw();
    }
	
	private function windowBottomMiddleUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowBottomMiddleUnFocus = true;draw();
    }
	
	private function windowBottomRightUnFocusLoaded(event : Event) : Void 
	{
		_blnWindowBottomRightUnFocus = true;draw();
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
			{
				setWindowSize(Std.int(_windowWidth), Std.int(_windowHeight + _windowBottomMiddle.mouseY - _windowBottomMiddle.mouseX));
            }
            else if (_resizeName == "windowMiddleRight") 
			{
				setWindowSize(Std.int(_windowWidth + _windowMiddleRight.mouseX - _windowMiddleRight.mouseY), Std.int(_windowHeight));
            }
            else if (_resizeName == "windowBottomRight") 
			{
				setWindowSize(Std.int(_windowWidth + _windowMiddleRight.mouseX - _windowMiddleRight.mouseY) + BOTTOM_RIGHT_DRAG_OFFSET, Std.int(_windowHeight + _windowBottomMiddle.mouseY - _windowBottomMiddle.mouseX) + BOTTOM_RIGHT_DRAG_OFFSET);
            }
        }
    }
	
	private function windowMouseDown(event : Event) : Void
	{
		_mouseDown = true;
		_resizeName = Std.string(event.target.name);
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
		
		// NOTE: Failsafe - I don't know if this out outside of the Flash window  
		stage.addEventListener(Event.MOUSE_LEAVE, windowMouseUp, false, 0, true);
    }
}