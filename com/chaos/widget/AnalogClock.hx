package com.chaos.widget;


import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.Label;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.utils.ThreadManager;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;

import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;

import com.chaos.media.DisplayImage;

/**
 * AnalogClock Widget
 * @author Erick Feiling
 */

class AnalogClock extends BaseContainer implements IBaseContainer implements IBaseUI
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
    
    private var textField_12 : Label;
    private var textField_3 : Label;
    private var textField_6 : Label;
    private var textField_9 : Label;
    
    private var clockNumberHolder : Sprite = new Sprite();
    
    /** This is the shape on the bottom*/
    public var clockBase : Shape = new Shape();
    
    /** This is the shape on the top that covers the clock hands */
    public var clockOver : Shape = new Shape();
    
    private var _dte_currentDate : Date = Date.now();
    
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
    
    private var _innerDisplayImage : BitmapData;
    
    private var _secondHandDisplayImage : BitmapData;
    private var _minuteHandDisplayImage : BitmapData;
    private var _hourHandDisplayImage : BitmapData;
    
    private var _innerCircleRadius : Int = 15;
    
    private var _lineHourSize : Float = 100;
    private var _lineMinuteSize : Float = 140;
    private var _lineSecondSize : Float = 165;
    
    private var _lineHourThinkness : Float = 12;
    private var _lineMinuteThinkness : Float = 8;
    private var _lineSecondThinkness : Float = 5;
    
    public function new( data:Dynamic = null )
    {
        super(data);
        
        addEventListener(Event.ADDED_TO_STAGE, onAddStage, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage, false, 0, true);
    }
	
	override public function initialize():Void 
	{
		super.initialize();
		
		
		textField_12 = new Label({"name":"12","border":true ,"text":"12", "size":DEFAULT_LABEL_SIZE, "width":DEFAULT_NUMBER_LABEL_WIDTH, "height":DEFAULT_NUMBER_LABEL_HEIGHT});
		textField_3 = new Label({"name":"3", "text":"3", "size":DEFAULT_LABEL_SIZE, "width":DEFAULT_NUMBER_LABEL_WIDTH, "height":DEFAULT_NUMBER_LABEL_HEIGHT});
		textField_6 = new Label({"name":"6", "text":"6", "size":DEFAULT_LABEL_SIZE, "width":DEFAULT_NUMBER_LABEL_WIDTH, "height":DEFAULT_NUMBER_LABEL_HEIGHT});
		textField_9 = new Label({"name":"9", "text":"9", "size":DEFAULT_LABEL_SIZE, "width":DEFAULT_NUMBER_LABEL_WIDTH, "height":DEFAULT_NUMBER_LABEL_HEIGHT});
		
		
        //textField_12.size = textField_3.size = textField_6.size = textField_9.size = DEFAULT_LABEL_SIZE;
        //textField_12.width = textField_3.width = textField_6.width = textField_9.width = DEFAULT_NUMBER_LABEL_WIDTH;
        //textField_12.height = textField_3.height = textField_6.height = textField_9.height = DEFAULT_NUMBER_LABEL_HEIGHT;
        
        //textField_9.textField.autoSize = TextFieldAutoSize.LEFT;
        //textField_3.textField.autoSize = TextFieldAutoSize.RIGHT;
        
        //textField_12.name = textField_12.text = "12";
        //textField_3.name = textField_3.text = "3";
        //textField_6.name = textField_6.text = "6";
        //textField_9.name = textField_9.text = "9";
        
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
		
	}
    
  
    
    /**
	 * The inner circle radius
	 */
    
    private function set_innerCircleRadius(value : Int) : Int
    {
        _innerCircleRadius = value;
        return value;
    }
    
    /**
	 * The circle radius
	 */
    
    private function get_innerCircleRadius() : Int
    {
        return _innerCircleRadius;
    }
    
    /**
	 * Set the line over all thinkness
	 */
    
    private function set_lineHourThinkness(value : Float) : Float
    {
        _lineHourThinkness = value;
        return value;
    }
    
    /**
	 * The size of the line
	 */
    
    private function get_lineHourThinkness() : Float
    {
        return _lineHourThinkness;
    }
    
    /**
	 * Set the line over all thinkness
	 */
    
    private function set_lineMinuteThinkness(value : Float) : Float
    {
        _lineMinuteThinkness = value;
        return value;
    }
    
    /**
	 * The thinkness of the line
	 */
    
    private function get_lineMinuteThinkness() : Float
    {
        return _lineMinuteThinkness;
    }
    
    /**
	 * Set the line over all thinkness
	 */
    
    private function set_lineSecondThinkness(value : Float) : Float
    {
        _lineSecondThinkness = value;
        
        return value;
    }
    
    /**
	 * The thinkness of the line
	 */
    
    private function get_lineSecondThinkness() : Float
    {
        return _lineSecondThinkness;
    }
    
    /**
	 * Set the line over all size
	 */
    
    private function set_lineHourSize(value : Float) : Float
    {
        _lineHourSize = value;
        
        return value;
    }
    
    /**
	 * The size of the line
	 */
    
    private function get_lineHourSize() : Float
    {
        return _lineHourSize;
    }
    
    /**
	 * Set the line over all size
	 */
    
    private function set_lineMinuteSize(value : Float) : Float
    {
        _lineMinuteSize = value;
        
        return value;
    }
    
    /**
	 * The size of the line
	 */
    
    private function get_lineMinuteSize() : Float
    {
        return _lineMinuteSize;
    }
    
    /**
	 * Set the line over all size
	 */
    
    private function set_lineSecondSize(value : Float) : Float
    {
        _lineSecondSize = value;
        
        return value;
    }
    
    /**
	 * The size of the line
	 */
    
    private function get_lineSecondSize() : Float
    {
        return _lineSecondSize;
    }
    
    /**
	 * Show or hide the seconds hand
	 */
	
    private function set_showSecondHand(value : Bool) : Bool
    {
        _showSecondHand = value;
        
        return value;
    }
    
    /**
	 * True if hand is being displayed and false if not
	 */
	
    private function get_showSecondHand() : Bool
    {
        return _showSecondHand;
    }
    
    /**
	 * Show or hide the minute hand
	 */
    
    private function set_showMinuteHand(value : Bool) : Bool
    {
        _showMinuteHand = value;
        draw();
        return value;
    }
    
    /**
	 * True if hand is being displayed and false if not
	 */
    
    private function get_showMinuteHand() : Bool
    {
        return _showMinuteHand;
    }
    
    /**
	 * Show or hide the hour hand
	 */
    
    private function set_showHourHand(value : Bool) : Bool
    {
        _showHourHand = value;
        draw();
        return value;
    }
    
    /**
	 * True if hand is being displayed and false if not
	 */
    
    private function get_showHourHand() : Bool
    {
        return _showHourHand;
    }
    
    /**
	 * Set the color of the seconds hand
	 */
    
    private function set_secondHandColor(value : Int) : Int
    {
        _secondHandColor = value;
        
        return value;
    }
    
    /**
	 * Return the hand color
	 */
    
    private function get_secondHandColor() : Int
    {
        return _secondHandColor;
    }
    
    /**
	 * Set the color of the minute hand
	 */
    
    private function set_minuteHandColor(value : Int) : Int
    {
        _minuteHandColor = value;
        
        return value;
    }
    
    /**
	 * Return the hand color
	 */
    
    private function get_minuteHandColor() : Int
    {
        return _minuteHandColor;
    }
    
    /**
	 * Set the color of the hour hand
	 */
    
    private function set_hourHandColor(value : Int) : Int
    {
        _hourHandColor = value;
        
        return value;
    }
    
    /**
	 * Return the hand color
	 */
    
    private function get_hourHandColor() : Int
    {
        return _hourHandColor;
    }
    
    /**
	 * Use the system clock
	 */
	
    private function set_useSystemClock(value : Bool) : Bool
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
    
    private function get_useSystemClock() : Bool
    {
        return _useSystemClock;
    }
    
    /**
	 * Draws the outer circle of the clock
	 */
    
    private function set_clockOuterCircle(value : Bool) : Bool
    {
        _clockOuterCircle = value;
        return value;
    }
    
    /**
	 * True if outer circle line will be drawn and false if not
	 */
    
    private function get_clockOuterCircle() : Bool
    {
        return _clockOuterCircle;
    }
    
    /**
	 * Draws the inner circle of the clock
	 */
    
    private function set_clockInnerCircle(value : Bool) : Bool
    {
        _clockInnerCircle = value;
        return value;
    }
    
    /**
	 * True if inner circle line will be drawn and false if not
	 */
    
    private function get_clockInnerCircle() : Bool
    {
        return _clockInnerCircle;
    }
    
    /**
	 * Show or hide numbers
	 */
    
    private function set_showNumbers(value : Bool) : Bool
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
    
    private function get_showNumbers() : Bool
    {
        return _showNumbers;
    }
    
    /**
	 * An list with all the number labels,
	 *
	 * @return An array with all the labels being used
	 */
	
    public function getLabels() : Array<ILabel>
    {
        var labelArray : Array<ILabel> = new Array<ILabel>();
        
        labelArray.push(textField_12);
        labelArray.push(textField_3);
        labelArray.push(textField_6);
        labelArray.push(textField_9);
        
        return labelArray;
    }
    
    /**
	 * Set the image for the inner circle
	 * @param	image The display that will be used
	 */
    
    public function setInnerImage(image : BitmapData) : Void
    {
        _innerDisplayImage = image;
    }
    
    
    /**
	 * Set the image for the second hand
	 * @param	image The display that will be used
	 */
    
    public function setSecondHandImage(image : BitmapData) : Void
    {
        _secondHandDisplayImage = image;
    }
    
    
    /**
	 * Set the image for the minute hand
	 * @param	bitmap The display that will be used
	 */
    
    public function setMinuteHandImage(image : BitmapData) : Void
    {
        _minuteHandDisplayImage = image;
    }
    
    /**
	 * Set the image for the hour hand
	 * @param	bitmap The display that will be used
	 */
    
    public function setHourHandImage(image : BitmapData) : Void
    {
        _hourHandDisplayImage = image;
    }
    
    /**
	 * Set the hands on the display. This will only work if the useSystemClock to false.
	 *
	 * @param	hour What the hour hand will be set to
	 * @param	min What the minute hand will be set to
	 * @param	sec What the second hand will be set to
	 */
    
    public function setTime(hour : Int, min : Int, sec : Int) : Void
    {
        
        _dte_currentDate = new Date(Date.now().getFullYear(), Date.now().getMonth(), Date.now().getDay(), hour, min, sec);
        
        updateHand();
    }
    
    override public function draw() : Void
    {
        super.draw();
        
        // Update the location of the text fields
        //textField_12.x = (_width / 2) - (textField_12.width / 2);
        //textField_12.y = 0;
        textField_12.y = 0;
		
        textField_3.x = _width - textField_3.width - NUMBER_LABEL_OFFSET;
        textField_3.y = (_height / 2) - (textField_3.height / 2);
        
        //textField_6.x = (_width / 2) - (textField_6.width / 2);
        //textField_6.y = (_height - textField_6.height) - NUMBER_LABEL_OFFSET;
        textField_6.y = (_height - textField_6.height) - NUMBER_LABEL_OFFSET;
		
        textField_9.x = NUMBER_LABEL_OFFSET;
        textField_9.y = (_height / 2) - (textField_9.height / 2);
        
        // Clear out and draw everything
        clockBase.graphics.clear();
        clockOver.graphics.clear();
        
        // Set the outer display
        clockBase.graphics.lineStyle(_clockOuterLineThinkness, _clockLineOuterColor, _clockOuterLineAlpha);
        
        // Outer circle
        if (_clockOuterCircle) 
            clockBase.graphics.drawCircle(_width / 2, _height / 2, (_width / 2));
        
        drawLine(hourHand, _lineHourSize, _lineHourThinkness, _hourHandColor, _hourHandDisplayImage);
        
        hourHand.x = _width / 2;
        hourHand.y = _height / 2;
        
        hourHand.visible = _showHourHand;
        
        drawLine(minHand, _lineMinuteSize, _lineMinuteThinkness, _minuteHandColor, _minuteHandDisplayImage);
        
        minHand.x = _width / 2;
        minHand.y = _height / 2;
        
        minHand.visible = _showMinuteHand;
        
        drawLine(secHand, _lineSecondSize, _lineSecondThinkness, _secondHandColor, _secondHandDisplayImage);
		
        secHand.x = _width / 2;
        secHand.y = _height / 2;
        
        secHand.visible = _showHourHand;
        
        // Inner circle
        clockOver.graphics.beginFill(_clockInnerColor, _clockInnerAlpha);
        
        if (_innerDisplayImage != null) 
            clockOver.graphics.beginBitmapFill(_innerDisplayImage);
        
        if (_clockInnerCircle) 
            clockOver.graphics.drawCircle(_width / 2, _height / 2, _innerCircleRadius);
        
        clockOver.graphics.endFill();
    }
    
    private function updateClockTimer( data:Dynamic ) : Void
    {
        _dte_currentDate = Date.now();
        
		draw();
        updateHand();
    }
    
    private function drawLine(line : Shape, Length : Float, thickness : Float, color : Int = 0x000000, bitmap : BitmapData = null) : Shape
    {
        line.graphics.clear();
        
        // Even if there isn't a bitmap lineStyle always have to be set
		if (bitmap != null)
			line.graphics.lineBitmapStyle(bitmap);
			
			
		line.graphics.lineStyle(thickness, color);
        line.graphics.lineTo(0, Length - Length - Length);
        
        return line;
    }
    
    private function updateHand() : Void
    {
        num_hour = _dte_currentDate.getHours();
        
        if (num_hour > 12) 
            num_hour -= 12;
        
        hourHand.rotation = (num_hour + (_dte_currentDate.getMinutes() / 60) + (_dte_currentDate.getSeconds() / 3600)) * 30;
        minHand.rotation = (_dte_currentDate.getMinutes() + (_dte_currentDate.getSeconds() / 60)) * 6;
        secHand.rotation = _dte_currentDate.getSeconds() * 6;
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

