package com.chaos.media.data;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.media.Sound;
import openfl.media.SoundChannel;

import com.chaos.utils.data.TaskDataObject;

class SoundData
{
    public var soundObj(get, set) : Sound;
    public var soundChannel(get, set) : SoundChannel;
    public var name(get, set) : String;
    public var volNum(get, set) : Int;
    public var autoStart(get, set) : Bool;
    public var repeat(get, set) : Bool;
    public var playing(get, set) : Bool;
    public var buffer(get, set) : Bool;
    public var position(get, set) : Int;
    public var panTracking(get, set) : Bool;
    public var soundTracking(get, set) : Bool;
    public var muteNum(get, set) : Int;
    public var volTask(get, set) : TaskDataObject;
    public var localSoundTrackNum(get, set) : Int;
    public var stageSoundTrackNum(get, set) : Int;
    public var stagePanTrackNum(get, set) : Int;
    public var localPanTrackNum(get, set) : Int;

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
    
    private var _posNum : Int = -1;
    private var _volTask : TaskDataObject;
    
    private var _localSoundTrackNum : Int = -1;
    private var _stageSoundTrackNum : Int = -1;
    private var _stagePanTrackNum : Int = -1;
    private var _localPanTrackNum : Int = -1;
    
    public function new()
    {
        
        
    }
    
    private function set_SoundObj(value : Sound) : Sound
    {
        _soundObj = value;
        return value;
    }
    
    private function get_SoundObj() : Sound
    {
        return _soundObj;
    }
    
    private function set_SoundChannel(value : SoundChannel) : SoundChannel
    {
        _soundChannel = value;
        return value;
    }
    
    private function get_SoundChannel() : SoundChannel
    {
        return _soundChannel;
    }
    
    private function set_Name(value : String) : String
    {
        _name = value;
        return value;
    }
    
    private function get_Name() : String
    {
        return _name;
    }
    
    private function set_VolNum(value : Int) : Int
    {
        _volNum = value;
        return value;
    }
    
    private function get_VolNum() : Int
    {
        return _volNum;
    }
    
    private function set_AutoStart(value : Bool) : Bool
    {
        _autoStart = value;
        return value;
    }
    
    private function get_AutoStart() : Bool
    {
        return _autoStart;
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
    
    private function set_Playing(value : Bool) : Bool
    {
        _playing = value;
        return value;
    }
    
    private function get_Playing() : Bool
    {
        return _playing;
    }
    
    private function set_Buffer(value : Bool) : Bool
    {
        _buffer = value;
        return value;
    }
    
    private function get_Buffer() : Bool
    {
        return _buffer;
    }
    
    private function set_Position(value : Int) : Int
    {
        _posNum = value;
        return value;
    }
    
    private function get_Position() : Int
    {
        return _posNum;
    }
    
    private function set_PanTracking(value : Bool) : Bool
    {
        _panTracking = value;
        return value;
    }
    
    private function get_PanTracking() : Bool
    {
        return _panTracking;
    }
    
    private function set_SoundTracking(value : Bool) : Bool
    {
        _soundTracking = value;
        return value;
    }
    
    private function get_SoundTracking() : Bool
    {
        return _soundTracking;
    }
    
    private function set_MuteNum(value : Int) : Int
    {
        _muteNum = value;
        return value;
    }
    
    private function get_MuteNum() : Int
    {
        return _muteNum;
    }
    
    private function set_VolTask(value : TaskDataObject) : TaskDataObject
    {
        _volTask = value;
        return value;
    }
    
    private function get_VolTask() : TaskDataObject
    {
        return _volTask;
    }
    
    private function set_LocalSoundTrackNum(value : Int) : Int
    {
        _localSoundTrackNum = value;
        return value;
    }
    
    private function get_LocalSoundTrackNum() : Int
    {
        return _localSoundTrackNum;
    }
    
    private function set_StageSoundTrackNum(value : Int) : Int
    {
        _stageSoundTrackNum = value;
        return value;
    }
    
    private function get_StageSoundTrackNum() : Int
    {
        return _stageSoundTrackNum;
    }
    
    private function set_StagePanTrackNum(value : Int) : Int
    {
        _stagePanTrackNum = value;
        return value;
    }
    
    private function get_StagePanTrackNum() : Int
    {
        return _stagePanTrackNum;
    }
    
    private function set_LocalPanTrackNum(value : Int) : Int
    {
        _localPanTrackNum = value;
        return value;
    }
    
    private function get_LocalPanTrackNum() : Int
    {
        return _localPanTrackNum;
    }
}

