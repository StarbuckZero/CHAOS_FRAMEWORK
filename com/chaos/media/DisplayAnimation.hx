package com.chaos.media;

import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * Display or apply an animation to a shape
 * @author Erick Feiling
 */

class DisplayAnimation extends BaseUI implements IBaseUI 
{
	public var index(get, never) : Int;
	public var rate(get, never) : Int;
	public var loop(get, never) : Bool;
	public var mode(get, set) : String;
	public var timer(get, never) : Timer;
	
	private var _index : Int = 0;
	private var _rate : Int = 1000;
	private var _timer : Timer;
	
	private var _shape:Shape;
	
	private var _loop:Bool = true;
	
	private var _mode:String = "framerate";
	
	private var _animation:Array<BitmapData> = new Array<BitmapData>();
	

	/**
	 * 
	 * @inheritDoc
	 */
	
	public function new(data:Dynamic = null) 
	{
		super(data);
	}
	
	/**
	 * @inheritDoc
	 */
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "rate"))
			_rate = Reflect.field(data, "rate");
			
		if (Reflect.hasField(data, "mode"))
			_mode = Reflect.field(data, "mode");
			
		if (Reflect.hasField(data, "loop"))
			_loop = Reflect.field(data, "loop");
			
	}
	
	/**
	 * @inheritDoc
	 */
	
	override public function initialize() : Void 
	{
		super.initialize();
		
		_timer = new Timer(_rate);
		_timer.stop();
		
		if (_mode.toLowerCase() == "timer")
			_timer.addEventListener(TimerEvent.TIMER, updateFrame);
		
	}	
	
	/**
	 * @inheritDoc
	 */
	override public function destroy():Void 
	{
		super.destroy();
		
		// Only add if there is no event
		if (hasEventListener(Event.ENTER_FRAME))
		removeEventListener(Event.ENTER_FRAME, updateFrame);		
		
		_timer.stop();
		_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, updateFrame);
		
		if (_shape != null)
			_shape.graphics.clear();
		
		for (i in 0 ... _animation.length)
			_animation[i].dispose();
			
		_animation = null;
		_shape = null;
		
	}
	
	private function set_loop( value:Bool ) : Bool
	{
		_loop = value;
		
		return value;
	}
	
	private function get_loop() : Bool
	{
		return _loop;
	}
	
	private function set_mode( value:String ) : String
	{
		_mode = value;
		return _mode;
	}
	
	private function get_mode() : String
	{
		return _mode;
	}
	
	private function get_index() : Int
	{
		return _index;
	}
	
	private function get_timer() : Timer
	{
		return _timer;
	}
	private function get_rate() : Int
	{
		return _rate;
	}
	
	
	/**
	 * Move to next frame
	 */
	
	public function next() : Void
	{
		// Don't go forward unless less than animation array
		if (_index < _animation.length - 1)
		{
			_index++;
			draw();
		}
	}
	
	/**
	 * Move back a frame
	 */
	
	public function prev() : Void
	{
		// Don't go back if less than 0
		if (_index > 0)
		{
			_index--;
			draw();
		}
	}
	
	
	/**
	 * Set index of frame
	 * @param	value the frame you want to be on
	 */
	
	public function setIndex( value:Int ):Void
	{
		// Make sure it's in range
		if (value >= 0 && value <= _animation.length -1)
			_index = value;
	}
	
	/**
	 * Draw animation to shape if not set then this object will be played here
	 * @param	value The shape to be used for animation
	 */
	
	public function drawAnimationTo(value:Shape) : Void
	{
		_shape = value;
	}
	
	/**
	 * Set the animation to be used
	 * @param	value The animation BitmapData
	 * @param	autoStart will start animation
	 */
	
	public function setAnimation( value:Array<BitmapData>, autoStart:Bool = false) : Void
	{
		_animation = value;
		
		if (autoStart)
			start();
	}
	
	/**
	 * Start animation
	 */
	
	public function start() : Void
	{
		if(_mode.toLowerCase() == "timer")
			_timer.start();
		else 
		{
			// Only add if there is no event
			if (!hasEventListener(Event.ENTER_FRAME))
			addEventListener(Event.ENTER_FRAME, updateFrame);
		}

	}
	
	/**
	 * Stop animation
	 */
	
	public function stop() : Void
	{
		if(_mode.toLowerCase() == "timer")
			_timer.stop();
		else 
			removeEventListener(Event.ENTER_FRAME, updateFrame);
	}

	
	private function updateFrame(event:Event):Void 
	{
		_index++;
		
		// Update index then go to draw
		if (_index >= _animation.length - 1)
		{
			
			_index = 0;
			
			if (!_loop)
				stop();
		}
		
		draw();
	}
	
	/**
	 * @inheritDoc
	 */
	
	override public function draw():Void 
	{
		super.draw();
		
		if (_animation.length > 0)
		{
			var image:BitmapData = _animation[_index];
			
			if (_shape != null)
			{
				_shape.graphics.clear();
				_shape.graphics.beginBitmapFill(image, null, false);
				_shape.graphics.drawRect(0, 0, _width, _height);
				_shape.graphics.endFill();

			}
			else
			{
				graphics.clear();
				graphics.beginBitmapFill(image, null, false);
				graphics.drawRect(0, 0, _width, _height);
				graphics.endFill();
				
			}
			
		}
		
		
	}
}