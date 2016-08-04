package com.chaos.ui.classInterface;

import haxe.Constraints.Function;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.events.Event;

interface IBaseUI 
{
	
	#if flash
	var name:String;
	#else
	var name(get, set):String;
	#end	
	
	
	/**
	 * True if the object is enabled and false if not
	 */
	
	/**
	 * Return true or false based on if the object is enabled or not
	 */
	
	 
	var enabled(get, set) : Bool;
		
	/**
	 * Set the level of detail on the text input. This degrade the text input with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 */   
	
	 var detail(get, set) : String;  
	 
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
	 * Update the UI class
	 */
	
	 function draw() : Void;  
	 
	/**
	 * Reload all bitmap images
	 */
	
	 function reskin() : Void;
}