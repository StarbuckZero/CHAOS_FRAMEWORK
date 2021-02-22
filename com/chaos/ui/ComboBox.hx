package com.chaos.ui;


import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IComboBox;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.ui.event.SliderEvent;
import com.chaos.utils.CompositeManager;
import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

import openfl.display.Shape;
import com.chaos.ui.data.ComboBoxObjectData;
import com.chaos.data.DataProvider;

import com.chaos.ui.Button;
import com.chaos.ui.Label;
import com.chaos.ui.ScrollBar;

import com.chaos.ui.ScrollContentBase;
import com.chaos.ui.event.ComboBoxEvent;
import openfl.display.DisplayObject;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.Event;

import openfl.text.Font;
import openfl.text.TextFormat;

/*
* A ComboBox which is a simple drop down list with text
*
*  @author Erick Feiling
*  @date 11-12-09
*
*/

class ComboBox extends BaseUI implements IComboBox implements IBaseUI
{
		
	/**
	 * Drop Down Button
	 */
	
	public var dropButton(get, never):IButton;
	
	/**
	 * ScrollBar
	 */
	
	public var scrollbar(get, never):IScrollBar;
	
	
	/**
	 * Current selected item
	 */
	
	public var selectedIndex(get, never) : Int;
	
	/**
	 * Set the track size of the scrollbar
	 */
	
	public var trackSize(get, set) : Int;
	
	/**
	 * Set the size of the button used on the combo box. The width is based on the height of the combox box.
	 */
	
	public var buttonWidth(get, set) : Int;
	
	/**
	 * Make it so the label can be clicked to show items much like dropdown
	 */
	
	public var clickLabelArea(get, set) : Bool;
	
	/**
	 * Replace the current data provider
	 */
	
	public var dataProvider(get, set) : DataProvider<ComboBoxObjectData>;
	

	/**
	 * Set the text for the main label on the combo box. This will be replace
	 */
	
	public var text(get, set) : String;
	
	/**
	 * Returns text label used on the combo box selected item area
	 */
	
	public var label(get, never) : ILabel;
	
	/**
	 * The color of the text in a label, in hexadecimal format.
	 */
	
	public var textColor(get, set) : Int;
	
	/**
	 * The color of the text in a label for it's roll over state
	 */
	
	public var textOverColor(get, set) : Int;
	
	/**
	 * The color of the text in a label for it's down state
	 */
	
	public var textDownColor(get, set) : Int;
	
	/**
	 * The color of the text roll over background
	 */
	
	public var backgroundColor(get, set) : Int;
	
	/**
	 * The color of the text roll over background
	 */
	
	public var textOverBackground(get, set) : Int;
	
	/**
	 * The color of the combo box border
	 */

	 
	public var borderColor(get, set) : Int;
	
	/**
	 * The border alpha being used around the combo box
	 */
	
	public var borderAlpha(get, set) : Float;
	
	/**
	 * The combo box border thinkness
	 */
	
	public var borderThinkness(get, set) : Float;
	
	
	/**
	 * Returns the number of objects being used in combox box
	 */
	
	public var length(get, never) : Int;
	
	/**
	 * The number of items that will be display once the user click the drop down button
	 */
	
	public var rowCount(get, set) : Int;
	
	
	public var itemBuffer(get, set) : Int;
	
	/**
	 * Set spacing for
	 */	
	
	public var dropDownPadding(get, set) : Int;


	/** The scrollbar offset */
	public static var SCROLLBAR_OFFSET : Int = 2;
	public static var DROPAREA_HEIGHT_PADDING : Int = 0;

	private var _selectLabel : Label;

	private var _selectIndex : Int = -1;
	private var _trackSize : Int = 15;

	private var _dropButton : Button;
	private var _scrollbar : ScrollBar;

	private var _dropDownScrollContent : ScrollContentBase;
	private var _dropDownList : Sprite = new Sprite();
	private var _dropDownLabelHolder:Sprite = new Sprite();

	private var _border : Shape = new Shape();
	private var _background : Shape = new Shape();

	private var _useEmbedFonts : Bool = false;
	private var _embedFont : Font;
	private var _dropDownBorder : Shape = new Shape();

	private var _outlineColor : Int = 0x000000;
	private var _thinkness : Float = 1;
	private var _rowCount : Int = 3;

	private var _buttonWidth : Int = 17;

	private var _list : DataProvider<ComboBoxObjectData> = new DataProvider<ComboBoxObjectData>();
	private var _listOpen : Bool = false;

	private var _backgroundColor : Int = 0xFFFFFF;
	private var _outlineAlpha : Float = 1;
	private var _showOutline : Bool = true;

	private var _buttonColor : Int = 0xCCCCCC;

	private var _textFormat : TextFormat  = new TextFormat();
	private var _textColor : Int = 0x000000;
	private var _textOverColor : Int = 0xFFFFFF;
	private var _textDownColor : Int = 0xCCCCCC;
	private var _textOverBackground : Int = 0x0000FF;
	private var _textDownBackground : Int = 0x999999;

	private var _dropDownButtonDefaultImage : BitmapData;
	private var _dropDownButtonOverImage : BitmapData;
	private var _dropDownButtonDown : BitmapData;
	private var _dropDownButtonDisable : BitmapData;
	
	private var _backgroundImage : BitmapData;
	private var _backgroundDropImage : BitmapData;
	
	private var _upIconButtonImage:BitmapData;
	private var _downIconImage:BitmapData;
	
	private var _scrollButtonDefaultImage : BitmapData;
	private var _scrollButtonOverImage : BitmapData;
	private var _scrollButtonDownImage : BitmapData;
	private var _scrollButtonDisableImage : BitmapData;
	
	private var _trackImage : BitmapData;
	
	private var _sliderButtonDefaultImage : BitmapData;
	private var _sliderButtonOverImage : BitmapData;
	private var _sliderButtonDownImage : BitmapData;
	private var _sliderButtonDisableImage : BitmapData;
	
	private var _showImage : Bool = true;

	private var _clickLabelArea : Bool = true;

	private var _dropDownHotspot : Sprite = new Sprite();
	private var _dropDownIcon:ArrowDownIcon;
	private var _dropDownPadding:Int = 0;
	private var _dropDownHeight:Float = 0;
	
	private var _itemDropDownSize:Shape = new Shape();
	private var _itemBuffer:Int = 4;
	private var _labelArray:Array<ILabel> = new Array<ILabel>();
	private var _lastScrollPercent:Float;
	private var _itemIndex:Int = 0;
	
	private var _labelData:Dynamic;
	private var _buttonData:Dynamic;
	
	private var _iconBorderColor:Int = 0xFFFFFF;

	/**
	 * UI ComboBox 
	 * @param	data The proprieties that you want to set on component.
	 */

	public function new(data = null)
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
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var dataObj:Dynamic = data[i];
				
				if (Reflect.hasField(dataObj,"text") && Reflect.hasField(dataObj, "value"))
					_list.addItem(new ComboBoxObjectData(i, Reflect.field(dataObj, "text"), Reflect.field(dataObj, "value"), (Reflect.hasField(dataObj, "selected")) ? Reflect.field(dataObj, "selected") : false));
			}
		}
		
		if (Reflect.hasField(data, "Label"))
			_labelData = Reflect.field(data, "Label");
		else
			_labelData = {"textColr":_textColor};
			
		if (Reflect.hasField(data, "Button"))
			_buttonData = Reflect.field(data, "Button");
	}

	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(UIBitmapType.ComboBox, this); stage.addEventListener(MouseEvent.MOUSE_DOWN, stageClick); }

	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(UIBitmapType.ComboBox, this); stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageClick); }

	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		_selectLabel = new Label(_labelData);
		
		// Scroll bars for drop down area
		Reflect.setField(_buttonData, "width", _buttonWidth);
		Reflect.setField(_buttonData, "height", _height);
		Reflect.setField(_buttonData, "showLabel", false);
		Reflect.setField(_buttonData, "iconDisplay", true);
		
		_dropButton = new Button(_buttonData);
		
		// Check and remove these if was set by UIBitmapManager
		if (null != _dropDownButtonDefaultImage)
		{
			_dropButton.setDefaultStateImage(_dropDownButtonDefaultImage.clone());
			
			_dropDownButtonDefaultImage.dispose();
			_dropDownButtonDefaultImage = null;
		}
			
		if (null != _dropDownButtonOverImage)
		{
			_dropButton.setOverStateImage(_dropDownButtonOverImage.clone());
			
			_dropDownButtonOverImage.dispose();
			_dropDownButtonOverImage = null;
		}
			
		if (null != _dropDownButtonDown)
		{
			_dropButton.setDownStateImage(_dropDownButtonDown.clone());
			
			_dropDownButtonDown.dispose();
			_dropDownButtonDown = null;
		}
		
		if (null != _dropDownButtonDisable)
		{
			_dropButton.setDisableStateImage(_dropDownButtonDisable.clone());
			
			_dropDownButtonDisable.dispose();
			_dropDownButtonDisable = null;
		}
		
		_dropButton.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);
		_dropDownHotspot.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);

		_dropDownIcon = new ArrowDownIcon({"width":5, "height":5, "borderColor":_iconBorderColor});
		
		super.initialize();
		
		// Create default text field and boarder
		_selectLabel.textColor = _textColor;
		_selectLabel.backgroundColor = _backgroundColor;
		
		_dropDownHotspot.buttonMode = true;
		
		// If there is no drop down icon then use default arrow
		if (null != _downIconImage)
		{
			_dropButton.setIcon(_downIconImage.clone());
			
			_downIconImage.dispose();
			_downIconImage = null;
			
		}
		else
		{
			_dropButton.setIcon(CompositeManager.displayObjectToBitmap(_dropDownIcon.displayObject, _smoothImage));
		}
		
		
		
		_labelData = null;
		
		// Add to display
		addChild(_background);
		addChild(_selectLabel);
		addChild(_dropButton);
		addChild(_border);
		addChild(_dropDownHotspot);	
		addChild(_dropDownLabelHolder);
	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Events
		_dropButton.removeEventListener(MouseEvent.CLICK, toggleList);
		_dropDownHotspot.removeEventListener(MouseEvent.CLICK, toggleList);
		
		
		// If open remove and destory 
		if (_listOpen)
			removeComboList();
		
		// Remove out screen
		removeChild(_selectLabel);
		removeChild(_dropDownHotspot);
		removeChild(_background);
		removeChild(_border);
		
		removeChild(_itemDropDownSize);
		removeChild(_dropDownList);
		removeChild(_dropDownBorder);
		
		// Clear graphics
		_dropDownHotspot.graphics.clear();
		_background.graphics.clear();
		_border.graphics.clear();
		
		// Destory the label
		_selectLabel.destroy();
		_scrollbar.destroy();
		
		// Combo Background
		if (null != _backgroundImage)
			_backgroundImage.dispose();
		
		if (null != _backgroundDropImage)
			_backgroundDropImage.dispose();

		// Scroll Area
		if (null != _upIconButtonImage)
			_upIconButtonImage.dispose();
			
		if(null != _downIconImage)
			_downIconImage.dispose();

		if (null != _scrollButtonDefaultImage)
			_scrollButtonDefaultImage.dispose();
		
		if (null != _scrollButtonOverImage)
			_scrollButtonOverImage.dispose();
		
		
		if (null != _scrollButtonDownImage)
			_scrollButtonDownImage.dispose();
			
		if(null != _scrollButtonDisableImage)
			_scrollButtonDisableImage.dispose();

		if(null != _trackImage)
			_trackImage.dispose();
		
		
		if (null != _sliderButtonDefaultImage)
			_sliderButtonDefaultImage.dispose();
		
		if (null != _sliderButtonOverImage)
			_sliderButtonOverImage.dispose();
			
		if (null != _sliderButtonDownImage)
			_sliderButtonDownImage.dispose();
		
		if (null != _sliderButtonDisableImage)
			_sliderButtonDisableImage.dispose();
		
		// Drop down area
		if (null != _dropDownButtonDefaultImage)
			_dropDownButtonDefaultImage.dispose();
		
		if (null != _dropDownButtonOverImage)
			_dropDownButtonOverImage.dispose();
			
		if (null != _dropDownButtonDown)
			_dropDownButtonDown.dispose();
			
		if (null != _dropDownButtonDisable)
			_dropDownButtonDisable.dispose();
		
		
			
		// Set everything to null
		_backgroundDropImage = _backgroundImage = null;
		_scrollButtonDisableImage = _scrollButtonDownImage = _scrollButtonOverImage = _scrollButtonDefaultImage = _downIconImage = _upIconButtonImage = null;
		_sliderButtonDisableImage = _sliderButtonDownImage = _sliderButtonOverImage = _sliderButtonDefaultImage = _trackImage = null;
		_dropDownButtonDisable = _dropDownButtonDown = _dropDownButtonOverImage = _dropDownButtonDefaultImage = null;
		
		
		_selectLabel = null;
		_dropDownHotspot = null;
		_background = null;
		_border = null;
		
		_itemDropDownSize = null;
		_dropDownList = null;
		
		_buttonData = _labelData = null;
		
	}	

	private function initBorder() : Void
	{
		// Setting the border outline
		if(UIStyleManager.hasStyle(UIStyleManager.COMBO_BORDER))
			_showOutline = UIStyleManager.getStyle(UIStyleManager.COMBO_BORDER);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BORDER_COLOR))
			_outlineColor = UIStyleManager.getStyle(UIStyleManager.COMBO_BORDER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BACKGROUND_COLOR))
			_backgroundColor = UIStyleManager.getStyle(UIStyleManager.COMBO_BACKGROUND_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BORDER_ALPHA))
			_outlineAlpha = UIStyleManager.getStyle(UIStyleManager.COMBO_BORDER_ALPHA);
	}

	private function initLabel() : Void
	{
		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_COLOR))
			_textColor = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_COLOR);

		//if ( -1 != UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR)
		//	_backgroundColor = UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR;

	}

	private function initBitmpDropDownButton() : Void
	{

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BACKGROUND));

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND))
			setDropDownBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND));

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_NORMAL))
			_dropDownButtonDefaultImage = UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_NORMAL).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_OVER))
			_dropDownButtonOverImage = UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_OVER).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DOWN))
			_dropDownButtonDown = UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DOWN).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DISABLE))
			_dropDownButtonDisable = UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DISABLE).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON))
			_downIconImage = UIBitmapManager.getUIElement(UIBitmapType.ComboBox, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON).clone();
		
			

		
		if (null != _dropButton)
		{

			// Check and remove these if was set by UIBitmapManager
			if (null != _dropDownButtonDefaultImage)
			{
				_dropButton.setDefaultStateImage(_dropDownButtonDefaultImage.clone());
				
				_dropDownButtonDefaultImage.dispose();
				_dropDownButtonDefaultImage = null;
			}
				
			if (null != _dropDownButtonOverImage)
			{
				_dropButton.setOverStateImage(_dropDownButtonOverImage.clone());
				
				_dropDownButtonOverImage.dispose();
				_dropDownButtonOverImage = null;
			}
				
			if (null != _dropDownButtonDown)
			{
				_dropButton.setDownStateImage(_dropDownButtonDown.clone());
				
				_dropDownButtonDown.dispose();
				_dropDownButtonDown = null;
			}
			
			if (null != _dropDownButtonDisable)
			{
				_dropButton.setDisableStateImage(_dropDownButtonDisable.clone());
				
				_dropDownButtonDisable.dispose();
				_dropDownButtonDisable = null;
			}			
			
			if (null != _downIconImage)
			{
				_dropButton.setIcon(_downIconImage.clone());
				
				_downIconImage.dispose();
				_downIconImage = null;
			}
		}
	}

	private function initBitmapScrollBar() : Void
	{
		
		
		// UI Skin/Theme for ScrollBar
		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL))
			_scrollButtonDefaultImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_OVER))
			_scrollButtonOverImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_OVER).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_DOWN))
			_scrollButtonDownImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_DOWN).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))
			_scrollButtonDisableImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE).clone();

		// Icons
		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_UP_ICON))
			_upIconButtonImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_UP_ICON).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_DOWN_ICON))
			_downIconImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_DOWN_ICON).clone();

		// Track
		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_TRACK))
			_trackImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_TRACK).clone();

		// Slider
		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))
			_sliderButtonDefaultImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER))
			_sliderButtonOverImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN))
			_sliderButtonDownImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN).clone();

		if (UIBitmapManager.hasUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE))
			_sliderButtonDisableImage = UIBitmapManager.getUIElement(UIBitmapType.ScrollBar, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE).clone();
		
		
		// Only if reskin was called and scrll bar is on screen
		if (null != _scrollbar)
		{
			// Up and Down Buttons
			if (null != _scrollButtonDefaultImage)
			{
				_scrollbar.upButton.setDisableStateImage(_scrollButtonDefaultImage.clone());
				_scrollbar.downButton.setDisableStateImage(_scrollButtonDefaultImage.clone());
				
				_scrollButtonDefaultImage.dispose();
				_scrollButtonDefaultImage = null;
			}
			
			if (null != _scrollButtonOverImage)
			{
				_scrollbar.upButton.setOverStateImage(_scrollButtonOverImage.clone());
				_scrollbar.downButton.setOverStateImage(_scrollButtonOverImage.clone());
				
				_scrollButtonOverImage.dispose();
				_scrollButtonOverImage = null;
			}
			
			
			if (null != _scrollButtonDownImage)
			{
				_scrollbar.upButton.setDownStateImage(_scrollButtonDownImage.clone());
				_scrollbar.downButton.setDownStateImage(_scrollButtonDownImage.clone());
				
				_scrollButtonDownImage.dispose();
				_scrollButtonDownImage = null;
			}
			
			if (null != _scrollButtonDisableImage)
			{
				_scrollbar.upButton.setDownStateImage(_scrollButtonDisableImage.clone());
				_scrollbar.downButton.setDownStateImage(_scrollButtonDisableImage.clone());
				
				_scrollButtonDisableImage.dispose();
				_scrollButtonDisableImage = null;
			}
			
			// Icons
			if (null != _upIconButtonImage)
			{
				_scrollbar.upButton.setIcon(_upIconButtonImage.clone());
				
				_upIconButtonImage.dispose();
				_upIconButtonImage = null;
			}
			
			if (null != _downIconImage)
			{
				_scrollbar.downButton.setIcon(_downIconImage.clone());
				
				_downIconImage.dispose();
				_downIconImage = null;
			}
			
			// Slider
			if (null != _sliderButtonDefaultImage)
			{
				_scrollbar.slider.setSliderImage(_sliderButtonDefaultImage.clone());
				
				_sliderButtonDefaultImage.dispose();
				_sliderButtonDefaultImage = null;
			}
			
			if (null != _sliderButtonOverImage)
			{
				_scrollbar.slider.setSliderOverImage(_sliderButtonOverImage.clone());
				
				_sliderButtonOverImage.dispose();
				_sliderButtonOverImage = null;
			}
			
			if (null != _sliderButtonDownImage)
			{
				_scrollbar.slider.setSliderDownImage(_sliderButtonDownImage.clone());
				
				_sliderButtonDownImage.dispose();
				_sliderButtonDownImage = null;
			}
			
			if (null != _sliderButtonDisableImage)
			{
				_scrollbar.slider.setSliderDisableImage(_sliderButtonDisableImage.clone());
				
				_sliderButtonDisableImage.dispose();
				_sliderButtonDisableImage = null;
			}
		}
	}

	private function initComboBoxStyle() : Void
	{
		
		// Set Label Style
		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_SIZE))
			_textFormat.size = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_SIZE);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_ITALIC))
			_textFormat.italic = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_ITALIC);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_BOLD))
			_textFormat.bold = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_BOLD);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_FONT))
			_textFormat.font = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_FONT);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_ALIGN))
			_textFormat.align = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_ALIGN);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_SIZE))
			_textFormat.size = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_SIZE);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_EMBED))
			_selectLabel.setEmbedFont(UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_EMBED));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_DEFAULT_TEXT))
			_selectLabel.text = UIStyleManager.getStyle(UIStyleManager.COMBO_DEFAULT_TEXT);

		// Set the Style for Over and Down states
		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_OVER_COLOR))
			_textOverColor = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR))
			_textOverBackground = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_DOWN_COLOR))
			_textOverColor = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_DOWN_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_TEXT_DOWN_BACKGROUND_COLOR))
			_textDownBackground = UIStyleManager.getStyle(UIStyleManager.COMBO_TEXT_DOWN_BACKGROUND_COLOR);

			
		// Drop Down Button
		_buttonData = {};
		
		
		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_NORMAL_COLOR))
			Reflect.setField(_buttonData, "defaultColor", UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_NORMAL_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_OVER_COLOR))
			Reflect.setField(_buttonData, "overColor", UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_OVER_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_DOWN_COLOR))
			Reflect.setField(_buttonData, "downColor", UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_DOWN_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_DISABLE_COLOR))
			Reflect.setField(_buttonData, "disableColor", UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_DISABLE_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_ICON_COLOR))
			Reflect.setField(_buttonData, "disableColor", UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_DISABLE_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_BUTTON_ICON_BORDER_COLOR))
			_iconBorderColor = UIStyleManager.getStyle(UIStyleManager.COMBO_BUTTON_ICON_BORDER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.COMBO_DROPDOWN_PADDING))
			_dropDownPadding = UIStyleManager.getStyle(UIStyleManager.COMBO_DROPDOWN_PADDING);

	}
	
	private function set_itemBuffer(value:Int):Int
	{
		_itemBuffer = value;
		return value;
	}
	
	private function get_itemBuffer():Int
	{
		return _itemBuffer;
	}

	/**
	 * Return a int value of the current selected item
	 */
	
	private function get_selectedIndex() : Int { return _selectIndex; }

	/**
	 * @inheritDoc
	 */

	override public function reskin() : Void
	{
		super.reskin();
		
		initBorder();
		initComboBoxStyle();
		
		initLabel();

		initBitmpDropDownButton();
		initBitmapScrollBar();

	}
	
	/**
	 * Drop Down button
	 * @return The drop down button being used
	 */
	
	
	private function get_dropButton():IButton
	{
		return _dropButton;
	}
	
	/**
	 * Return the scrollbar used in combo box
	 * @return A scroll bar interface
	 */

	private function get_scrollbar() : IScrollBar 
	{
		return _scrollbar; 
	}


	/**
	* Set the track size of the scrollbar
	*/
	private function set_trackSize(value : Int) : Int
	{
		_scrollbar.trackSize = _trackSize = value;

		return value;
	}

	/**
	* Returns the track size which is based on the direction the scrollbar is pointed
	*/
	private function get_trackSize() : Int { return _trackSize; }

	/**
	* Set the size of the button used on the combo box. The width is based on the height of the combox box.
	*/
	private function set_buttonWidth(value : Int) : Int
	{
		_buttonWidth = value;
		

		return value;
	}

	/**
	* Returns the size of the button width being used.
	*/

	private function get_buttonWidth() : Int { return _buttonWidth; }

	

	private function set_borderThinkness( value : Float) : Float
	{
		_thinkness = value;

		return value;
	}

	private function get_borderThinkness(): Float
	{
		return _thinkness;
	}

	private function set_dropDownPadding( value:Int ):Int
	{
		_dropDownPadding = value;

		return value;
	}

	private function get_dropDownPadding():Int
	{
		return _dropDownPadding;
	}


	/**
	 * Make it so the label can be clicked to show items much like dropdown
	 */

	private function set_clickLabelArea(value : Bool) : Bool
	{
		_clickLabelArea = value;

		return value;
	}

	/**
	 * Return true if the user is able to click the lable area to show items and false if not
	 */

	private function get_clickLabelArea() : Bool { return _clickLabelArea; }



	/**
	 * Replace the current data provider
	 */

	private function set_dataProvider(value : DataProvider<ComboBoxObjectData>) : DataProvider<ComboBoxObjectData>
	{
		_list = value;
		return value;
	}

	/**
	 * Returns the data provider being used
	 */

	private function get_dataProvider() : DataProvider<ComboBoxObjectData> { return _list; }

	/**
	* Set the text for the main label on the combo box. This will be replace
	*/

	private function set_text(value : String) : String
	{
		_selectLabel.text = value;
		

		return value;
	}

	/**
	* Returns text used on the combo box selected item area
	*/

	private function get_text() : String 
	{
		return _selectLabel.text; 
	}

	/**
	* Returns text label used on the combo box selected item area
	*/

	private function get_label() : ILabel 
	{
		return _selectLabel; 
		
	}

	/**
	* Configure and setup the label to handle embedded fonts
	*
	* @param value The font you want to use.
	*
	*/

	public function setEmbedFont(value : Font) : Void 
	{
		_embedFont = value;
		_useEmbedFonts = true;
		_selectLabel.setEmbedFont(value); 
		
	};

	/**
	* Unload the font that was set by using the setEmbedFont
	*
	*/

	public function unloadEmbedFont() : Void 
	{
		_selectLabel.unloadEmbedFont();
		_embedFont = null;
		_useEmbedFonts = false; 
		
	}

	/**
	* The color of the text in a label, in hexadecimal format.
	*/

	private function set_textColor(value : Int) : Int
	{
		_textColor = value;
		

		return value;
	}

	/**
	* Returns the default color
	*/

	private function get_textColor() : Int 
	{
		return _textColor;
		
	}

	/**
	* The color of the text in a label for it's roll over state
	*/

	private function set_textOverColor(value : Int) : Int
	{
		_textOverColor = value;
		

		return value;
	}

	/**
	* Returns the color being used for the over state
	*/
	private function get_textOverColor() : Int 
	{
		return _textOverColor; 
		
	}

	/**
	* The color of the text in a label for it's down state
	*/

	private function set_textDownColor(value : Int) : Int
	{
		_textDownColor = value;
		

		return value;
	}

	/**
	* Returns the color being used for the down state
	*/

	private function get_textDownColor() : Int 
	{
		return _textDownColor; 
		
	}

	/**
	* The color of the text roll over background
	*/

	private function set_backgroundColor(value : Int) : Int
	{
		_backgroundColor = value;
		

		return value;
	}

	/**
	*  Returns the color being used for the background default state.
	*/

	private function get_backgroundColor() : Int
	{
		return _backgroundColor; 
	}

	/**
	* The color of the text roll over background
	*/

	private function set_textOverBackground(value : Int) : Int
	{
		_textOverBackground = value;

		return value;
	}

	/**
	*  Return the color being used for the text label roll over state
	*/

	private function get_textOverBackground() : Int { return _textOverBackground; }

	/**
	* The color of the combo box border
	*/

	private function set_borderColor(value : Int) : Int
	{
		_outlineColor = value;
		

		return value;
	}

	/**
	* Return border color
	*/

	private function get_borderColor() : Int { return _outlineColor; }

	/**
	* The border alpha being used around the combo box
	*/

	private function set_borderAlpha(value : Float) : Float
	{
		_outlineAlpha = value;

		return value;
	}

	/**
	* Return border border alpha
	*/

	private function get_borderAlpha() : Float { return _outlineAlpha; }

	/**
	* Returns the number of objects being used in combox box
	*/

	private function get_length() : Int { return _list.length; }

	/**
	* The number of items that will be display once the user click the drop down button
	*/

	private function set_rowCount(value : Int) : Int { _rowCount = value; return value; }

	/**
	* Returns the number of items that will be listed
	*/

	private function get_rowCount() : Int { return _rowCount; }

	/**
	* Set if the combo box will be enabled or disable
	*/

	override private function set_enabled(value : Bool) : Bool
	{
		super.enabled = _scrollbar.enabled = _dropButton.enabled = _dropDownHotspot.buttonMode =value;
		 

		return value;
	}


	/**
	* Applies the text formatting that the format parameter specifies to the specified text in a label.
	*
	* @param format A TextFormat object that contains character and paragraph formatting information.
	*/

	public function setTextFormat(value : TextFormat) : Void 
	{
		_textFormat = value; 
		
	}

	/**
	* This is for setting an image to the combox box. It is best to set an image that can be tile.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public function setBackgroundImage(value : BitmapData) : Void
	{
		_backgroundImage = value;
	}

	/**
	* This is for setting an image to the combox box once using click the drop down button. It is best to set an image that can be tile.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/

	public function setDropDownBackgroundImage(value : BitmapData) : Void
	{
		_backgroundDropImage = value;
	}
	


	/**
	* Returns the item at the selected index.
	*
	* @return The item at the selected index. Returns null if nothing was selected
	*
	*/

	public function getSelected() : ComboBoxObjectData 
	{
		return ((_selectIndex == -1)) ? null : _list.getItemAt(_selectIndex); 
	}


	/**
	* Opens the combo box so the user can select an item
	*
	*/
	public function open() : Void
	{
		// Check to see if drop down is close
		if (!_listOpen && enabled)
		{
			_listOpen = true;
			createComboList();
			dispatchEvent(new ComboBoxEvent(ComboBoxEvent.OPEN));
		}
	}

	/**
	* Close the combo box
	*
	*/

	public function close() : Void
	{
		// Check to see if drop down is open
		if (_listOpen && enabled)
		{
			_listOpen = false;
			removeComboList();
			dispatchEvent(new ComboBoxEvent(ComboBoxEvent.CLOSE));
		}
	}
	
	

	/**
	* Draw the element on the stage
	*
	*/
	override public function draw() : Void
	{
		super.draw();

		// Draw hotspot box for main area
		_dropDownHotspot.graphics.clear();

		if (_clickLabelArea)
		{
			_dropDownHotspot.graphics.beginFill(0, 0);
			_dropDownHotspot.graphics.drawRect(0, 0, (_width - _buttonWidth), _height);
			_dropDownHotspot.graphics.endFill();
		}

		// Show display image
		_background.graphics.clear();

		if (_backgroundImage != null && _showImage)
			_background.graphics.beginBitmapFill(_backgroundImage, null, true, _smoothImage);
		else
			_background.graphics.beginFill(_backgroundColor, 1);

		_background.graphics.drawRect(0, 0, _width, _height);
		_background.graphics.endFill();

		// Draw border
		_border.graphics.clear();

		// Draw outline if true
		if (_showOutline)
		{
			_border.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
			_border.graphics.lineTo(0, _height);
			_border.graphics.lineTo(_width, _height);
			_border.graphics.lineTo(_width, 0);
			_border.graphics.lineTo(0, 0);
			_border.graphics.moveTo(_width, 0);
			_border.graphics.lineTo(_width, _height);
		}

		// Draw outline
		_border.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
		_border.graphics.lineTo(0, _height);
		_border.graphics.lineTo(_width - _buttonWidth, _height);
		_border.graphics.lineTo(_width - _buttonWidth, 0);
		_border.graphics.lineTo(0, 0);
		_border.graphics.moveTo(_width, 0);
		_border.graphics.lineTo(_width, _height);

		//_selectLabel.backgroundColor = _backgroundColor;
		_selectLabel.textColor = _textColor;
		_selectLabel.width = (_width - _buttonWidth);
		_selectLabel.height = _height;
		_selectLabel.textField.setTextFormat(_textFormat);
		_selectLabel.draw();
		
		_dropButton.width = _buttonWidth;
		_dropButton.height = _height;
		_dropButton.x = (_width - _buttonWidth);
		_dropButton.draw();
	}

	private function textOutEvent(event : MouseEvent) : Void
	{
		var label:Label = cast(event.currentTarget, Label);
		
		label.textColor = _textColor;
		label.backgroundColor = _backgroundColor;
		label.background = true;
		label.draw();
	}

	private function textOverEvent(event : MouseEvent) : Void
	{
		
		// Stop Slider
		_scrollbar.slider.stop();
		
		var label:Label = cast(event.currentTarget, Label);
		
		label.textColor = _textOverColor;
		label.backgroundColor = _textOverBackground;
		label.background = true;
		label.draw();
	}

	private function textDownEvent(event : MouseEvent) : Void
	{
		var label:Label = cast(event.currentTarget, Label);
		
		// Set background and text color
		label.textColor = _textDownColor;
		label.backgroundColor = _textDownBackground;
		label.background = true;
		label.draw();
	}

	private function textUpEvent(event : MouseEvent) : Void
	{

		var listDataObject:ComboBoxObjectData = null;
		var currentLabel:Label = cast(event.currentTarget, Label);
		
		for (i in 0 ... _list.length)
		{
			if (currentLabel.name == Std.string(_list.getItemAt(i).id))
			{
				listDataObject = _list.getItemAt(i);
				
				_selectLabel.text = listDataObject.text;
				_selectIndex = i;
				
				break;
			}

		}

		// Set close flag
		_listOpen = false;
		removeComboList();

		// Clear all selected items
		clearSelected();
		

		// Get the selected item
		if (listDataObject != null)
			listDataObject.selected = true;
		
		dispatchEvent(new ComboBoxEvent(ComboBoxEvent.CHANGE));
		
		draw();
	}
	


	private function stageClick(event : MouseEvent) : Void
	{
		// If mouse is not over combo box then close
		if (!this.hitTestPoint(root.mouseX, root.mouseY))
			close();
	}

	private function toggleList(e : MouseEvent) : Void
	{
		// Check to see if drop down is open or close
		if (!_listOpen && enabled)
		{
			_listOpen = true;
			createComboList();

			dispatchEvent(new ComboBoxEvent(ComboBoxEvent.OPEN));
		}
		else if (_listOpen && enabled)
		{
			_listOpen = false;
			removeComboList();

			dispatchEvent(new ComboBoxEvent(ComboBoxEvent.CLOSE));
		}
	}

	private function clearSelected() : Void
	{
		for (i in 0..._list.length)
			_list.getItemAt(i).selected = false;
	}

	private function removeComboList() : Void
	{
		
		
		// First remove everything drop down area
		for (i in 0 ... _labelArray.length)
		{
			
			_labelArray[i].removeEventListener(MouseEvent.MOUSE_OVER, textOverEvent);
			_labelArray[i].removeEventListener(MouseEvent.MOUSE_OUT, textOutEvent);
			_labelArray[i].removeEventListener(MouseEvent.MOUSE_DOWN, textDownEvent);
			_labelArray[i].removeEventListener(MouseEvent.MOUSE_UP, textUpEvent);
			
			_dropDownList.removeChild(_labelArray[i].displayObject);
			
			_labelArray[i].destroy();
		}
		
		for (i in 0 ... _labelArray.length)
			_labelArray.shift();
			
		removeChild(_scrollbar);
		

		if (_dropDownScrollContent != null)
			_dropDownScrollContent.unload();
			
		if (_itemDropDownSize.parent != null)
			_itemDropDownSize.parent.removeChild(_itemDropDownSize);
		
		_itemDropDownSize.graphics.clear();
		_dropDownList.graphics.clear();
		_dropDownBorder.graphics.clear();
		
		_scrollbar.slider.removeEventListener(SliderEvent.CHANGE, updateLabelLocation);
		_scrollbar.destroy();
		_scrollbar = null;
		
		_lastScrollPercent = _itemIndex = 0;
		
	}

	private function createComboList() : Void
	{
		// Create scrollbar and setup event to keep track of labels
		_scrollbar = new ScrollBar();
		
		// Set buttons if there are images
		if (null != _scrollButtonDefaultImage)
		{
			_scrollbar.upButton.setDefaultStateImage(_scrollButtonDefaultImage);
			_scrollbar.downButton.setDefaultStateImage(_scrollButtonDefaultImage);
		}
		
		if (null != _scrollButtonOverImage)
		{
			_scrollbar.upButton.setOverStateImage(_scrollButtonOverImage);
			_scrollbar.downButton.setOverStateImage(_scrollButtonOverImage);
		}
		
		if (null != _scrollButtonDownImage)
		{
			_scrollbar.upButton.setDownStateImage(_scrollButtonDownImage);
			_scrollbar.downButton.setDownStateImage(_scrollButtonDownImage);
		}
		
		if (null != _scrollButtonDisableImage)
		{
			_scrollbar.upButton.setDisableStateImage(_scrollButtonDisableImage);
			_scrollbar.downButton.setDisableStateImage(_scrollButtonDisableImage);
		}
		
		
		_scrollbar.slider.addEventListener(SliderEvent.CHANGE, updateLabelLocation, false, 0, true);
		
		//TODO: Figure out the buffer mode to work better
		_itemBuffer = _list.length;//Std.int(_list.length / 2);
		
		// Setup drop down area
		_dropDownList.y = _height;
		
		// Get ready to create labels
		var labelCount:Int = _itemBuffer;//(_rowCount + _itemBuffer);
		
		// If row count and label buffer is greater than list then set list length as label count
		if (labelCount >= _list.length)
			labelCount = _list.length;
			 
		
		// Draw the over all size that is needed for labels
		if (_backgroundDropImage != null && _showImage)
			_itemDropDownSize.graphics.beginBitmapFill(_backgroundDropImage, null, true, _smoothImage);
		else
			_itemDropDownSize.graphics.beginFill(_backgroundColor, 1);
			
		_itemDropDownSize.graphics.drawRect(0, 0, (_width + SCROLLBAR_OFFSET) - _buttonWidth, (_height + _dropDownPadding) * (_list.length));
		_itemDropDownSize.graphics.endFill();
		
		
		_dropDownList.addChild(_itemDropDownSize);
		
		if (_rowCount >= labelCount - 1)
			_scrollbar.visible = false;
			
		_itemIndex = labelCount;
		
		
		// This will be used to create the label
		var labelData:Dynamic = {"width": (_scrollbar.visible)  ? _width + SCROLLBAR_OFFSET + _scrollbar.width - _buttonWidth : _width, "height": _height + SCROLLBAR_OFFSET, "textColor": _textColor, "backgroundColor":_backgroundColor,"bitmapMode":true, "background":true};
		
		// Create labels
		for (i in 0 ... labelCount)
		{
			var comboLabel : Label = new Label(labelData);
			
			comboLabel.name = Std.string(i);
			comboLabel.textField.setTextFormat(_textFormat);
			
			// If label count is less or equal to the data in the list
			if(labelCount <= _list.length)
				comboLabel.text = _list.getItemAt(i).text;
			
			if (null != _textFormat.size)
				comboLabel.size = _textFormat.size;
			  
			if (null != _textFormat.align)
				comboLabel.align = _textFormat.align;
			  
			if (_useEmbedFonts)
				comboLabel.setEmbedFont(_embedFont);
				
			  
			// Set location of item
			comboLabel.y = (_height * i) - SCROLLBAR_OFFSET;
			
			// Events for text fields
			comboLabel.addEventListener(MouseEvent.MOUSE_OVER, textOverEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_OUT, textOutEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_DOWN, textDownEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_UP, textUpEvent, false, 0, true);
			comboLabel.buttonMode = true;
			
			_labelArray.push(comboLabel);
			
			// Add to Drop down display
			_dropDownList.addChild(comboLabel);
			comboLabel.draw();
		}
		
			
		var mask:Shape = new Shape();
		mask.graphics.beginFill(0, 1);
		
		if (labelCount < _rowCount)
			mask.graphics.drawRect(0, 0, (_width + SCROLLBAR_OFFSET), (_height + _dropDownPadding) * (_list.length) + SCROLLBAR_OFFSET);
		else
			mask.graphics.drawRect(0, 0, (_width + SCROLLBAR_OFFSET), (_height + _dropDownPadding) * (_rowCount) + SCROLLBAR_OFFSET);
		
		mask.graphics.endFill();
		
		_dropDownHeight = mask.height;
		_dropDownScrollContent = new ScrollMaskContent(_dropDownList, _scrollbar, mask);
		
		//var scrollRect:Rectangle;
		//if (labelCount < _rowCount)
		//	scrollRect = new Rectangle(0, 0, (_width + SCROLLBAR_OFFSET), (_height + _dropDownPadding) * (_list.length) + SCROLLBAR_OFFSET);
		//else
		//	scrollRect = new Rectangle(0, 0, (_width + SCROLLBAR_OFFSET), (_height + _dropDownPadding) * (_rowCount) + SCROLLBAR_OFFSET);
		//
		//_dropDownScrollContent = new ScrollRectContent(_dropDownList, _scrollbar, scrollRect);
		//_dropDownHeight = scrollRect.height;
		
		
		// Redraw outline
		_dropDownBorder.y = _scrollbar.y;
		_dropDownBorder.graphics.clear();
		
		if (labelCount < _rowCount)
		{
			_dropDownBorder.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
			_dropDownBorder.graphics.lineTo(0, (((_scrollbar.height + _dropDownPadding)) - _thinkness));
			_dropDownBorder.graphics.lineTo(_dropDownList.width, (((_scrollbar.height + _dropDownPadding))  - _thinkness));
			_dropDownBorder.graphics.lineTo(_dropDownList.width, 0);
			_dropDownBorder.graphics.moveTo(0, 0);
			
		}
		else
		{
			_dropDownBorder.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
			_dropDownBorder.graphics.lineTo(0, ((_scrollbar.height + _dropDownPadding) - _thinkness));
			_dropDownBorder.graphics.lineTo(_dropDownList.width, ((_scrollbar.height + _dropDownPadding) - _thinkness));
			_dropDownBorder.graphics.lineTo(_dropDownList.width, 0);
			_dropDownBorder.graphics.moveTo(0, 0);			
		}
		
		addChild(_dropDownList);
		addChild(_scrollbar);
		
		
		// Show Outline
		if (_showOutline)
			addChild(_dropDownBorder);

	}
	
	
	private function updateLabelLocation(e:SliderEvent):Void 
	{
		var labelShift:Bool = false;
		var direction:String = "";
		var shiftDirection:String = "";
		var label:ILabel = null;
		var lastLabel:ILabel = _labelArray[0];
		var labelLoc:Point = new Point();
		
		
		if (_lastScrollPercent > e.percent)
			direction = "up";
		else
			direction = "down";
		
		_lastScrollPercent = e.percent;	
		
		for (i in 0 ... _labelArray.length)
		{
			var locY:Float = _dropDownList.localToGlobal(new Point(0, _labelArray[i].y)).y;
			
			if (direction == "down" && (locY + _labelArray[i].height) < (_height + SCROLLBAR_OFFSET) * -(_itemBuffer - _rowCount))
			{
				shiftDirection = "down";
				label = _labelArray[i];
				labelShift = true;
				
				
				//trace("Hit! On Going Down!");
				break;
			}
			else if (direction == "up" && (locY) >= (_height + SCROLLBAR_OFFSET) * (_itemBuffer + _rowCount))
			{
				
				//TODO: This should be the item with the lowest id. How
				shiftDirection = "up";
				label = _labelArray[i];
				labelShift = true;
				
				//trace("Hit! On Going Up!");
				break;
			}
			
		}
		
		for (i in 0 ... _labelArray.length)
		{
			// Save the highest label Y location
			if (direction == "down")
			{
				if (lastLabel.y < _labelArray[i].y)
					lastLabel = _labelArray[i];				
			}
			else if (direction == "up")
			{
				if (lastLabel.y > _labelArray[i].y && labelShift)
				{
					//trace("Updated to -> " + _labelArray[i].name);
					lastLabel = _labelArray[i];
				}
			}
		}
			
		
		if (direction == "down" && label != null && Std.parseInt(lastLabel.name) < _list.length - 1)
		{
			//trace("Down -> Label: " + label.name + " Last Label: " + lastLabel.name + " Updated: " + (Std.parseInt(lastLabel.name) + 1));
			var newId:Int = Std.parseInt(lastLabel.name) + 1;
			label.name = Std.string(newId);
			label.text = _list.getItemAt(newId).text;
			label.y = lastLabel.y + lastLabel.height;
		}
		else if (direction == "up" && label != null && Std.parseInt(lastLabel.name) > 0)
		{
			//trace("Up -> Label: " + label.name + " Last Label: " + lastLabel.name + " Updated: " + (Std.parseInt(lastLabel.name) - 1));
			
			var newId:Int = Std.parseInt(lastLabel.name) - 1;
			label.name = Std.string(newId);
			label.text = _list.getItemAt(newId).text;
			label.y = lastLabel.y - lastLabel.height;
		}
			
	}
	
	private function updateLabelLocationOld(e:SliderEvent):Void 
	{
		
		var labelShift:Bool = false;
		var direction:String = "";
		var shiftDirection:String = "";
		var label:ILabel = null;
		var labelLoc:Point = new Point();
		
		if (_lastScrollPercent > e.percent)
			direction = "up";
		else
			direction = "down";
		
		_lastScrollPercent = e.percent;
		
		//trace("Direction -> " + direction + " Scroll -> " + _lastScrollPercent);
		
		// Check the labels and see if they need to be shifted
		for (i in 0 ... _labelArray.length)
		{
			var locY:Float = _dropDownList.localToGlobal(new Point(0, _labelArray[i].y)).y;
			
			
			if (direction == "down")
			{
				if ((locY + _labelArray[i].height) < 0)
				{
					shiftDirection = "down";
					label = _labelArray[i];
					labelShift = true;
					
					break;
				}
			}
			else 
			{
				
				// Check to see if item should be grab from the top
				if ((locY + _labelArray[i].height) < 0)
				{
					shiftDirection = "up";
					label = _labelArray[i];
					labelShift = true;
					
					break;
				}
				else if ((locY + _labelArray[i].height) > (_dropDownHeight) )
				{
					shiftDirection = "down";
					label = _labelArray[i];
					labelShift = true;
					
					break;
				}
				
			}
		}
		
		
		for (i in 0 ... _labelArray.length)
		{
			// Save the highest label Y location
			if (shiftDirection == "down")
			{
				if (labelLoc.y < _labelArray[i].y)
					labelLoc.y = _labelArray[i].y;				
			}
			else if (shiftDirection == "up")
			{
				if (labelLoc.y >= _labelArray[i].y)
					labelLoc.y = _labelArray[i].y;
			}
		}
			
	}



}