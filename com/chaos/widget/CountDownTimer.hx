package com.chaos.widget;


import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.interface.ILabel;
import com.chaos.ui.Label;
import com.chaos.ui.layout.Interface.IBaseContainer;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.utils.ThreadManager;
import flash.events.Event;

/**
	 * Count's down from a gaven day and time
	 * @author Erick Feiling
	 */

class CountDownTimer extends Label
{
    public var day(get, never) : String;
    public var hour(get, never) : String;
    public var minute(get, never) : String;
    public var second(get, never) : String;

    
    // Stores the current date
    private var today : Date = Date.now();
    
    // Stores the Current Year
    private var currentYear : Dynamic;
    private var currentMonth : Dynamic;
    private var currentSec : Dynamic;
    private var currentMin : Dynamic;
    private var currentHours : Dynamic;
    private var currentDays : Dynamic;
    
    private var secondLeft : String;
    private var minuteLeft : String;
    private var hoursLeft : String;
    private var daysLeft : String;
    
    // Stores the Current Time
    private var currentTime : Float = today.getTime();
    
    // Creates and stores the target date
    private var targetDate : Date = new Date(currentYear, 11, 11);
    private var targetTime : Float = targetDate.getTime();
    
    // Determines how much time is left.  Note: Leaves time in milliseconds
    private var timeLeft : Float = targetTime - currentTime;
    private var sec : Float = Math.floor(timeLeft / 1000);
    private var min : Float = Math.floor(sec / 60);
    private var hours : Float = Math.floor(min / 60);
    private var days : Float = Math.floor(hours / 24);
    
    private var _characterSpacer : String = ":";
    private var _padNumber : Bool = true;
    private var _paddingCharacter : String = "0";
    private var _counterCompleText : String = "";
    
    /**
		 * Creates a count time clock
		 */
    
    public function new(objWidth : Int = 100, objHeight : Int = 30)
    {
        super();
        width = objWidth;
        height = objHeight;
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
    }
    
    override public function init() : Void
    {
        super.init();
        updateCountDisplay();
    }
    
    /**
		 * The amount of days left
		 */
    
    private function get_Day() : String
    {
        return daysLeft;
    }
    
    /**
		 * The amount of hours left
		 */
    
    private function get_Hour() : String
    {
        return hoursLeft;
    }
    
    /**
		 * The amount of mintues left
		 */
    
    private function get_Minute() : String
    {
        return minuteLeft;
    }
    
    /**
		 * The amount of seconds left
		 */
    private function get_Second() : String
    {
        return secondLeft;
    }
    
    /**
		 * @inheritDoc
		 */
    
    override public function draw() : Void
    {
        super.draw();
    }
    
    /**
		 * Set the counter time
		 *
		 * @param	year The year the count time is going to go to
		 * @param	month The month the count time is going to go to
		 * @param	day The day the count time is going to go to
		 * @param	hours The hours the count time is going to go to
		 * @param	minutes The minutes the count time is going to go to
		 * @param	seconds The seconds the count time is going to go to
		 */
    
    public function setCounter(year : Int, month : Int, day : Dynamic = null, hours : Dynamic = null, minutes : Dynamic = null, seconds : Dynamic = null) : Void
    {
        
        currentYear = year;
        currentMonth = month;
        currentDays = day;
        currentHours = hours;
        currentMin = minutes;
        currentSec = seconds;
    }
    
    private function updateCountDisplay() : Void
    {
        today = Date.now();
        targetDate = new Date(currentYear, currentMonth, currentDays, currentHours, currentMin, currentSec);
        
        currentTime = today.getTime();
        targetTime = targetDate.getTime();
        
        timeLeft = targetTime - currentTime;
        sec = Math.floor(timeLeft / 1000);
        min = Math.floor(sec / 60);
        hours = Math.floor(min / 60);
        days = Math.floor(hours / 24);
        
        //Takes results of var remaining value.  Also converts "sec" into a string
        secondLeft = Std.string(sec % 60);
        
        //Once a string, you can check the values length and see whether it has been reduced below 2.
        //If so, add a "0" for visual purposes.
        
        if (secondLeft.length < 2 && _padNumber) 
            secondLeft = _paddingCharacter + Std.string(secondLeft);
        
        minuteLeft = Std.string(min % 60);
        
        if (minuteLeft.length < 2 && _padNumber) 
            minuteLeft = _paddingCharacter + Std.string(minuteLeft);
        
        hoursLeft = Std.string(hours % 24);
        
        if (hoursLeft.length < 2 && _padNumber) 
            hoursLeft = _paddingCharacter + Std.string(hoursLeft);
        
        daysLeft = Std.string(days);
        
        if (timeLeft > 0) 
        {
            //Joins all values into one string value
            var counter : String = "";
            
            counter += daysLeft + _characterSpacer;
            counter += hoursLeft + _characterSpacer;
            counter += minuteLeft;
            counter += _characterSpacer + secondLeft;
            
            text = counter;
        }
        else 
        {
            text = _counterCompleText;
        }
    }
    
    private function onStageAdd(event : Event) : Void
    {
        ThreadManager.stage = stage;
        ThreadManager.addEventTimer(updateCountDisplay);
    }
    
    private function onStageRemove(event : Event) : Void
    {
        ThreadManager.stage = null;
        ThreadManager.removeEventTimer(updateCountDisplay);
    }
}

