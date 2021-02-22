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
 */

class TabPane extends BaseUI implements ITabPane implements IBaseUI
{
		
	/**
	 * Return ScrollPane that content is loaded in for each tab
	 */
	
	public var scrollPane(get, never) : IScrollPane;
	
    /**
	 * Switch the TabPane to the section as if the button was pressed. This will remove whatever content that is currenly being used and replace it with new data.
	 */	
	public var selectedIndex(get, set) : Int;

	/**
	 * Set the color of the TabPane button text field color
	 */
	
	public var tabButtonTextColor(get, set) : Int;
	
	/**
	 * Set the color of the TabPane button text field color in it's selected state
	 */
	
	public var tabButtonTextSelectedColor(get, set) : Int;
	
	/**
	 * Set the color of the tab button over state
	 */
	
	public var tabButtonColor(get, set) : Int;
	
	/**
	 * Set the color of the tab button selected state
	 */
	
	public var tabButtonOverColor(get, set) : Int;
	
	/**
	 * Set the color of the tab button selected state
	 */	
	
	public var tabButtonSelectedColor(get, set) : Int;
	
	/**
	 * Set the color of the tab button disabled state
	 */	
	
	public var tabButtonDisableColor(get, set) : Int;
	
	/**
	* Set the height of the button. 
	**/
	public var tabButtonHeight(get,set) : Int;
	
	public var buttonArea : Sprite = new Sprite();
	
	private var _contentList : DataProvider<TabPaneObjectData> = new DataProvider<TabPaneObjectData>();
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
	
	private var _scrollPanelBackgroundImage:BitmapData;
	
	private var _scrollPane:ScrollPane;
	private var _scrollPaneData:Dynamic;

	
	/**
	 * UI TabPane 
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

	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(UIBitmapType.TabPane, this); }
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(UIBitmapType.TabPane, this); }
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		if (_scrollPaneData == null)
			_scrollPaneData = {"border":true};
		
		_scrollPane = new ScrollPane(_scrollPaneData);
		
		
		super.initialize();
		
		_scrollPaneData = null;
		
		addChild(buttonArea);
		addChild(_scrollPane);
		
		
	}


	private function initSkin() : Void
	{
		// Background
		if (UIBitmapManager.hasUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BACKGROUND))
			_scrollPane.setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BACKGROUND));

		// Buttons
		if (UIBitmapManager.hasUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_NORMAL))
			setTabButtonDefaultImage(UIBitmapManager.getUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_NORMAL));

		if (UIBitmapManager.hasUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_OVER))
			setTabButtonOverImage(UIBitmapManager.getUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_OVER));

		if ( UIBitmapManager.hasUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_SELECTED))
			setTabButtonDownImage(UIBitmapManager.getUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_SELECTED));

		if (UIBitmapManager.hasUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_DISABLE))
			setTabButtonDisableImage(UIBitmapManager.getUIElement(UIBitmapType.TabPane, UIBitmapManager.TABPANE_BUTTON_DISABLE));
	}

	private function initStyle() : Void
	{
		_scrollPaneData = {};
		
		// Border
		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BACKGROUND))
			Reflect.setField(_scrollPaneData, "backgroundColor", UIStyleManager.getStyle(UIStyleManager.TABPANE_BACKGROUND));

		Reflect.setField(_scrollPaneData, "border", UIStyleManager.getStyle(UIStyleManager.TABPANE_BORDER));

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BORDER_COLOR))
			Reflect.setField(_scrollPaneData, "borderColor", UIStyleManager.getStyle(UIStyleManager.TABPANE_BORDER_COLOR));

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BORDER_ALPHA))
			Reflect.setField(_scrollPaneData, "borderAlpha", UIStyleManager.getStyle(UIStyleManager.TABPANE_BORDER_ALPHA));
			
		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BORDER_THINKNESS))
			Reflect.setField(_scrollPaneData, "borderThinkness", UIStyleManager.getStyle(UIStyleManager.TABPANE_BORDER_THINKNESS));

		// Buttons
		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR))
			_tabButtonNormalColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_NORMAL_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_OVER_COLOR))
			_tabButtonOverColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_OVER_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR))
			_tabButtonSelectedColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_SELECTED_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR))
			_tabButtonDisableColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_DISABLE_COLOR);

		// Button Text Field
		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR))
			_tabButtonTextColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR_SELECTED))
			_tabButtonTextSelectedColor = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_COLOR_SELECTED);

	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		for (i in 0 ... buttonArea.numChildren)
		{
			var button:Button = cast(buttonArea.getChildByName(Std.string(i)), Button);
			
			button.removeEventListener(MouseEvent.CLICK, tabPress);
			button.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);

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
		for (i in 0 ... _contentList.length)
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
		var tabButton : Button = new Button({"disableColor":_tabButtonTextSelectedColor});
		var tempObject : TabPaneObjectData = new TabPaneObjectData(content, -1, value, value);

		tabButton.text = value;
		tabButton.addEventListener(MouseEvent.CLICK, tabPress);
		tabButton.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		tabButton.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

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
	* Get selected item
	*/

	public function getSelectedItem() : TabPaneObjectData 
	{
		if(_selectedIndex >= 0)
			return _contentList.getItemAt(_selectedIndex);
		else 
			return null;
	}

	/**
	* Get the TabDataObject based on value passed in
	* @param value  The index of item you want
	*
	* @return Object with the content that is being stored
	*/

	public function getItemAt( value : Int ) : TabPaneObjectData
	{
		if (value <= _contentList.length - 1 && value >= 0)
			return _contentList.getItemAt(value);

		return null;
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

	private function set_tabButtonHeight(value : Int) : Int
	{
		_tabButtonHeight = value;
		return value;
	}

	private function get_tabButtonHeight() : Int
	{
		return _tabButtonHeight;
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
	 * @param value The button you want starting from 0
	 *
	 * @return Return button
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
			
			// Check to see if Custom Texture will need to be used first
			if(_useCustomRender && UIBitmapManager.hasCustomRenderTexture(UIBitmapType.TabPane) && button.width > 0 && button.height > 0) {

				button.useCustomRender = false;
				
				_tabButtonDefaultImage = UIBitmapManager.runCustomRender(UIBitmapType.TabPane,{"width":button.width,"height":button.height,"state":"default"});
				_tabButtonOverImage = UIBitmapManager.runCustomRender(UIBitmapType.TabPane,{"width":button.width,"height":button.height,"state":"over"});
				_tabButtonDownImage = UIBitmapManager.runCustomRender(UIBitmapType.TabPane,{"width":button.width,"height":button.height,"state":"down"});
				_tabButtonDisableImage = UIBitmapManager.runCustomRender(UIBitmapType.TabPane,{"width":button.width,"height":button.height,"state":"disable"});				
			}  

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
			if(UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_BOLD))
				button.textBold = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_BOLD);

			if(UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_ITALIC))
				button.textItalic = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_ITALIC);

			if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_SIZE))
				button.textSize = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_SIZE);

			if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_FONT))
				button.textFont = UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_FONT);

			if (UIStyleManager.hasStyle(UIStyleManager.TABPANE_BUTTON_TEXT_EMBED))
				button.label.setEmbedFont(UIStyleManager.getStyle(UIStyleManager.TABPANE_BUTTON_TEXT_EMBED));
				
			button.draw();

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
		_scrollPane.draw();
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
			button.disableColor = _tabButtonDisableColor;

			// Disable old one
			oldButton.enabled = true;
			oldButton.textColor = _tabButtonTextColor;
			
			button.draw();
			oldButton.draw();

			// Update selected index and grab new content
			_selectedIndex = Std.parseInt(button.name);
			contentLoad(cast(_contentList.getItemAt(Std.parseInt(button.name)).content, DisplayObject));

			dispatchEvent(new Event(Event.CHANGE));
			
		}
	}

	private function onMouseDown(event : MouseEvent) : Void {

		var button:Button =  cast(event.currentTarget, Button);

		if(button.enabled)
		{
			button.textColor = _tabButtonTextSelectedColor;
			button.draw();
		}
	}

	private function onMouseUp(event : MouseEvent) : Void {
		
		var button:Button =  cast(event.currentTarget, Button);

		if(button.enabled)
		{
			button.textColor = _tabButtonTextColor;
			button.draw();
		}

	}



}