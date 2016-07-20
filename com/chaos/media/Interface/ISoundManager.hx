package com.chaos.media.Interface;

import com.chaos.media.Interface.ISoundStatus;


/**
	 * Sound Manager
	 *
	 * @author Erick Feiling
	 */

import openfl.media.Sound;
import openfl.events.Event;
import openfl.display.DisplayObject;

interface ISoundManager
{
    
    
    var displayMessage(get, set) : Bool;

    
    function load(strName : String, url : String, autoStart : Bool = false, repeatSound : Bool = false, muteSound : Bool = false) : Void;
    function addSoundObject(strName : String, loadSoundObj : Sound) : Void;
    function getSoundObj(strName : String) : Sound;
    function setBufferPercent(buffNum : Int = 20) : Void;
    function setVolume(soundName : String, volume : Int) : Void;
    function getVolume(strName : String) : Int;
    function crossFade(strFadeOutName : String = "", strFadeInName : String = "", fadeRate : Int = 0, callBack : Function = null) : Bool;
    function fadeTo(strName : String, fadeToNum : Int, fadeRate : Int = -1, callBack : Function = null) : Void;
    function fadeKill(strName : String) : Bool;
    function getPercent(strName : String) : Int;
    function removeSound(strName : String) : Bool;
    function stopSound(strName : String) : Void;
    function playSound(strName : String) : Void;
    function pauseSound(strName : String) : Void;
    function getPan(strName : String) : Float;
    function setPan(strName : String, panNumber : Float) : Bool;
    function getPosition(strName : String) : Float;
    function setPosition(strName : String, posNum : Float) : Bool;
    function getDuration(strName : String) : Float;
    function getFormatDuration(strName : String) : String;function getFormatTimeRemaing(strName : String) : String;
    function getFormatTimeLeft(strName : String) : String;
    function timeRemaining(strName : String) : Float;
    function repeatAudio(strName : String, loopAudio : Bool = false) : Bool;
    function clipSoundTracker(strName : String, trackerClip : DisplayObject) : Bool;
    function soundTrackerKill(strName : String) : Void;
    function clipPanTracker(strName : String, trackerClip : DisplayObject) : Bool;
    function panTrackerKill(strName : String) : Void;
    function getStatus(strName : String) : ISoundStatus;
    function muteSound(strName : String) : Void;
    function unMuteSound(strName : String) : Void;
    function muteAll() : Void;
    function unMuteAll() : Void;
    function getList() : Array<Dynamic>;
    function addEventListener(type : String, listener : Function, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void;
    function removeEventListener(type : String, listener : Function, useCapture : Bool = false) : Void;
    function dispatchEvent(event : Event) : Bool;
    function hasEventListener(type : String) : Bool;
    function willTrigger(type : String) : Bool;
}

