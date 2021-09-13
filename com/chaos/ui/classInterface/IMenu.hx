package com.chaos.ui.classInterface;


import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IFitContainer;
import openfl.display.BitmapData;

/**
 * Interface for menu system
 * @author Erick Feiling
 */

interface IMenu extends IBaseContainer
{
    
    
    /**
	 * Return a container with the menu top level buttons
	 */
    
    var buttonContainer(get, never) : IFitContainer;    
    
    /**
	 * Flip what side the drop down menu is done.
	 */
    
    var reverse(never, set) : Bool; 
	
    /**
	 * Set the default menu icon color
	 */
    

    
    var menuDefaultColor(get, set) : Int;    
    
    /**
	 * Set the default menu color
	 */
    
    var menuSubDefaultColor(get, set) : Int;    
    
    /**
	 * Set the over menu icon color
	 */
    
    
    var menuOverColor(get, set) : Int;    
    
    /**
	 * Set the over sub menu color
	 */
    
    
    var menuSubOverColor(get, set) : Int;    
    
    /**
	 * Set the down menu icon color
	 */
    

    
    var menuDownColor(get, set) : Int;    
    
    /**
	 * Set the down sub menu color
	 */
    
    var menuSubDownColor(get, set) : Int;    
    
    /**
	 * Set the disable menu icon color
	 */
    
    
    var menuDisableColor(get, set) : Int;    
    
    /**
	 * Set the disable sub menu color
	 */
    

    
    var menuSubDisableColor(get, set) : Int;    
    
    /**
	 * Border color for normal button state
	 */
    

    var normalBorderColor(get, set) : Int;    
    
    /**
	 * Border color for sub-normal button state
	 */
    
    
    
    var normalSubBorderColor(get, set) : Int;    
    
    /**
	 * Border color for over button state
	 */
    

    
    var overBorderColor(get, set) : Int;    
    
    /**
	 * Border color for over sub button state
	 */
    
    
    var overSubBorderColor(get, set) : Int;    
    
    /**
	 * Border color for down button state
	 */
    
    var downBorderColor(get, set) : Int;    
    
    /**
	 * Border color for down sub button state
	 */


    var downSubBorderColor(get, set) : Int;    
    
    /**
	 * Border color for disable button state
	 */
    
    
    var disableBorderColor(get, set) : Int;    
    
    /**
	 * Border color for disable sub button state
	 */
    
    
    var disableSubBorderColor(get, set) : Int;    
    
    /**
	 * Set the inner menu button alpha
	 */
    

    
    var buttonAlpha(get, set) : Float;    
    
    /**
	 * Set the inner menu sub button alpha
	 */
    

    var subButtonAlpha(get, set) : Float;    
    
    /**
	 * Set the border menu button alpha
	 */
    
    
    var buttonLineAlpha(get, set) : Float;    
    
    /**
	 * Set the border sub menu button alpha
	 */
    
    
    var subButtonLineAlpha(get, set) : Float;    
    
    /**
	 * Set the label text color
	 */
    
    
    var textColor(get, set) : Int;    
    
    /**
	 * Set the label sub text color
	 */
    
    
    var subTextColor(get, set) : Int;    
    
    /**
	 * Set the label over state color
	 */
    
    var textOverColor(get, set) : Int;    
    
    /**
	 * Set the sub label over state color
	 */
    
    
    var textSubOverColor(get, set) : Int;    
    
    /**
	 * Set the label selected state
	 */
    
    
    var textSelectedColor(get, set) : Int;    
    
    /**
	 * Set the label selected state
	 */
    
    
    var textSubSelectedColor(get, set) : Int;    
    
    /**
	 * Set the label disable color
	 */
    
    var textDisableColor(get, set) : Int;    
    
    /**
	 * Set the sub button label disable color
	 */
    
    var textSubDisableColor(get, set) : Int;    
    
    /**
	 * Border thinkness
	 */
    
    
    var buttonBorderThinkness(get, set) : Float;    
    
    /**
	 * Border thinkness
	 */
    
    var subButtonBorderThinkness(get, set) : Float;    
      
	
    /**
	 * Show or hide the Sub menu icon
	 */
    
    var showSubMenuIcon(get, set) : Bool;

    
    /**
	 * Unload all menu items
	 */
	
    function unload() : Void;
    
    /**
	 * Remove sub menu
	 */
	
    function removeSubMenu() : Void;
    
    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setDefaultStateImage(value : BitmapData) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setSubDefaultStateImage(value : BitmapData) : Void;
    
    
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setOverStateImage(value : BitmapData) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setSubOverStateImage(value : BitmapData) : Void;
	
	
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setDownStateImage(value : BitmapData) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
    
    function setSubDownStateImage(value : BitmapData) : Void;
	
    /**
	 * Set the state using bitmap image
	 * @param	value The image that will be used
	 */
	
    function setDisableStateImage(value : BitmapData) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	value The image that will be used
	 */
	
    function setSubDisableStateImage(value : BitmapData) : Void;
    
    
    /**
	 * Set the icon that will be used using a bitmap image
	 * @param	value The bitmap that will be used
	 */
    
    function setIcon(value : BitmapData) : Void;
	
    /**
	 * Set the sub menu icon that will be used using a bitmap image
	 * @param	value The bitmap that will be used
	 */
    
    function setSubIcon(value : BitmapData) : Void;
    
    /**
	 * The bitmap that be used for an icon
	 * @param	value The bitmap that will be used.
	 */
    
    function setSubMenuDropDownIconImage(value : BitmapData) : Void;
}

