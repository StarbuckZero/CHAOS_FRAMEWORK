/**
*
*   @author: Erick Feiling
*   @date: September 30, 2008
*   @eescription: Window events
*
*/

package com.chaos.ui.event;

import openfl.events.Event;

class WindowEvent extends Event
{
	public static inline var WINDOW_CLOSE_BTN : String = "close";
	public static inline var WINDOW_MAX_BTN : String = "max";
	public static inline var WINDOW_MIN_BTN : String = "mix";
	public static inline var WINDOW_RESIZE : String = "resize";
	
	public function new(type : String)
    {
		super(type);
    }
}