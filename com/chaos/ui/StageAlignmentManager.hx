package com.chaos.ui;

import com.chaos.utils.Debug;
import openfl.display.DisplayObject;
import openfl.display.Stage;
import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.events.Event;
import openfl.utils.Dictionary;
class StageAlignmentManager
{
    public static var stageObj(get, never) : Stage;
	
	// Nine slices for pinning objects
	public static inline var TL : Int = 1;
	public static inline var TC : Int = 2;
	public static inline var TR : Int = 3;
	public static inline var ML : Int = 4;
	public static inline var MC : Int = 5;
	public static inline var MR : Int = 6;
	public static inline var BL : Int = 7;
	public static inline var BC : Int = 8;
	public static inline var BR : Int = 9;
	
	private static var _stage : Stage;
	
	private static var _stageW : Int;
	private static var _stageH : Int;
	private static var _minW : Int;
	private static var _minH : Int;
	private static var _registeredObjects : Dictionary; 
	
	/**
	 * Inital call, sets stage and minimum stage size
	 *
	 * @param stageObj The stage object
	 * @param minW The smallest size the stage will resize to width wise. Default is 800
	 * @param minH The smallest size the stage will resize to height wise. Default is 600
	 *
	  */
	public static function init(stageObj : Stage, minW : Int = 800, minH : Int = 600) : Void
	{
		_stage = stageObj;
		_stageW = _stage.stageWidth;
		_stageH = _stage.stageHeight;
		_minW = minW;
		_minH = minH;
		_stage.scaleMode = StageScaleMode.NO_SCALE;
		_stage.align = StageAlign.TOP_LEFT;
		_registeredObjects = new Dictionary();
		_stage.addEventListener(Event.RESIZE, onStageResize);
    }
	
	/**
	 *
	 * If you need to stop positioning objects for some reason
	 */
	
	public static function kill() : Void
	{
		_stage.removeEventListener(Event.RESIZE, onStageResize);
	}
		
	/**
	 *
	 *	Used to add a display object to the list of objects that will be laid out. It use the current location and keep it in place.
	 *
	 *	@param disp The new display object you want to link to the stage
	 *	@param loc Pass one of the Nine slices for pinning objects alignment
	 *	@param stayRelative If true the object will retain it's original offset from the stage (when registered). If false the object will pin to whichever corner is set by loc.
	 */
	public static function registerLocation(displayObj : DisplayObject, loc : Int, stayRelative : Bool = false, percentWidth : Int = -1, percentHeight : Int = -1) : Void
	{
		if (_stage != null) 
		{
			Reflect.setField(_registeredObjects, Std.string(displayObj), { location : loc, stayRelative : stayRelative, ogX : displayObj.x, ogY : displayObj.y, } );
		
			if (percentWidth >= 0)
			Reflect.setField(_registeredObjects, Std.string(displayObj), percentWidth).percentWidth;
			
			if (percentHeight >= 0)  
			Reflect.setField(_registeredObjects, Std.string(displayObj), percentHeight).percentHeight;
			
			onStageResize(null);
		}
		else
			Debug.print("[StageAlignmentManager::registerLocation] Stage has not been set! Set the stage with the init function first.");
		
	}
		
	/**
	 * Stop tracking a display object when it comes to resize event
	 * @param	displayObj The name of the object you no longer want to track
	 */ 
	
	public static function unregisterLocation(displayObj : DisplayObject) : Void
	{
		if (null != Reflect.field(_registeredObjects, Std.string(displayObj)))
			Reflect.setField(_registeredObjects, Std.string(displayObj), null);
	}
	
	private static function onStageResize(e : Event = null) : Void
	{
		var sw : Int = ((_stage.stageWidth >= _minW)) ? _stage.stageWidth : _minW;
		var sh : Int = ((_stage.stageHeight >= _minH)) ? _stage.stageHeight : _minH;
		
		for (displayObj in Reflect.fields(_registeredObjects))
		{
			var _sw0_ = (Reflect.field(_registeredObjects, displayObj).location);            

            switch (_sw0_)
            {
				case TL:
					if (!Reflect.field(_registeredObjects, displayObj).stayRelative)
					displayObj.x = displayObj.y = 0;
					
				case TC:
					if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
					{
						displayObj.x = (sw / 2) - (_stageW / 2) + Reflect.field(_registeredObjects, displayObj).ogX;
					}
					else 
					{
						displayObj.x = (sw / 2) - (displayObj.width / 2);displayObj.y = 0;
					}
				case TR:
						
					if (Reflect.field(_registeredObjects, displayObj).stayRelative)
					{
						displayObj.x = sw - _stageW + Reflect.field(_registeredObjects, displayObj).ogX;
					}
					else 
					{
						displayObj.x = (sw - displayObj.width);displayObj.y = 0;
					}
					
					case ML:
						if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
						{ 
							//x doesn't change  
							displayObj.y = (sh / 2) - (_stageH / 2) + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = 0;displayObj.y = (sh / 2) - (displayObj.height / 2);
						}
					
					case MC:
						
						if (Reflect.field(_registeredObjects, displayObj).stayRelative)
						{
							displayObj.x = (sw / 2) - (_stageW / 2) + Reflect.field(_registeredObjects, displayObj).ogX;
							displayObj.y = (sh / 2) - (_stageH / 2) + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = (sw / 2) - (displayObj.width / 2);displayObj.y = (sh / 2) - (displayObj.height / 2);
						}
					
					case MR:
						if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
						{
							displayObj.x = sw - _stageW + Reflect.field(_registeredObjects, displayObj).ogX;
							displayObj.y = (sh / 2) - (_stageH / 2) + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = (sw - displayObj.width);displayObj.y = (sh / 2) - (displayObj.height / 2);
						}
						
					case BL:
						if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
						{  
							//x doesn't change
							displayObj.y = sh - _stageH + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = 0;displayObj.y = (sh - displayObj.height);
						}
					
					case BC:
						if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
						{
							displayObj.x = (sw / 2) - (_stageW / 2) + Reflect.field(_registeredObjects, displayObj).ogX;
							displayObj.y = sh - _stageH + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = (sw / 2) - (displayObj.width / 2);
							displayObj.y = (sh - displayObj.height);
						}
					
					case BR:
						if (Reflect.field(_registeredObjects, displayObj).stayRelative) 
						{
							displayObj.x = sw - _stageW + Reflect.field(_registeredObjects, displayObj).ogX;
							displayObj.y = sh - _stageH + Reflect.field(_registeredObjects, displayObj).ogY;
						}
						else 
						{
							displayObj.x = (sw - displayObj.width);displayObj.y = (sh - displayObj.height);
						}
						
            }
			
			if (Reflect.field(_registeredObjects, displayObj).exists("percentWidth"))   
			displayObj.width = sw * Reflect.field(_registeredObjects, displayObj).percentWidth * .01;
			
			if (Reflect.field(_registeredObjects, displayObj).exists("percentHeight"))   
			displayObj.height = sh * Reflect.field(_registeredObjects, displayObj).percentHeight * .01;
        }
    }
	
	private static function get_StageObj() : Stage
	{
		return _stage;
    }

    public function new()
    {
    }
}