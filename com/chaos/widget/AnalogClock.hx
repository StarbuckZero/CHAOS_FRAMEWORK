package com.chaos.widget;


import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.ILabel;
import com.chaos.ui.Label;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.Interface.IBaseContainer;
import com.chaos.utils.ThreadManager;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;

import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

import com.chaos.media.DisplayImage;

/**
	 * ...
	 * @author Erick Feiling
	 */

class AnalogClock extends BaseContainer implements IBaseContainer implements com.chaos.ui.classInterface.IBaseUI
{
    public var innerCircleRadius(get, set) : Int;
    public var lineHourThinkness(get, set) : Float;
    public var lineMinuteThinkness(get, set) : Float;
    public var lineSecondThinkness(get, set) : Float;
    public var lineHourSize(get, set) : Float;
    public var lineMinuteSize(get, set) : Float;
    public var lineSecondSize(get, set) : Float;
    public var showSecondHand(get, set) : Bool;
    public var showMinuteHand(get, set) : Bool;
    public var showHourHand(get, set) : Bool;
    public var secondHandColor(get, set) : Int;
    public var minuteHandColor(get, set) : Int;
    public var hourHandColor(get, set) : Int;
    public var useSystemClock(get, set) : Bool;
    public var clockOuterCircle(get, set) : Bool;
    public var clockInnerCircle(get, set) : Bool;
    public var showNumbers(get, set) : Bool;

    /** Default label width */
    public var DEFAULT_NUMBER_LABEL_WIDTH : Int = 55;
    
    /** Default label height */
    public var DEFAULT_NUMBER_LABEL_HEIGHT : Int = 45;
    
    /** Default label size */
    public var DEFAULT_LABEL_SIZE : Int = 35;
    
    /** The default label offset */
    public var NUMBER_LABEL_OFFSET : Int = 10;
    
    public var INNER_CIC_RATE : Int = 15;
    
    /** The hour hand shape */
    public var hourHand : Shape = new Shape();
    
    /** The minute hand shape */
    public var minHand : Shape = new Shape();
    
    /** The seconds hand shape */
    public var secHand : Shape = new Shape();
    
    private var textField_12 : com.chaos.ui.classInterface.ILabel = new Label();
    private var textField_3 : com.chaos.ui.classInterface.ILabel = new Label();
    private var textField_6 : com.chaos.ui.classInterface.ILabel = new Label();
    private var textField_9 : com.chaos.ui.classInterface.ILabel = new Label();
    
    private var clockNumberHolder : Sprite = new Sprite();
    
    /** This is the shape on the bottom*/
    public var clockBase : Shape = new Shape();
    
    /** This is the shape on the top that covers the clock hands */
    public var clockOver : Shape = new Shape();
    
    private var dte_currentDate : Date = Date.now();
    
    private var num_hour : Float;
    
    private var _useSystemClock : Bool = true;
    
    private var _showNumbers : Bool = true;
    
    private var _secondHandColor : Int = 0x000000;
    private var _minuteHandColor : Int = 0x000000;
    private var _hourHandColor : Int = 0x000000;
    
    private var _clockInnerColor : Int = 0x000000;
    private var _clockInnerAlpha : Float = 1;
    
    private var _clockLineOuterColor : Int = 0x000000;
    private var _clockOuterLineThinkness : Int = 15;
    private var _clockOuterLineAlpha : Float = 1;
    
    private var _clockOuterCircle : Bool = true;
    private var _clockInnerCircle : Bool = true;
    
    private var _showSecondHand : Bool = true;
    private var _showMinuteHand : Bool = true;
    private var _showHourHand : Bool = true;
    
    private var innerDisplayImage : DisplayImage = new DisplayImage();
    
    private var secondHandDisplayImage : DisplayImage = new DisplayImage();
    private var minuteHandDisplayImage : DisplayImage = new DisplayImage();
    private var hourHandDisplayImage : DisplayImage = new DisplayImage();
    
    private var _innerCircleRadius : Float = 15;
    
    private var _lineHourSize : Float = 100;
    private var _lineMinuteSize : Float = 140;
    private var _lineSecondSize : Float = 165;
    
    private var _lineHourThinkness : Float = 12;
    private var _lineMinuteThinkness : Float = 8;
    private var _lineSecondThinkness : Float = 5;
    
    public function new()
    {
        super();
        init();
        
        addEventListener(Event.ADDED_TO_STAGE, onAddStage, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage, false, 0, true);
    }
    
    private function init() : Void
    {
        textField_12.size = textField_3.size = textField_6.size = textField_9.size = DEFAULT_LABEL_SIZE;
        textField_12.width = textField_3.width = textField_6.width = textField_9.width = DEFAULT_NUMBER_LABEL_WIDTH;
        textField_12.height = textField_3.height = textField_6.height = textField_9.height = DEFAULT_NUMBER_LABEL_HEIGHT;
        
        textField_9.textField.autoSize = TextFieldAutoSize.LEFT;
        textField_3.textField.autoSize = TextFieldAutoSize.RIGHT;
        
        textField_12.name = textField_12.text = "12";
        textField_3.name = textField_3.text = "3";
        textField_6.name = textField_6.text = "6";
        textField_9.name = textField_9.text = "9";
        
        contentObject.addChild(clockNumberHolder);
        
        clockNumberHolder.addChild(textField_12.displayObject);
        clockNumberHolder.addChild(textField_3.displayObject);
        clockNumberHolder.addChild(textField_6.displayObject);
        clockNumberHolder.addChild(textField_9.displayObject);
        
        contentObject.addChild(clockBase);
        
        contentObject.addChild(hourHand);
        contentObject.addChild(secHand);
        contentObject.addChild(minHand);
        
        contentObject.addChild(clockOver);
        
        draw();
    }
    
    /**
		 * The inner circle radius
		 */
    
    private function set_InnerCircleRadius(value : Int) : Int
    {
        _innerCircleRadius = value;
        return value;
    }
    
    /**
		 * The circle radius
		 */
    
    private function get_InnerCircleRadius() : Int
    {
        return _innerCircleRadius;
    }
    
    /**
		 * Set the line over all thinkness
		 */
    
    private function set_LineHourThinkness(value : Float) : Float
    {
        _lineHourThinkness = value;
        draw();
        return value;
    }
    
    /**
		 * The size of the line
		 */
    
    private function get_LineHourThinkness() : Float
    {
        return _lineHourThinkness;
    }
    
    /**
		 * Set the line over all thinkness
		 */
    
    private function set_LineMinuteThinkness(value : Float) : Float
    {
        _lineMinuteThinkness = value;
        draw();
        return value;
    }
    
    /**
		 * The thinkness of the line
		 */
    
    private function get_LineMinuteThinkness() : Float
    {
        return _lineMinuteThinkness;
    }
    
    /**
		 * Set the line over all thinkness
		 */
    
    private function set_LineSecondThinkness(value : Float) : Float
    {
        _lineSecondThinkness = value;
        draw();
        return value;
    }
    
    /**
		 * The thinkness of the line
		 */
    
    private function get_LineSecondThinkness() : Float
    {
        return _lineSecondThinkness;
    }
    
    /**
		 * Set the line over all size
		 */
    
    private function set_LineHourSize(value : Float) : Float
    {
        _lineHourSize = value;
        draw();
        return value;
    }
    
    /**
		 * The size of the line
		 */
    
    private function get_LineHourSize() : Float
    {
        return _lineHourSize;
    }
    
    /**
		 * Set the line over all size
		 */
    
    private function set_LineMinuteSize(value : Float) : Float
    {
        _lineMinuteSize = value;
        draw();
        return value;
    }
    
    /**
		 * The size of the line
		 */
    
    private function get_LineMinuteSize() : Float
    {
        return _lineMinuteSize;
    }
    
    /**
		 * Set the line over all size
		 */
    
    private function set_LineSecondSize(value : Float) : Float
    {
        _lineSecondSize = value;
        draw();
        return value;
    }
    
    /**
		 * The size of the line
		 */
    
    private function get_LineSecondSize() : Float
    {
        return _lineSecondSize;
    }
    
    /**
		 * Show or hide the seconds hand
		 */
    private function set_ShowSecondHand(value : Bool) : Bool
    {
        _showSecondHand = value;
        draw();
        return value;
    }
    
    /**
		 * True if hand is being displayed and false if not
		 */
    private function get_ShowSecondHand() : Bool
    {
        return _showSecondHand;
    }
    
    /**
		 * Show or hide the minute hand
		 */
    
    private function set_ShowMinuteHand(value : Bool) : Bool
    {
        _showMinuteHand = value;
        draw();
        return value;
    }
    
    /**
		 * True if hand is being displayed and false if not
		 */
    
    private function get_ShowMinuteHand() : Bool
    {
        return _showMinuteHand;
    }
    
    /**
		 * Show or hide the hour hand
		 */
    
    private function set_ShowHourHand(value : Bool) : Bool
    {
        _showHourHand = value;
        draw();
        return value;
    }
    
    /**
		 * True if hand is being displayed and false if not
		 */
    
    private function get_ShowHourHand() : Bool
    {
        return _showHourHand;
    }
    
    /**
		 * Set the color of the seconds hand
		 */
    
    private function set_SecondHandColor(value : Int) : Int
    {
        _secondHandColor = value;
        draw();
        return value;
    }
    
    /**
		 * Return the hand color
		 */
    
    private function get_SecondHandColor() : Int
    {
        return _secondHandColor;
    }
    
    /**
		 * Set the color of the minute hand
		 */
    
    private function set_MinuteHandColor(value : Int) : Int
    {
        _minuteHandColor = value;
        draw();
        return value;
    }
    
    /**
		 * Return the hand color
		 */
    
    private function get_MinuteHandColor() : Int
    {
        return _minuteHandColor;
    }
    
    /**
		 * Set the color of the hour hand
		 */
    
    private function set_HourHandColor(value : Int) : Int
    {
        _hourHandColor = value;
        draw();
        return value;
    }
    
    /**
		 * Return the hand color
		 */
    
    private function get_HourHandColor() : Int
    {
        return _hourHandColor;
    }
    
    /**
		 * Use the system clock
		 */
    private function set_UseSystemClock(value : Bool) : Bool
    {
        _useSystemClock = value;
        
        // Remove it just to be safe
        ThreadManager.removeEventTimer(updateClockTimer);
        
        // Add it back to the thread manager
        if (_useSystemClock) 
            ThreadManager.addEventTimer(updateClockTimer);
        return value;
    }
    
    /**
		 * If true the system clock will be used and if false nothing will update
		 */
    
    private function get_UseSystemClock() : Bool
    {
        return _useSystemClock;
    }
    
    /**
		 * Draws the outer circle of the clock
		 */
    
    private function set_ClockOuterCircle(value : Bool) : Bool
    {
        _clockOuterCircle = value;
        return value;
    }
    
    /**
		 * True if outer circle line will be drawn and false if not
		 */
    
    private function get_ClockOuterCircle() : Bool
    {
        return _clockOuterCircle;
    }
    
    /**
		 * Draws the inner circle of the clock
		 */
    
    private function set_ClockInnerCircle(value : Bool) : Bool
    {
        _clockInnerCircle = value;
        return value;
    }
    
    /**
		 * True if inner circle line will be drawn and false if not
		 */
    
    private function get_ClockInnerCircle() : Bool
    {
        return _clockInnerCircle;
    }
    
    /**
		 * Show or hide numbers
		 */
    
    private function set_ShowNumbers(value : Bool) : Bool
    {
        _showNumbers = value;
        
        if (_showNumbers) 
        {
            clockNumberHolder.addChild(textField_12.displayObject);
            clockNumberHolder.addChild(textField_3.displayObject);
            clockNumberHolder.addChild(textField_6.displayObject);
            clockNumberHolder.addChild(textField_9.displayObject);
        }
        else 
        {
            if (null != textField_12.parent) 
                clockNumberHolder.removeChild(textField_12.displayObject);
            
            if (null != textField_3.parent) 
                clockNumberHolder.removeChild(textField_3.displayObject);
            
            if (null != textField_6.parent) 
                clockNumberHolder.removeChild(textField_6.displayObject);
            
            if (null != textField_9.parent) 
                clockNumberHolder.removeChild(textField_9.displayObject);
        }
        return value;
    }
    
    /**
		 * Return true if there numbers are being displayed and false if not
		 */
    
    private function get_ShowNumbers() : Bool
    {
        return _showNumbers;
    }
    
    /**
		 * An list with all the number labels,
		 *
		 * @return An array with all the labels being used
		 */
    public function getLabels() : Array<Dynamic>
    {
        var labelArray : Array<Dynamic> = new Array<Dynamic>();
        
        labelArray.push(textField_12);
        labelArray.push(textField_3);
        labelArray.push(textField_6);
        labelArray.push(textField_9);
        
        return labelArray;
    }
    
    /**
		 * Set the display image for the inner circle
		 * @param	displayImage The display that will be used
		 */
    
    public function setInnerDisplayImage(displayImage : DisplayImage) : Void
    {
        innerDisplayImage = displayImage;
        draw();
    }
    
    /**
		 * Set the image for the inner circle
		 * @param	bitmap The display that will be used
		 */
    
    public function setInnerImage(bitmap : Bitmap) : Void
    {
        innerDisplayImage.setImage(bitmap);
        draw();
    }
    
    /**
		 * Set the image for the inner circle using a url location
		 * @param	url The path to the image file
		 */
    
    public function setInnerURL(url : String) : Void
    {
        innerDisplayImage.onImageComplete = function() : Void
                {
                    draw();
                    innerDisplayImage.onImageComplete = null;
                };
        
        innerDisplayImage.load(url);
    }
    
    /**
		 * Set the display image for the second hand
		 * @param	displayImage The display that will be used
		 */
    
    public function setSecondHandDisplayImage(displayImage : DisplayImage) : Void
    {
        secondHandDisplayImage = displayImage;
        draw();
    }
    
    /**
		 * Set the image for the second hand
		 * @param	bitmap The display that will be used
		 */
    
    public function setSecondHandImage(bitmap : Bitmap) : Void
    {
        secondHandDisplayImage.setImage(bitmap);
        draw();
    }
    
    /**
		 * Set the image for the second hand using a url location
		 * @param	url The path to the image file
		 */
    
    public function setSecondHandURL(url : String) : Void
    {
        secondHandDisplayImage.onImageComplete = function() : Void
                {
                    draw();
                    secondHandDisplayImage.onImageComplete = null;
                };
        secondHandDisplayImage.load(url);
    }
    
    /**
		 * Set the display image for the minute hand
		 * @param	displayImage The display that will be used
		 */
    
    public function setMinuteHandDisplayImage(displayImage : DisplayImage) : Void
    {
        
        minuteHandDisplayImage = displayImage;
        draw();
    }
    
    /**
		 * Set the image for the minute hand
		 * @param	bitmap The display that will be used
		 */
    
    public function setMinuteHandImage(bitmap : Bitmap) : Void
    {
        minuteHandDisplayImage.setImage(bitmap);
        draw();
    }
    
    /**
		 * Set the image for the minute hand using a url location
		 * @param	url The path to the image file
		 */
    
    public function setMinuteHandURL(url : String) : Void
    {
        minuteHandDisplayImage.onImageComplete = function() : Void
                {
                    draw();
                    minuteHandDisplayImage.onImageComplete = null;
                };
        
        minuteHandDisplayImage.load(url);
    }
    
    /**
		 * Set the display image for the hour hand
		 * @param	displayImage The display that will be used
		 */
    
    public function setHourHandDisplayImage(displayImage : DisplayImage) : Void
    {
        
        hourHandDisplayImage = displayImage;
        draw();
    }
    
    /**
		 * Set the image for the hour hand
		 * @param	bitmap The display that will be used
		 */
    
    public function setHourHandImage(bitmap : Bitmap) : Void
    {
        hourHandDisplayImage.setImage(bitmap);
        draw();
    }
    
    /**
		 * Set the image for the hour hand using a url location
		 * @param	url The path to the image file
		 */
    
    public function setHourHandURL(url : String) : Void
    {
        hourHandDisplayImage.onImageComplete = function() : Void
                {
                    draw();
                    hourHandDisplayImage.onImageComplete = null;
                };
        
        hourHandDisplayImage.load(url);
    }
    
    /**
		 * Set the hands on the display. This will only work if the useSystemClock to false.
		 *
		 * @param	hour What the hour hand will be set to
		 * @param	min What the minute hand will be set to
		 * @param	sec What the second hand will be set to
		 */
    
    public function setTime(hour : Dynamic = null, min : Dynamic = null, sec : Dynamic = null) : Void
    {
        
        dte_currentDate = new Date(null, null, null, hour, min, sec);
        
        updateHand();
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        // Update the location of the text fields
        textField_12.x = (width >> 1) - (textField_12.width >> 1);
        textField_12.y = NUMBER_LABEL_OFFSET;
        
        textField_3.x = width - textField_3.width - NUMBER_LABEL_OFFSET;
        textField_3.y = (height >> 1) - (textField_3.height >> 1);
        
        textField_6.x = (width >> 1) - (textField_6.width >> 1);
        textField_6.y = (height - textField_6.height) - NUMBER_LABEL_OFFSET;
        
        textField_9.x = NUMBER_LABEL_OFFSET;
        textField_9.y = (height >> 1) - (textField_9.height >> 1);
        
        // Clear out and draw everything
        clockBase.graphics.clear();
        clockOver.graphics.clear();
        
        // Set the outer display
        clockBase.graphics.lineStyle(_clockOuterLineThinkness, _clockLineOuterColor, _clockOuterLineAlpha);
        
        // Outer circle
        if (_clockOuterCircle) 
            clockBase.graphics.drawCircle(width >> 1, height >> 1, (width >> 1) - 10);
        
        drawLine(hourHand, _lineHourSize, _lineHourThinkness, _hourHandColor, hourHandDisplayImage.image);
        
        hourHand.x = width >> 1;
        hourHand.y = height >> 1;
        
        hourHand.visible = _showHourHand;
        
        drawLine(minHand, _lineMinuteSize, _lineMinuteThinkness, _minuteHandColor, minuteHandDisplayImage.image);
        
        minHand.x = width >> 1;
        minHand.y = height >> 1;
        
        minHand.visible = _showMinuteHand;
        
        drawLine(secHand, _lineSecondSize, _lineSecondThinkness, _secondHandColor, secondHandDisplayImage.image);
        secHand.x = width >> 1;
        secHand.y = height >> 1;
        
        secHand.visible = _showHourHand;
        
        // Inner circle
        clockOver.graphics.beginFill(_clockInnerColor, _clockInnerAlpha);
        
        if (innerDisplayImage.image != null) 
            clockOver.graphics.beginBitmapFill(innerDisplayImage.image.bitmapData);
        
        if (_clockInnerCircle) 
            clockOver.graphics.drawCircle(width >> 1, height >> 1, _innerCircleRadius);
        
        clockOver.graphics.endFill();
    }
    
    private function updateClockTimer() : Void
    {
        dte_currentDate = Date.now();
        
        updateHand();
    }
    
    private function drawLine(line : Shape, Length : Float, thickness : Float, color : Int = 0x000000, bitmap : Bitmap = null) : Shape
    {
        line.graphics.clear();
        
        // Even if there isn't a bitmap lineStyle alwaysw have to be set
        line.graphics.lineStyle(thickness, color);
        line.graphics.lineTo(0, Length - Length - Length);
        
        return line;
    }
    
    private function updateHand() : Void
    {
        num_hour = dte_currentDate.hours;
        
        if (num_hour > 12) 
            num_hour -= 12;
        
        hourHand.rotation = (num_hour + (dte_currentDate.minutes / 60) + (dte_currentDate.seconds / 3600)) * 30;
        minHand.rotation = (dte_currentDate.minutes + (dte_currentDate.seconds / 60)) * 6;
        secHand.rotation = dte_currentDate.seconds * 6;
    }
    
    private function onAddStage(event : Event) : Void
    {
        ThreadManager.stage = this.stage;
        
        if (_useSystemClock) 
            ThreadManager.addEventTimer(updateClockTimer);
    }
    
    private function onRemoveStage(event : Event) : Void
    {
        ThreadManager.removeEventTimer(updateClockTimer);
    }
}

