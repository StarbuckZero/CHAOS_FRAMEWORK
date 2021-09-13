package com.chaos.ui.layout.classInterface;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;
import openfl.display.BitmapData;

import com.chaos.ui.classInterface.IBaseUI;

interface IBaseContainer extends IBaseUI
{
    
    
    /**
	 * The content layer
	 */
    
    var content(get, never) : DisplayObject;    
    
    /**
	 * Hide or show the background
	 */

    
    var background(get, set) : Bool;    
    /**
	 * The background color
	 */

    
    var backgroundColor(get, set) : Int;    
    
    /**
	 * The background alpha
	 */
    

    var backgroundAlpha(get, set) : Float;    
    
    /**
	 * Toggle on and off images, if false then will use default render
	 */

	var showImage(get, set) : Bool;
		

    /**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */
    
	function setBackgroundImage(value : BitmapData) : Void;
	
    /**
	 * Adds more then one item to the object to the list
	 *
	 * @param	list A list of UI Elements
	 */
    
	 function addElementList(list : Array<IBaseUI>) : Void;
	
	 /**
	  * Return the object inside the container
	  *
	  * @param	value The index of the object inside the container
	  * @return The object that is stored in the container
	  */
	 
	 function getElementAtIndex(value : Int) : IBaseUI;
	 
	 /**
	  * Return the object inside the container based on the name passed
	  *
	  * @param	value The name of the object
	  * @return The object that is stored in the container
	  */
	 
	 function getElementByName(value : String) : IBaseUI;
	 
	 /**
	  * Add an UI element to the container
	  *
	  * @param	object The object you want to add
	  */
	 
	 function addElement(object : IBaseUI) : Void;
	 
	 /**
	  * Remove an UI element from the container
	  *
	  * @param	object The object you want to remove
	  */
	 
	 function removeElement(object : IBaseUI) : Void;	
	
    /**
	 * Remove all items that are stored
	 */
    
    function removeAll() : Void;	

}

