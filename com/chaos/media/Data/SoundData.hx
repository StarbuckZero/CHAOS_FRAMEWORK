package com.chaos.media.data;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;
import openfl.media.Sound;
import openfl.media.SoundChannel;

import com.chaos.utils.data.TaskDataObject;

class SoundData
{
    public var soundObj(get, set) : Sound;
    public var soundChannel(get, set) : SoundChannel;
    public var name(get, set) : String;
    public var volume(get, set) : Int;
    public var autoStart(get, set) : Bool;
    public var repeat(get, set) : Bool;
    public var playing(get, set) : Bool;
    public var buffer(get, set) : Bool;
    public var position(get, set) : Float;
    public var panTracking(get, set) : Bool;
    public var soundTracking(get, set) : Bool;
	
    public var panTrackingObj(get, set) : DisplayObject;
    public var soundTrackingObj(get, set) : DisplayObject;
	
    public var muteVolume(get, set) : Int;
	
    public var volTask(get, set) : TaskDataObject;

    private var _soundObj : Sound = null;
    private var _soundChannel : SoundChannel = null;
    private var _name : String = "";
    
    private var _repeat : Bool = false;
    private var _playing : Bool = false;
    private var _buffer : Bool = false;
    
    private var _autoStart : Bool = false;
    private var _soundTracking : Bool = false;
    private var _panTracking : Bool = false;
    
    private var _muteNum : Int = -1;
    
    private var _volNum : Int = 100;
    
    private var _posNum : Float = -1;
    private var _volTask : TaskDataObject;
    
	private var _panTrackingObj:DisplayObject;
	private var _soundTrackingObj:DisplayObject;

    
    public function new()
    {
        
        
    }
    
    private function set_soundObj(value : Sound) : Sound
    {
        _soundObj = value;
        return value;
    }
    
    private function get_soundObj() : Sound
    {
        return _soundObj;
    }
    
    private function set_soundChannel(value : SoundChannel) : SoundChannel
    {
        _soundChannel = value;
        return value;
    }
    
    private function get_soundChannel() : SoundChannel
    {
        return _soundChannel;
    }
    
    private function set_name(value : String) : String
    {
        _name = value;
        return value;
    }
    
    private function get_name() : String
    {
        return _name;
    }
    
    private function set_volume(value : Int) : Int
    {
        _volNum = value;
        return value;
    }
    
    private function get_volume() : Int
    {
        return _volNum;
    }
    
    private function set_autoStart(value : Bool) : Bool
    {
        _autoStart = value;
        return value;
    }
    
    private function get_autoStart() : Bool
    {
        return _autoStart;
    }
    
    private function set_repeat(value : Bool) : Bool
    {
        _repeat = value;
        return value;
    }
    
    private function get_repeat() : Bool
    {
        return _repeat;
    }
    
    private function set_playing(value : Bool) : Bool
    {
        _playing = value;
        return value;
    }
    
    private function get_playing() : Bool
    {
        return _playing;
    }
    
    private function set_buffer(value : Bool) : Bool
    {
        _buffer = value;
        return value;
    }
    
    private function get_buffer() : Bool
    {
        return _buffer;
    }
    
    private function set_position(value : Float) : Float
    {
        _posNum = value;
        return value;
    }
    
    private function get_position() : Float
    {
        return _posNum;
    }
    
    private function set_panTracking(value : Bool) : Bool
    {
        _panTracking = value;
        return value;
    }
    
    private function get_panTracking() : Bool
    {
        return _panTracking;
    }
    
    private function set_soundTracking(value : Bool) : Bool
    {
        _soundTracking = value;
        return value;
    }
    
    private function get_soundTracking() : Bool
    {
        return _soundTracking;
    }
    
    private function set_muteVolume(value : Int) : Int
    {
        _muteNum = value;
        return value;
    }
    
    private function get_muteVolume() : Int
    {
        return _muteNum;
    }
    
    private function set_volTask(value : TaskDataObject) : TaskDataObject
    {
        _volTask = value;
        return value;
    }
    
    private function get_volTask() : TaskDataObject
    {
        return _volTask;
    }
	
	private function set_soundTrackingObj(value:DisplayObject) : DisplayObject
	{
		_soundTrackingObj = value;
		return value;
	}
	
	private function get_soundTrackingObj() : DisplayObject
	{
		return _soundTrackingObj;
	}
	
	
	private function set_panTrackingObj(value:DisplayObject) : DisplayObject
	{
		_panTrackingObj = value;
		return value;
	}
	
	private function get_panTrackingObj() : DisplayObject
	{
		return _panTrackingObj;
	}
    
}

