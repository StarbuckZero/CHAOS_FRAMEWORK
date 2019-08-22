package com.chaos.media.event;

/**
*  For sound events in framework
*
*  @author Erick Feiling
*  @date August 2007
*
*/

import com.chaos.media.data.SoundData;
import openfl.events.Event;

class SoundStatusEvent extends openfl.events.Event
{
    public var soundData(get, never) : SoundData;
    public var status(get, never) : String;
	
	private var _soundData : SoundData;
	private var _status : String;
	
	/** @eventType For whenever sound object start loading */
	public static inline var SOUND_STATUS_PROGRESS : String = "progress";
	
	/** @eventType When id3 data has been loaded */
	public static inline var SOUND_ID3 : String = "id3"; 
	
	/** @eventType Sound has been buffer in sound manager */ 
	public static inline var SOUND_STATUS_BUFFER : String = "buffer";
	
	/** @eventType Once sound is loaded in sound manager */
	public static inline var SOUND_LOADED : String = "sound_loaded";
	
	/** @eventType If there was a problem loading any of the sound objects */ 
	public static inline var SOUND_ERROR : String = "error";
	
	/** @eventType For when sound fade effect has finished in sound manager */
	public static inline var SOUND_FADE_COMPLETE : String = "finish_fade";
	
	public function new(newSoundData : SoundData, soundStatus : String)
    {
		super(soundStatus);
		
		_soundData = newSoundData;
		_status = soundStatus;
    }
	
	private function get_soundData() : SoundData
	{
		return _soundData;
    }
	
	private function get_status() : String
	{
		return _status;
    }
}