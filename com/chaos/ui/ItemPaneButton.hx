package com.chaos.ui;

import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.display.BitmapData;
import openfl.display.Shape;

/**
 * ...
 * @author Erick Feiling
 */

class ItemPaneButton extends ToggleButton implements IToggleButton 
{

	public var label(get, never) : ILabel;
	public var showLabel(get, set) : Bool;
	
	private var _labelData:Dynamic = null;
	
	private var _label : Label;
	private var _icon : Shape;
	
	public function new(data:Dynamic=null) 
	{
		super(data);
		
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
	}
	
	override public function initialize():Void 
	{
		_label = new Label(_labelData);
		_icon = new Shape();
		
		super.initialize();
		
		_labelData = null;
		
		addChild(_label);
		addChild(_icon);
		
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
	
	override public function draw():Void 
	{
		super.draw();
		
		_label.width = _width;
		_label.height = _label.textField.textHeight;
		
		_label.x = UIStyleManager.ITEMPANE_LABEL_OFFSET_X;
		_label.y = (_height - _label.height) + UIStyleManager.ITEMPANE_LABEL_OFFSET_Y;
		
        _icon.x = UIStyleManager.ITEMPANE_ICON_LOC_X;
        _icon.y = UIStyleManager.ITEMPANE_ICON_LOC_Y;
		
	}
	
}