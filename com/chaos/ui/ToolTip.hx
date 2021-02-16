package com.chaos.ui;



import com.chaos.data.DataProvider;
import com.chaos.ui.data.ToolTipData;
import openfl.display.BitmapData;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Point;

import com.chaos.ui.Label;
import com.chaos.ui.Bubble;

import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.BubbleTailLocation;

import com.chaos.utils.Debug;

import openfl.utils.Timer;

import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.Stage;

import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.events.MouseEvent;

import openfl.text.TextFieldAutoSize;

/**
 * Shows a tool-tip on top of a on the stage DisplayObject
 *
 * @author Erick Feiling
 */

class ToolTip
{
	
    
    /** The type of UI Element */
    public static inline var TYPE : String = "ToolTip";
	
	/**
	 * The amount of time in seconds before tool-tip show up
	 */
    public static var delay(get, set) : Int;
	
	/**
	 * Follow user mouse
	 */
    public static var followMouse(get, set) : Bool;
	
	/**
	 * The tool-tip bubble
	 */
    public static var displayObject(get, never) : Bubble;
	
	/**
	 * Label being used for text
	 */
    public static var label(get, never) : Label;
	
	/**
	 * The area for the tool-tip content
	 */
    public static var displayArea(get, set) : DisplayObject;

    
    private static var _followMouse : Bool = true;
    
    private static var _list : DataProvider<ToolTipData>;
    private static var _displayArea : DisplayObject;
    
    private static var _stageWidth : Float = -1;
    private static var _stageHeight : Float = -1;
    
    private static var _label : Label;
    private static var _bubble : Bubble;
    
    private static var _init : Bool = false;
    
    private static var _delay : Int = 0;
    
    private static var _timer : Timer;

    private static var _defaultWidth : Int = 80;
    private static var _defaultHeight : Int = 40;

    private static inline var DEFAULT_TEXT_COLOR : Int = 0;
    private static inline var DEFAULT_BORDER_COLOR : Int = 0;
    private static inline var DEFAULT_BG_COLOR : Int = 0xFFFFFF;

    
    public function new()
    {
        
    }
    
    private static function initialize() : Void
    {
        _list = new DataProvider<ToolTipData>();
        
        _label = new Label();
        _label.textField.multiline = true;
        _label.textField.autoSize = TextFieldAutoSize.LEFT;
        
        _bubble = new Bubble();
        _bubble.rounded = 0;
        _bubble.content.addChild(_label);
        
        _timer = new Timer(_delay);
        _timer.addEventListener(TimerEvent.TIMER, onShowBubble);
        
        initSkin();
        
        _init = true;
    }
    
    private static function initSkin() : Void
    {
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_BACKGROUND)) 
            _bubble.setBackgroundImage(UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_BACKGROUND));
        
        var topLeftImage : BitmapData = null;
        var topMiddleImage : BitmapData = null;
        var topRightImage : BitmapData = null;
        
        var middleLeftImage : BitmapData = null;
        var middleRightImage : BitmapData = null;
        
        var bottomLeftImage : BitmapData = null;
        var bottomMiddleImage : BitmapData = null;
        var bottomRightImage : BitmapData = null;
        
        // Top
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_LEFT)) 
            topLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_MIDDLE)) 
            topMiddleImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_MIDDLE);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_RIGHT)) 
            topRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_TOP_RIGHT);
        
        _bubble.setTopImage(topLeftImage, topMiddleImage, topRightImage);
        
        // Middle
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_MIDDLE_LEFT)) 
            middleLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_MIDDLE_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_MIDDLE_RIGHT)) 
            middleRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_MIDDLE_RIGHT);
        
        _bubble.setMiddleCenterImage(middleLeftImage, middleRightImage);
        
        // Bottom
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_LEFT)) 
            bottomLeftImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_LEFT);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_MIDDLE)) 
            bottomMiddleImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_MIDDLE);
        
        if (null != UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_RIGHT)) 
            bottomRightImage = UIBitmapManager.getUIElement(Bubble.TYPE, UIBitmapManager.TOOLTIP_OVERLAY_BOTTOM_RIGHT);
        
        _bubble.setBottomImage(bottomLeftImage, bottomMiddleImage, bottomRightImage);
    }
    
    
    /**
	 * The amount of time it takes before before showing the ToolTip in milliseconds
	 */
    
    private static function set_delay(value : Int) : Int
    {
        _delay = value;
        return value;
    }
    
    /**
	 * Return the amount of time
	 */
    
    private static function get_delay() : Int
    {
        return _delay;
    }
    
    /**
	 * Tool-Tip will follow the mouse
	 */
    
    private static function set_followMouse(value : Bool) : Bool
    {
        _followMouse = value;
        return value;
    }
    
    /**
	 * If true the Tool-Tip will follow the user mouse
	 */
    
    private static function get_followMouse() : Bool
    {
        return _followMouse;
    }
    
    /**
	 * Return the bubble that is being used for the Tool-Tip
	 */
    
    private static function get_displayObject() : Bubble
    {
        if (!_init) 
            initialize();
        
        return _bubble;
    }
    
    /**
	 * The label being use inside the Tool-Tip
	 */
    private static function get_label() : Label
    {
        if (!_init) 
            initialize();
        
        return _label;
    }
    
    /**
	 * The DisplayObject the Tool-Tip will show up in. If one is not given then it will use the DisplayObject.
	 */
    
    private static function set_displayArea(value : DisplayObject) : DisplayObject
    {
        if (_stageWidth == -1) 
            _stageWidth = value.width;
        
        if (_stageHeight == -1) 
            _stageHeight = value.height;
        
        _displayArea = value;
        return value;
    }
    
    /**
	 * Returns the DisplayObject the tool-tip will be displayed in.
	 */
    
    private static function get_displayArea() : DisplayObject
    {
        return _displayArea;
    }
    
    /**
	 * Set area the tool-tip will be in
	 * @param	newWidth
	 * @param	newHeight
	 */
    
    public static function setToolTipArea(newWidth : Int, newHeight : Int) : Void
    {
        _defaultWidth = newWidth;
        _defaultHeight = newHeight;
    }
    
    /**
	 *
	 * Add events to a DisplayObject to show a tool tip once user rolls mouse over it
	 *
	 * @param	displayObj The object you want to attach the Tool-Tip to
	 * @param	text What you want the tool-tip to say
	 * @param	tipWidth The width of the Tool-Tip
	 * @param	tipHeight The height of the Tool-Tip
	 * @param	textColor The color of the text
	 * @param	backgroundColor The background of the tool tip
	 * @param	border Set to true if you want to use border and false if not. It is false by default
	 * @param	borderColor The color of the border
	 */
    
    public static function attach(displayObj : DisplayObject, text : String, tipWidth : Float = -1, tipHeight : Float = -1, textColor : Int = -1, backgroundColor : Int = -1, border : Bool = false, borderColor : Int = -1) : Void
    {
        // Init class
        if (!_init) 
            initialize();
        

        if (UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_LABEL_TEXT_COLOR) && -1 == textColor) 
            textColor = UIStyleManager.getStyle(UIStyleManager.TOOLTIP_LABEL_TEXT_COLOR);
        else
            textColor = DEFAULT_TEXT_COLOR;

        if(UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BACKGROUND_NORMAL_COLOR) && -1 == backgroundColor)
            backgroundColor = UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BACKGROUND_NORMAL_COLOR);
        else 
            backgroundColor = DEFAULT_BG_COLOR;

        if(UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BORDER_COLOR) && -1 == borderColor)
            borderColor = UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BORDER_COLOR);
        else
            borderColor = DEFAULT_BORDER_COLOR;
        
        if(UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BORDER_COLOR))
            border = UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BORDER);

        _list.addItem(new ToolTipData(displayObj, text, tipWidth, tipHeight, textColor, backgroundColor, border, borderColor));
        
        displayObj.addEventListener(MouseEvent.MOUSE_OUT, onRollOut);
        displayObj.addEventListener(MouseEvent.MOUSE_OVER, onRollOver);
        displayObj.addEventListener(MouseEvent.MOUSE_MOVE, onMouseLocUpdate);
    }
    
    /**
	 * This will show the Tool-Tip in any location on the stage
	 *
	 * @param	text What you want the Tool Tip to say
	 * @param	locX The X location of the Tool Tip
	 * @param	locY The X location of the Tool Tip
	 * @param	tailLocation The location of the tail
	 * @param	tipWidth The width of the Tool Tip
	 * @param	tipHeight The height of the Tool Tip
	 * @param	textColor The color of the text
	 * @param	backgroundColor The background of the tool tip
	 * @param	border If there should be a border around the Tool-Tip
	 * @param	borderColor The border color of its being displayed
	 */
    
    public static function show(text : String, locX : Float, locY : Float, tailLocation : String = "", tipWidth : Float = -1, tipHeight : Float = -1, textColor : Int = -1, backgroundColor : Int = -1, border : Bool = false, borderColor : Int = -1) : Void
    {
        
        // Init class
        if (!_init) 
            initialize();
        
        
        // Reset location
        _label.x = 0;
        _label.y = 0;
        
        _label.text = text;

        var labelPadding : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_LABEL_PADDING) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_LABEL_PADDING) : 0;
        
        if (-1 != tipWidth) 
            _label.width = tipWidth;
        else if (_label.textField.textWidth < _defaultWidth) 
            _label.width = _defaultWidth;
        
        if (-1 != tipHeight) 
            _label.height = tipHeight;
        else if (_label.textField.textHeight < _defaultHeight) 
            _label.height = _defaultHeight;
        
        if ("" != tailLocation) 
            _bubble.tailPlacement = tailLocation;
        
        _bubble.width = _label.width + labelPadding;
        _bubble.height = _label.height + labelPadding;
        
        if (-1 != textColor) 
            _label.textColor = textColor;
        
        if (-1 != borderColor) 
            _bubble.borderColor = borderColor;
        
        _bubble.border = border;
        
        _label.x = (_bubble.width / 2) - (_label.width / 2);
        _label.y = (_bubble.height / 2) - (_label.height / 2);
        
		
        _bubble.x = locX - (_bubble.width / 2);
        _bubble.y = locY - _bubble.height;
        
        if (-1 != backgroundColor) 
            _bubble.backgroundColor = backgroundColor;
        
        if (_bubble.showTail) 
            _bubble.y -= _bubble.tailSize;
        
        
		_label.draw();
		_bubble.draw();
		
        onShowBubble();
    }
    
    /**
	 * Hide the Tool-Tip
	 */
    
    public static function hide() : Void
    {
        if (null != _bubble.parent) 
        {
            
            if (Std.is(_displayArea, MovieClip)) 
                cast((_displayArea), MovieClip).removeChild(_bubble)
            else if (Std.is(_displayArea, Sprite)) 
                cast((_displayArea), Sprite).removeChild(_bubble);
        }
    }
    
    /**
	 * Remove the events from Tool-Tip
	 *
	 * @param	displayObj
	 */
    
    public static function remove(displayObj : DisplayObject) : Void
    {
        
        // Init class
        if (!_init) 
            initialize();
			
		// Remove from list
        removeToolTipFromList(displayObj);
        
        // Remove events
        displayObj.removeEventListener(MouseEvent.MOUSE_OUT, onRollOut);
        displayObj.removeEventListener(MouseEvent.MOUSE_OVER, onRollOver);
        displayObj.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseLocUpdate);
    }
    
    public static function getToolTipData(displayObj : DisplayObject) : ToolTipData
    {
        for (i in 0..._list.length)
		{
            
            var dataObj : ToolTipData = cast(_list.getItemAt(i), ToolTipData);
            
            // Once found remove out of list
            if (dataObj.displayObject == displayObj) 
                return dataObj;
        }
        
        return null;
    }
    
    private static function onRollOver(event : MouseEvent) : Void
    {
        var displayObj : DisplayObject = cast(event.currentTarget, DisplayObject);
        
        prepToolTip(displayObj);
        
        if (_delay <= 0) 
        {
            onShowBubble();
        }
        else 
        {
            _timer.delay = _delay;
            _timer.start();
        }
    }
    
    private static function prepToolTip(displayObj : DisplayObject, placeToolTip : Bool = true) : Void
    {
        var dataObj : ToolTipData;
        
        // Get ToolTip ready
        dataObj = setToolTipFromList(displayObj);
        
        // Reset location
        _label.x = 0;
        _label.y = 0;

        var labelPadding : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_LABEL_PADDING) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_LABEL_PADDING) : 0;
        
        if (-1 != dataObj.width) 
            _label.width = dataObj.width
        else if (_label.textField.textWidth < _defaultWidth) 
            _label.width = _defaultWidth;
        
        // If width is being set but height is not
        if (-1 != dataObj.height) 
            _label.height = dataObj.height
        else if (_label.textField.textHeight < _defaultHeight)
            _label.height = _defaultHeight;
        
        
        // If the height is being set but the width is not
        if (dataObj.width > 0 && dataObj.height <= -1) 
        {
            _label.textField.autoSize = TextFieldAutoSize.LEFT;
            _label.textField.wordWrap = false;
            _label.textField.multiline = true;
        }
        else if (dataObj.height > 0 && dataObj.width <= -1) 
        {
            // Have to turn off auto size off
            _label.textField.autoSize = TextFieldAutoSize.NONE;
            _label.textField.wordWrap = false;
            _label.textField.multiline = true;
        }
        else if (dataObj.width <= -1 && dataObj.height <= -1)  // If both is not being set
        {
            _label.textField.autoSize = TextFieldAutoSize.LEFT;
            
            _label.textField.multiline = false;
            _label.textField.wordWrap = false;
        }
        
        _bubble.width = ((_label.textField.textWidth <= _defaultWidth)) ? _defaultWidth + labelPadding : _label.width + labelPadding;
        _bubble.height = _label.height + labelPadding;
        
        if (-1 != dataObj.textColor) 
            _label.textColor = dataObj.textColor;
        
        // if (-1 != dataObj.borderColor) 
        //     _label.borderColor = dataObj.borderColor;
        
        _bubble.border = dataObj.border;
        _label.x = (_bubble.width / 2) - (_label.width / 2);
        _label.y = (_bubble.height / 2) - (_label.height / 2);
        
        // Checks to see if tool-tip is off screen
        if (placeToolTip) 
            toolTipAlign(displayObj);
        
        if (_bubble.showTail) 
            _bubble.y -= _bubble.tailSize;
			
		_label.draw();
		_bubble.draw();
    }
    
    private static function onRollOut(event : MouseEvent) : Void
    {
        
        if (!_bubble.hitTestPoint(_displayArea.mouseX, _displayArea.mouseY)) 
        {
            // Hide ToolTip
            hide();
            
            // Stop timer
            _timer.stop();
        }
    }
    
    private static function onShowBubble(event : TimerEvent = null) : Void
    {
        if (Std.is(_displayArea, MovieClip)) 
            cast((_displayArea), MovieClip).addChild(_bubble)
        else if (Std.is(_displayArea, Sprite)) 
            cast((_displayArea), Sprite).addChild(_bubble);
    }
    
    private static function setToolTipFromList(displayObj : DisplayObject) : ToolTipData
    {
        // Setup ToolTip
        for (i in 0..._list.length)
		{
            var dataObj : ToolTipData = cast(_list.getItemAt(i), ToolTipData);
            
            if (dataObj.displayObject == displayObj) 
            {
                _label.text = dataObj.text;
                
                if (-1 != dataObj.textColor) 
                    _label.textColor = dataObj.textColor;
                
                if (-1 != dataObj.width) 
                    _bubble.width = dataObj.width;
                
                if (-1 != dataObj.height) 
                    _bubble.height = dataObj.height;
                
                if (-1 != dataObj.backgroundColor) 
                    _bubble.backgroundColor = dataObj.backgroundColor;
                
                if (dataObj.border) 
                    _bubble.border = dataObj.border;
                
                if (-1 != dataObj.borderColor) 
                    _bubble.borderColor = dataObj.borderColor;
                
                return dataObj;
            }
        }
        
        return null;
    }
    
    private static function removeToolTipFromList(displayObj : DisplayObject) : Void
    {
        
        var toolTipData : ToolTipData = getToolTipData(displayObj);
        
        if (null != toolTipData) 
            _list.removeItem(toolTipData);
    }
    
    private static function toolTipAlign(displayObj : DisplayObject) : Void
    {
        
        var bubbleLocX : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_X) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_X) : 0;
        var bubbleLocY : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_Y) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_Y) : 0;

        _bubble.tailPlacement = BubbleTailLocation.BOTTOM;
        
        _bubble.x = _displayArea.mouseX - (_bubble.width / 2) + bubbleLocX;
        _bubble.y = _displayArea.mouseY - _bubble.height + bubbleLocY;
        
        if (_bubble.x < 0) 
            _bubble.x = 0;
        
        if ((_bubble.x + _bubble.width) > _stageWidth) 
            _bubble.x = _stageWidth - _bubble.width;
        
        if (_bubble.y < 0) 
        {
            _bubble.tailPlacement = BubbleTailLocation.TOP;
            _bubble.y = _displayArea.mouseY + (_bubble.height / 2);
        }
        
        if ((_bubble.y + _bubble.height) > _stageHeight) 
        {
            _bubble.tailPlacement = BubbleTailLocation.BOTTOM;
            _bubble.y = _stageHeight - _bubble.height;
        }
    }
    
    private static function onMouseLocUpdate(event : Event) : Void
    {
        if (!_followMouse) 
            return;
        
        var bubbleLocX : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_X) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_X) : 0;
        var bubbleLocY : Int = UIStyleManager.hasStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_Y) ? UIStyleManager.getStyle(UIStyleManager.TOOLTIP_BUBBLE_LOC_Y) : 0;

        _bubble.x = _displayArea.mouseX - (_bubble.width / 2) + bubbleLocX;
        _bubble.y = _displayArea.mouseY - _bubble.height + bubbleLocY;
    }
}

