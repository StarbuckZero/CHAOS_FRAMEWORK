package com.chaos.mobile.ui.classInterface;

import com.chaos.ui.classInterface.IBaseUI;

/**
 * @author Erick Feiling
 */

 interface IToggleSwitch extends IBaseUI
 {
	/**
	 * Set if you want the button to be selected or not
	 */

     var selected(get, set):Bool;

     /**
      * The animation when moving to selected and unselected state
      */
 
     var toggleAnimationSpeed(get, set):Float;  
 
     /**
      * Set the border button alpha
      */

      var borderAlpha(get, set):Float;
 
      /**
       * Border thinkness
       */

     var borderThinkness(get, set):Float;
 
     /**
      * Border color 
      */
 
     var borderColor(get, set):Int;
 
     /**
      * Show border
      */
 
    var border(get, set):Bool;
 
 
     /**
     * Set the switch button alpha
     */
 
    var switchOutlineAlpha(get, set):Float;
 
     /**
     * Switch thinkness
     */
     
     var switchOutlineThinkness(get, set):Float;
 
     /**
      * Switch color 
      */
 
    var switchOutlineColor(get, set):Int;
 
     /**
      * Show switch border
      */
 
    var switchOutline(get, set):Bool;  
 }