package com.chaos.ui.classInterface;

import motion.actuators.GenericActuator;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;


interface IBaseUI 
{
	
	#if flash
	var name:String;
	#else
	var name(get, set):String;
	#end	
	
	/*
	* Use custom render created by theme. 
	*/	
	var useCustomRender(get,set):Bool;	
	
	/**
	 * True if the object is enabled and false if not
	 */
	 
	var enabled(get, set) : Bool;

	/*
	* Use custom render created by theme. 
	*/

	var defaultTweenDuration(get,set):Float;		

	/**
	 * Turns on or off image smoothing, which gives the image a nice anti aliasing effect
	 */
	
	var imageSmoothing(get, set) : Bool;	

	 
	#if flash
	var width:Float;
	#else
	var width(get, set):Float;
	#end
	
	#if flash
	var height:Float;
	#else
	var height(get, set):Float;
	#end
	
	
	#if flash
	var x:Float;
	#else
	var x(get, set):Float;
	#end
	 
	#if flash
	var y:Float;
	#else
	var y(get, set):Float;
	#end
	
	#if flash
	var scaleX:Float;
	#else
	var scaleX(get, set):Float;
	#end
	
	#if flash
	var scaleY:Float;
	#else
	var scaleY(get, set):Float;
	#end
	
	#if flash
	var visible:Bool;
	#else
	var visible(get, set):Bool;
	#end	 
	 
	var parent(default, never):DisplayObjectContainer;
	
	 
	#if flash
	var rotation:Float;
	#else
	var rotation(get, set):Float;
	#end	 

		 
	 /**
	 * Return the this class DisplayObject so it can be added and removed from the stage
	 */  
	 var displayObject(get, never) : DisplayObject;
	
	function addEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void;
	function removeEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false) : Void;
	function hasEventListener(type : String) : Bool; 

	/**
	* Apply a tween to this UI component or one of the display objects. Pass in duration of the tween or the default will be used.
	*
	* @param	data object with properties that will be used to adjust component or child DisplayObject.
	*/

	function animateTo( data:Dynamic ) : GenericActuator<DisplayObject>;

	/**
	* Pause the animation 
	*  @param	data object with the name of the object child object. If nothing is passed then the current object will be paused.
	**/

	function pauseAnimate( data:Dynamic = null ) : Void;
	/**
	* Resume the animation if it was paused
	*  @param	data object with the name of the object child object. If nothing is passed then the current object will be resume from being paused.
	**/

	function resumeAnimate( data:Dynamic = null ) : Void;

	/**
	* Stop the animation
	*  @param	data object with the name of the object child object. If nothing is passed then the current object animation will stop.
	**/

	function stopAnimate( data:Dynamic = null ) : Void;
		
	/**
	 * Unload Component
	 */
	
	function destroy() : Void;  
	 
	 
	/**
	 * Update the UI class
	 */
	
	 function draw() : Void;  
	 
	/**
	 * Reload all bitmap images
	 */
	
	 function reskin() : Void;

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	 	 
	 function setComponentData(data:Dynamic):Void;
}