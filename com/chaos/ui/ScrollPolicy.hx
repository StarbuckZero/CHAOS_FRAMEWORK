package com.chaos.ui;

/**
 * These values are used for the scrollbars on the ScrollPane, TabPane and Window Class.
 *	
 *  @author Erick Feiling
 *  @date 11-14-09
 *
 */

enum ScrollPolicy 
{
	/** The AUTO setting turn on and off the scrollbar based on the size of the content  */ 
	AUTO; 
	
	/** The scrollbar will always be turned off  */
	OFF; 
	
	/** The scrollbar will always be turned on  */ 
	ON;
	
	/** Only show the vertical scrollbar  */
	ONLY_VERTICAL; 
	
	/** Only show the horizontal scrollbar  */ 
	ONLY_HORIZONTAL;
	
}