package com.chaos.ui.classInterface;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Bitmap;


/**
 * Interface for Menu Item
 * @author Erick Feiling
 */

interface IMenuItem extends IToggleButton
{
    
    
    /**
	 * Set the menu to being open or closed on roll over
	 */
    
    
    var open(get, set) : Bool;    
    /**
	 * Set the button has a parent
	 */
    
    var hasParent(get, set) : Bool;    
    /**
	 * Set the button has a sub menu
	 */
    
    var hasChildren(get, set) : Bool;    
    
    /**
	 * Set the parent menu
	 */
    
    var parentMenuItem(get, set) : IMenuItem;    
   
    
    /**
	 * Set the default menu color
	 */
    
    var menuDefaultColor(get, set) : Int;    
    
    /**
	 * Set the over menu color
	 */

    var menuOverColor(get, set) : Int;    
    
    /**
	 * Set the down menu color
	 */
 
    
    var menuDownColor(get, set) : Int;    
    
    /**
	 * Set the disable menu icon color
	 */
  
    
    var menuDisableColor(get, set) : Int;    
    
    /**
	 * Border color for normal button state
	 */
    
    

    var normalBorderColor(get, set) : Int;    
    
    /**
	 * Border color for over button state
	 */
    

    
    var overBorderColor(get, set) : Int;    
    
    /**
	 * Border color for down button state
	 */
    
    
    var downBorderColor(get, set) : Int;    
    
    /**
	 * Border color for disable button state
	 */
    
    
    var disableBorderColor(get, set) : Int;    
    
    /**
	 * Set the inner menu button alpha
	 */
    

    var fillAlpha(get, set) : Float;    
    
    /**
	 * Set the border menu button alpha
	 */

    
    var lineAlpha(get, set) : Float;    
    
    /**
	 * Set the label text color
	 */
    
    

    var textColor(get, set) : Int;    
    
    /**
	 * Set the label over state color
	 */
    
    

    
    var textOverColor(get, set) : Int;    
    
    /**
	 * Set the label selected state
	 */
    

    var textSelectedColor(get, set) : Int;    
    
    /**
	 * Set the label disable color
	 */
    
    
    var textDisableColor(get, set) : Int;    
    
    /**
	 * Set the menu button icon
	 */
    
    var showIcon(get, set) : Bool;    
    
    /**
	 * Border thinkness
	 */
    
    
    var borderThinkness(get, set) : Float;    
    
    /**
	 * Show or hide border around button
	 */
    
    var border(get, set) : Bool;    
    
    /**
	 * Show or hide the Sub menu icon
	 */
    

    
    var showSubMenuIcon(get, set) : Bool;    
    
    /**
	 * Turn on and off image smoothing
	 */

    
    var smoothImage(get, set) : Bool;

    
    /**
	 * Set the icon that will be used using a bitmap image
	 * @param	image The bitmap that will be used
	 */
    
    function setIcon(image : BitmapData) : Void;
    
    /**
	 * Return the icon that is being used for the set menu.
	 * @return Return an icon interface
	 */
    
    function getSubMenuIcon() : Shape;
    
    /**
	 * Set a new icon to the button menu.
	 *
	 * @param	image The new display icon
	 */
    
    function setSubMenuIcon(image : BitmapData) : Void;

    
    /**
	 * Return the label being used
	 *
	 * @return An interface
	 */
    
    function getLabel() : ILabel;


}

