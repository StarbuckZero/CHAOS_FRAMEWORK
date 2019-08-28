package com.chaos.ui;

import com.chaos.ui.data.StageAlignmentObjectData;
import com.chaos.utils.Debug;
import openfl.display.DisplayObject;
import openfl.display.Stage;
import openfl.display.StageScaleMode;
import openfl.display.StageAlign;
import openfl.events.Event;


/**
 * For laying out elements at the stage level.
 */
class StageAlignmentManager
{


	/** Top Left **/
	public static inline var TL : Int = 1;
	
	/** Top Center **/
	public static inline var TC : Int = 2;
	
	/** Top Right **/
	public static inline var TR : Int = 3;
	
	/** Middle Left **/
	public static inline var ML : Int = 4;
	
	/** Middle Center **/
	public static inline var MC : Int = 5;
	
	/** Middle Right **/
	public static inline var MR : Int = 6;
	
	/** Bottom Left **/
	public static inline var BL : Int = 7;
	
	/** Bottom Center **/
	public static inline var BC : Int = 8;
	
	/** Bottom Right  **/
	public static inline var BR : Int = 9;

	private static var _stage : Stage;

	private static var _stageW : Int;
	private static var _stageH : Int;
	private static var _minW : Int;
	private static var _minH : Int;
	private static var _registeredObjects : Array<StageAlignmentObjectData>;

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
		_registeredObjects = new Array<StageAlignmentObjectData>();

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
			_registeredObjects.push(new StageAlignmentObjectData(loc, stayRelative, displayObj, percentWidth, percentHeight));
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
		
		for ( i in 0 ... _registeredObjects.length)
		{
			if (displayObj == _registeredObjects[i].displayObj)
				_registeredObjects.remove(_registeredObjects[i]);

		}
	}

	private static function onStageResize(e : Event = null) : Void
	{
		var sw : Int = ((_stage.stageWidth >= _minW)) ? _stage.stageWidth : _minW;
		var sh : Int = ((_stage.stageHeight >= _minH)) ? _stage.stageHeight : _minH;

		for (i in 0 ... _registeredObjects.length)
		{
			var stageAlignDataObj:StageAlignmentObjectData = _registeredObjects[i];


			switch (stageAlignDataObj.location)
			{
				
				case TL:

					if (!stageAlignDataObj.stayRelative)
						stageAlignDataObj.displayObj.x = stageAlignDataObj.displayObj.y = 0;

				case TC:

					if (stageAlignDataObj.stayRelative)
					{
						
						stageAlignDataObj.displayObj.x = (sw / 2) - (_stageW / 2) + stageAlignDataObj.defaultX;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw / 2) - (stageAlignDataObj.displayObj.width / 2);
						stageAlignDataObj.displayObj.y = 0;
					}

				case TR:

					if (stageAlignDataObj.stayRelative)
					{
						stageAlignDataObj.displayObj.x = sw - _stageW + stageAlignDataObj.defaultX;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw - stageAlignDataObj.displayObj.width);
						stageAlignDataObj.displayObj.y = 0;
					}

				case ML:
					if (stageAlignDataObj.stayRelative)
					{
						//x doesn't change
						stageAlignDataObj.displayObj.y = (sh / 2) - (_stageH / 2) + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = 0;
						stageAlignDataObj.displayObj.y = (sh / 2) - (stageAlignDataObj.displayObj.height / 2);
					}

				case MC:

					if (stageAlignDataObj.stayRelative)
					{
						stageAlignDataObj.displayObj.x = (sw / 2) - (_stageW / 2) + stageAlignDataObj.defaultX;
						stageAlignDataObj.displayObj.y = (sh / 2) - (_stageH / 2) + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw / 2) - (stageAlignDataObj.displayObj.width / 2);
						stageAlignDataObj.displayObj.y = (sh / 2) - (stageAlignDataObj.displayObj.height / 2);
					}

				case MR:
					if (stageAlignDataObj.stayRelative)
					{
						stageAlignDataObj.displayObj.x = sw - _stageW + stageAlignDataObj.defaultX;
						stageAlignDataObj.displayObj.y = (sh / 2) - (_stageH / 2) + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw - stageAlignDataObj.displayObj.width); 
						stageAlignDataObj.displayObj.y = (sh / 2) - (stageAlignDataObj.displayObj.height / 2);
					}

				case BL:
					if (stageAlignDataObj.stayRelative)
					{
						//x doesn't change
						stageAlignDataObj.displayObj.y = sh - _stageH + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = 0; 
						stageAlignDataObj.displayObj.y = (sh - stageAlignDataObj.displayObj.height);
					}

				case BC:
					if (stageAlignDataObj.stayRelative)
					{
						stageAlignDataObj.displayObj.x = (sw / 2) - (_stageW / 2) + stageAlignDataObj.defaultX;
						stageAlignDataObj.displayObj.y = sh - _stageH + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw / 2) - (stageAlignDataObj.displayObj.width / 2);
						stageAlignDataObj.displayObj.y = (sh - stageAlignDataObj.displayObj.height);
					}

				case BR:
					
					if (stageAlignDataObj.stayRelative)
					{
						stageAlignDataObj.displayObj.x = sw - _stageW + stageAlignDataObj.defaultX;
						stageAlignDataObj.displayObj.y = sh - _stageH + stageAlignDataObj.defaultY;
					}
					else
					{
						stageAlignDataObj.displayObj.x = (sw - stageAlignDataObj.displayObj.width);
						stageAlignDataObj.displayObj.y = (sh - stageAlignDataObj.displayObj.height);
					}

			}

			if (stageAlignDataObj.percentWidth > -1)
				stageAlignDataObj.displayObj.width = sw * stageAlignDataObj.percentWidth * .01;

			if (stageAlignDataObj.percentHeight > -1)
				stageAlignDataObj.displayObj.height = sh * stageAlignDataObj.percentHeight * .01;
		}
	}



	public function new()
	{
	}
}