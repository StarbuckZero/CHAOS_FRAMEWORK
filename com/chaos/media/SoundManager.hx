/**
 * 2D sound mixing class for sound panning and volume contorl
 * @date August 2007
 * @author Erick Feiling
 *
 */

package com.chaos.media;



import com.chaos.media.data.SoundData;
import com.chaos.media.data.SoundStatusObject;
import com.chaos.media.classInterface.ISoundManager;
import com.chaos.media.classInterface.ISoundStatus;
import com.chaos.utils.data.TaskDataObject;
import com.chaos.utils.classInterface.ITask;
import com.chaos.utils.ThreadManager;
import openfl.events.*;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;
import openfl.net.URLRequest;
import openfl.events.TimerEvent;
import openfl.utils.Timer;
import openfl.display.DisplayObject;

import com.chaos.media.event.SoundStatusEvent;

class SoundManager implements ISoundManager
{
	public static inline var TYPE : String = "SoundManager";	
	
	private static inline var TASKNAME : String = "chaos_soundmanager";
	
	private var _soundObjectHolder : Dynamic;
	private var _loaderHolder : Dynamic;
	
	
	// Show trace in output window 
	private var _soundBufferPercent : Int = 20; 
	
	// Default for loading sound from URL 
	private var _defaultFadeRate : Int = 30; 
	
	// For fading Method
	private var _defaultCrossFadeRate : Int = 80; 
	
	// For timer that is used for crossfade and 
	private var _soundManagerTimerRate : Int = 10;
	
	private var _crossFadeCount : Int = 0; 
	
	// Simple counter for crossfade
	private var _crossFadeItem : String = "";
	
	// Hold the to items that are being faded out 
	private var _crossFadeCallBack : Dynamic->Void;
	
	private var _eventDispatcher : EventDispatcher;  
	
	private var _timer:Timer;
	
	/**
	 * For load and manage sounds
	 *
	 */
	
	public function new()
    {
		// Initialize class
		_soundObjectHolder = {};
		_loaderHolder = {};
		
		ThreadManager.createTaskManager(TASKNAME);
		_eventDispatcher = new EventDispatcher();
		
		
		_timer = new Timer(_soundManagerTimerRate);
		_timer.addEventListener(TimerEvent.TIMER, onTimerUpdate);
		_timer.stop();
		
    }
	
	
	/**
	 *
	 * Places an mp3 into the Sound Manager and set it as the current selected object
	 *
	 * @param strName The name of the sound object.
	 * @param url The location of the mp3 file
	 * @param autoStart Once the sound file is loaded into memory to play it or not.
	 *
	 */ 
	
	public function load(strName : String, url : String, autoStart : Bool = false, repeatSound : Bool = false, muteSound : Bool = false) : Void 
	{  
		// Remove sound object if it's there
		removeSound(strName);
		
		// Create Sound Object to go into an array
		var tempSound : Sound = new Sound();

		
		// Add in events <- Should remove listeners once done loading  
		tempSound.addEventListener(Event.COMPLETE, soundLoaded);  
		
		// Finished Loading MP3 
		tempSound.addEventListener(Event.OPEN, onSoundOpen);  
		
		// Once sound open  
		tempSound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); 
		
		// If MP3 can't load
		tempSound.addEventListener(ProgressEvent.PROGRESS, progressHandler); 
		
		// As the MP3 loads  
		var soundData : SoundData = new SoundData();
		soundData.name = strName;
		soundData.autoStart = autoStart;
		soundData.soundObj = tempSound;
		soundData.soundObj.load(new URLRequest(url));
		soundData.volume = 100;
		
		if (muteSound) 
		soundData.muteVolume = 100;
		
		soundData.repeat = repeatSound; 
		
		// This is for when the sound is loading and it deleted from list once it's done
		Reflect.setField(_loaderHolder, urlNameClean(url), soundData); 
		
		// This is the main list and holder for all sound data objects 
		Reflect.setField(_soundObjectHolder, strName, soundData);
    }
	
	/**
	 * Load a embed sound object into the Sound Mamager. Just make sure the sound is not playing when doing so.
	 *
	 * @param	strName The name of the sound file, this is what is used to keep track of the object
	 * @param	loadSoundObj The sound object itself
	 *
	 */
	
	public function addSoundObject(strName : String, loadSoundObj : Sound) : Void 
	{
		// Remove sound object if it's there
		removeSound(strName);
		
		var soundObject : SoundData = new SoundData();
		soundObject.name = strName;
		soundObject.soundObj = loadSoundObj;
		soundObject.repeat = false;
		soundObject.volume = 100;
		
		Reflect.setField(_soundObjectHolder, strName, soundObject);
    }
	
	/**
	 * Return the sound object that is stored inside the Sound Manger.
	 *
	 * @return The sound object or a null value if the sound wasn't in the Sound Manager or wasn't set.
	 *
	 */  
	
	public function getSoundObj(strName : String) : Sound 
	{ 
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return null;
		
		// Check for sound and return it if found
		return cast(Reflect.field(_soundObjectHolder, strName), SoundData).soundObj;
    }
	
	/**
	 * setBufferPercent - Let's the developer know when the buffer time has been reached
	 *
	 *	@param buffNum: The percentage for the audio files that will be loading.
	 *
	 */
	
	public function setBufferPercent(buffNum : Int = 20) : Void 
	{  
		// Set buffer if nothing is passed then go back to default
		_soundBufferPercent = buffNum;
    }
	
	/**
	 * Change the volume level of the current selected audio item. If the audio is muted the sound won't change.
	 *
	 *	@param soundName This could be the name
	 *	@param volume The volume of the object
	 *
	 *	@return True if the volume was changed was changed and false if it failed.
	 */  
	
	public function setVolume(soundName : String, volume : Int) : Void  
	{   
		var tempObj : SoundData;  
		
		// If passing name and number  
		if (!Reflect.hasField(_soundObjectHolder, soundName))      
			return;
		
		tempObj = cast(Reflect.field(_soundObjectHolder, soundName), SoundData);
		
		// Set current volume 
		tempObj.volume = volume;
		
		if (tempObj.volTask == null && !tempObj.soundTracking && tempObj.soundChannel != null) 
		{  
			// Make sure is not muted 
			if (tempObj.muteVolume == -1) 
				setChannelVolume(volume, tempObj.soundChannel);
        }
    }
	
	/**
	 * Change the volume level of the current selected audio item or you can pass in a name.
	 *
	 * @param strName The name of the sound object.
	 *
	 * @return The current volume level of the sound object the Sound Manager has selected. Returns -1 if couldn't find sound.
	 */ 
	
	public function getVolume(strName : String) : Int 
	{  
		
		// Check to see if anything was pasted 
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return -1;
		
		return Std.int( cast(Reflect.field(_soundObjectHolder, strName), SoundData).soundChannel.soundTransform.volume * 100);
		
    }
	
	/**
	 * Fade out Audio file out and fade out Audio file in at the same time. This will unmute any of the auto files being used.
	 * Note: You can only have two sound objects cross fading at a time.
	 *
	 *	@param strFadeOutName The name of the sound object you want to fade out
	 *	@param strFadeInName The name of the sound object you want to fade in
	 *	@param fadeRate The rate you want the audio files to cross fade.
	 *	@param callBack The function you want to call once the cross fade effect is done
	 * 
	 *	@return True if the effect has been started false if it has failed
	 *
	 */ 
	
	public function crossFade(strFadeOutName : String = "", strFadeInName : String = "", fadeRate : Int = 0, callBack : Dynamic->Void = null) : Bool 
	{
		
		// First make sure both audio files for effect are being passed 
		if (strFadeInName != "" && strFadeOutName != "" &&  _crossFadeCount == 0) 
		{
			var audioRate : Int = 0; 
			
			// Check to see if fade rate was pass
			((fadeRate == 0)) ? audioRate = _defaultCrossFadeRate : audioRate = fadeRate; 
			
			// Start audio if not already playing  
			if (!getStatus(strFadeInName).playing) 
				playSound(strFadeInName);
			
			// Setup fade object to fade in
			setVolume(strFadeInName, 0);
			
			// What's going to be sent once cross fade is done 
			_crossFadeItem = strFadeOutName + "," + strFadeInName; 
			
			// For when callballs are done 
			_crossFadeCallBack = callBack;
			
			// Fade in audio
			fadeTo(strFadeInName, 100, audioRate, crossFadeCallBack); 
			
			// Fade out audio 
			fadeTo(strFadeOutName, 0, audioRate, crossFadeCallBack);
			
			return true;
        }
		
		return false;
    }
	
	/**
	 * Adjust the volume at a rate. This will unmute any of the auto files being used.
	 *
	 *	Note: Flash ActionScript does not support overloading so this is my way.
	 *	I'm using the arguments object when it comes to what's being passed. Information
	 *	on that could be found in the Macromedia help.
	 *
	 *	@param arg1 (String/Number) This could be the name or the volume you just want to set the
	 *	current sound.
	 *
	 *	@param arg2 If you pass in a name for the first argument then you'll have pass the
	 *	volume as the second argument.
	 *
	 *	@param arg4 (Function) All function for when the sound is done
	 *
	 *	@reutrn (Number) True if the volume was changed was changed and false if it failed.
	 *
	 */ 
	
	public function fadeTo(strName : String, fadeToNum : Int, fadeRate : Int = -1, callBack : Dynamic->Void = null) : Void
	{
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		// Kill old timer if there is any
		fadeKill(strName);
		
		if (fadeRate >= 0) 
		fadeRate = _defaultFadeRate;
		
		var currentSoundObj : SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData);
		
		var startVolume : Int = getVolume(currentSoundObj.name); 
		
		// NOTE: Long as the start and end index are different that's when TaskManager is setup to run the same function over again with ITask as first param
		// Don't do anything if the volume and fade to is the same number 
		if (startVolume == fadeToNum)
		return;
		
		// Start timer for fade
		currentSoundObj.muteVolume = -1;
		currentSoundObj.volTask = new TaskDataObject(strName, startVolume, fadeToNum, fadeVolTimer, {"soundData":currentSoundObj} );
		
		ThreadManager.setTimerRate(TASKNAME, fadeRate);
		ThreadManager.addTask(TASKNAME, currentSoundObj.volTask);
		
    } 
	
	/**
	 * Stop fadeTo effect
	 *
	 * @param strName The name of the sound object that has the volume fading effect running
	 *
	 * @return Return True if the item has been stopped and false if it did not find the sound object
	 * or the fadeTo timer was not found.
	 *
	 */  
	public function fadeKill(strName : String) : Bool 
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return false;
		
		var currentSoundObj : SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData); 
		
		// Check to see if anything was pass and if it has timer.  
		if (currentSoundObj.volTask != null) 
		{
			ThreadManager.removeTask(TASKNAME, currentSoundObj.volTask); 
			currentSoundObj.volTask = null;
			
			return true;
        }
		
		return false;
    } 
	
	/**
	 * Change the volume level of the current selected audio item or you can pass in a name
	 *
	 * @param strName The name of the sound object you want to get the percentage from
	 *
	 * @return The percentage of the sound file that is being loaded
	 *
	 */ 
	public function getPercent(strName : String) : Int 
	{	
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return 0;
		
		var sound:Sound = cast(Reflect.field(_soundObjectHolder, strName), SoundData).soundObj;
		
		// Get current volume of new switched media
		return Math.round( sound.bytesLoaded / sound.bytesTotal * 100);
    }
	
	/**
	 *	Returns an array with all the sound object names.
	 *
	 *	@return A list of all the sound objects names as strings.
	 */
	
	public function getList() : Array<String>
	{
		var nameList : Array<String> = new Array<String>();
		
		// Take the name of the object
		for (name in Reflect.fields(_soundObjectHolder))
			nameList.push(name);
		
		return nameList;
    }
	
	/**
	 * Remove sound object out of manager with given name.
	 *
	 * @return True if the object was delete and false if it was not
	 *
	 */ 
	public function removeSound(strName : String) : Bool 
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
		return false;
		
		var soundData : SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData);
		
		// Stop sound from playing 
		if (null != soundData.soundChannel)
			soundData.soundChannel.stop();
		
		// Remove sound loops 
		repeatAudio(soundData.name, false);
		
		// Stop volume timer if there is any 
		if (soundData.volTask != null) 
		{
			ThreadManager.removeTask(TASKNAME, soundData.volTask);
			soundData.volTask = null;
        } 
		
		// Flag as null for GC then delete
		Reflect.setField(_soundObjectHolder, strName, null);
		
		return true;
    }
	
	/**
	 * Stop the sound from playing
	 *
	 * @param strName The sound object that you want to stop based on given name.
	 */
	
	public function stopSound(strName : String) : Void	
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch(e:Dynamic) null;
		
		// Remove any sound events 
		if (null != soundData.soundChannel) 
		{
			soundData.soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundRepeat);
			soundData.soundChannel.stop();
			soundData.soundChannel = null;
        } 
		
		// Remove pause position
		soundData.position = -1;
		soundData.playing = false;
    } 
	
	/**
	 * Play the sound file and sound object
	 *
	 * @param strName The sound object that you want to stop based on given name.
	 *
	 */ 
	public function playSound(strName : String) : Void	
	{  
		// If this is a blank string then nothing  
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		// Check to see if this object has been paused  
		if (soundData.position != -1) 
		{
			soundData.soundChannel = soundData.soundObj.play(soundData.position * 1000);
			soundData.position = -1;
        }
        else // Just play sound 
		{
			
			soundData.soundChannel = soundData.soundObj.play(0);
        }
		
		// Set volume to what the default is  
		setVolume(soundData.name, soundData.volume);  
		
		// Since new sound channel update mute if need be  
		if (soundData.muteVolume != -1)   
			setVolume(soundData.name, 0);
		
		// Setup audio to loop if need be  
		if (soundData.repeat)
			repeatAudio(soundData.name, soundData.repeat);
		
		soundData.playing = true;
    } 
	
	/**
	 * Pause the sound object. Use this method or the playSound method to start the sound again.
	 *
	 * @param strName The sound object that you want to pause based on given name.
	 *
	 */  
	
	public function pauseSound(strName : String) : Void	
	{  

		// If this is a blank string then nothing  
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		// Check to see if this object has been paused already
		if (soundData.position == -1) 
		{
			soundData.position = getPosition(soundData.name);
			soundData.soundChannel.stop();
			soundData.playing = false;
        }
        else 
		{ 
			// Pick up where it left off  
			soundData.soundChannel = soundData.soundObj.play(soundData.position * 1000);
			soundData.playing = true;
			soundData.position = -1;  
			
			// Since new sound channel update mute if need be  
			if (soundData.muteVolume != -1) 
				setVolume(soundData.name, 0);
			
			// Setup audio to loop if need be  
			if (soundData.repeat)
				repeatAudio(soundData.name, soundData.repeat);
        }
    }
	
	/**
	 * Returns the pan integer from -100 (left) to 100 (right).
	 *
	 * @param strName(String): The name of the sound object
	 *
	 * @return The current pan value in the audio file
	 */ 
	
	public function getPan(strName : String) : Float 
	{
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return 0;
		
		var soundData : SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData);
		
		return Std.int(soundData.soundChannel.soundTransform.pan * 100);
    }
	
	/**
	 * Set the pan level from -100 (left) to 100 (right).
	 *
	 * Note: Flash ActionScript does not support overloading so this is my way.
	 * I'm using the arguments object when it comes to what's being passed. Information
	 * on that could be found in the Macromedia help.
	 *
	 * @param strName This could be the name of the object or number you want use for adjusting the current object.
	 *
	 * @param panNumber If you pass in a name for the first argument then you'll have pass the position as the second argument.
	 *
	 * @return True if the audio position was changed and false if it failed.
	 *
	 */
	
	public function setPan(strName : String, panNumber : Float) : Bool	
	{
		
		if (null == Reflect.field(_soundObjectHolder, strName))
		return false;
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch(e:Dynamic) null;
		
		// Make sure none of the pan trackers are running
		if (soundData.panTracking)
			setChannelPan(Std.int(panNumber), soundData.soundChannel);
		
		return true;
    }
	
	/**
	 * Return the current position sound object you have selected or passed
	 *
	 * @param strName The name of the sound object
	 *
	 * @return The current position in the audio file in seconds else just returns null
	 *
	 */  
	
	public function getPosition(strName : String) : Float	
	{
		
		if (null == Reflect.field(_soundObjectHolder, strName)) 
		return -1;
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null;
		
		if (soundData.soundChannel != null)
			return Math.round(soundData.soundChannel.position / 1000);
		
		return -1;
    } 
	
	/**
	 * Set the current position of a given sound object
	 *
	 * @param strName This could be the name of the object
	 *
	 * @param posNum The position
	 *
	 * @return True if the audio position was changed and false if it failed.
	 *
	 */ 
	
	public function setPosition(strName : String, posNum : Float) : Bool 
	{
		
		if (null == Reflect.field(_soundObjectHolder, strName)) 
		return false;
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null;
		
		soundData.soundChannel.stop();
		soundData.soundChannel = soundData.soundObj.play(Math.round(Std.int(posNum) * 1000));
		
		return true;
    }
	
	/**
	 * Return the length of sound object you have selected or passed in seconds
	 *
	 * @param strName The name of the sound object
	 *
	 * @return The current position in the audio file in seconds or else just return null.
	 */
	
	public function getDuration(strName : String) : Float	
	{
		
		if (null == Reflect.field(_soundObjectHolder, strName)) 
		return -1;
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null;
		
		return Math.round(soundData.soundObj.length / 1000);
    }
	
	/**
	 * Return the current location of the sound
	 *
	 * @param	strName The name of the sound
	 *
	 * @return The sound current location formated
	 */  
	
	public function getFormatDuration(strName : String) : String	
	{
		
		if (null == Reflect.field(_soundObjectHolder, strName))
			return "00:00";
		
		var soundData : SoundData = try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null;
		return formatTime(soundData.soundObj.length);
		
    } 
	
	/**
	 * Return the formated time in minute and seconds
	 *
	 * @param	strName The name of the audio file
	 *
	 * @return The time formated in minutes and seconds
	 */
	
	public function getFormatTimeRemaing(strName : String) : String	
	{	
		if (null == Reflect.field(_soundObjectHolder, strName))    
			return "00:00";
		
		var tempSound : Sound = (try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null).soundObj;
		var tempSoundChannel : SoundChannel = (try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch(e:Dynamic) null).soundChannel;
		
		// If sound hasn't been started then just return the length  
		if (tempSoundChannel == null && tempSound != null) 
		return formatTime(tempSound.length);
		
		return formatTime(tempSoundChannel.position);
    }
	
	public function getFormatTimeLeft(strName : String) : String 
	{ 
		if (null == Reflect.field(_soundObjectHolder, strName))  
			return "00:00";
		
		var tempSound : Sound = (try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null).soundObj;
		
		var tempSoundChannel : SoundChannel = (try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null).soundChannel;  
		
		// If sound hasn't been started then just return the length
		if (tempSoundChannel == null && tempSound != null)         
			return formatTime(tempSound.length);
		
		return formatTime(tempSound.length - tempSoundChannel.position);
    } 
	
	/**
	 * Get how much time is left in the sound object based on the current position
	 *
	 * @param strName The name of the sound object return to see how much time is left
	 *
	 * @return The around of time left in the sound object that is paused or playing before its done.
	 *
	 */  
	
	public function timeRemaining(strName : String) : Float
	{	
		if (null == Reflect.field(_soundObjectHolder, strName))  
			return -1;
		
		var tempSound : Sound = (try cast(Reflect.field(_soundObjectHolder, strName), SoundData) catch (e:Dynamic) null).soundObj;
		
		var tempSoundChannel : SoundChannel = cast(Reflect.field(_soundObjectHolder, strName), SoundData).soundChannel; 
		
		// If sound hasn't been started then just return the length  
		if (tempSoundChannel == null && tempSound != null)    
		return Math.round(tempSound.length / 1000);
		
		return Math.round((tempSoundChannel.position / 1000));
    }
	
	/**
	 * Set this to true if you want to have an audio file loop and false to stop it.
	 *
	 * @param strName This could be the name of the audio file you want to have loop or
	 * a true or false value for the current audio file.
	 *
	 * @param loopAudio If you pass in a name for the first argument then you'll have pass a true
	 * or false value for the second one.
	 *
	 * @return  The current position in the audio file in seconds
	 *
	 */ 
	
	public function repeatAudio(strName : String, loopAudio : Bool = false) : Bool	
	{	
		if (null == Reflect.field(_soundObjectHolder, strName)) 
			return false;
		
		var soundChannel : SoundChannel = try cast(Reflect.field(_soundObjectHolder, strName).soundChannel, SoundChannel) catch(e:Dynamic) null;
		
		// If no sound channel 
		if (null == soundChannel)
			return false;
		
		// If the sound is setup to loop then
		if (loopAudio) 
		{
			if (!soundChannel.hasEventListener(Event.SOUND_COMPLETE))
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundRepeat);
        }
        else 
		{
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundRepeat);
        }
		
		
		cast( Reflect.field(_soundObjectHolder, strName), SoundData).repeat = loopAudio;
		
		
		return true;
    } 
	
	/**
	 * Use the width of the target parent movieclip on to adjust the volume.
	 * The sound object starts at 0 and goes to 100 once it reach the center of the stage.
	 *
	 * Note: Using this function disables the setVolume method from being used
	 *
	 * @param strName The name of the sound inside the sound manager
	 *
	 * @param trackerClip: The name of the movie clip you want to track
	 *
	 * @return True if effect has been started false if not
	 *
	 */ 
	
	public function clipSoundTracker(strName : String, trackerClip : DisplayObject) : Bool	
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return false;
		
		var soundData : SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData);
		
		// Making sure both movie clip and sound object has been found 
		if (trackerClip != null) 
		{ 
			// Stop old tracker if there is any
			soundTrackerKill(strName);  
			
			// For status
			soundData.soundTrackingObj = trackerClip;
			soundData.soundTracking = true;
			
			return true;
        }
		
		return false;
    }
	
	/**
	 * Stop stageSoundTracker and clipSoundTracker effect
	 *
	 * @param strName The name of the sound object that has the sound tracking effect running
	 *
	 */
	public function soundTrackerKill(strName : String) : Void
	{	
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		soundData.soundTrackingObj = null;
		soundData.soundTracking = false;
    }
	
	/**
	 * Use the width of the target parent movieclip on to pan from the left to right speaker.
	 * Note: Using this function disables the setPan method from being used for the sound object
	 *
	 * @param strName The name of the sound inside the sound manager
	 * @param trackerClip The name of the movie clip you want to track
	 *
	 * @return True if effect has been started false if not
	 *
	 */
	
	public function clipPanTracker(strName : String, trackerClip : DisplayObject) : Bool	
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return false; 
		
		var soundData:SoundData = cast(Reflect.field(_soundObjectHolder, strName), SoundData);
		
		// Making sure both movie clip and sound object has been found 
		if (trackerClip != null) 
		{  
			// Stop old tracker if there is any
			panTrackerKill(strName); 
			
			// For status
			soundData.panTrackingObj = trackerClip;
			soundData.panTracking = true;
			
			return true;
        }
		
		return false;
    }
	
	/**
	 * Stop stagePanTracker and clipPanTracker effect
	 *
	 * @param strName The name of the sound object that has the sound tracking effect running
	 *
	 */  
	
	public function panTrackerKill(strName : String) : Void	
	{
		
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		soundData.panTracking = false;
    }
	
	/**
	 * An Object with the pause,repeat and play status of a sound object
	 *
	 * @param strName The name of the sound object you want to get the status from
	 *
	 * @return  True if the item has been stopped and false if it did not find the sound object or the fadeTo timer was not found.
	 * Return null if nothing current sound hasn't been set and name wasn't given.
	 *
	 */
	
	public function getStatus(strName : String) : ISoundStatus 
	{  
		// If this is a blank string then nothing  
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return null;
		
		var statusObj : ISoundStatus = new SoundStatusObject(false, false, false, false);
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		// If mute var was set then  
		if (soundData.muteVolume != -1)   
			statusObj.mute = true;
		
		// If pause var is found set pause status to true  
		if (soundData.position != -1) 
			statusObj.pause = true;
		
		// Set play status
		statusObj.playing = soundData.playing;
		
		// Set loop with current repeat variable on clip
		statusObj.repeat = soundData.repeat;
		
		// Setting if being tracked
		statusObj.isTracking = soundData.soundTracking;
		statusObj.isPanning = soundData.panTracking;
		
		return statusObj;
    } 
	
	/**
	 * Mute a given sound, if none was pasted then the current selected sound will be muted.
	 * This will only work on sounds that are playing or have been paused.
	 *
	 * @param	strName The name of the sound object you want to mute.
	 */  
	
	public function muteSound(strName : String) : Void	
	{  
		// If this is a blank string then nothing  
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName);
		
		// If sound channel is null when calling this set mute to 100
		soundData.muteVolume = ((null == soundData.soundChannel)) ? 100 : getVolume(soundData.name);
		setVolume(soundData.name, 0);
    } 
	
	/**
	 * Unmute a given sound, if none was pasted then the current selected sound will be unmute.
	 * This will only work on sounds that are playing or have been paused.
	 *
	 * @param	strName The name of the sound object you want to unmute.
	 */ 
	
	public function unMuteSound(strName : String) : Void	
	{
		
		// If this is a blank string then nothing  
		if (!Reflect.hasField(_soundObjectHolder, strName))
			return;
		
		var soundData : SoundData = Reflect.field(_soundObjectHolder, strName); 
		
		// Alrelady unmuted  
		if (soundData.muteVolume == -1)
			return;
		
		setVolume(soundData.name, soundData.muteVolume);
		soundData.muteVolume = -1;
    }
	
	/**
	 * Mute all sounds that are playing or paused.
	 */  
	public function muteAll() : Void
	{
		for (i in Reflect.fields(_soundObjectHolder))
			muteSound(i);
    }
	
	/**
	 * Unmute all sounds that are playing or paused.
	 */ 
	public function unMuteAll() : Void 
	{
		for (i in Reflect.fields(_soundObjectHolder))
			unMuteSound(i);
    }
	

	
	/**
	 * Format the time in minutes and seconds
	 * @param	time The current sound time on the sound object
	 * @return A formated string
	 *
	 * @example formatTime(channel.position);
	 * @private
	 */  
	
	private function formatTime(time : Float) : String
	{
		var min : String = Std.string(Math.floor(time / 60000));
		var sec : String = ((Math.floor((time / 1000) % 60) < 10)) ? "0" + Std.string(Math.floor((time / 1000) % 60)) : Std.string(Math.floor((time / 1000) % 60));
		
		return (min + ":" + sec);
    }
	
	public function addEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void 
	{
		_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }
	
	public function dispatchEvent(event : Event) : Bool
	{
		return _eventDispatcher.dispatchEvent(event);
    }
	
	public function hasEventListener(type : String) : Bool
	{
		return _eventDispatcher.hasEventListener(type);
    }
	
	public function removeEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false) : Void
	{
		_eventDispatcher.removeEventListener(type, listener, useCapture);
    }
	
	public function willTrigger(type : String) : Bool
	{
		return _eventDispatcher.willTrigger(type);
    } 
	
	/* Private Function */ 
	private function onSoundRepeat(event : Event) : Void 
	{
		var soundChannel : SoundChannel = try cast(event.target, SoundChannel);
		soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundRepeat);
		
		// Loop until find matching sound channel  
		for (i in Reflect.fields(_soundObjectHolder))
		{
			var soundData : SoundData = (try cast(Reflect.field(_soundObjectHolder, i), SoundData) catch (e:Dynamic) null);
			
			if (soundData.soundChannel == soundChannel) 
				playSound(soundData.name);
        }
    }
	
	
	private function onSoundOpen (event : Event)  : Void
	{
		
		var soundData : SoundData = Reflect.field(_loaderHolder, urlNameClean(cast(event.target, Sound).url)); 
		
		// Check for ID3 tags
		soundData.soundObj.addEventListener(Event.ID3, id3Handler); 
		
		// ID3 from MP3  
		soundData.soundObj.removeEventListener(Event.OPEN, onSoundOpen);
	}
		
	private function soundLoaded(event : Event) : Void	
	{
		
		
		// Strip down URL to get name of item 
		var soundData : SoundData = Reflect.field(_loaderHolder, urlNameClean(cast(event.target, Sound).url)); 
		
		// Started loading sound 
		dispatchEvent(new SoundStatusEvent(soundData, SoundStatusEvent.SOUND_LOADED));
		
		// Removing listeners now that loading is done 
		soundData.soundObj.removeEventListener(Event.COMPLETE, soundLoaded);
		
		// Finished Loading MP3  
		soundData.soundObj.removeEventListener(Event.ID3, id3Handler);
		
		// ID3 from MP3
		soundData.soundObj.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); 
		
		// If MP3 can't load 
		soundData.soundObj.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
		
		// As the MP3 loads  This is an intentional compilation error. See the README for handling the delete keyword
        Reflect.deleteField(_loaderHolder, urlNameClean(soundData.soundObj.url));
    }
	
	private function id3Handler(event : Event) : Void	
	{
		
		// Get Sound Object out of array
		var soundData : SoundData = Reflect.field(_loaderHolder, urlNameClean( cast(event.target, Sound).url ));
		
		// For MP3 id3 infomation being passed 
		dispatchEvent(new SoundStatusEvent(soundData, SoundStatusEvent.SOUND_ID3));
    }
	
	private function ioErrorHandler(event : Event) : Void	
	{  
		// Strip down URL to get name of item 
		var soundStr : String = cast(event.target, Sound).url;
		
		// Get Sound Object out of array
		var soundData : SoundData = cast(Reflect.field(_loaderHolder, urlNameClean(soundStr)), SoundData);
		
		// For load error message  
		dispatchEvent(new SoundStatusEvent(soundData, SoundStatusEvent.SOUND_ERROR));
    }
	
	private function progressHandler(event : ProgressEvent) : Void
	{
		var soundStr : String = cast(event.target, Sound).url;
		var tempSoundObj : SoundData = Reflect.field(_loaderHolder, urlNameClean(soundStr));
		
		var percentNum : Int = Math.round(event.bytesLoaded / event.bytesTotal * 100);
		
		// Send out Event only when buffer is reached for the first time 
		if (percentNum >= _soundBufferPercent && null != tempSoundObj && tempSoundObj.buffer == false) 
		{
			tempSoundObj.buffer = true; 
			
			// Start sound if  
			if (tempSoundObj.autoStart) 
				playSound(tempSoundObj.name);
			
			// For Event for buffer status  
			dispatchEvent(new SoundStatusEvent(tempSoundObj, SoundStatusEvent.SOUND_STATUS_BUFFER));
        }
		
		// For Event for progress of data status 
		dispatchEvent(new SoundStatusEvent(tempSoundObj, SoundStatusEvent.SOUND_STATUS_PROGRESS));
    }
	
	private function crossFadeCallBack(strName : String) : Void	
	{
		_crossFadeCount++;
		
		if (_crossFadeCount == 2) 
		{
			_crossFadeCount = 0;
			
			var tempArray : Array<Dynamic> = _crossFadeItem.split(",");
			
			setVolume(tempArray[0], 100);
			stopSound(tempArray[0]);
			
			//_crossFadeCallBack(_crossFadeItem);
			_crossFadeCallBack = null;
			_crossFadeItem = "";
        }
    }
	
	private function convertName(strName : String = "") : String
	{	
		if (strName == "")
			return "";
		
		// Check to see if string has .mp3
		if (strName.indexOf(".mp3") != -1)
			return strName.substring(0, strName.indexOf(".mp3")).toLowerCase();
		
		return strName.toLowerCase();
    }
	
	private function urlNameClean(strURL : String) : String
	{
		
		strURL = StringTools.htmlUnescape(strURL).toLowerCase();
		var i:Int = strURL.length;
		
		// Loop backwards until forward slash is found  var i : Int = strURL.length;
        while (i >= 0)
		{
			if (strURL.charAt(i) == "/") 
			{
				strURL = strURL.substring((i + 1), strURL.indexOf(".mp3"));
				break;
            }
			
            i--;
        }
		
		return convertName(strURL);
    }
	
	private function setChannelVolume(volInt : Int, volSoundChannel : SoundChannel) : Bool	
	{
		
		if (null == volSoundChannel) 
		return false;
		
		if (volInt >= 0 && volInt <= 100) 
		{
			var tempSoundTransform : SoundTransform = new SoundTransform();
			tempSoundTransform.volume = (.010 * volInt);  
			
			// Break down value for volume contorls 
			tempSoundTransform.pan = volSoundChannel.soundTransform.pan;
			
			// Make sure it keeps old pan settings
			volSoundChannel.soundTransform = tempSoundTransform; 
			
			// Apply new Sound Transform
			return true;
        }
		
		return false;
    }
	
	private function setChannelPan(panInt : Int, panSoundChannel : SoundChannel) : Bool
	{
		if (panSoundChannel == null)
			return false;
		
		if (panInt >= -100 && panInt <= 100) 
		{
			var tempSoundTransform : SoundTransform = new SoundTransform();
			tempSoundTransform.pan = (.01 * panInt);
			
			// Break down value for pans contorls  
			tempSoundTransform.volume = panSoundChannel.soundTransform.volume;
			
			// Make sure it keeps old volume settings 
			panSoundChannel.soundTransform = tempSoundTransform;
        }
		
		return false;
    }
	
	public function onTimerUpdate(event:TimerEvent):Void 
	{
		
		for (index in Reflect.fields(_soundObjectHolder))
		{
			var soundObj:SoundData = Reflect.field(_soundObjectHolder, index);
			
			if (soundObj.panTracking)
			{
				
				var tempNum : Int = Math.round(((soundObj.panTrackingObj.x + soundObj.panTrackingObj.width) / (soundObj.panTrackingObj.parent.stage.stageWidth + soundObj.panTrackingObj.width)) * 200 - 100);
			
				if (tempNum >= -100 && tempNum <= 100) 
					setChannelPan(tempNum, soundObj.soundChannel);
			}
			
			if (soundObj.soundTracking)
			{
				
				// Check to see which side movieclip is on then 0-100(left) and 100-0(right)
				if (Math.round(((soundObj.soundTrackingObj.x + soundObj.soundTrackingObj.width) / soundObj.soundTrackingObj.parent.stage.stageWidth) * 200) > 100) 
				{
					var tempNum1 : Int = (100 - Math.round(((soundObj.soundTrackingObj.x + soundObj.soundTrackingObj.width) / soundObj.soundTrackingObj.parent.stage.stageWidth) * 200) + 100); 
					
					// Check to make sure it doesn't drop below 0 
					if (tempNum1 < 0)
						tempNum1 = 0;
					
					setChannelVolume(tempNum1, soundObj.soundChannel);
				}
				else 
				{
					var tempNum2 : Int = Math.round(((soundObj.soundTrackingObj.x + soundObj.soundTrackingObj.width) / soundObj.soundTrackingObj.parent.stage.stageWidth) * 200);
					
					// Check to make sure it doesn't drop below 0  
					if (tempNum2 < 0) 
						tempNum2 = 0;
					
					setChannelVolume(tempNum2, soundObj.soundChannel);
				}
				
			}
		}
		
	}

	
	private function volLocalTrackTimer(volSoundObj : SoundData, trackerClip : DisplayObject) : Void 
	{  
		// Check to see which side movieclip is on then 0-100(left) and 100-0(right)
		if (Math.round(((trackerClip.x + trackerClip.width) / trackerClip.parent.stage.stageWidth) * 200) > 100) 
		{
			var tempNum1 : Int = (100 - Math.round(((trackerClip.x + trackerClip.width) / trackerClip.parent.stage.stageWidth) * 200) + 100); 
			
			// Check to make sure it doesn't drop below 0 
			if (tempNum1 < 0)
				tempNum1 = 0;
			
			setChannelVolume(tempNum1, volSoundObj.soundChannel);
        }
        else 
		{
			var tempNum2 : Int = Math.round(((trackerClip.x + trackerClip.width) / trackerClip.parent.stage.stageWidth) * 200);
			
			// Check to make sure it doesn't drop below 0  
			if (tempNum2 < 0) 
				tempNum2 = 0;
			
			setChannelVolume(tempNum2, volSoundObj.soundChannel);
        }
    }
	
	private function panLocalTrackTimer(panSoundObj : SoundData, trackerClip : DisplayObject) : Void	
	{
		if (trackerClip.parent != null && trackerClip.parent.stage != null)
		{
			var tempNum : Int = Math.round(((trackerClip.x + trackerClip.width) / (trackerClip.parent.stage.stageWidth + trackerClip.width)) * 200 - 100);
			
			if (tempNum >= -100 && tempNum <= 100) 
				setChannelPan(tempNum, panSoundObj.soundChannel);
		}
    }
	
	private function fadeVolTimer(task:ITask) : Void	
	{
		
		var soundData:SoundData = cast(Reflect.field(task.data, "soundData"), SoundData);
		

		
		//task : ITask, fadeSoundObj : SoundData, callBack : Dynamic->Void = null
		// Note: Add and Sub by 1 doesn't work with HAXE so just fading  
		if (task.index > task.end) 
		{
			setChannelVolume(getVolume(soundData.name) - 5, soundData.soundChannel);
        }
        else if (task.index < task.end) 
		{
			setChannelVolume(getVolume(soundData.name) + 5, soundData.soundChannel);
        }
        else if (task.index == task.end) 
		{
			soundData.volTask = null;
			
			// Just send name in callback because dev and pull sound object from sound manager
			//if (null != callBack)  
			//	callBack(soundData.name);
			
			// Event for when fade is finished  
			dispatchEvent(new SoundStatusEvent(soundData, SoundStatusEvent.SOUND_FADE_COMPLETE));
        }
    }
}