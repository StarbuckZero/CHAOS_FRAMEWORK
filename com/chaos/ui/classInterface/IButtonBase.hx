package com.chaos.ui.classInterface;

import openfl.display.BitmapData;
/**
 * @author Erick Feiling
 */

 interface IButtonBase extends IBorder
 {
 
	/**
	 * Color for button state
     */
     
     var baseColor(get, set):Int;
 
     /**
     * Alpha for base
     */
          
    var baseAlpha(get, set):Float; 

     /**
     * Image for base
     */
          
    var image(get, set):BitmapData;

	/**
	 * Title the image that is being used
	 */
    var tileImage(get, set):Bool;  

	/**
	 * Border for button
     */
     
    var border(get, set):Bool;     
    
	/**
	 * Set how rounded the button is
     */
     
     var roundEdge(get, set):Int;
     
 }
   