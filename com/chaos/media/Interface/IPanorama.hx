package com.chaos.media.Interface;



/**
	 * The interface for the panorama
	 * @author Erick Feiling
	 */

import openfl.display.DisplayObject;

interface IPanorama
{
    
    
    /**
		 * The margin or hit area for when in forceMode
		 */
    
    
    /**
		 * Return the hit area size
		 */
    
    var spacing(get, set) : Int;    
    
    /**
		 * The higher the number the slower panorama moves
		 */
    
    
    
    /**
		 * Return the amount of lag apply to the panorama
		 */
    
    var lag(get, set) : Int;    
    
    /**
		 * Making it so user can zoom in and out
		 */
    
    
    
    /**
		 * If true zooming is supported
		 */
    
    var enableZoom(get, set) : Bool;    
    
    /**
		 * This is enabled then the image scrolling is based on a point set on the stage
		 */
    
    
    
    /**
		 * Return true mode is enabled
		 */
    
    var forceMode(get, set) : Bool;    
    
    /**
		 * Lock the whole panorama from moving
		 */
    
    
    
    /**
		 * Returns true of false if panorama is locked or enabled
		 */
    
    var lock(get, set) : Bool;    
    
    /**
		 * If false will only move on the x axis
		 */
    
    
    
    /**
		 * Return true if the x axis is enabled and false if not
		 */
    
    var enableX(get, set) : Bool;    
    
    /**
		 * If false will only move on the y axis
		 */
    
    
    
    /**
		 * Return true if the y axis is enabled and false if not
		 */
    
    var enableY(get, set) : Bool;    
    
    /**
		 * Set the block spacing which display arrow once over
		 */
    
    
    
    /**
		 * The block size
		 */
    
    var blockSpace(get, set) : Int;    
    
    /**
		 * The mode being used, which is 360 and normal mode
		 */
    
    var mode(get, never) : String;    
    
    /**
		 * Set the display object that will be used
		 */
    
    
    
    /**
		 * Return the display object being used
		 */
    
    var source(get, set) : DisplayObject;

    
    /**
		 * Set a mask to current display object
		 *
		 * @param	maskWidth The width of the mask
		 * @param	maskHeight The height of the mask
		 */
    
    function setMask(maskWidth : Float, maskHeight : Float) : Void;
    
    /**
		 * Loads an image or swf file
		 *
		 * @param	fileURL The file that will be used
		 */
    
    function load(fileURL : String) : Void;
    
    /**
		 * This moves the panorama to based on a X and Y location set. To use this set forceMode to true.
		 *
		 * @param	locX The X location of the VR
		 * @param	locY The Y location of the VR
		 *
		 * @see com.media.Panorama.forceMode
		 */
    
    function setForcePoint(locX : Int, locY : Int) : Void;
}

