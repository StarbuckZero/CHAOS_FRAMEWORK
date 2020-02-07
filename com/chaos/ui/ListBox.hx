package com.chaos.ui;



import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IListBox;

import com.chaos.ui.data.ListObjectData;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.Event;

import openfl.text.Font;
import openfl.text.TextFormatAlign;

import com.chaos.ui.Label;
import com.chaos.ui.ScrollPane;
import com.chaos.data.DataProvider;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

/**
 * Creates a list box on the fly
 *
 * @author Erick Feiling
 * @date 7-12-2008
 */

class ListBox extends ScrollPane implements IListBox implements IBaseUI
{

	/** The type of UI Element */
	public static inline var TYPE : String = "ListBox";

    /**
	 * Outline color
	 */
	
	public var outlineColor(get, set) : Int;
	
    /**
	 * Outline alpha
	 */
	
	public var outlineAlpha(get, set) : Float;
	
	/**
	 * The default label color
	 */	
	public var textColor(get, set) : Int;
	
	/**
	 * Set the roll over state
	 */
	
	public var textOverColor(get, set) : Int;
	
	/**
	 * Set the selected of the label
	 */
	
	public var textSelectedColor(get, set) : Int;
	
	/**
	 * The selected text background
	 */
	
	public var textSelectedBackground(get, set) : Int;
	
	/**
	 * The user can select more then one item on the list
	 */
	
	public var allowMultipleSelection(get, set) : Bool;
	
    /**
	 * Set the align on all the labels
	 */
	
	public var textAlign(get, set) : String;
	
	/**
	 * Replace the current data provider
	 */ 
	
	public var dataProvider(get, set) : DataProvider<ListObjectData>;
	
	private var _outlineColor : Int = 0x000000;
	private var _outlineAlpha : Float = 1;
	private var _list : DataProvider<ListObjectData> = new DataProvider<ListObjectData>();
	private var _itemList : Sprite = new Sprite();
	private var _scrollPane : ScrollPane;
	private var _embedFonts : Bool = true;
	private var _font : Font = null;
	private var _selectText : String = "";
	private var _selectIndex : Int = -1;
	private var _textColor : Int = 0x000000;
	private var _textOverColor : Int = 0x000000;
	private var _textSelectedColor : Int = 0xCCCCCC;
	private var _textOverBackground : Int = 0xCCCCCC;
	private var _textSelectedBackground : Int = 0x0000FF;
	private var _allowMultipleSelection : Bool = false;
	private var _align : String = TextFormatAlign.LEFT;


	/**
	 * UI LixBox 
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
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var dataObj:Dynamic = data[i];
				
				if (Reflect.hasField(dataObj,"text") && Reflect.hasField(dataObj, "value"))
					_list.addItem(new ListObjectData(i, Reflect.field(dataObj, "text"), Reflect.field(dataObj, "value"), (Reflect.hasField(dataObj, "selected")) ? Reflect.field(dataObj, "selected") : false));
					
				// Update selected item
				if (Reflect.hasField(dataObj, "selected") && Reflect.field(dataObj, "selected"))
					_selectIndex = i;			
			}
			
		}

		
		if (Reflect.hasField(data, "textColor"))
			_textColor = Reflect.field(data,"textColor");
		
		if (Reflect.hasField(data, "textOverColor"))
			_textOverColor = Reflect.field(data,"textOverColor");

		if (Reflect.hasField(data, "textSelectedColor"))
			_textSelectedColor = Reflect.field(data,"textSelectedColor");

		if (Reflect.hasField(data, "textOverBackground"))
			_textOverBackground = Reflect.field(data,"textOverBackground");

		if (Reflect.hasField(data, "allowMultipleSelection"))
			_allowMultipleSelection = Reflect.field(data,"allowMultipleSelection");

		if (Reflect.hasField(data, "align"))
			_align = Reflect.field(data,"align");

		if (Reflect.hasField(data, "outlineColor"))
			_outlineColor = Reflect.field(data,"outlineColor");

		if (Reflect.hasField(data, "outlineAlpha"))
			_outlineAlpha = Reflect.field(data, "outlineAlpha");
			
		// If false then use default
		if (!Reflect.hasField(data, "border"))
			_border = UIStyleManager.LIST_BORDER;	
		
		 

		
	}

	override private function onStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(TYPE, this);
	}

	override private function onStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(TYPE, this);
	}


	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		
		super.initialize();
		
		source = _itemList;
		mode = ScrollPolicy.AUTO; 
	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
		// Remove all labels out of list
		removeList();
		
		_list.removeAll();
		_list = null;
	}

	private function initListStyle() : Void
	{
		// UISkin and Style for ScrollPane
		if (null != UIBitmapManager.getUIElement(ListBox.TYPE, UIBitmapManager.LIST_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(ListBox.TYPE, UIBitmapManager.LIST_BACKGROUND));

		if ( -1 != UIStyleManager.LIST_BACKGROUND_COLOR)
			backgroundColor = UIStyleManager.LIST_BACKGROUND_COLOR;

		if ( -1 != UIStyleManager.LIST_TEXT_NORMAL_COLOR)
			_textColor = UIStyleManager.LIST_TEXT_NORMAL_COLOR;

		if ( -1 != UIStyleManager.LIST_TEXT_OVER_COLOR)
			_textOverColor = UIStyleManager.LIST_TEXT_OVER_COLOR;

		if( -1 != UIStyleManager.LIST_TEXT_OVER_BACKGROUND_COLOR)
			_textOverBackground = UIStyleManager.LIST_TEXT_OVER_BACKGROUND_COLOR;

		if ( -1 != UIStyleManager.LIST_TEXT_SELECTED_COLOR)
			_textSelectedColor = UIStyleManager.LIST_TEXT_SELECTED_COLOR;

		if ( -1 != UIStyleManager.LIST_TEXT_SELECTED_BACKGROUND_COLOR)
			_textSelectedBackground = UIStyleManager.LIST_TEXT_SELECTED_BACKGROUND_COLOR;

		if (null != UIStyleManager.LIST_TEXT_EMBED)
			_font = UIStyleManager.LIST_TEXT_EMBED;

		
	}

	/**
	 * Reload all bitmap images and UI Styles
	 */

	override public function reskin() : Void 
	{
		super.reskin();
		
		initListStyle();
	}

	/**
	 * The default label color
	 */

	private function set_textColor(value : Int) : Int
	{
		_textColor = value;
		

		return value;
	}

	private function set_outlineAlpha(value:Float) : Float 
	{
		_outlineAlpha = value;
		return value;
	}

	private function get_outlineAlpha() : Float 
	{
		return _outlineAlpha;
	}

	private function set_outlineColor( value:Int ) : Int 
	{
		_outlineColor = value;
		return _outlineColor;
	}


	private function get_outlineColor() : Int
	{
		return _outlineColor;
	}

	/**
	 * Return the color
	 */

	private function get_textColor() : Int { return _textColor; }

	/**
	 * Set the roll over state
	 */

	private function set_textOverColor(value : Int) : Int
	{
		_textOverColor = value;

		return value;
	}

	/**
	 * Return the color
	 */

	private function get_textOverColor() : Int { return _textOverColor; }

	/**
	 * Set the selected of the label
	 */

	private function set_textSelectedColor(value : Int) : Int
	{
		_textSelectedColor = value;
		return value;
	}

	/**
	 * Return the color
	 */

	private function get_textSelectedColor() : Int { return _textSelectedColor; }

	/**
	 * The selected text background
	 */

	private function set_textSelectedBackground(value : Int) : Int
	{
		_textSelectedBackground = value;

		return value;
	}

	/**
	 * Return the color
	 */

	private function get_textSelectedBackground() : Int { return _textSelectedBackground; }

	/**
	 * The user can select more then one item on the list
	 */

	private function set_allowMultipleSelection(value : Bool) : Bool
	{
		_allowMultipleSelection = value;

		return value;
	}

	/**
	 * Returns if the user can select more then one at a time.
	 */

	private function get_allowMultipleSelection() : Bool { return _allowMultipleSelection; }

	/**
	 * Configure and setup the label to handle embedded fonts
	 *
	 * @param value The font you want to use.
	 *
	 */
	public function setEmbedFont(value : Font) : Void
	{
		_font = value;
		
	}

	/**
	 * Unload the font that was set by using the setEmbedFont
	 */

	public function unloadEmbedFont() : Void
	{
		_font = new Font();
		
	}


	/**
	 * Make sure no items are selected
	 */

	public function clear() : Void { clearAllSelected(); }

	/**
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index.
	 *
	 */

	public function getSelected() : ListObjectData 
	{
		return _list.getItemAt(_selectIndex); 
	}

	/**
	 * A list of selected items
	 * @return An array with selected list items
	 */

	public function getSelectedList() : Array<ListObjectData>
	{
		var selectedList : Array<ListObjectData> = new Array<ListObjectData>();

		for (i in 0..._list.length - 1 + 1)
		{
			var listData : ListObjectData = _list.getItemAt(i);

			if (listData.selected)
				selectedList.push(listData);
		}

		return selectedList;
	}

	/**
	 * Set if the combo box will be enabled or disable
	 *
	 * @param value Set true if you want to enable the combo box and false if not
	 *
	 */

	override private function set_enabled(value : Bool) : Bool
	{
		super.enabled = value;

		return value;
	}

	/**
	 * Set the align on all the labels
	 */

	private function set_textAlign(value : String) : String
	{
		_align = value;
		return value;
	}

	/**
	 * Return the setting for the label
	 */

	private function get_textAlign() : String
	{
		return _align;
	}

	/**
	 * Draw the ListBox and all the UI classes it's using
	 *
	 */
	override public function draw() : Void
	{
		super.draw();

		createList();

		if (null != _itemList)
			source = _itemList;

		refreshPane();

	}

	/**
	 * Return the index number of the item that was selected
	 */

	public function selectIndex() : Int { return _selectIndex; }

	/**
	 * Replace the current data provider and rebuild the list
	 */

	private function set_dataProvider(value : DataProvider<ListObjectData>) : DataProvider<ListObjectData>
	{
		_list = value;

		return value;
	}

	/**
	 * Returns the data provider being used
	 */

	private function get_dataProvider() : DataProvider<ListObjectData>
	{
		return _list;

	}

	private function createList() : Void
	{
		if (null == _list)
			return;

		// Remove old one
		removeList();
		
		// Create data object for common use values for when label is created
		var labelData:Dynamic = {"textColor":_textColor, "background":false, "align":_align, "width":_width - 1};
		
		for (i in 0 ... _list.length)
		{
			// Setup text field
			var listData : ListObjectData = _list.getItemAt(i);
			Reflect.setField(labelData, "name", Std.string(i));
			Reflect.setField(labelData, "text", listData.text);
			
			var listBoxLabel : Label = new Label(labelData);
			listBoxLabel.textField.autoSize = "left";
			listBoxLabel.textFormat.bold = UIStyleManager.LIST_TEXT_BOLD;
			listBoxLabel.textFormat.italic = UIStyleManager.LIST_TEXT_ITALIC;
			listBoxLabel.draw();

			if ( -1 != UIStyleManager.LIST_TEXT_SIZE)
				listBoxLabel.size = UIStyleManager.LIST_TEXT_SIZE;

			if (null != _font)
				listBoxLabel.setEmbedFont(_font);

			// Set location of item
			if (i > 0)
			{
				var oldLabel : ILabel = cast(_itemList.getChildByName( Std.string( Std.int(i - 1) ) ), ILabel);
				listBoxLabel.y = oldLabel.y + oldLabel.height;
			}

			if (listData.selected == true)
			{
				// Set background and text color
				listBoxLabel.textColor = _textSelectedColor;
				listBoxLabel.backgroundColor = _textSelectedBackground;
				listBoxLabel.background = true;
				
				listBoxLabel.draw();
			}
			
			// Events for text fields
			listBoxLabel.addEventListener(MouseEvent.MOUSE_OVER, textOverEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_OUT, textOutEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_DOWN, textSelectedEvent, false, 0, true);
			listBoxLabel.addEventListener(MouseEvent.MOUSE_UP, textUpEvent, false, 0, true);
			
			
			_itemList.addChild(listBoxLabel);
		}

	}

	private function removeList() : Void
	{
		if (null == _itemList)
			return;

		// NOTE: Turn this into a class file later
		var i : Int = _itemList.numChildren;

		while (i > 0)
		{
			
			var tempObj : Label = cast(_itemList.getChildByName(Std.string( Std.int(i - 1) ) ),Label);
			tempObj.removeEventListener(MouseEvent.MOUSE_OVER, textOverEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_OUT, textOutEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_DOWN, textSelectedEvent);
			tempObj.removeEventListener(MouseEvent.MOUSE_UP, textUpEvent);
			
			_itemList.removeChild(tempObj);
			
			tempObj.destroy();
			tempObj = null;
			
			i--;
		}

	}

	private function textOutEvent(event : MouseEvent) : Void
	{
		var label:Label = cast(event.currentTarget, Label);
		
		if (_list.getItemAt(Std.parseInt(label.name)).selected == true)
		{
			label.textColor = _textSelectedColor;
			label.backgroundColor = _textSelectedBackground;
			label.background = true;
		}
		else
		{
			label.textColor = _textColor;
			label.backgroundColor = _backgroundColor;
			label.background = false;
		}
		
		label.draw();
	}

	private function textOverEvent(event : MouseEvent) : Void
	{
		
		var label:Label = cast(event.currentTarget, Label);
		
		label.backgroundColor = _textOverBackground;
		label.textColor = _textOverColor;
		label.background = true;
		label.draw();
	}

	private function textSelectedEvent(event : MouseEvent) : Void
	{
		// If user only want one item listed
		if (!_allowMultipleSelection)
			clearAllSelected();
		
		var label:Label = cast(event.currentTarget, Label);
		
		// Set background and text color
		label.textColor = _textSelectedColor;
		label.backgroundColor = _textSelectedBackground;
		label.background = true;
		label.draw();
	}

	private function textUpEvent(event : MouseEvent) : Void
	{
		
		var label:Label = cast(event.currentTarget, Label);
		
		// Set text and selected index
		_selectText = label.text;
		_selectIndex = Std.parseInt(label.name);
		_list.getItemAt(_selectIndex).selected = !_list.getItemAt(_selectIndex).selected;
		
		label.background = true;
		label.draw();
		
		dispatchEvent(new Event(Event.CHANGE));
		
	}

	private function clearAllSelected() : Void
	{
		for (i in 0 ... _list.length - 1 + 1)
		{
			var listData : ListObjectData = _list.getItemAt(i);
			var label:Label = cast(_itemList.getChildByName(Std.string(i)),Label);
			listData.selected = false;
			
			label.textColor = _textColor;
			label.background = false;
			label.draw();
		}
	}
}

