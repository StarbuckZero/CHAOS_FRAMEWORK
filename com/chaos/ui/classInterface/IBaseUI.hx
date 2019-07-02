package com.chaos.ui.classInterface;


import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;


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
	 
	var enabled(get, set) : Bool;

	 
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
}