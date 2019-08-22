package com.chaos.media.data;
import com.chaos.media.classInterface.ISoundStatus;



/**
 * ...
 * @author Erick Feiling
 */



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
    
    private function set_pause(value : Bool) : Bool
    {
        _pause = value;
        return value;
    }
    
    private function get_pause() : Bool
    {
        return _pause;
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
    
    private function set_stop(value : Bool) : Bool
    {
        _stop = value;
        return value;
    }
    
    private function get_stop() : Bool
    {
        return _stop;
    }
    
    private function set_mute(value : Bool) : Bool
    {
        _mute = value;
        return value;
    }
    
    private function get_mute() : Bool
    {
        return _mute;
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
    
    private function set_isPanning(value : Bool) : Bool
    {
        _isPanning = value;
        return value;
    }
    
    private function get_isPanning() : Bool
    {
        return _isPanning;
    }
    
    private function set_isTracking(value : Bool) : Bool
    {
        _isTracking = value;
        return value;
    }
    
    private function get_isTracking() : Bool
    {
        return _isTracking;
    }
}

