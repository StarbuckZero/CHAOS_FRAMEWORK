package com.chaos.ui.classInterface;


import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IFitContainer;
import openfl.display.Bitmap;

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
    

    
    var fillAlpha(get, set) : Float;    
    
    /**
	 * Set the inner menu sub button alpha
	 */
    

    var subAlpha(get, set) : Float;    
    
    /**
	 * Set the border menu button alpha
	 */
    
    
    var lineAlpha(get, set) : Float;    
    
    /**
	 * Set the border sub menu button alpha
	 */
    
    
    var subLineAlpha(get, set) : Float;    
    
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
    
    
    var borderThinkness(get, set) : Float;    
    
    /**
	 * Border thinkness
	 */
    
    var subBorderThinkness(get, set) : Float;    
    
    /**
	 * Turn on and off image smoothing
	 */

    var smoothImage(get, set) : Bool;    
	
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
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setDefaultStateURL(strImage : String) : Void;
    
    /**
	 * Set the sub menu button state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setSubDefaultStateURL(strImage : String) : Void;
    
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setDefaultStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setSubDefaultStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setOverStateURL(strImage : String) : Void;
    
    /**
	 * Set the sub menu state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setSubOverStateURL(strImage : String) : Void;
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setOverStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setSubOverStateBitmap(bitmap : Bitmap) : Void;
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    function setDownStateURL(strImage : String) : Void;
    
    /**
	 * Set the sub menu state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setSubDownStateURL(strImage : String) : Void;
	
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setDownStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	bitmap The image that will be used
	 */
    
    function setSubDownStateBitmap(bitmap : Bitmap) : Void;
	
    /**
	 * Set the state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setDisableStateURL(strImage : String) : Void;
    
    /**
	 * Set the sub menu state based on the URL location.
	 * @param	strImage The path to the file that will be used
	 */
    
    function setSubDisableStateURL(strImage : String) : Void;
	
    /**
	 * Set the state using bitmap image
	 * @param	bitmap The image that will be used
	 */
	
    function setDisableStateBitmap(bitmap : Bitmap) : Void;
    
    /**
	 * Set the sub menu state using bitmap image
	 * @param	bitmap The image that will be used
	 */
	
    function setSubDisableStateBitmap(bitmap : Bitmap) : Void;
    
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
	 * Set the sub menu icon that will be used based on a URL location.
	 * @param	strImage The path to the file that will be used.
	 */
    
    function setSubIconURL(strImage : String) : Void;
	
    /**
	 * Set the sub menu icon that will be used using a bitmap image
	 * @param	bitmap The bitmap that will be used
	 */
    
    function setSubIconBitmap(bitmap : Bitmap) : Void;
	
    /**
	 * The file location of the image that will be used.
	 *
	 * @param	fileURL The file location
	 */
    
    function setSubMenuDropDownIconURL(fileURL : String) : Void;
    
    /**
	 * The bitmap that be used for an icon
	 * @param	bitmap The bitmap that will be used.
	 */
    
    function setSubMenuDropDownIconBitmap(bitmap : Bitmap) : Void;
}

