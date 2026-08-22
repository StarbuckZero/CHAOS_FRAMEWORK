package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextFieldAutoSize;

/**
 * Base class for Radio and CheckBox buttons
 * @author Erick Feiling
 */
class SelectToggleBase extends ToggleButton implements IToggleButton implements IBaseUI 
{
	/**
	 * Return label
	 */

	public var label(get, never) : ILabel;
	
	/**
	 * Is text selectable as well
	 */
	public var textSelectable(get, set) : Bool;
	
	/**
	 * Button Size
	 */
	public var buttonSize(get, set) : Int;
	
	/**
	 * Line Alpha
	 */
	public var lineAlpha(get, set) : Float;
	
	/**
	 * Line size
	 */
	public var lineSize(get, set) : Float;
	
	private var _label : Label;
	
	private var _selectedDefaultColor:Int = 0xCCCCCC;
	private var _selectedOverColor:Int = 0x666666;
	private var _selectedDownColor:Int = 0x333333;
	private var _selectedDisableColor:Int = 0x999999;

	
	private var _selectedDefaultStateImage : BitmapData;
	private var _selectedOverStateImage : BitmapData;
	private var _selectedDownStateImage : BitmapData;
	private var _selectedDisableStateImage : BitmapData;
	
	private var _textSelectable : Bool = true;

	private var _lineAlpha : Float = 1;
	
	private var _lineSize : Float = 2;

	private var _buttonSize : Int = 9;
	
	
	private var _text : String = "Label";
	private var _labelData : Dynamic;
	
	

	/**
	 * UI Select Toggle Button 
	 * @param	data The proprieties that you want to set on component.
	 */
	public function new(data:Dynamic=null) 
	{
		super(data);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		addEventListener(MouseEvent.MOUSE_UP, selectedToggleMouseUpEvent, false, 0, true);
		
	}
	
	override private function onStageAdd(event : Event) : Void 
	{
		
	}
	
	override private function onStageRemove(event : Event) : Void 
	{
		
	}
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		
		if (Reflect.hasField(data, "text") )
			_text = Reflect.field(data, "text");
		
		// Button Size
		if (Reflect.hasField(data, "buttonSize") )
			_buttonSize = Reflect.field(data, "buttonSize");
			
		if (Reflect.hasField(data, "lineSize") )
			_lineSize = Reflect.field(data, "lineSize");
			
		if (Reflect.hasField(data, "lineAlpha") )
			_lineAlpha = Reflect.field(data, "lineAlpha");
			
			
		// Componet data
		if (Reflect.field(data, "Label"))
		{
			// Set object
			_labelData = Reflect.field(data, "Label");
			
			// Add in default text
			Reflect.setField(_labelData, "text", _text);
		}
		else
		{
			_labelData = {"text": _text};
		}
		
		Reflect.setField(_labelData, "height", _height);
	}
	
	/**
	 * @inheritDoc
	 */
	
	override public function initialize():Void 
	{
		// Setup label
		_label = new Label(_labelData);
		_label.textField.selectable = false;
		_label.textField.wordWrap = true;
		_label.textField.multiline = false;
		_label.textField.autoSize = TextFieldAutoSize.LEFT;
		_label.align = "left";
		
		//_label.border = true;
		
		
		addChildAt(_label, 0);
		
		super.initialize();
	}
	
	override function initStyle() : Void
	{
		

	}
	
	override function initBitmap() : Void
	{

	}	
	
	/**
	 * @inheritDoc
	 */
	
	override public function reskin() : Void
	{
		super.reskin();

		initBitmap();
		initStyle();	
	}	
	
	
	/**
	 * @inheritDoc
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		removeEventListener(MouseEvent.MOUSE_UP, selectedToggleMouseUpEvent);
		
		_label.destroy();
		
		if (null != _selectedDefaultStateImage)
			_selectedDefaultStateImage.dispose();
		
		if (null != _selectedOverStateImage)
			_selectedOverStateImage.dispose();
		
		if (null != _selectedDownStateImage)
			_selectedDownStateImage.dispose();
			
		if (null != _selectedDisableStateImage)
			_selectedDisableStateImage.dispose();
		
		
		_selectedDefaultStateImage = _selectedOverStateImage = _selectedDownStateImage = _selectedDisableStateImage = null;
		
	}
	
	/**
	 * Set button width and height
	 */
	private function set_buttonSize( value:Int ) : Int
	{
		_buttonSize = value;
		return value;
	}
	
	/**
	 * Return the size of button
	 */
	private function get_buttonSize() : Int
	{
		return _buttonSize;
	}
	
	/**
	 * Set if user can select text to toggle button state as well
	 */
	private function set_textSelectable( value:Bool ) : Bool
	{
		_textSelectable = value;
		
		return value;
	}
	
	private function get_textSelectable() : Bool
	{
		return _textSelectable;
	}
	
	
	/**
	 * Return label 
	 */
	
	private function get_label():ILabel
	{
		return _label;
	}
	
	private function set_lineAlpha( value:Float ) : Float {
		_lineAlpha = value;

		return value;
	}

	private function get_lineAlpha() : Float {
		return _lineAlpha;
	}
	
	
	private function set_lineSize( value:Float ) : Float
	{
		_lineSize = value;
		return value;
	}
	
	private function get_lineSize() : Float
	{
		return _lineSize;
	}	
	
	
	
	public function setSelectedDefaultStateImage( value:BitmapData ) : Void
	{
		_selectedDefaultStateImage = value;
	}
	
	public function setSelectedOverStateImage( value:BitmapData ) : Void
	{
		_selectedOverStateImage = value;
	}
	
	public function setSelectedDownStateImage( value:BitmapData ) : Void
	{
		_selectedDownStateImage = value;
	}
	
	public function setSelectedDisableStateImage( value:BitmapData) : Void
	{
		_selectedDisableStateImage = value;
	}	
	
    /**
	 * Draw the container
	 */
	
	override public function draw():Void 
	{

		// Figure to use bitmap or normal mode
		if (_selected)
		{
			var selectedFallbackImage = _selectedDefaultStateImage;
			drawButtonState(normalState, _selectedDefaultColor, _normalBorderColor, selectedFallbackImage);
			drawButtonState(overState, _selectedOverColor, _overBorderColor, _selectedOverStateImage != null ? _selectedOverStateImage : selectedFallbackImage);
			drawButtonState(downState, _selectedDownColor, _downBorderColor, _selectedDownStateImage != null ? _selectedDownStateImage : selectedFallbackImage);
			drawButtonState(disableState, _selectedDisableColor, _disableBorderColor, _selectedDisableStateImage != null ? _selectedDisableStateImage : selectedFallbackImage);
		}
		else
		{

			drawButtonState(normalState,_defaultColor,_normalBorderColor,_defaultStateImage);
			drawButtonState(overState,_overColor,_overBorderColor,_overStateImage);
			drawButtonState(downState,_downColor,_downBorderColor,_downStateImage);
			drawButtonState(disableState,_disableColor,_disableBorderColor,_disableStateImage);
		}

		normalState.alpha = 1;
		overState.alpha = downState.alpha = disableState.alpha = 0;
		if (!_enabled)
		{
			normalState.alpha = 0;
			disableState.alpha = 1;
		}
		
		// Update label size
		_label.text = _text;
		_label.width = _width - _buttonSize;
		_label.height = _height;
		
		// Draw clear box for rollover states
		if (_textSelectable)
		{
			normalState.graphics.lineStyle(_lineSize, 0, 0);
			normalState.graphics.beginFill(0, 0);
			normalState.graphics.drawRect(0, 0, _width, _height);
			normalState.graphics.endFill();
			
			overState.graphics.lineStyle(_lineSize, 0, 0);
			overState.graphics.beginFill(0, 0);
			overState.graphics.drawRect(0, 0, _width, _height);
			overState.graphics.endFill();
			
			downState.graphics.lineStyle(_lineSize, 0, 0);
			downState.graphics.beginFill(0, 0);
			downState.graphics.drawRect(0, 0, _width, _height);
			downState.graphics.endFill();
			
			disableState.graphics.lineStyle(_lineSize, 0, 0);
			disableState.graphics.beginFill(0, 0);
			disableState.graphics.drawRect(0, 0, _width, _height);
			disableState.graphics.endFill();
		}		
		
		
	}
	
	/**
	 * Draws shape that could be textured
	 * @param	square The shape that will be used
	 * @param	color The color of the shape if no image being passed
	 * @param	image The image
	 */

	override public function drawButtonState(base:ButtonBase, color:Int = 0xFFFFFF, borderColor:Int = 0x000000, image:BitmapData = null):Void 
	{

		base.setComponentData({"border":_border,"lineThinkness":_borderThinkness,"lineAlpha":_borderAlpha, "lineColor":borderColor,
		 "baseAlpha":_bgAlpha,"tileImage":_tileImage,"image":image,"baseColor":color,"width":_buttonSize,"height":_buttonSize});

		 base.draw();
		
	}
	
	override function mouseOutEvent(event:MouseEvent):Void
	{
		showButtonState(_enabled ? normalState : disableState);
	}

	override function mouseOverEvent(event:MouseEvent):Void
	{
		if (_enabled)
			showButtonState(overState);
	}

	override function mouseDownEvent(event:MouseEvent):Void 
	{
		super.mouseDownEvent(event);
		draw();
		if (_enabled)
			showButtonState(downState);
	}

	private function selectedToggleMouseUpEvent(event:MouseEvent):Void
	{
		if (_enabled)
			showButtonState(overState);
	}

	private function showButtonState(state:ButtonBase):Void
	{
		normalState.alpha = state == normalState ? 1 : 0;
		overState.alpha = state == overState ? 1 : 0;
		downState.alpha = state == downState ? 1 : 0;
		disableState.alpha = state == disableState ? 1 : 0;
	}
	
}