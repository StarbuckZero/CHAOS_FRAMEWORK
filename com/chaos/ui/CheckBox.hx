package com.chaos.ui;



import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ICheckBox;
import openfl.events.MouseEvent;

import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;

/**
 * Creates a checkbox
 */

class CheckBox extends SelectToggleBase implements ICheckBox implements IBaseUI
{

	/** The type of UI Element */
	public static inline var TYPE : String = "CheckBox";

	/** X or checkmark to be used in default draw mode **/
	public var style(get, set) : String;
	
	private static inline var STYLE_X:String = "x";
	private static inline var STYLE_CHECKMARK:String = "checkmark";
	
	private var _style:String = STYLE_CHECKMARK;
	
	
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */

	public function new(data:Dynamic = null)
	{
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		// Go with what's in data object first, UI style second
		if (Reflect.hasField(data, "textColor"))
			Reflect.setField(_labelData, "textColor", Reflect.field(data, "textColor") );

		else if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_TEXT_COLOR))
			Reflect.setField(_labelData, "textColor", UIStyleManager.CHECKBOX_TEXT_COLOR);
		
		// Go with what's in data object first, UI style second
		if (Reflect.hasField(data, "size"))
			Reflect.setField(_labelData, "size", Reflect.field(data, "size"));
		else if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_TEXT_SIZE))
			Reflect.setField(_labelData, "size", UIStyleManager.CHECKBOX_TEXT_SIZE);
		
		if (Reflect.hasField(data, "style"))
			_style = Reflect.field(data, "style");
		
		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_TEXT_ALIGN))
			Reflect.setField(_labelData, "align", UIStyleManager.getStyle(UIStyleManager.CHECKBOX_TEXT_ALIGN));
		
		// If not found then go with default
		if (!Reflect.hasField(_labelData, "bold") && !UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_TEXT_BOLD))
			Reflect.setField(_labelData, "bold", false);
		
		if (!Reflect.hasField(_labelData, "italic") && !UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_TEXT_ITALIC))
			Reflect.setField(_labelData, "italic", false);
	}

	override function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	override function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	override private function initSkin() : Void
	{
		// Skin element
		if (UIBitmapManager.hasUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_NORMAL))
			setDefaultStateImage(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_NORMAL));

		if (UIBitmapManager.hasUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_OVER))
			setOverStateImage(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_OVER));

		if (UIBitmapManager.hasUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DOWN))
			setDownStateImage(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DOWN));

		if (UIBitmapManager.hasUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DISABLE))
			setDisableStateImage(UIBitmapManager.getUIElement(CheckBox.TYPE, UIBitmapManager.CHECKBOX_DISABLE));
	}

	override private function initStyle() : Void
	{
		// Color
		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_NORMAL_COLOR))
			_defaultColor = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_NORMAL_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_OVER_COLOR))
			_overColor = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_DOWN_COLOR))
			_downColor = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_DOWN_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_DISABLE_COLOR))
			_disableColor = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_DISABLE_COLOR);
			
		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_DISABLE_COLOR))
			_disableColor = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_DISABLE_COLOR);
			
		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_SIZE))
			_buttonSize = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_SIZE);
		
		if (UIStyleManager.hasStyle(UIStyleManager.CHECKBOX_SIZE))
			_useCustomRender = UIStyleManager.getStyle(UIStyleManager.CHECKBOX_USE_CUSTOM_RENDER);
		
	}
	
	private function set_style(value:String) : String
	{
		_style = value;
		
		return value;
	}
	
	private function get_style() : String
	{
		return _style;
	}
	
    /**
	 * Update the UI class
	 */
	
	override public function draw():Void 
	{
		var radioButtonOffSetX : Int = UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_X) ? UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_X) : 0;
		var radioButtonOffSetY : Int = UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_Y) ? UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_Y) : 0;

        if(_useCustomRender && UIBitmapManager.hasCustomRenderTexture(CheckBox.TYPE) && _width > 0 && _height > 0) {

            _defaultStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"default","style":_style});
            _overStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"over","style":_style});
            _downStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"selected","style":_style});
			_disableStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"disable","style":_style});
			
            _selectedDefaultStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"default","style":_style});
            _selectedOverStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"over","style":_style});
            _selectedDownStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"selected","style":_style});
			_selectedDisableStateImage = UIBitmapManager.runCustomRender(CheckBox.TYPE,{"width":_buttonSize,"height":_buttonSize,"state":"disable","style":_style});
			
		}

		super.draw();
		
		// Update label size
		_label.text = _text;
		_label.width = _width - _buttonSize - radioButtonOffSetX;
		_label.height = _height;
		
		// Center Shapes
		_label.draw();
		_label.x = _buttonSize + radioButtonOffSetX;
		_label.y = (_height / 2) - (_label.height / 2) + radioButtonOffSetY;
		
		disableState.y = downState.y = overState.y = normalState.y = (_height / 2) - (_buttonSize / 2);
	}

	
	/**
	 * Draws shape that could be textured
	 * @param	square The shape that will be used
	 * @param	color The color of the shape if no image being passed
	 * @param	image The image
	 */
	
	override public function drawButtonState(base:ButtonBase, color:Int = 0xFFFFFF, borderColor:Int = 0x000000, image:BitmapData = null):Void 
	{
		
		if (image != null)
		{
			super.drawButtonState(base, color, image);
		}
		else
		{
			base.shapeBase.graphics.clear();
			base.shapeBase.graphics.lineStyle(_lineSize, color, _lineAlpha);
			base.shapeBase.graphics.drawRect(0,0,_buttonSize,_buttonSize);

			// Draw X if selected
			if (_selected)
			{
				base.shapeBase.graphics.moveTo(0, 0);
				if (_style == STYLE_X)
				{
					base.shapeBase.graphics.lineTo(_buttonSize, _buttonSize);
					base.shapeBase.graphics.moveTo(_buttonSize, 0);
					base.shapeBase.graphics.lineTo(0, _buttonSize);
				}
				else if (_style == STYLE_CHECKMARK)
				{
					base.shapeBase.graphics.moveTo(0, (_buttonSize / 2));
					base.shapeBase.graphics.lineTo(_buttonSize / 2, _buttonSize);
					base.shapeBase.graphics.lineTo(_buttonSize - 1, 0);
				}
			}
		}

	}
	
	override function mouseDownEvent(event:MouseEvent):Void 
	{
		super.mouseDownEvent(event);
		
		// Force redraw after select toggle
		draw();
	}

}