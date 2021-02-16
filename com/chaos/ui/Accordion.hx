package com.chaos.ui;

import com.chaos.ui.classInterface.IAccordion;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.data.AccordionObjectData;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * Menu for holding content that is displayed based on click on title area
 *
 * @author Erick Feiling
 */
class Accordion extends BaseContainer implements IAccordion implements IBaseContainer implements IBaseUI {
	/** The type of UI Element */
	public static inline var TYPE:String = "Accordion";

	/**
	 * The current selected item
	 */
	public var selectedSectionName(get, never):String;

	/**
	 * Default state color
	 */
	public var buttonNormalColor(get, set):Int;

	/**
	 * Over state color
	 */
	public var buttonOverColor(get, set):Int;

	/**
	 * Selected state color
	 */
	public var buttonSelectedColor(get, set):Int;

	/**
	 * Disable state color
	 */
	public var buttonDisableColor(get, set):Int;

	/**
	 * Default state text color
	 */
	public var buttonTextColor(get, set):Int;

	/**
	 * Selected state text color
	 */
	public var buttonTextSelectedColor(get, set):Int;

	/**
	 * Adjust the height of the button
	 */
	public var buttonSize(get, set):Int;

	/**
	 * The animation speed of moving between sections
	 */
	 public var animationSpeed(get, set):Float;	

	private var _buttonNormalColor:Int = 0xCCCCCC;
	private var _buttonOverColor:Int = 0x666666;
	private var _buttonSelectedColor:Int = 0x333333;
	private var _buttonDisableColor:Int = 0x999999;

	private var _buttonTextColor:Int = 0xFFFFFF;
	private var _buttonTextSelectedColor:Int = 0xFFFFFF;

	private var _buttonDefaultImage:BitmapData;
	private var _buttonOverImage:BitmapData;
	private var _buttonDisableImage:BitmapData;
	private var _buttonDownImage:BitmapData;

	private var _buttonSize:Int = 20;

	private var _animationSpeed:Float = 0;

	private var _selectedSection:String = "";

	private var _currentSelected:AccordionObjectData;
	private var _lastSelected:AccordionObjectData;

	private var _section:Array<AccordionObjectData> = new Array<AccordionObjectData>();

	public function new(data:Dynamic = null) {
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}

	private function onStageAdd(event:Event):Void {
		UIBitmapManager.watchElement(TYPE, this);
	}

	private function onStageRemove(event:Event):Void {
		UIBitmapManager.stopWatchElement(TYPE, this);
	}

	override public function setComponentData(data:Dynamic):Void {
		super.setComponentData(data);

		if (Reflect.hasField(data, "data")) {
			var data:Array<Dynamic> = Reflect.field(data, "data");

			// Add section
			for (i in 0...data.length) {
				var dataObj:Dynamic = data[i];
				addSection(Reflect.field(dataObj, "name"), Reflect.field(dataObj, "text"), Reflect.field(dataObj, "content"));
			}
		}
	}

	override public function destroy():Void {
		super.destroy();


		// Remove all
		for (i in 0..._section.length) {
			_section[i].button.removeEventListener(MouseEvent.CLICK, onButtonClick);

			removeChild(_section[i].button.displayObject);
			removeChild(_section[i].container.displayObject);

			_section[i].container.destroy();
			_section[i].button.destroy();
		}

		if (_buttonDefaultImage != null)
			_buttonDefaultImage.dispose();

		if (_buttonOverImage != null)
			_buttonOverImage.dispose();

		if (_buttonDownImage != null)
			_buttonDownImage.dispose();

		if (_buttonDisableImage != null)
			_buttonDisableImage.dispose();

		_buttonDefaultImage = null;
		_buttonOverImage = null;
		_buttonDownImage = null;
		_buttonDisableImage = null;
	}

	override public function reskin():Void {
		super.reskin();

		setStyle();
		setBitmapStyle();
	}

	private function setStyle():Void {
		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_NORMAL_COLOR))
			_buttonNormalColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_NORMAL_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_OVER_COLOR))
			_buttonOverColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_COLOR))
			_buttonSelectedColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_DISABLE_COLOR))
			_buttonDisableColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_DISABLE_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_TEXT_COLOR))
			_buttonTextColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_TEXT_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_TEXT_COLOR))
			_buttonTextSelectedColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BUTTON_SELECTED_TEXT_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_BACKGROUND_COLOR))
			_backgroundColor = UIStyleManager.getStyle(UIStyleManager.ACCORDION_BACKGROUND_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.ACCORDION_USE_CUSTOM_RENDER))
			_useCustomRender = UIStyleManager.getStyle(UIStyleManager.ACCORDION_USE_CUSTOM_RENDER);
		
	}

	private function setBitmapStyle():Void {

        if (UIBitmapManager.hasUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_NORMAL)) 
			_buttonDefaultImage = UIBitmapManager.getUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_NORMAL);
		
        if (UIBitmapManager.hasUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_OVER)) 
            _buttonOverImage = UIBitmapManager.getUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_OVER);

        if (UIBitmapManager.hasUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_SELECTED)) 
			_buttonDownImage = UIBitmapManager.getUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_SELECTED);
		
        if (UIBitmapManager.hasUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_DISABLE)) 
            _buttonDisableImage = UIBitmapManager.getUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BUTTON_DISABLE);

        if (UIBitmapManager.hasUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BACKGROUND)) 
            setBackgroundImage(UIBitmapManager.getUIElement(Accordion.TYPE, UIBitmapManager.ACCORDION_BACKGROUND));

	}
		


	private function get_selectedSectionName():String {
		return _selectedSection;
	}

	private function set_buttonNormalColor(value:Int):Int {
		_buttonNormalColor = value;

		return value;
	}

	private function get_buttonNormalColor():Int {
		return _buttonNormalColor;
	}

	private function set_buttonOverColor(value:Int):Int {
		_buttonOverColor = value;

		return _buttonOverColor;
	}

	private function get_buttonOverColor():Int {
		return _buttonOverColor;
	}

	private function set_buttonSelectedColor(value:Int):Int {
		_buttonSelectedColor = value;

		return value;
	}

	private function get_buttonSelectedColor():Int {
		return _buttonSelectedColor;
	}

	private function set_buttonDisableColor(value:Int):Int {
		_buttonDisableColor = value;

		return _buttonDisableColor;
	}

	private function get_buttonDisableColor():Int {
		return _buttonDisableColor;
	}

	private function set_buttonTextColor(value:Int):Int {
		_buttonTextColor = value;
		return value;
	}

	private function get_buttonTextColor():Int {
		return _buttonTextColor;
	}

	private function set_buttonTextSelectedColor(value:Int):Int {
		_buttonTextSelectedColor = value;
		return value;
	}

	private function get_buttonTextSelectedColor():Int {
		return _buttonTextSelectedColor;
	}

	private function set_buttonSize(value:Int):Int {
		_buttonSize = value;

		return value;
	}

	private function get_buttonSize():Int {
		return _buttonSize;
	}

	private function set_animationSpeed(value:Float):Float {
		_animationSpeed = value;

		return value;
	}

	private function get_animationSpeed():Float {
		return _animationSpeed;
	}	

	/**
	 * This set the image for the over state
	 *
	 * @param value The image you want to use
	 *
	 */
	public function setDefaultStateImage(value:BitmapData):Void {
		_buttonDefaultImage = value;
	}

	/**
	 * This set the image for the over state
	 * @param	value The image you want to use
	 */
	public function setOverStateImage(value:BitmapData):Void {
		_buttonOverImage = value;
	}

	/**
	 * This set the image for the down state
	 * @param	value The image you want to use
	 */
	public function setDownStateImage(value:BitmapData):Void {
		_buttonDownImage = value;
	}

	/**
	 * This set the image for the disable state
	 * @param	value The image you want to use
	 */
	public function setDisableStateImage(value:BitmapData):Void {
		_buttonDisableImage = value;
	}

	/**
	 * Add section
	 * @param	sectionName The name of the section
	 * @param	title The text that will show up on the button for the section
	 * @param	content The DisplayObject you want to use
	 * @param	icon The icon that will be displayed on the button
	 */
	public function addSection(sectionName:String, title:String, content:DisplayObject, icon:BitmapData = null):Void {
		var container:BaseContainer = new BaseContainer({"name": sectionName + "_container", "content": content});
		var button:Button = new Button({
			"name": sectionName + "_button",
			"textColor": _buttonTextColor,
			"defaultColor": _buttonNormalColor,
			"overColor": _buttonOverColor,
			"downColor": _buttonSelectedColor,
			"disableColor": _buttonDisableColor,
			"text": title,
			"mode": "toggle"
		});

		button.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);

		_section.push(new AccordionObjectData(sectionName, button, container, content));

		// Hide it will be shown if selected later
		container.visible = false;

		_content.addChild(container);
		_content.addChild(button);

	}

	/**
	 * Get section data object for adjusting
	 * @param	value Name of the section
	 * @return object that gives access to button, container and content for section
	 */
	public function getSection(sectionName:String):AccordionObjectData {
		for (i in 0..._section.length) {
			if (_section[i].name == sectionName)
				return _section[i];
		}

		return null;
	}

	/**
	 * Close all menus
	 */
	public function closeAll():Void {
		for (i in 0..._section.length) {
			var button:IButton = _section[i].button;
			var container:IBaseContainer = _section[i].container;

			container.visible = button.selected = false;
			button.textColor = _buttonTextColor;
			container.y = button.y + button.height;	

			if(_animationSpeed > 0)
				button.animateTo({"duration":_animationSpeed,"y":i * _buttonSize});
			else
				button.y = i * _buttonSize;

			button.draw();
		}
	}

	/**
	 * Close all other sections and open one given
	 * @param	sectionName The name of the section
	 */
	public function open(sectionName:String):Void {

		var index:Int = -1;
	
		// Figure out what button to open based on section passed in
		for (i in 0 ... _section.length) {

			// Get the current section
			var section:AccordionObjectData = _section[i];

			// If the name match then open else close
			if (_section[i].name == sectionName) {

				// Take the current
				index = i;

				// Resize container based on how many sections below
				section.container.height = _height - (_buttonSize * _section.length);
				section.container.draw();

				// If the first item then  
				if(_animationSpeed > 0)
					section.button.animateTo({"duration":_animationSpeed,"y":(section.container.y - section.button.height)}).onComplete(onSectionComplete,[section]);
				else
				{
					section.button.y = section.container.y - section.button.height;
					section.container.visible = true;
				}
				
			}
			else
			{
				section.container.height = 0;
				
				section.button.selected = section.container.visible = false;
				section.button.draw();

				// If already see if items need to be shifted up or down
				if(index != -1)
				{
					// Grab whatever the last item was
					var selectedSection:AccordionObjectData = _section[index];

					// If true that means it's open so shift down based on height
					if(_animationSpeed > 0)
					{
						section.button.animateTo({"duration":_animationSpeed,"y":(selectedSection.container.y + selectedSection.container.height) + (_buttonSize * (i - (1 + index)) )});
					}
					else
						section.button.y = selectedSection.container.y + selectedSection.container.height + (_buttonSize * (i - (1 + index)));
				}
				else
				{
					if(_animationSpeed > 0)
						section.button.animateTo({"duration":_animationSpeed,"y":i * _buttonSize});
					else

						section.button.y = i * _buttonSize;
				}
			}
		}
	}

	/**
	 * Draw the container
	 */
	override public function draw():Void {

		if(UIStyleManager.hasStyle(UIStyleManager.ACCORDION_USE_CUSTOM_RENDER) && UIStyleManager.getStyle(UIStyleManager.ACCORDION_USE_CUSTOM_RENDER) && UIBitmapManager.hasCustomRenderTexture(Accordion.TYPE) && _width > 0 && _height > 0)
		{
			_buttonDefaultImage = UIBitmapManager.runCustomRender(Accordion.TYPE,{"width":_width,"height":_buttonSize,"state":"default"});
			_buttonOverImage = UIBitmapManager.runCustomRender(Accordion.TYPE,{"width":_width,"height":_buttonSize,"state":"over"});
			_buttonDownImage = UIBitmapManager.runCustomRender(Accordion.TYPE,{"width":_width,"height":_buttonSize,"state":"down"});
			_buttonDisableImage = UIBitmapManager.runCustomRender(Accordion.TYPE,{"width":_width,"height":_buttonSize,"state":"disable"});
			
			_imageBackground = UIBitmapManager.runCustomRender(Accordion.TYPE,{"width":_width,"height":_height,"state":"background"});
		}	
			
		super.draw();

		for (i in 0..._section.length) {
			var button:IButton = _section[i].button;
			var container:IBaseContainer = _section[i].container;
			button.useCustomRender = false;
			
			container.width = button.width = _width;
			button.height = _buttonSize;
			button.y = i * _buttonSize;

			button.defaultColor = _buttonNormalColor;
			button.overColor = _buttonOverColor;
			button.downColor = _buttonSelectedColor;
			button.disableColor = _buttonDisableColor;

			if(null != _buttonDefaultImage)
				button.setDefaultStateImage(_buttonDefaultImage);

			if(null != _buttonOverImage)
				button.setOverStateImage(_buttonOverImage);

			if(null != _buttonDownImage)
				button.setDownStateImage(_buttonDownImage);

			if(null != _buttonDisableImage)
				button.setDisableStateImage(_buttonDisableImage);

			container.y = button.y + button.height;

			// Check to see if it's open or not
			button.draw();
			container.draw();
		}
	}

	private function onButtonClick(event:MouseEvent):Void {
		// Get button name so can open menu
		var button:IButton = cast(event.currentTarget, IButton);

		open(button.name.substr(0, button.name.lastIndexOf("_button")));
		button.selected = true;
		button.textColor = _buttonTextSelectedColor;
		button.draw();
	}

	private function onSectionComplete(section:Dynamic):Void {

		cast(section,AccordionObjectData).container.visible = true;
	}
}
