package com.chaos.ui;

import motion.actuators.GenericActuator;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.UIBitmapManager.UIBitmapType;


import openfl.display.DisplayObject;
import openfl.display.BitmapData;
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
	private var _renderState:Dynamic = {};
	private var _styleOverrides:Dynamic = {};
	private var _bitmapOverrides:Dynamic = {};
    
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
		if (data == null)
			return;

		var skinChanged:Bool = false;

		if (Reflect.hasField(data, "Style"))
			skinChanged = syncStyleOverrides(Reflect.field(data, "Style")) || skinChanged;

		if (Reflect.hasField(data, "Bitmap"))
			skinChanged = syncBitmapOverrides(Reflect.field(data, "Bitmap")) || skinChanged;
		
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

		if (skinChanged)
			reskin();

	}
	
	/** Returns true when an instance style override or the active UIStyleManager defines the key. */
	public function hasResolvedStyle(styleName:String):Bool
	{
		return Reflect.hasField(_styleOverrides, styleName) || UIStyleManager.hasStyle(styleName);
	}

	/** Resolves instance style overrides before shared UIStyleManager defaults. */
	public function getResolvedStyle(styleName:String):Dynamic
	{
		return Reflect.hasField(_styleOverrides, styleName)
			? Reflect.field(_styleOverrides, styleName)
			: UIStyleManager.getStyle(styleName);
	}

	/** Returns true when an instance bitmap override or UIBitmapManager defines the state. */
	public function hasResolvedBitmap(UIType:UIBitmapType, bitmapName:String):Bool
	{
		return Reflect.hasField(_bitmapOverrides, bitmapName)
			|| UIBitmapManager.hasUIElement(UIType, bitmapName);
	}

	/** Resolves instance bitmap overrides before shared UIBitmapManager defaults. */
	public function getResolvedBitmap(UIType:UIBitmapType, bitmapName:String):BitmapData
	{
		if (Reflect.hasField(_bitmapOverrides, bitmapName))
		{
			var bitmap:BitmapData = Reflect.field(_bitmapOverrides, bitmapName);

			if (bitmap != null)
				return bitmap.clone();

			var managerBitmap:BitmapData = UIBitmapManager.getUIElement(UIType, bitmapName);
			return managerBitmap != null
				? managerBitmap
				: new BitmapData(1, 1, true, 0x00000000);
		}

		return UIBitmapManager.getUIElement(UIType, bitmapName);
	}

	/** Applies an already-loaded bitmap to one component instance. */
	public function setBitmapOverride(bitmapName:String, bitmap:BitmapData):Void
	{
		if (bitmapName == null || bitmapName == "" || bitmap == null)
			return;

		disposeBitmapOverride(bitmapName);
		Reflect.setField(_bitmapOverrides, bitmapName, bitmap.clone());
		reskin();
		draw();
	}

	/** Clears an instance bitmap so rendering falls back to UIBitmapManager. */
	public function removeBitmapOverride(bitmapName:String):Void
	{
		if (bitmapName == null || bitmapName == "")
			return;

		if (Reflect.hasField(_bitmapOverrides, bitmapName))
		{
			disposeBitmapOverride(bitmapName);

			// Keep a one-pass clear marker so reskin replaces any cached instance
			// bitmap with the manager fallback (or a transparent bitmap).
			Reflect.setField(_bitmapOverrides, bitmapName, null);
			reskin();
			draw();
			Reflect.deleteField(_bitmapOverrides, bitmapName);
		}
	}

	private function syncStyleOverrides(value:Dynamic):Bool
	{
		var source:Dynamic = value == null ? {} : value;
		var changed:Bool = false;

		for (field in Reflect.fields(_styleOverrides))
		{
			if (!Reflect.hasField(source, field))
			{
				Reflect.deleteField(_styleOverrides, field);
				changed = true;
			}
		}

		for (field in Reflect.fields(source))
		{
			var nextValue:Dynamic = Reflect.field(source, field);

			if (!Reflect.hasField(_styleOverrides, field)
				|| Reflect.field(_styleOverrides, field) != nextValue)
			{
				Reflect.setField(_styleOverrides, field, nextValue);
				changed = true;
			}
		}

		return changed;
	}

	private function syncBitmapOverrides(value:Dynamic):Bool
	{
		var source:Dynamic = value == null ? {} : value;
		var changed:Bool = false;

		for (field in Reflect.fields(_bitmapOverrides))
		{
			if (!Reflect.hasField(source, field))
			{
				disposeBitmapOverride(field);
				changed = true;
			}
		}

		// Serialized IDE data stores imported-image keys here. Actual BitmapData
		// values are installed asynchronously by the AuthoringLayer callback.
		for (field in Reflect.fields(source))
		{
			var nextValue:Dynamic = Reflect.field(source, field);

			if (Std.isOfType(nextValue, BitmapData))
			{
				disposeBitmapOverride(field);
				var bitmap:BitmapData = cast nextValue;
				Reflect.setField(_bitmapOverrides, field, bitmap.clone());
				changed = true;
			}
		}

		return changed;
	}

	private function disposeBitmapOverride(bitmapName:String):Void
	{
		if (!Reflect.hasField(_bitmapOverrides, bitmapName))
			return;

		var bitmap:BitmapData = Reflect.field(_bitmapOverrides, bitmapName);

		if (bitmap != null)
			bitmap.dispose();

		Reflect.deleteField(_bitmapOverrides, bitmapName);
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
		invalidateRenderState();
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

			if(Std.isOfType(obj, String) && this.getChildByName(obj) != null)
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
		Actuate.stop(this);

		for (bitmapName in Reflect.fields(_bitmapOverrides))
			disposeBitmapOverride(bitmapName);

		invalidateRenderState();
	}	

	/** Clears one cached render signature or all component render signatures. */
	private function invalidateRenderState(slot:String = null):Void
	{
		if (_renderState == null)
			_renderState = {};

		if (slot == null)
		{
			for (field in Reflect.fields(_renderState))
				Reflect.deleteField(_renderState, field);
		}
		else
			Reflect.deleteField(_renderState, slot);
	}

	/** Returns the existing custom texture until its type, parameters, or theme revision changes. */
	private function getCustomRenderTexture(slot:String, UIElement:UIBitmapType, data:Dynamic, current:Dynamic):Dynamic
	{
		if (_renderState == null)
			_renderState = {};

		var signature:String = UIBitmapManager.getCustomRenderCacheKey(UIElement, data);

		if (current != null && Reflect.field(_renderState, slot) == signature)
			return current;

		var rendered:Dynamic = UIBitmapManager.runCustomRender(UIElement, data);

		if (rendered == null)
			return current;

		Reflect.setField(_renderState, slot, signature);
		return rendered;
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
		_height = value;

		if (_drawOnResize)
			draw();
        
		
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
		if (_useCustomRender != value)
			invalidateRenderState();

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
    
    private function get_displayObject() : DisplayObject
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

