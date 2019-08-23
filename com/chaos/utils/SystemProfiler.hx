package com.chaos.utils;



import com.chaos.ui.Label;
import com.chaos.utils.event.SystemProfilerEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextFieldAutoSize;


import flash.system.System;

class SystemProfiler extends Sprite
{
    public var highLevelFPS(get, set) : Int;
    public var midLevelFPS(get, set) : Int;
    public var lowLevelFPS(get, set) : Int;
    public var fpsAndMemLabel(get, never) : Label;
    public var average(get, never) : Float;
    public var fps(get, never) : Float;
    public var memory(get, never) : Float;
    public var level(get, never) : String;

    private var last : Int = Math.round(haxe.Timer.stamp() * 1000);
    private var ticks : Int = 0;
    
    private var _fps : Float = 0;
    private var _average : Float = 0;
    private var _memory : Float = 0;
    
    private var _fpsAndMemLabel : Label;
    
    private var _levelSwitchCoolDown : Int = 3;
    private var coolDownCounter : Int = 0;
    
    private var _highLevelFPS : Int = -1;
    private var _midLevelFPS : Int = -1;
    private var _lowLevelFPS : Int = -1;
    
    private var _level : String = "";
    
    private var averageFrameRateArray : Array<Dynamic>;
    private var averageMax : Int = 60;
    private var averageCounter : Int = 0;
    
    public function new()
    {
        super();
		
        // Get the average frame rate
        averageFrameRateArray = new Array<Dynamic>();
        
        addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
        
        _fpsAndMemLabel = new Label();
        _fpsAndMemLabel.textField.autoSize = TextFieldAutoSize.LEFT;
        _fpsAndMemLabel.width = 200;
        _fpsAndMemLabel.x = 0;
        
		
        addChild(_fpsAndMemLabel);
    }
    
    /**
	 * By setting this an event will dispatch an event when frame hit this
	 */
    
    private function set_highLevelFPS(value : Int) : Int
    {
        _highLevelFPS = value;
        return value;
    }
    
    /**
	 * Return the frame rate count being used
	 */
    
    private function get_highLevelFPS() : Int
    {
        return _highLevelFPS;
    }
    
    /**
	 * By setting this an event will dispatch an event when frame hit this
	 */
    
    private function set_midLevelFPS(value : Int) : Int
    {
        _midLevelFPS = value;
        return value;
    }
    
    /**
	 * Return the frame rate count being used
	 */
    
    private function get_midLevelFPS() : Int
    {
        return _midLevelFPS;
    }
    
    /**
	 * By setting this an event will dispatch an event when frame hit this
	 */
    
    private function set_lowLevelFPS(value : Int) : Int
    {
        _lowLevelFPS = value;
        return value;
    }
    
    /**
	 * Return the frame rate count being used
	 */
    
    private function get_lowLevelFPS() : Int
    {
        return _lowLevelFPS;
    }
    
    /**
	 * A label of with the fps and memory
	 */
    
    private function get_fpsAndMemLabel() : Label
    {
        return _fpsAndMemLabel;
    }
    
    /**
	 * The average frame rate
	 */
    
    private function get_average() : Float
    {
        return _average;
    }
    
    /**
	 * The fps of the current movie
	 */
    
    private function get_fps() : Float
    {
        
        return _fps;
    }
    
    /**
	 * The memory being used by the program
	 */
    
    private function get_memory() : Float
    {
        return _memory;
    }
    
    /**
	 * The current frame rate level setting
	 */
    
    private function get_level() : String
    {
        return _level;
    }
    
    /**
	 * Reset the average when it comes to the frame rate
	 */
    
    public function resetAverage() : Void
    {
        for (i in 0...averageMax - 1)
		{
            if (null != stage) 
                averageFrameRateArray[i] = Std.int(stage.frameRate);
        }
    }
    
    private function tick(evt : Event) : Void
    {
        ticks++;
        
        var now : Int = Math.round(haxe.Timer.stamp() * 1000);
        var delta : Int = now - last;
        
        if (delta >= 1000) 
        {
            var fps : Float = ticks / delta * 1000;
            _fps = fps;
            
            ticks = 0;
            last = now;
            
            // Delay for when event is dispatch between levels
            if (coolDownCounter > 0) 
                coolDownCounter--;
        }
        
        _memory = Math.round(System.totalMemory / 1024 / 1024 * 100) / 100;
        
        // Check to see if item is in slot
        if (null != stage) 
            averageFrameRateArray[averageCounter] = ((null == averageFrameRateArray[averageCounter])) ? Std.int(stage.frameRate) : Std.int(_fps);
        
		
		//trace(averageFrameRateArray.length);
		
        // Update conter  
        averageCounter++;
        
        // Add up everything
        //averageFrameRateArray.every(addValues);
		for (i in 0...averageFrameRateArray.length)
			addValues();
		
		
        
        // If reach max index
        if (averageCounter > averageMax - 1)
            averageCounter = 0;
        
        // Update Memory  
        _fpsAndMemLabel.text = "FPS: " + Std.int(_fps) + " AV: " + Std.int(_average) + " Memory: " + Std.int(System.totalMemory / 1024 / 1024);
    }
    
    private function addValues() : Void
    {
        var total : Int = 0;
        
        // Adding everything up
        for (i in 0...averageFrameRateArray.length)
		{
			if (null != averageFrameRateArray[i])
				total += averageFrameRateArray[i];
			
        }
        
        // Get the average frame rate
        _average = (total / averageMax);
        
        // Display event if average change
        if (_level != SystemProfilerEvent.HIGH && coolDownCounter == 0 && _highLevelFPS != -1 && _average >= _highLevelFPS) 
        {
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.FPS_HIT, SystemProfilerEvent.HIGH));
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.HIGH, SystemProfilerEvent.HIGH));
            
            coolDownCounter = _levelSwitchCoolDown;
            _level = SystemProfilerEvent.HIGH;
        }
        else if (_level != SystemProfilerEvent.MEDIUM && coolDownCounter == 0 && _midLevelFPS != -1 && _average <= _midLevelFPS && _average < (_highLevelFPS - 1)) 
        {
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.FPS_HIT, SystemProfilerEvent.MEDIUM));
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.MEDIUM, SystemProfilerEvent.MEDIUM));
            
            coolDownCounter = _levelSwitchCoolDown;
            
            _level = SystemProfilerEvent.MEDIUM;
        }
        else if (_level != SystemProfilerEvent.LOW && coolDownCounter == 0 && _lowLevelFPS != -1 && _average <= _lowLevelFPS) 
        {
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.FPS_HIT, SystemProfilerEvent.LOW));
            dispatchEvent(new SystemProfilerEvent(SystemProfilerEvent.LOW, SystemProfilerEvent.LOW));
            
            coolDownCounter = _levelSwitchCoolDown;
            _level = SystemProfilerEvent.LOW;
        }
    }
}
