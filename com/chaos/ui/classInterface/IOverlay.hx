package com.chaos.ui.classInterface;



/**
	 * ...
	 * @author Erick Feiling
	 */

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;

interface IOverlay extends IBaseUI
{
    
    
    /**
	 * If you want to scale or just title the top center image
	 */
    

    
    var tileTopCenterImage(get, set) : Bool;    
    
    /**
	 * Set if the middle part of the object will be tile
	 */
    
    
    var tileMiddleImage(get, set) : Bool;    
    
    /**
	 * Set if the bottom center image will be tile
	 */
    
    
    
    var tileBottomCenterImage(get, set) : Bool;

    
    /**
	 * Setting the Upper half of the object
	 *
	 * @param	leftImage An image the left
	 * @param	middleImage An middle image that will tile
	 * @param	rightImage An right image that will be used
	 */
    
    function setTopImage(leftImage : Bitmap = null, middleImage : Bitmap = null, rightImage : Bitmap = null) : Void;
    
    /**
	 * Set the middle sides of the object
	 * @param	leftImage left hand side
	 * @param	rightImage right hand side
	 */
    
    function setMiddleCenterImage(leftImage : Bitmap = null, rightImage : Bitmap = null) : Void;
    
    /**
	 * Left the bottom part of the object
	 * @param	leftImage lower left image
	 * @param	middleImage lower center image
	 * @param	rightImage lower right image
	 */
    
    function setBottomImage(leftImage : Bitmap = null, middleImage : Bitmap = null, rightImage : Bitmap = null) : Void;
}

