package com.chaos.ui.classInterface;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
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
	 * If true this will apply a mask content layer
	 */
    
    var useMask(get, set) : Bool;    
    
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
    
    
    /**
	 * Return true if border is being shown and false if not
	 */
    var border(get, set) : Bool;    
    
    /**
	 * Show or hide the Sub menu icon
	 */
    
    
    
    /**
	 * If true sub menu icon is being displayed and false if not.
	 */
    
    var showSubMenuIcon(get, set) : Bool;    
    
    /**
	 * Turn on and off image smoothing
	 */
    
    
    
    /**
	 * Return true if smoothing is on and false if not
	 */
    
    var smoothImage(get, set) : Bool;

    
    /**
	 * Set the icon that will be used based on a URL location.
	 * @param	strImage The path to the file that will be used.
	 */
    
    function setIconURL(strImage : String) : Void;
    
    /**
	 * Set the icon that will be used using a bitmap image
	 * @param	bitmap The bitmap that will be used
	 */
    
    function setIconBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Return the icon that is being used for the set menu.
	 * @return Return an icon interface
	 */
    
    function getSubMenuIcon() : IBasicIcon;
    
    /**
	 * Set a new icon to the button menu.
	 *
	 * @param	newIcon The new display icon
	 */
    
    function setSubMenuIcon(newIcon : IBasicIcon) : Void;
    
    /**
	 * The file location of the image that will be used.
	 *
	 * @param	fileURL The file location
	 */
    
    function setSubMenuURL(fileURL : String) : Void;
    
    /**
	 * The bitmap that be used for an icon
	 * @param	bitmap The bitmap that will be used.
	 */
    
    function setSubMenuBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * The overlay that is being used for the button. This is for masking the bottom button layer shape.
	 *
	 * @return An Overlay interface interface
	 */
    
    function getOvery() : IOverlay;
    
    /**
	 * Return the label being used
	 *
	 * @return An interface
	 */
    
    function getLabel() : ILabel;
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setDefaultStateURL(strImage : String) : Void;
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setDefaultStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setOverStateURL(strImage : String) : Void;
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setOverStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    function setDownStateURL(strImage : String) : Void;
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setDownStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setDisableStateURL(strImage : String) : Void;
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    function setDisableStateBitmap(bitmap : Bitmap) : Void;
}

