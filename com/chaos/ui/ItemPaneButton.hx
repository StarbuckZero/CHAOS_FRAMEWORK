package com.chaos.ui;

import openfl.events.MouseEvent;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.display.BitmapData;
import openfl.display.Shape;

/**
 * Button used for ItemPane
 */

class ItemPaneButton extends ToggleButton implements IToggleButton 
{

	/**
	 * Label used on button
	 */
	public var label(get, never) : ILabel;
	
	/**
	 * Show or hide label
	 */
	public var showLabel(get, set) : Bool;
	
	private var _labelData:Dynamic = null;
	
	private var _label : Label;
	private var _icon : Shape;
	private var _item : Shape;

	private var _defaultTextColor : Int = 0x000000;
	private var _selectedTextColor : Int = 0x000000;
	
	private var _itemLocX : Int = 0;
	private var _itemLocY : Int = 0;

	private var _iconLocX : Int = 0;
	private var _iconLocY : Int = 0;

	private var _labelLocX : Int = 0;
	private var _labelLocY : Int = -10;
	
	/**
	 * ItemPane Button 
	 * @param	data The proprieties that you want to set on component.
	 */
	
	public function new(data:Dynamic=null) 
	{
		super(data);
		
	}

	override function reskin() {
		super.reskin();

		if(UIStyleManager.hasStyle(UIStyleManager.ITEMPANE_TEXT_COLOR))
			_defaultTextColor = UIStyleManager.getStyle(UIStyleManager.ITEMPANE_TEXT_COLOR);
		
		if(UIStyleManager.hasStyle(UIStyleManager.ITEMPANE_TEXT_SELECTED_COLOR))
			_selectedTextColor = UIStyleManager.getStyle(UIStyleManager.ITEMPANE_TEXT_SELECTED_COLOR);

		if(UIStyleManager.hasStyle(UIStyleManager.ITEMPANE_LABEL_OFFSET_X))
			_labelLocX = UIStyleManager.getStyle(UIStyleManager.ITEMPANE_LABEL_OFFSET_X);

		if(UIStyleManager.hasStyle(UIStyleManager.ITEMPANE_LABEL_OFFSET_Y))
			_labelLocY = UIStyleManager.getStyle(UIStyleManager.ITEMPANE_LABEL_OFFSET_Y);

	}
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
			
		if (Reflect.hasField(data, "ItemLocX"))
			_itemLocX = Reflect.field(data, "ItemLocX");
		
		if (Reflect.hasField(data, "ItemLocY"))
			_itemLocY = Reflect.field(data, "ItemLocY");
			
	}
	
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeChild(_label);
		
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);

		_label.destroy();
		_label = null;
		
		removeChild(_icon);
		
		_icon.graphics.clear();
		_icon = null;
		
	}
	
	/**
	 * Setup button core components
	 */
	override public function initialize():Void 
	{
		_label = new Label(_labelData);
		_icon = new Shape();
		_item = new Shape();
		
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);

		super.initialize();
		
		_labelData = null;
		
		
		addChild(_icon);
		addChild(_item);
		addChild(_label);
	}
	
	
    /**
	 * Return the label that is being used in the button
	 */
    
    private function get_label() : ILabel
    {
        return _label;
    }
	
	private function set_showLabel( value:Bool ) : Bool
	{
		_label.visible = value;
		
		return value;
	}
	
	private function get_showLabel() : Bool
	{
		return _label.visible;
	}
    	
	public function setIcon( value:BitmapData ):Void
	{
		_icon.graphics.beginBitmapFill(value, null, false, true);
		_icon.graphics.drawRect(0, 0, value.width, value.height);
		_icon.graphics.endFill();
	}
	
	public function setItem( value:BitmapData ) : Void
	{
		_item.graphics.beginBitmapFill(value, null, false, true);
		_item.graphics.drawRect(0, 0, value.width, value.height);
		_item.graphics.endFill();
		
	}
	
	/**
	 * Update ItemPane button
	 */
	override public function draw():Void 
	{
		super.draw();
		
		_label.width = _width;
		_label.height = _label.textField.textHeight;
		_label.draw();
		
		_label.x = Std.int(_labelLocX);
		_label.y = Std.int((_height - _label.height) + _labelLocY);
		
        _icon.x = _iconLocX;
        _icon.y = _iconLocY;
		
		_item.x = _itemLocX;
		_item.y = _itemLocY;

		
	}

	private function onMouseUp(event:MouseEvent) {
		
		if(_enabled)
		{
			if(_selected)
				label.textColor = _selectedTextColor;
			else 
				label.textColor = _defaultTextColor;

			_label.draw();
		}
			
	}

	private function onMouseDown(event:MouseEvent) {

		if(_enabled)
		{
			label.textColor = _selectedTextColor;
			_label.draw();
		}

	}
	
}