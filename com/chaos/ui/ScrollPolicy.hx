package com.chaos.ui;

/**
 * These values are used for the scrollbars on the ScrollPane, TabPane and Window Class.
 *
 *  @author Erick Feiling
 *  @date 11-14-09
 *
 */

class ScrollPolicy 
{
	/** The AUTO setting turn on and off the scrollbar based on the size of the content  */ 
	public static inline var AUTO : String = "auto"; 
	
	/** The scrollbar will always be turned off  */
	public static inline var OFF : String = "off"; 
	
	/** The scrollbar will always be turned on  */ 
	public static inline var ON : String = "on";
	
	/** Only show the vertical scrollbar  */
	public static inline var ONLY_VERTICAL : String = "vertical_only"; 
	
	/** Only show the horizontal scrollbar  */ 
	public static inline var ONLY_HORIZONTAL : String = "horizontal_only";
	
	private function new()
    {
        
    }
}