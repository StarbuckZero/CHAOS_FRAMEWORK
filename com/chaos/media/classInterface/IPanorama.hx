package com.chaos.media.classInterface;



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

    
    var spacing(get, set) : Int;    
    
    /**
	 * The higher the number the slower panorama moves
	 */

    var lag(get, set) : Int;    
    
    /**
	 * Making it so user can zoom in and out
	 */
    
    
    var enableZoom(get, set) : Bool;    
    
    /**
	 * This is enabled then the image scrolling is based on a point set on the stage
	 */

    
    var forceMode(get, set) : Bool;    
    
    /**
	 * Lock the whole panorama from moving
	 */

    
    var lock(get, set) : Bool;    
    
    /**
	 * If false will only move on the x axis
	 */
    
    
    var enableX(get, set) : Bool;    
    
    /**
	 * If false will only move on the y axis
	 */

    
    var enableY(get, set) : Bool;    
    
    /**
	 * Set the block spacing which display arrow once over
	 */
    
    
    var blockSpace(get, set) : Int;    
    
    /**
	 * The mode being used, which is 360 and normal mode
	 */
    
    var mode(get, never) : String;    
    
    /**
	 * Set the display object that will be used
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

