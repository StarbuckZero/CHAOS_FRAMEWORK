package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IToggleButton;
import com.chaos.ui.ButtonBase;

import openfl.display.BitmapData;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.display.Shape;


/**
 * Creates a simple toggle button it doesn't use a label or icon
 *
 * @author Erick Feiling
 */

class ToggleButton extends BaseUI implements IToggleButton implements IBaseUI {

	/** The type of UI Element */
	public static inline var TYPE:String = "ToggleButton";

	/**
	 * Border color for normal button state
	 */
	public var normalBorderColor(get, set):Int;

	/**
	 * Border color for over button state
	 */
	public var overBorderColor(get, set):Int;

	/**
	 * Border color for down button state
	 */
	public var downBorderColor(get, set):Int;

	/**
	 * Border color for disable button state
	 */
	public var disableBorderColor(get, set):Int;

	/**
	 * Set the border menu button alpha
	 */
	public var borderAlpha(get, set):Float;

	/**
	 * Border thinkness
	 */
	public var borderThinkness(get, set):Float;

	/**
	 * Set if you want the button to be selected or not
	 */
	public var selected(get, set):Bool;

	/**
	 * The button normal state color
	 */
	public var defaultColor(get, set):Int;

	/**
	 * The button over state color
	 */
	public var overColor(get, set):Int;

	/**
	 * The button down state color
	 */
	public var downColor(get, set):Int;

	/**
	 * The button disable state color
	 */
	public var disableColor(get, set):Int;

	/**
	 * Set how rounded the button is
	 */
	public var roundEdge(get, set):Int;

	/**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
	public var bitmapAlpha(get, set):Float;

	/**
	 * Title the image that is being used
	 */
	public var tileImage(get, set):Bool;

	/**
	 * Well do a cross fade effect on over and disable states
	 */
	public var stateFadeSpeed(get, set):Float;

	/**
	 * This will make sure down state fade in on click
	 */

	public var fadeToDownState(get, set):Bool;
	

	public var normalState:ButtonBase;
	public var overState:ButtonBase;
	public var downState:ButtonBase;
	public var disableState:ButtonBase;

	private var _defaultColor:Int = 0xCCCCCC;
	private var _overColor:Int = 0x666666;
	private var _downColor:Int = 0x333333;
	private var _disableColor:Int = 0x999999;

	private var _defaultStateImage:BitmapData;
	private var _overStateImage:BitmapData;
	private var _downStateImage:BitmapData;
	private var _disableStateImage:BitmapData;

	private var _roundEdge:Int = 0;

	private var _bgAlpha:Float = UIStyleManager.BUTTON_ALPHA;

	private var _selected:Bool = false;
	private var _tileImage:Bool = false;

	private var _border:Bool = UIStyleManager.TOGGLE_BUTTON_BORDER;
	private var _normalBorderColor:Int = 0x000000;
	private var _overBorderColor:Int = 0x000000;
	private var _downBorderColor:Int = 0x000000;
	private var _disableBorderColor:Int = 0x000000;
	private var _borderAlpha:Float = 1;
	private var _borderThinkness:Float = 1;
	private var _stateFadeSpeed:Float = 0;
	private var _fadeToDownState:Bool = false;

	/**
	 * UI Toggle Button
	 * @param	data The proprieties that you want to set on component.
	 */
	public function new(data:Dynamic = null) {
		super(data);

		// Setup events
		addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 2, true);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);

		buttonMode = true;
		mouseChildren = false;
	}

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	override public function setComponentData(data:Dynamic):Void {
		super.setComponentData(data);

		if (Reflect.hasField(data, "selected"))
			_selected = Reflect.field(data, "selected");

		// Base Colors
		if (Reflect.hasField(data, "defaultColor"))
			_defaultColor = Reflect.field(data, "defaultColor");

		if (Reflect.hasField(data, "overColor"))
			_overColor = Reflect.field(data, "overColor");

		if (Reflect.hasField(data, "downColor"))
			_downColor = Reflect.field(data, "downColor");

		if (Reflect.hasField(data, "disableColor"))
			_disableColor = Reflect.field(data, "disableColor");

		// Border Colors
		if (Reflect.hasField(data, "normalBorderColor"))
			_normalBorderColor = Reflect.field(data, "normalBorderColor");

		if (Reflect.hasField(data, "overBorderColor"))
			_overBorderColor = Reflect.field(data, "overBorderColor");

		if (Reflect.hasField(data, "downBorderColor"))
			_downBorderColor = Reflect.field(data, "downBorderColor");

		if (Reflect.hasField(data, "disableBorderColor"))
			_disableBorderColor = Reflect.field(data, "disableBorderColor");

		if (Reflect.hasField(data, "roundEdge"))
			_roundEdge = Reflect.field(data, "roundEdge");

		if (Reflect.hasField(data, "backgroundAlpha"))
			_bgAlpha = Reflect.field(data, "backgroundAlpha");

		if (Reflect.hasField(data, "border"))
			_border = Reflect.field(data, "border");

		if (Reflect.hasField(data, "stateFadeSpeed"))
			_stateFadeSpeed = Reflect.field(data, "stateFadeSpeed");

		if (Reflect.hasField(data, "fadeToDownState"))
			_fadeToDownState = Reflect.field(data, "fadeToDownState");		
		
	}

	/**
	 * initialize all importain objects
	 */
	override public function initialize():Void {
		super.initialize();

		
		normalState = new ButtonBase();
		overState = new ButtonBase();
		downState = new ButtonBase();
		disableState = new ButtonBase();

		
		addChild(downState);
		addChild(normalState);
		addChild(overState);
		addChild(disableState);
	}

	/**
	 * Unload Component
	 */
	override public function destroy():Void {
		super.destroy();

		// Remove Events
		removeEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent);
		removeEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent);
		removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);

		normalState.graphics.clear();
		overState.graphics.clear();
		downState.graphics.clear();
		disableState.graphics.clear();

		removeChild(normalState);
		removeChild(overState);
		removeChild(downState);
		removeChild(disableState);

		if (_defaultStateImage != null)
			_defaultStateImage.dispose();

		if (_defaultStateImage != null)
			_defaultStateImage.dispose();

		if (_downStateImage != null)
			_downStateImage.dispose();

		if (_disableStateImage != null)
			_disableStateImage.dispose();

		_disableStateImage = _downStateImage = _overStateImage = _defaultStateImage = null;
		disableState = downState = overState = normalState = null;
	}

	override function reskin() {
		super.reskin();

		initStyle();
		initBitmap();
	}

	private function initStyle() {
		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_ALPHA)
			_borderAlpha = UIStyleManager.TOGGLE_BUTTON_BORDER_ALPHA;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_NORMAL_COLOR)
			_normalBorderColor = UIStyleManager.TOGGLE_BUTTON_BORDER_NORMAL_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_OVER_COLOR)
			_overBorderColor = UIStyleManager.TOGGLE_BUTTON_BORDER_OVER_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_SELECTED_COLOR)
			_downBorderColor = UIStyleManager.TOGGLE_BUTTON_BORDER_SELECTED_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_DISABLE_COLOR)
			_disableBorderColor = UIStyleManager.TOGGLE_BUTTON_BORDER_DISABLE_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_BORDER_THINKNESS)
			_borderThinkness = UIStyleManager.TOGGLE_BUTTON_BORDER_THINKNESS;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_NORMAL_COLOR)
			_defaultColor = UIStyleManager.TOGGLE_BUTTON_NORMAL_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_OVER_COLOR)
			_overColor = UIStyleManager.TOGGLE_BUTTON_OVER_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_SELECTED_COLOR)
			_downColor = UIStyleManager.TOGGLE_BUTTON_SELECTED_COLOR;

		if (-1 != UIStyleManager.TOGGLE_BUTTON_DISABLE_COLOR)
			_disableColor = UIStyleManager.TOGGLE_BUTTON_DISABLE_COLOR;

		
		_useCustomRender = UIStyleManager.TOGGLE_BUTTON_USE_CUSTOM_RENDER;

		_tileImage = UIStyleManager.TOGGLE_TILE_IMAGE;

		_border = UIStyleManager.TOGGLE_BUTTON_BORDER;
	}

	private function initBitmap() {
		// Set skining if in UIBitmapManager
		if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_NORMAL))
			setDefaultStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_NORMAL));

		if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_OVER))
			setOverStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_OVER));

		if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_DOWN))
			setDownStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_DOWN));

		if (null != UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_DISABLE))
			setDisableStateImage(UIBitmapManager.getUIElement(Button.TYPE, UIBitmapManager.TOGGLE_BUTTON_DISABLE));
	}

	private function onStageAdd(event:Event):Void {
		UIBitmapManager.watchElement(TYPE, this);
	}

	private function onStageRemove(event:Event):Void {
		UIBitmapManager.stopWatchElement(TYPE, this);
	}

	/**
	 * Border color for normal button state
	 */
	private function set_normalBorderColor(value:Int):Int {
		_normalBorderColor = value;

		return value;
	}

	/**
	 * Return the color
	 */
	private function get_normalBorderColor():Int {
		return _normalBorderColor;
	}

	/**
	 * Border color for over button state
	 */
	private function set_overBorderColor(value:Int):Int {
		_overBorderColor = value;

		return value;
	}

	/**
	 * Return the color
	 */
	private function get_overBorderColor():Int {
		return _overBorderColor;
	}

	/**
	 * Border color for down button state
	 */
	private function set_downBorderColor(value:Int):Int {
		_downBorderColor = value;

		return value;
	}

	/**
	 * Return the color
	 */
	private function get_downBorderColor():Int {
		return _downBorderColor;
	}

	/**
	 * Border color for disable button state
	 */
	private function set_disableBorderColor(value:Int):Int {
		_disableBorderColor = value;

		return value;
	}

	/**
	 * Return the color
	 */
	private function get_disableBorderColor():Int {
		return _disableBorderColor;
	}

	/**
	 * Show or hide border around button
	 */
	private function set_border(value:Bool):Bool {
		_border = value;

		return value;
	}

	/**
	 * Return true if border is being shown and false if not
	 */
	private function get_border():Bool {
		return _border;
	}

	/**
	 * Border thinkness
	 */
	private function set_borderThinkness(value:Float):Float {
		_borderThinkness = value;
		return value;
	}

	/**
	 * Return thinkness
	 */
	private function get_borderThinkness():Float {
		return _borderThinkness;
	}

	private function set_borderAlpha(value:Float):Float {
		_borderAlpha = value;
		return value;
	}

	private function get_borderAlpha():Float {
		return _borderAlpha;
	}

	/**
	 * Set how rounded the button is
	 */
	private function set_roundEdge(value:Int):Int {
		_roundEdge = value;

		return value;
	}

	/**
	 * Return how rounded the button is
	 */
	private function get_roundEdge():Int {
		return _roundEdge;
	}

	/**
	 * The button normal state color
	 */
	private function set_defaultColor(value:Int):Int {
		_defaultColor = value;

		return value;
	}

	/**
	 * Return the normal state button color
	 */
	private function get_defaultColor():Int {
		return _defaultColor;
	}

	/**
	 * The button over state color
	 */
	private function set_overColor(value:Int):Int {
		_overColor = value;

		return value;
	}

	/**
	 * Return the button over state color
	 */
	private function get_overColor():Int {
		return _overColor;
	}

	/**
	 * The button down state color
	 */
	private function set_downColor(value:Int):Int {
		_downColor = value;

		return value;
	}

	/**
	 * Return the button down state color
	 */
	private function get_downColor():Int {
		return _downColor;
	}

	/**
	 * The button disable state color
	 */
	private function set_disableColor(value:Int):Int {
		_disableColor = value;

		return value;
	}

	/**
	 * Return the button disable state color
	 */
	private function get_disableColor():Int {
		return _disableColor;
	}

	/**
	 * Set if you want the button to be selected or not
	 */
	private function set_selected(value:Bool):Bool {
		_selected = value;

		return value;
	}

	/**
	 * Return if the button is on it's selected state
	 */
	private function get_selected():Bool {
		return _selected;
	}

	/**
	 * The alpha of the button roll over and down state. Use this if you only set the default bitmap image, this will tint the button.
	 */
	private function set_bitmapAlpha(value:Float):Float {
		_bgAlpha = value;

		return value;
	}

	/**
	 *  Return the alpha of the button
	 */
	private function get_bitmapAlpha():Float {
		return _bgAlpha;
	}

	private function set_tileImage(value:Bool):Bool {
		_tileImage = value;

		return value;
	}

	private function get_tileImage():Bool {
		return _tileImage;
	}

	/**
	 * The fade up speed of over and disable state
	 */
	 private function set_stateFadeSpeed(value:Float):Float {
		_stateFadeSpeed = value;

		return value;
	}

	/**
	 *  Return the current speed of fade rate
	 */
	private function get_stateFadeSpeed():Float {
		return _stateFadeSpeed;
	}

	/**
	 * The fade up speed of over and disable state
	 */
	 private function set_fadeToDownState(value:Bool):Bool {
		_fadeToDownState = value;

		return value;
	}

	/**
	 *  Return the current speed of fade rate
	 */
	private function get_fadeToDownState():Bool {
		return _fadeToDownState;
	}	

	/**
	 * This is for setting an shape for the button default state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setDefaultStateImage(value:BitmapData):Void {
		_defaultStateImage = value;
	}

	/**
	 * This is for setting an shape for the button over state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setOverStateImage(value:BitmapData):Void {
		_overStateImage = value;
	}

	/**
	 * This is for setting an shape for the button down state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setDownStateImage(value:BitmapData):Void {
		_downStateImage = value;
	}

	/**
	 * This is for setting an shape for the button down state
	 *
	 * @param value Set the shape that you want to use
	 *
	 */
	public function setDisableStateImage(value:BitmapData):Void {
		_disableStateImage = value;
	}

	/**
	 * Set if you want the button to be enabled or not
	 *
	 * @param value True if you want the button to be enabled and false if not
	 *
	 */
	override private function set_enabled(value:Bool):Bool {

		if (_enabled != value) {

			if (value) {
				// Add events
				if (!hasEventListener(MouseEvent.MOUSE_OUT))
					addEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent, false, 0, true);

				if (!hasEventListener(MouseEvent.MOUSE_OVER))
					addEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent, false, 0, true);

				if (!hasEventListener(MouseEvent.MOUSE_DOWN))
					addEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent, false, 0, true);

				if(_stateFadeSpeed > 0)
					disableState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
				else
					disableState.alpha = 0;
				
			} else {
				// Remove Events
				removeEventListener(MouseEvent.MOUSE_OUT, mouseOutEvent);
				removeEventListener(MouseEvent.MOUSE_OVER, mouseOverEvent);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownEvent);

				if(_stateFadeSpeed > 0)
					disableState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
				else
				{
					normalState.alpha = downState.alpha = overState.alpha = 0;
					disableState.alpha = 1;
				}
			}
		}

		super.enabled = buttonMode = value;

		return value;
	}

	/**
	 * This setup and draw the toogle button on the screen
	 */
	override public function draw():Void {

		// Check to see if Custom Texture will need to be used first
        if(_useCustomRender && UIBitmapManager.hasCustomRenderTexture(ToggleButton.TYPE) && _width > 0 && _height > 0) {
            _defaultStateImage = UIBitmapManager.runCustomRender(ToggleButton.TYPE,{"width":_width,"height":_height,"state":"default"});
            _overStateImage = UIBitmapManager.runCustomRender(ToggleButton.TYPE,{"width":_width,"height":_height,"state":"over"});
            _downStateImage = UIBitmapManager.runCustomRender(ToggleButton.TYPE,{"width":_width,"height":_height,"state":"down"});
            _disableStateImage = UIBitmapManager.runCustomRender(ToggleButton.TYPE,{"width":_width,"height":_height,"state":"disable"});
		}   

		// Figure to use bitmap or normal mode
		drawButtonState(normalState, _defaultColor, _normalBorderColor, _defaultStateImage);
		drawButtonState(overState, _overColor, _overBorderColor, _overStateImage);
		drawButtonState(downState, _downColor, _downBorderColor, _downStateImage);
		drawButtonState(disableState, _disableColor, _disableBorderColor, _disableStateImage);

		// Toggle Seleect state
		if (_selected) {
			
			if(_stateFadeSpeed > 0)
			{
				downState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
				normalState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
			}
			else 
			{
				downState.alpha = 1;
				disableState.alpha = overState.alpha = normalState.alpha = 0;
			}

		} else {

			if(_stateFadeSpeed > 0)
			{
				normalState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
				downState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
			}
			else
			{
				normalState.alpha = 1;
				disableState.alpha = overState.alpha = downState.alpha = 0;	
			}
		}

		if (!_enabled)
		{
			if(_stateFadeSpeed > 0)
				disableState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
			else
				disableState.alpha = 1;
		}
	}

	/**
	 * Draws shape that could be textured
	 * @param	square The shape that will be used
	 * @param	color The color of the shape if no image being passed
	 * @param	image The image
	 */
	public function drawButtonState(base:ButtonBase, color:Int = 0xFFFFFF, borderColor:Int = 0x000000, image:BitmapData = null):Void {

		base.setComponentData({"border":_border,"lineThinkness":_borderThinkness,"lineAlpha":_borderAlpha, "lineColor":borderColor,
		"baseAlpha":_bgAlpha,"tileImage":_tileImage,"image":image,"baseColor":color,"width":_width,"height":_height});

		base.draw();
	}

	private function mouseOutEvent(event:MouseEvent):Void {

		if(_stateFadeSpeed > 0)
		{
			if (_selected)
				downState.alpha = 1;
			else
				normalState.alpha = 1;

			overState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
		}
		else
		{
			overState.alpha = 0;

			if (_selected) {
				downState.alpha = 1;
				normalState.alpha = disableState.alpha = 0;
			} else {
				normalState.alpha = 1;
				downState.alpha = disableState.alpha = 0;
			}
		}


	}

	private function mouseOverEvent(event:MouseEvent):Void {

		// Check to set toggle
		if(_stateFadeSpeed > 0)
		{
			overState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
		}
		else
		{
			overState.alpha = 1;
			disableState.alpha = downState.alpha = normalState.alpha = 0;
		}
	}

	private function mouseDownEvent(event:MouseEvent):Void {
		// Toggle selected stage
		_selected = !_selected;

		if(_stateFadeSpeed > 0 && _fadeToDownState)
		{
			disableState.alpha = overState.alpha = 0;

			if (_selected) {
				downState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
				normalState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
			} else {
				normalState.animateTo({"duration":_stateFadeSpeed,"alpha":1});
				downState.animateTo({"duration":_stateFadeSpeed,"alpha":0});
			}
		}
		else
		{
			if (_selected) {
				downState.alpha = 1;
				disableState.alpha = overState.alpha = normalState.alpha = 0;
			} else {
				normalState.alpha = 1;
				disableState.alpha = overState.alpha = downState.alpha = 0;
			}
		}
	}
}
