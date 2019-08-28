package com.chaos.ui.data;
import openfl.display.DisplayObject;

/**
 * keeps track of what objects have been placed on stage for StageAlignmentManager
 * @author Erick Feiling
 */

class StageAlignmentObjectData 
{
	
	public var location(get, never) : Int;
	public var stayRelative(get, never) :Bool;
	public var displayObj(get, never) : DisplayObject;
	
	public var defaultX(get, never) : Float;
	public var defaultY(get, never) : Float;
	
	public var percentWidth(get, never) : Int;
	public var percentHeight(get, never) : Int;
	
	
	private var _loc : Int;
	private var _stayRelative : Bool;
	private var _displayObj : DisplayObject;
	
	private var _defaultX:Float;
	private var _defaultY:Float;
	
	private var _percentWidth : Int = -1;
	private var _percentHeight : Int = -1;
	
	
	public function new( location:Int, stayRelative:Bool, displayObj:DisplayObject, defaultX:Float = 0, defaultY:Float = 0, percentWidth:Int = -1, percentHeight:Int = -1) 
	{
		_loc = location;
		_stayRelative = stayRelative;
		_displayObj = displayObj;
		
		_defaultX = defaultX;
		_defaultY = defaultY;
		
		_percentWidth = percentWidth;
		_percentHeight = percentHeight;
		
	}
	
	private function get_defaultX() : Float
	{
		return _defaultX;
	}
	
	private function get_defaultY() : Float
	{
		return _defaultY;
	}
	
	private function get_location() : Int
	{
		return _loc;
	}
	
	private function get_stayRelative() : Bool
	{
		return _stayRelative;
	}
	
	private function get_displayObj() : DisplayObject
	{
		return _displayObj;
	}
	
	private function get_percentWidth () : Int
	{
		return _percentWidth;
	}
	
	private function get_percentHeight() : Int
	{
		return _percentHeight;
	}
	
	
	
	
}