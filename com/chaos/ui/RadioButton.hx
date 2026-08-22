package com.chaos.ui;



import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IRadioButton;
import openfl.events.MouseEvent;

import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.events.Event;

/**
 * Creates new radio button
 * @author Erick Feiling
 */
class RadioButton extends SelectToggleBase implements IRadioButton implements IBaseUI
{

	/**
	 * Name of group this button will be linked to
	 */
	public var groupName(get, set) : String;
	
	/**
	 * Side of dot
	 */
	public var dotSize(get, set) : Int;
	
	private var _groupName : String = "default";
	
	private var _dotSize : Int = 1;

	private var _labelOffX : Int = 0;
	private var _labelOffY : Int = 0;

	/**
	 * UI Radio Button 
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

		
		// Go with what's in data object first then see if set in UI style
		if (Reflect.hasField(data, "size"))
			Reflect.setField(_labelData, "size", Reflect.field(data, "size"));
		else if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_TEXT_SIZE))
			Reflect.setField(_labelData, "size", UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_TEXT_SIZE));
		
		if (Reflect.hasField(data, "dotSize"))
			_dotSize = Reflect.field(data, "dotSize");
			
		if (Reflect.hasField(data, "groupName"))
		{
			_groupName = Reflect.field(data, "groupName");
			
			// If group is not there then add it 
			if (!RadioButtonManager.groupCheck(_groupName))  
			RadioButtonManager.addGroup(_groupName); 
			
			// Add item to the manager  
			RadioButtonManager.addItem(_groupName, this);
		}
		
		if (""  != UIStyleManager.RADIOBUTTON_TEXT_ALIGN)
			Reflect.setField(_labelData, "align", UIStyleManager.RADIOBUTTON_TEXT_ALIGN);
		
		// If not found then go with default
		if (!Reflect.hasField(_labelData, "bold"))
			Reflect.setField(_labelData, "bold", UIStyleManager.RADIOBUTTON_TEXT_BOLD);
		
		if (!Reflect.hasField(_labelData, "italic"))
			Reflect.setField(_labelData, "italic", UIStyleManager.RADIOBUTTON_TEXT_ITALIC);

	}
	
	

	override function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(UIBitmapType.RadioButton, this); }
	override function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(UIBitmapType.RadioButton, this); }


	override function initBitmap():Void
	{
		// Unselected states
		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_NORMAL))
			setDefaultStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_NORMAL));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_OVER))
			setOverStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_OVER));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_DOWN))
			setDownStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_DOWN));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_DISABLE))
			setDisableStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_DISABLE));

		// Selected states
		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_NORMAL))
			setSelectedDefaultStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_NORMAL));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_OVER))
			setSelectedOverStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_OVER));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_DOWN))
			setSelectedDownStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_DOWN));

		if (UIBitmapManager.hasUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_DISABLE))
			setSelectedDisableStateImage(UIBitmapManager.getUIElement(UIBitmapType.RadioButton, UIBitmapManager.RADIOBUTTON_SELECTED_DISABLE));
	}

	override private function initStyle() : Void
	{
		super.initStyle();

		// Color
		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_NORMAL_COLOR))
			_defaultColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_NORMAL_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_OVER_COLOR))
			_overColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_DOWN_COLOR))
			_downColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_DOWN_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_DISABLE_COLOR))
			_disableColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_DISABLE_COLOR);

		// Selected colors
		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_SELECTED_NORMAL_COLOR))
			_selectedDefaultColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_SELECTED_NORMAL_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_SELECTED_OVER_COLOR))
			_selectedOverColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_SELECTED_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_SELECTED_DOWN_COLOR))
			_selectedDownColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_SELECTED_DOWN_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_SELECTED_DISABLE_COLOR))
			_selectedDisableColor = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_SELECTED_DISABLE_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_SIZE))
			_buttonSize = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_SIZE);
			
		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_DOT))
			_dotSize = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_DOT);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_X))
			_labelOffX = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_X);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_Y))
			_labelOffY = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_LABEL_OFFSET_Y);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_USE_CUSTOM_RENDER))
			_useCustomRender = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_USE_CUSTOM_RENDER);

		if (UIStyleManager.hasStyle(UIStyleManager.RADIOBUTTON_TILE_IMAGE))
			_tileImage = UIStyleManager.getStyle(UIStyleManager.RADIOBUTTON_TILE_IMAGE);
	}
	
	private function set_dotSize( value:Int ) : Int
	{
		_dotSize = value;
		return value;
	}
	
	private function get_dotSize() : Int
	{
		return _dotSize;
	}
	
	/**
	 * Set what group this radio button belong to
	 */
	private function set_groupName(value : String) : String
	{
		// Remove from old group
		RadioButtonManager.removeItem(_groupName, this);
		_groupName = value;
		
		// If group is not there then add it 
		if (!RadioButtonManager.groupCheck(_groupName))  
		RadioButtonManager.addGroup(_groupName); 
		
		// Add to group
		RadioButtonManager.addItem(_groupName, this);
		
        return value;
    }
	
	/**
	 * Return what group the
	 */  
	
	private function get_groupName() : String
	{
		return _groupName;
    }
	
    /**
	 * Draw the container
	 */
	
	override public function draw():Void {
		
		if (_useCustomRender &&UIBitmapManager.hasCustomRenderTexture(UIBitmapType.RadioButton) &&_buttonSize > 0) {
			var defaultImage = UIBitmapManager.runCustomRender(
				UIBitmapType.RadioButton,
				{
					width: _buttonSize,
					height: _buttonSize,
					state: "default"
				}
			);

			var overImage = UIBitmapManager.runCustomRender(
				UIBitmapType.RadioButton,
				{
					width: _buttonSize,
					height: _buttonSize,
					state: "over"
				}
			);

			var downImage = UIBitmapManager.runCustomRender(
				UIBitmapType.RadioButton,
				{
					width: _buttonSize,
					height: _buttonSize,
					state: "down"
				}
			);

			var disableImage = UIBitmapManager.runCustomRender(
				UIBitmapType.RadioButton,
				{
					width: _buttonSize,
					height: _buttonSize,
					state: "disable"
				}
			);

			var selectedDefaultImage = UIBitmapManager.runCustomRender(UIBitmapType.RadioButton, {width: _buttonSize, height: _buttonSize, state: "selected_default"});
			var selectedOverImage = UIBitmapManager.runCustomRender(UIBitmapType.RadioButton, {width: _buttonSize, height: _buttonSize, state: "selected_over"});
			var selectedDownImage = UIBitmapManager.runCustomRender(UIBitmapType.RadioButton, {width: _buttonSize, height: _buttonSize, state: "selected_down"});
			var selectedDisableImage = UIBitmapManager.runCustomRender(UIBitmapType.RadioButton, {width: _buttonSize, height: _buttonSize, state: "selected_disable"});

			if (defaultImage != null) {
				_defaultStateImage = defaultImage;
			}

			if (overImage != null) {
				_overStateImage = overImage;
			}

			if (downImage != null)
				_downStateImage = downImage;

			if (selectedDefaultImage != null)
				_selectedDefaultStateImage = selectedDefaultImage;

			if (selectedOverImage != null)
				_selectedOverStateImage = selectedOverImage;

			if (selectedDownImage != null)
				_selectedDownStateImage = selectedDownImage;

			if (selectedDisableImage != null)
				_selectedDisableStateImage = selectedDisableImage;

			if (disableImage != null) {
				_disableStateImage = disableImage;
			}
		}

		super.draw();

		if (_label != null) {
			_label.draw();
			_label.x = _buttonSize + _labelOffX;
			_label.y = (_height / 2) - (_label.height / 2) + _labelOffY;
		}

		var stateY:Float = (_height / 2) - (_buttonSize / 2);

		disableState.y = stateY;
		downState.y = stateY;
		overState.y = stateY;
		normalState.y = stateY;
	}

	
	/**
	 * Draws shape that could be textured
	 * @param	square The shape that will be used
	 * @param	color The color of the shape if no image being passed
	 * @param	image The image
	 */
	
	override public function drawButtonState(base:ButtonBase, color:Int = 0xFFFFFF, borderColor:Int = 0x000000, image:BitmapData = null):Void {

		if (image != null)
		{
			super.drawButtonState(base, color, borderColor, image);
			return;
		}

		base.shapeBase.graphics.clear();

		// Draw the styled fallback only when no complete bitmap state is supplied.
		base.shapeBase.graphics.lineStyle(_lineSize, color, _lineAlpha);

		base.shapeBase.graphics.beginFill(color, 0);
		base.shapeBase.graphics.drawCircle(0, 0, _buttonSize / 2);
		base.shapeBase.graphics.endFill();

		if (_selected) {
			base.shapeBase.graphics.lineStyle(_lineSize, color, _lineAlpha);

			base.shapeBase.graphics.beginFill(color, _bgAlpha);
			base.shapeBase.graphics.drawCircle(0, 0, _dotSize);

			base.shapeBase.graphics.endFill();
		}
	}
	
	override function mouseDownEvent(event:MouseEvent):Void 
	{
		super.mouseDownEvent(event);
		
		// Force redraw after select toggle
		RadioButtonManager.setGroupState(_groupName, false);
		_selected = true;
		
		draw();
		normalState.alpha = overState.alpha = disableState.alpha = 0;
		downState.alpha = 1;
	}

}