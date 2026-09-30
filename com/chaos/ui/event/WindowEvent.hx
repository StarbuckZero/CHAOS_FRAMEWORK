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
	/** Identifier for the window close button. */
	public static inline var WINDOW_CLOSE_BTN : String = "close";
	/** Identifier for the window maximize button. */
	public static inline var WINDOW_MAX_BTN : String = "max";
	/** Identifier for the minimize button; its stored key is `mix`. */
	public static inline var WINDOW_MIN_BTN : String = "mix";
	/** Window resize event type. */
	public static inline var WINDOW_RESIZE : String = "resize";
	
	/** Creates a window event of the supplied type. */
	public function new(type : String)
    {
		super(type);
    }
}