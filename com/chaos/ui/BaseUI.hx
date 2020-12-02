package com.chaos.ui;

import motion.actuators.GenericActuator;
import com.chaos.ui.classInterface.IBaseUI;


import openfl.display.DisplayObject;
import openfl.display.Sprite;
import motion.Actuate;
import motion.easing.*;




/**
 * Base UI element used in the framework
 *
 * @author Erick Feiling
 */

class BaseUI extends Sprite implements IBaseUI
{
	
	/**
	 * Calls draw function every time component width or height is adjusted
	 */
	public var drawOnResize(get, set) : Bool;
	
	/**
	 * Turns on or off image smoothing, which gives the image a nice anti aliasing effect
	 */
	
	public var imageSmoothing(get, set) : Bool;
	
	/**
	 * Enable or Disable component
	 */
    public var enabled(get, set) : Bool;
	
	/**
	 * This display object
	 */
	public var displayObject(get, never) : DisplayObject;
	
	/*
	* Use custom render created by theme. 
	*/
	public var useCustomRender(get,set) : Bool;

	/*
	* Use custom render created by theme. 
	*/
	public var defaultTweenDuration(get,set) : Float;	


    private var _width : Float = 0;
    private var _height : Float = 0;
    
    private var _enabled : Bool = true;
	private var _drawOnResize:Bool = false;
    
	private var _smoothImage : Bool = true;

	private var _useCustomRender:Bool = false;

	private var _defaultTweenDuration : Float = 1;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new( data:Dynamic = null )
    {
        super();
		
		// Make sure all style and bitmap skinning is set first
		reskin();
		
		// If object passed in then start setting defaults
		if (null != data)
			setComponentData(data);
		
		// Init component parts
		initialize();
		
		// Draw and texture object
		draw();
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	public function setComponentData(data:Dynamic):Void
	{
		
		if (Reflect.hasField(data, "width"))
			_width = Reflect.field(data, "width");
		
		if (Reflect.hasField(data, "height"))
			_height = Reflect.field(data, "height");
			
		if (Reflect.hasField(data, "enabled"))
			_enabled = Reflect.field(data, "enabled");

		if (Reflect.hasField(data, "useCustomRender"))
			_useCustomRender = Reflect.field(data, "useCustomRender");		

		if (Reflect.hasField(data, "defaultTweenDuration"))
			_defaultTweenDuration = Std.parseFloat( Reflect.field(data, "defaultTweenDuration"));
			
		if (Reflect.hasField(data, "x"))
			x = Reflect.field(data, "x");
		
		if (Reflect.hasField(data, "y"))
			y = Reflect.field(data, "y");
			
		if (Reflect.hasField(data, "name"))
			name = Reflect.field(data, "name");

	}
	
	/**
	 * initialize all importain objects
	 */
	
	public function initialize():Void
	{
		// Init objects here
	}
	
    
    /**
	 * Reload all bitmap images and UI Styles
	 */
	
    public function reskin() : Void
    {
        // Style and set all bitmap data objects here
    }
	
    /**
	 * Update the UI class
	 */
    public function draw() : Void
    {
        // Update component(s) here
        
	}
	
	/**
	* Apply a tween to this UI component or one of the display objects. Pass in duration of the tween or the default will be used.
	*
	* @param	data object with properties that will be used to adjust component or child DisplayObject.
	*/

	public function animateTo( data:Dynamic ) : GenericActuator<DisplayObject>
	{
		// See if it can find object
		var displayObj:DisplayObject = this;
		var duration: Float = Reflect.hasField(data,"duration") ? Reflect.field(data,"duration") : _defaultTweenDuration;

		if(Reflect.hasField(data,"obj")) {

			var obj:Dynamic = Reflect.field(data,"obj");

			if(Std.is(obj, String) && this.getChildByName(obj) != null)
				displayObj = this.getChildByName(obj);
			else 
				trace("[BaseUI::animateTo] Couldn't find " + obj + " going to default to using current " + this.name);
		}


		var tween:GenericActuator<DisplayObject> = Actuate.tween (displayObj, duration, data);

		if(Reflect.hasField(data,"delay"))
			tween.delay(Reflect.field(data,"delay"));

		if(Reflect.hasField(data,"reflect") && Reflect.field(data,"reflect"))
			tween.reflect();

		if(Reflect.hasField(data,"repeat"))
			tween.repeat(Reflect.field(data,"repeat"));

		if(Reflect.hasField(data,"ease"))
			tween.ease(getEase(Reflect.field(data,"ease")));
		else 
			tween.ease(getEase("Linear.easeNone"));

		// Call Back Events
		if(Reflect.hasField(data,"onComplete"))
			tween.onComplete(Reflect.field(data,"onComplete"));

		if(Reflect.hasField(data,"onRepeat"))
			tween.onRepeat(Reflect.field(data,"onRepeat"));

		if(Reflect.hasField(data,"onPause"))
			tween.onPause(Reflect.field(data,"onPause"));

		if(Reflect.hasField(data,"onResume"))
			tween.onResume(Reflect.field(data,"onResume"));		

		if(Reflect.hasField(data,"onUpdate"))
			tween.onResume(Reflect.field(data,"onUpdate"));		

		return tween;
	}

	/**
	* Pause the animation 
	*  @param	data object with the name of the object child object. If nothing is passed then the current object will be paused.
	**/

	public function pauseAnimate( data:Dynamic = null ) : Void
	{
		var displayObj:DisplayObject = (data != null && Reflect.hasField(data,"obj")) ? this.getChildByName(Reflect.field(data,"obj")) : this;
		Actuate.pause(DisplayObject);
	}

	/**
	* Resume the animation if it was paused
	*  @param	data object with the name of the object child object. If nothing is passed then the current object will be resume from being paused.
	**/

	public function resumeAnimate( data:Dynamic = null ) : Void
	{
		var displayObj:DisplayObject = (data != null && Reflect.hasField(data,"obj")) ? this.getChildByName(Reflect.field(data,"obj")) : this;
		Actuate.resume(displayObj);
	}

	/**
	* Stop the animation
	*  @param	data object with the name of the object child object. If nothing is passed then the current object animation will stop.
	**/

	public function stopAnimate( data:Dynamic = null ) : Void
	{
		var displayObj:DisplayObject = (data != null && Reflect.hasField(data,"obj")) ? this.getChildByName(Reflect.field(data,"obj")) : this;
		Actuate.stop(displayObj);
	}
	
	/**
	 * Unload Component
	 */
	
	public function destroy():Void
	{
		// Remove events and clear graphics here
	}	
    
    /**
	 * @inheritDoc
	 */
	

	override private function set_width(value : Float) : Float
	{
        _width = value;
		
		if (_drawOnResize)
		draw();
        
		
		return value;
	}

	
    /**
	 * @inheritDoc
	 */
	

    override private function get_width() : Float
    {
        return _width;
    }
	
    
    /**
	 * @inheritDoc
	 */
	

    override private function set_height(value : Float) : Float
    {
		if (_drawOnResize)
		draw();
		
        _height = value;
        
		
        return value;
    }	
	
	
    /**
	 * @inheritDoc
	 */
	

    override private function get_height() : Float
    {
        return _height;
    }
	
	
	private function set_drawOnResize(value:Bool):Bool
	{
		_drawOnResize = value;
		return value;
	}
	
	private function get_drawOnResize():Bool
	{
		return _drawOnResize;
	}
	
	/**
	 * Turn on or off smoothing for image
	 */
	
	private function set_imageSmoothing( value:Bool ) : Bool
	{
		_smoothImage = value;
		
		return value;
	}
	
	/**
	 * Turn on or off smoothing for image
	 */
	
	private function get_imageSmoothing() : Bool
	{
		return _smoothImage;
	}
	
	
    function set_enabled(value : Bool) : Bool
    {
        _enabled = value;
        return value;
    }
    
    function get_enabled() : Bool
    {
        return _enabled;
	}
	
	private function set_useCustomRender(value:Bool):Bool 
	{
		_useCustomRender = value;

		return _useCustomRender;
	}

	private function get_useCustomRender():Bool 
	{
		return _useCustomRender;	
	}	

	private function set_defaultTweenDuration( value:Float ) : Float
	{
		_defaultTweenDuration = value;

		return _defaultTweenDuration;
	}

	private function get_defaultTweenDuration() : Float 
	{
		return _defaultTweenDuration;
	}
    
    
    /**
	 * Return the this class DisplayObject so it can be added and removed from the stage
	 */
    
    function get_displayObject() : DisplayObject
    {
        return this;
	}
	
	private static function getEase(easing : String) : IEasing
		{
			if (easing.indexOf(".") == -1)
			{
				return Linear.easeNone;
			}
			
			var type : Array<String> = easing.toLowerCase().split(".");
			
			if (type[0].indexOf("back") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Back.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Back.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Back.easeInOut;
					}
				}
				else if (type[0].indexOf("cubic") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Cubic.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Cubic.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Cubic.easeOut;
					}				
				}
				else if (type[0].indexOf("elastic") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Elastic.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Elastic.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Elastic.easeInOut;
					}				
				}
				else if (type[0].indexOf("expo") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Expo.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Expo.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Expo.easeOut;
					}				
				}
				else if (type[0].indexOf("quad") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Quad.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Quad.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Quad.easeOut;
					}				
				}
				else if (type[0].indexOf("quart") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Quart.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Quart.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Quart.easeOut;
					}				
				}
				else if (type[0].indexOf("quint") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Quint.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Quint.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Quint.easeOut;
					}				
				}
				else if (type[0].indexOf("sine") != -1)
				{
					if (type[1].indexOf("easein") != -1)
					{
						return Sine.easeIn;
					}
					else if (type[1].indexOf("easeinout") != -1)
					{
						return Sine.easeInOut;
					}
					else if (type[1].indexOf("easeout") != -1)
					{
						return Sine.easeOut;
					}				
				}
			
			return Linear.easeNone;
		}	

}

