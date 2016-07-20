package com.chaos.media.data;



/**
	 * ...
	 * @author Erick Feiling
	 */

import com.chaos.media.Interface.ISoundStatus;

class SoundStatusObject implements ISoundStatus
{
    public var pause(get, set) : Bool;
    public var playing(get, set) : Bool;
    public var stop(get, set) : Bool;
    public var mute(get, set) : Bool;
    public var repeat(get, set) : Bool;
    public var isPanning(get, set) : Bool;
    public var isTracking(get, set) : Bool;

    private var _pause : Bool;
    private var _playing : Bool;
    private var _stop : Bool;
    private var _repeat : Bool;
    private var _mute : Bool;
    
    private var _isPanning : Bool;
    private var _isTracking : Bool;
    
    public function new(soundPause : Bool = false, soundPlaying : Bool = false, soundStop : Bool = false, soundRepeat : Bool = false, soundPanning : Bool = false, soundTracking : Bool = false)
    {
        _pause = soundPause;
        _playing = soundPlaying;
        _stop = soundStop;
        _repeat = soundRepeat;
        
        _isPanning = soundPanning;
        _isTracking = soundTracking;
    }
    
    private function set_Pause(value : Bool) : Bool
    {
        _pause = value;
        return value;
    }
    
    private function get_Pause() : Bool
    {
        return _pause;
    }
    
    private function set_Playing(value : Bool) : Bool
    {
        _playing = value;
        return value;
    }
    
    private function get_Playing() : Bool
    {
        return _playing;
    }
    
    private function set_Stop(value : Bool) : Bool
    {
        _stop = value;
        return value;
    }
    
    private function get_Stop() : Bool
    {
        return _stop;
    }
    
    private function set_Mute(value : Bool) : Bool
    {
        _mute = value;
        return value;
    }
    
    private function get_Mute() : Bool
    {
        return _mute;
    }
    
    private function set_Repeat(value : Bool) : Bool
    {
        _repeat = value;
        return value;
    }
    
    private function get_Repeat() : Bool
    {
        return _repeat;
    }
    
    private function set_IsPanning(value : Bool) : Bool
    {
        _isPanning = value;
        return value;
    }
    
    private function get_IsPanning() : Bool
    {
        return _isPanning;
    }
    
    private function set_IsTracking(value : Bool) : Bool
    {
        _isTracking = value;
        return value;
    }
    
    private function get_IsTracking() : Bool
    {
        return _isTracking;
    }
}

