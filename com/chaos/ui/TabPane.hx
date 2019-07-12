package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.ITabPane;
import com.chaos.ui.data.TabPaneObjectData;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.events.*;
import com.chaos.data.DataProvider;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.Button;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

/**
 *  A list of containers for displaying content based on what button is pressed
 *
 *  @author Erick Feiling
 *  @date 11-19-09
 */

class TabPane extends BaseUI implements ITabPane implements IBaseUI
{
	
	/** The type of UI Element */
	public static inline var TYPE : String = "TabPane";
	
	public var tabButtonTextColor(get, set) : Int;
	public var tabButtonTextSelectedColor(get, set) : Int;
	public var selectedIndex(get, set) : Int;
	public var tabButtonColor(get, set) : Int;
	public var tabButtonOverColor(get, set) : Int;
	public var tabButtonSelectedColor(get, set) : Int;
	public var tabButtonDisableColor(get, set) : Int;
	public var scrollPane(get, never) : IScrollPane;
	
	public var buttonArea : Sprite;
	
	private var _contentList : DataProvider<TabPaneObjectData>;
	private var _tabButtonHeight : Int = 20;
	private var _tabButtonNormalColor : Int = 0xCCCCCC;
	private var _tabButtonOverColor : Int = 0x666666;
	private var _tabButtonSelectedColor : Int = 0x333333;
	private var _tabButtonDisableColor : Int = 0x999999;
	private var _tabButtonTextColor : Int = 0xFFFFFF;
	private var _tabButtonTextSelectedColor : Int = 0xFFFFFF;

	private var _tabButtonDefaultImage : BitmapData;
	private var _tabButtonOverImage : BitmapData;
	private var _tabButtonDisableImage : BitmapData;
	private var _tabButtonDownImage : BitmapData;

	private var _scrollButtonNormalColor : Int = 0xCCCCCC;
	private var _scrollButtonOverColor : Int = 0x666666;
	private var _scrollButtonDownColor : Int = 0x333333;
	private var _scrollButtonDisableColor : Int = 0x999999;

	private var _selectedIndex : Int = 0;
	
	private var _scrollPane:ScrollPane;
	private var _scrollPaneData:Dynamic;

	public function new(data:Dynamic = null)
	{
		// paneWidth : Int = 400, paneHeight : Int = 300
		super(data);

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "tabButtonHeight"))
			_tabButtonHeight = Reflect.field(data, "tabButtonHeight");
			
		if (Reflect.hasField(data, "tabButtonNormalColor"))
			_tabButtonNormalColor = Reflect.field(data, "tabButtonNormalColor");
			
		if (Reflect.hasField(data, "tabButtonOverColor"))
			_tabButtonOverColor = Reflect.field(data, "tabButtonOverColor");
			
		if (Reflect.hasField(data, "tabButtonSelectedColor"))
			_tabButtonSelectedColor = Reflect.field(data, "tabButtonSelectedColor");
			
		if (Reflect.hasField(data, "tabButtonDisableColor"))
			_tabButtonDisableColor = Reflect.field(data, "tabButtonDisableColor");
			
		if (Reflect.hasField(data, "tabButtonTextColor"))
			_tabButtonTextColor = Reflect.field(data, "tabButtonTextColor");
			
		if (Reflect.hasField(data, "tabButtonTextSelectedColor"))
			_tabButtonTextSelectedColor = Reflect.field(data, "tabButtonTextSelectedColor");
			
			
		// Component
		
		if (Reflect.hasField(data, "ScrollPane"))
		_scrollPaneData = Reflect.field(data, "ScrollPane");
			
	}

	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	override public function initialize():Void 
	{
		// setup list
		_contentList = new DataProvider<TabPaneObjectData>();
		buttonArea = new Sprite();
		
		_scrollPane = new ScrollPane(_scrollPaneData);
		_scrollPaneData = null;
		
		super.initialize();
		
		_scrollPane.border = true;
		
		addChild(buttonArea);
		addChild(_scrollPane);
		
		
	}


	private function initSkin() : Void
	{
		// Background
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BACKGROUND))
			_scrollPane.setBackgroundImage(UIBitmapManager.getUIElement(ScrollPane.TYPE, UIBitmapManager.TABPANE_BACKGROUND));

		// Buttons
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_NORMAL))
			setTabButtonDefaultImage(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_NORMAL));

		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_OVER))
			setTabButtonOverImage(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_OVER));

		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_SELECTED))
			setTabButtonDownImage(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_SELECTED));

		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_DISABLE))
			setTabButtonDisableImage(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_DISABLE));
	}

	private function initStyle() : Void
	{
		
		
		// Border
		if ( -1 != UIStyleManager.TABPANE_BACKGROUND)
			_scrollPane.backgroundColor = UIStyleManager.TABPANE_BACKGROUND;

		_scrollPane.border = UIStyleManager.TABPANE_BORDER;

		if ( -1 != UIStyleManager.TABPANE_BORDER_COLOR)
			_scrollPane.borderColor = UIStyleManager.TABPANE_BORDER_COLOR;

		if ( -1 != UIStyleManager.TABPANE_BORDER_ALPHA)
			_scrollPane.borderAlpha = UIStyleManager.TABPANE_BORDER_ALPHA;

		if ( -1 != UIStyleManager.TABPANE_BORDER_THINKNESS)
			_scrollPane.borderThinkness = UIStyleManager.TABPANE_BORDER_THINKNESS;

		// Buttons
		if ( -1 != UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR)
			_tabButtonNormalColor = UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR;

		if ( -1 != UIStyleManager.TABPANE_BUTTON_OVER_COLOR)
			_tabButtonOverColor = UIStyleManager.TABPANE_BUTTON_OVER_COLOR;

		if ( -1 != UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR)
			_tabButtonSelectedColor = UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR;

		if ( -1 != UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR)
			_tabButtonDisableColor = UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR;

		// Button Text Field
		if (-1 != UIStyleManager.TABPANE_BUTTON_TEXT_COLOR)
			_tabButtonTextColor = UIStyleManager.TABPANE_BUTTON_TEXT_COLOR;

		if ( -1 != UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR)
			_tabButtonSelectedColor = UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR;

	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeEventListener(Event.ADDED_TO_STAGE, onStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onStageRemove);
		
		for (i in 0 ... buttonArea.numChildren)
		{
			var button:Button = cast(buttonArea.getChildByName(Std.string(i)), Button);
			
			button.removeEventListener(MouseEvent.CLICK, tabPress);
			buttonArea.removeChild(button);
			
			button.destroy();
			button = null;
		}
		
		removeChild(buttonArea);
		removeChild(_scrollPane);
		
		_contentList.removeAll();
		
		_scrollPane.destroy();
		_scrollPane = null;
	}

	/**
	 * @inheritDoc
	 */
	override public function reskin() : Void
	{
		super.reskin();

		initSkin();
		initStyle();
	}
	
	private function get_scrollPane() : IScrollPane
	{
		return _scrollPane;
	}

	/**
	 * Set the color of the TabPane button text field color
	 */

	private function set_tabButtonTextColor(value : Int) : Int
	{
		_tabButtonTextColor = value;
		draw();
		
		return value;
	}

	/**
	 *
	 * @return Returns the color
	 */

	private function get_tabButtonTextColor() : Int {return _tabButtonTextColor;}

	/**
	 * Set the color of the TabPane button text field color in it's selected state
	 */
	private function set_tabButtonTextSelectedColor(value : Int) : Int
	{
		_tabButtonTextSelectedColor = value;
		draw();
		return value;
	}

	/**
	 *
	 * @return Returns the color
	 */
	private function get_tabButtonTextSelectedColor() : Int
	{
		return _tabButtonTextSelectedColor;
	}

	/**
	 * Set if the TabPane is enabled
	 *
	 * @param value Set to true if you want the TabPane to be enabled and false if not
	 */
	override private function set_enabled(value : Bool) : Bool
	{
		super.enabled = value;

		// Disable or enable all buttons
		for (i in 0..._contentList.length)
			cast(buttonArea.getChildByName(Std.string(i)), IButton).enabled = value;

		
		// Don't know why it would enable the current selected button here
		//_contentList.getItemAt(_selectedIndex).button.enabled = (super.enabled) ? false : true;

		return value;
	}

	/**
	 * Appends an item to the end of the data provider.
	 *
	 * @param value Appends an item to the end of the data provider.
	 * @param content The DisplayObject you want to attach to the button click.
	 *
	 * @return Returns a object with the TabPane with the label,button and the content if it was attached.
	 */

	public function addItem(value : String, content : DisplayObject) : Dynamic
	{
		// Create new button & scroll pane
		var tabButton : Button = new Button();
		var tempObject : TabPaneObjectData = new TabPaneObjectData(content, -1, value, value);

		tabButton.text = value;
		tabButton.addEventListener(MouseEvent.CLICK, tabPress);


		buttonArea.addChild(tabButton);
		_contentList.addItem(tempObject);

		// Redraw buttons
		draw();

		return tempObject;
	}

	/**
	 * Removes the specified item from the
	 *
	 * @param item  Item to be removed.
	 *
	 */

	public function removeItem(value : String) : Dynamic
	{
		for (i in 0..._contentList.length)
		{
			if (_contentList.getItemAt(i).text.toLowerCase() == value.toLowerCase())
				return removeItemAt(i);
		}

		return null;
	}

	/**
	 * Removes the item at the specified index
	 *
	 * @param index  The index at which the item is to be added.
	 */
	public function removeItemAt(value : Int) : TabPaneObjectData
	{
		if (value < 0 || value > _contentList.length - 1)
			return null;

		var tempObj : TabPaneObjectData = _contentList.removeItemAt(value)[0];

		var button:Button = cast(buttonArea.getChildByName(Std.string(tempObj.id)), Button);
		
		// Remove button from display
		removeChild(button);

		button.addEventListener(MouseEvent.CLICK, tabPress);

		draw();

		return tempObj;
	}
	/**
	 * Switch the TabPane to the section as if the button was pressed. This will remove whatever content that is currenly being used and replace it with new data.
	 */
	private function set_selectedIndex(value : Int) : Int
	{
		if (_selectedIndex != value)
		{
			_selectedIndex = value;
			contentLoad(_contentList.getItemAt(value).content);
		}

		return value;
	}

	/**
	 * Return the selected index
	 */
	private function get_selectedIndex() : Int
	{
		return _selectedIndex;
	}

	/**
	 * Set the color of the tab button
	 */
	private function set_tabButtonColor(value : Int) : Int
	{
		_tabButtonNormalColor = value; draw();
		return value;
	}

	/**
	 * Returns the color
	 */

	private function get_tabButtonColor() : Int
	{
		return _tabButtonNormalColor;
	}

	/**
	 * Set the color of the tab button over state
	 */

	private function set_tabButtonOverColor(value : Int) : Int
	{
		_tabButtonOverColor = value;

		draw();
		return value;
	}

	/**
	 * Returns the color
	 */
	private function get_tabButtonOverColor() : Int
	{
		return _tabButtonOverColor;
	}

	/**
	 * Set the color of the tab button selected state
	 */
	private function set_tabButtonSelectedColor(value : Int) : Int
	{
		_tabButtonSelectedColor = value;
		draw();

		return value;
	}

	/**
	 * Returns the color
	 */
	private function get_tabButtonSelectedColor() : Int
	{
		return _tabButtonSelectedColor;
	}

	/**
	 * Set the color of the tab button disabled state
	 */
	private function set_tabButtonDisableColor(value : Int) : Int
	{
		_tabButtonDisableColor = value;

		draw();
		return value;
	}

	/**
	 *
	 * @return Returns the color
	 */

	private function get_tabButtonDisableColor() : Int
	{
		return _tabButtonDisableColor;
	}

	/**
	 * Set a image to the tab buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setTabButtonDefaultImage(value : BitmapData) : Void
	{
		_tabButtonDefaultImage = value;
	}

	/**
	 * Set a image to the tab buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setTabButtonOverImage(value : BitmapData) : Void
	{
		_tabButtonOverImage = value;
	}

	/**
	 * Set a image to the tab up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setTabButtonDownImage(value : BitmapData) : Void
	{
		_tabButtonDownImage = value;
	}

	/**
	 * Set a image to the tab up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */

	public function setTabButtonDisableImage(value : BitmapData) : Void
	{
		_tabButtonDisableImage = value;
	}

	/**
	 * Return the TabPane buton being used.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 * @return Return button being on TabPane
	 */

	public function getTabButton(value : Int = -1) : IButton
	{
		// Return value passed if not found or incorrect return the current selected index
		if (value <= _contentList.length - 1 && value >= 0)
			return cast(buttonArea.getChildByName(Std.string(value)), Button);
		else
			return cast(buttonArea.getChildByName(Std.string(_selectedIndex)), Button);
	}

	/**
	 * Draw the TabPane and all the UI classes it's using
	 */

	override public function draw() : Void
	{
		if (null == _contentList)
			return;

		super.draw();

		// Create and resize buttons
		for (i in 0 ... buttonArea.numChildren)
		{

			// Setting up buttons
			var button:Button = cast(buttonArea.getChildAt(i), Button);
			
			// Update all the i
			_contentList.getItemAt(i).id = i;
			
			button.name = Std.string(i);
			button.width = width / buttonArea.numChildren;
			button.height = _tabButtonHeight;
			button.x = button.width * i;
			button.y = 0;
			
			button.textColor = _tabButtonTextColor;
			button.defaultColor = _tabButtonNormalColor;
			button.overColor = _tabButtonOverColor;
			button.downColor = _tabButtonSelectedColor;
			button.disableColor = _tabButtonDisableColor;

			if (null != _tabButtonDefaultImage)
				button.setDefaultStateImage(_tabButtonDefaultImage);

			if (null != _tabButtonOverImage)
				button.setOverStateImage(_tabButtonOverImage);

			if (null != _tabButtonDownImage)
				button.setDownStateImage(_tabButtonDownImage);

			if (null != _tabButtonDisableImage)
				button.setDisableStateImage(_tabButtonDisableImage);

			// Set TextFormat based on UIStyleManager
			button.textBold = UIStyleManager.TABPANE_BUTTON_TEXT_BOLD;
			button.textItalic = UIStyleManager.TABPANE_BUTTON_TEXT_ITALIC;

			if ( -1 != UIStyleManager.TABPANE_BUTTON_TEXT_SIZE)
				button.textSize = UIStyleManager.TABPANE_BUTTON_TEXT_SIZE;

			if ("" != UIStyleManager.TABPANE_BUTTON_TEXT_FONT)
				button.textFont = UIStyleManager.TABPANE_BUTTON_TEXT_FONT;

			if (null != UIStyleManager.TABPANE_BUTTON_TEXT_EMBED)
				button.label.setEmbedFont(UIStyleManager.TABPANE_BUTTON_TEXT_EMBED);

			if ( -1 != UIStyleManager.TABPANE_BUTTON_TINT_ALPHA)
				button.label.borderAlpha = UIStyleManager.TABPANE_BUTTON_TINT_ALPHA;

		}

		// Set location of scroll pane
		buttonArea.x = 0;
		buttonArea.y = 0;
		
		_scrollPane.width = _width;
		_scrollPane.height = _height - _tabButtonHeight;
		_scrollPane.y = _tabButtonHeight;

		// Load in content
		if (_contentList.length > 0 && _contentList.getItemAt(_selectedIndex).content != null)
		{
			cast(buttonArea.getChildByName(Std.string(_selectedIndex)), Button).enabled = false;
			contentLoad(_contentList.getItemAt(_selectedIndex).content);
		}

		_scrollPane.update();
	}

	private function contentLoad(value : DisplayObject) : Void
	{
		// Selected Index
		_scrollPane.source = value;
	}

	private function tabPress(event : MouseEvent) : Void
	{
		var button:Button =  cast(event.currentTarget, Button);
		var oldButton:Button = cast(buttonArea.getChildByName(Std.string(_selectedIndex)), Button);

		if (_selectedIndex != Std.parseInt(button.name))
		{
			// Current Button
			button.enabled = false;
			button.textColor = _tabButtonSelectedColor;

			// Disable old one
			oldButton.enabled = true;
			oldButton.textColor = _tabButtonTextColor;

			// Update selected index and grab new content
			_selectedIndex = Std.parseInt(button.name);
			contentLoad(cast(_contentList.getItemAt(Std.parseInt(button.name)).content, DisplayObject));

			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}