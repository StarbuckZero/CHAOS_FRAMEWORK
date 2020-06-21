package com.chaos.ui.classInterface;

import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.DisplayObject;



interface IScrollPane extends IBaseContainer
{


    /**
	 * Returns the bottom horizontal scrollbar being used
	 */
	
	var scrollBarH(get, never) : IScrollBar;      
	
	/**
	 * Returns the vertical scrollbar on the righ side
	 */
	
	var scrollBarV(get, never) : IScrollBar;  
    
  
	/**
	 * Places a DisplayObject in the ScrollPane
	 */

	var source(get, set) : DisplayObject;      
	
	/**
	 * Change the ScrollBar settings on the ScrollPane. This changes the way the scrollbars react to content.
	 * The settings are ScrollPolicy.AUTO,ScrollPolicy.VERTICAL_ONLY,ScrollPolicy.HORIZONTAL_ONLY,ScrollPolicy.ON or ScrollPolicy.OFF.
	 *
	 * @see com.chaos.ui.ScrollPolicy
	 */
	

	var mode(get, set) : String;      
	
	
	/**
	 * Reload the content that is inside the ScrollPane
	 */
	
	function refreshPane() : Void;  
	
	/**
	 * Update the content area, this is needed for when the content loaded inside the ScrollPane size has changed
	 */
	
	function update() : Void;  
	
	
}