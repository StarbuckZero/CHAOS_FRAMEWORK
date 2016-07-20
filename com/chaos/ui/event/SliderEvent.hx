package com.chaos.ui.event;

import openfl.events.Event;

class SliderEvent extends Event
{
    public var percent(get, never) : Float;
	
	// events 
	public static inline var CHANGE : String = "change";
	private var _percentage : Float;
	
	/**
	 * Read-Only
	 */
  private function get_percent() : Float
  {
	return _percentage;
	}
	
	/**
	 * Constructor
	 */
	public function new(type : String, percent : Float)
    {
		super(type);
		_percentage = percent;
    }
}