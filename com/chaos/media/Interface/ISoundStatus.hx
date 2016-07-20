package com.chaos.media.Interface;



/**
	 * ...
	 * @author Erick Feiling
	 */
interface ISoundStatus
{
    
    
    var pause(get, set) : Bool;    
    
    
    var playing(get, set) : Bool;    
    
    
    var stop(get, set) : Bool;    
    
    
    var mute(get, set) : Bool;    
    
    
    var repeat(get, set) : Bool;    
    
    
    var isPanning(get, set) : Bool;    
    
    
    var isTracking(get, set) : Bool;

}

