package com.chaos.ui;

import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IComboBox;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.ui.classInterface.IScrollBar;
import com.chaos.utils.CompositeManager;
import openfl.display.BitmapData;

import openfl.display.Shape;
import com.chaos.ui.data.ComboBoxObjectData;
import com.chaos.data.DataProvider;

import com.chaos.ui.Button;
import com.chaos.ui.Label;
import com.chaos.ui.ScrollBar;

import com.chaos.ui.ScrollContent;
import com.chaos.ui.event.ComboBoxEvent;
import openfl.display.DisplayObject;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.Event;
import openfl.geom.Rectangle;
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
	
	/** The type of UI Element */
	public static inline var TYPE : String = "ComboBox";
	
	
	public var dropButton(get, never):IButton;
	public var scrollbar(get, never):IScrollBar;
	
	
	public var selectedIndex(get, never) : Int;
	public var trackSize(get, set) : Int;
	public var buttonWidth(get, set) : Int;
	public var clickLabelArea(get, set) : Bool;
	public var dataProvider(get, set) : DataProvider<ComboBoxObjectData>;
	public var text(get, set) : String;
	public var label(get, never) : ILabel;
	public var textColor(get, set) : Int;
	public var textOverColor(get, set) : Int;
	public var textDownColor(get, set) : Int;
	public var backgroundColor(get, set) : Int;
	public var textOverBackground(get, set) : Int;
	public var borderColor(get, set) : Int;
	public var borderAlpha(get, set) : Float;
	public var borderThinkness(get, set) : Float;
	public var length(get, never) : Int;
	public var rowCount(get, set) : Int;
	
	
	public var dropDownPadding(get, set) : Int;


	/** The scrollbar offset */
	public static var SCROLLBAR_OFFSET : Int = 2;
	public static var DROPAREA_HEIGHT_PADDING : Int = 0;

	private var _selectLabel : Label;

	private var _selectIndex : Int = -1;
	private var _trackSize : Int = 15;

	private var _dropButton : Button;
	private var _scrollbar : ScrollBar;

	private var _dropDownScrollContent : ScrollContent;
	private var _dropDownList : Sprite;

	private var _border : Shape;
	private var _background : Shape;

	private var _useEmbedFonts : Bool = false;
	private var _embedFont : Font;
	private var _dropDownBorder : Shape;

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

	private var _textFormat : TextFormat;
	private var _textColor : Int = 0x000000;
	private var _textOverColor : Int = 0xFFFFFF;
	private var _textDownColor : Int = 0xCCCCCC;
	private var _textOverBackground : Int = 0x00FF00;
	private var _textDownBackground : Int = 0x999999;

	private var _backgroundImage : BitmapData;
	private var _backgroundDropImage : BitmapData;

	private var _showImage : Bool = true;
	private var _smoothImage : Bool = true;

	private var _clickLabelArea : Bool = true;

	private var _dropDownHotspot : Sprite;
	private var _dropDownIcon:ArrowDownIcon;
	private var _dropDownPadding:Int = 0;

	/**
	 * Creates a drop down list
	 * @param	comboWidth The width of this object
	 * @param	comboHeight The height of this object
	 * @param	comboList A list of data objects
	 *
	 */

	public function new(data = null)
	{
		super(data);
		

		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);

	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		//comboWidth : Int = 70, comboHeight : Int = 15, comboList : DataProvider = null
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var dataObj:Dynamic = data[i];
				
				if (Reflect.hasField(dataObj,"text") && Reflect.hasField(dataObj, "value") && Reflect.hasField(dataObj, "selected"))
				{
					//TODO: 
					//_list
				}
			}
		}
		

		//if (comboWidth > 0)
		//	_width = comboWidth;
        //
		//if (comboHeight > 0)
		//	_height = comboHeight;
		
	}

	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); stage.addEventListener(MouseEvent.MOUSE_DOWN, stageClick); }

	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageClick); }

	override public function initialize():Void 
	{
		_selectLabel = new Label();
		_textFormat = new TextFormat();
		
		// Draw outline
		_border = new Shape();
		_background = new Shape();

		// Setup drop down outline
		_dropDownBorder = new Shape();

		// Scroll bars for drop down area
		_scrollbar = new ScrollBar();
		_dropButton = new Button();
		_dropDownHotspot = new Sprite();

		_dropDownIcon = new ArrowDownIcon(5, 5);
		
		super.initialize();
		
		// Create default text field and boarder
		_selectLabel.width = _width;
		_selectLabel.height = _height;
		_dropButton.setIcon(CompositeManager.cropToSize(_dropDownIcon.displayObject));
		
		// Add to display
		addChild(_background);
		addChild(_selectLabel);
		addChild(_dropButton);
		addChild(_border);
		addChild(_dropDownHotspot);		
	}
	

	private function initBorder() : Void
	{
		// Setting the border outline
		_showOutline = UIStyleManager.COMBO_BORDER;

		if ( -1 != UIStyleManager.COMBO_BORDER_COLOR)
			_outlineColor = UIStyleManager.COMBO_BORDER_COLOR;

		if ( -1 != UIStyleManager.COMBO_BORDER_COLOR)
			_backgroundColor = UIStyleManager.COMBO_BORDER_COLOR;

		if ( -1 != UIStyleManager.COMBO_BORDER_ALPHA)
			_outlineAlpha = UIStyleManager.COMBO_BORDER_ALPHA;
	}

	private function initLabel() : Void
	{
		if ( -1 != UIStyleManager.COMBO_TEXT_COLOR)
			_textColor = UIStyleManager.COMBO_TEXT_COLOR;

		if ( -1 != UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR)
			_backgroundColor = UIStyleManager.COMBO_TEXT_NORMAL_BACKGROUND_COLOR;

		_selectLabel.textColor = _textColor;
		_selectLabel.backgroundColor = _backgroundColor;
	}

	private function initDropDownButton() : Void
	{
		// Create button
		_dropButton.width = _buttonWidth;
		_dropButton.showLabel = false;
		_dropButton.height = _height;
		_dropButton.iconDisplay = true;
		_dropButton.text = "";

		_dropButton.x = _selectLabel.width;
		_dropButton.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);
		_dropDownHotspot.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BACKGROUND));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND))
			setDropDownBackgroundImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_NORMAL))
			dropButton.setDefaultStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_NORMAL));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_OVER))
			dropButton.setOverStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_OVER));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DOWN))
			dropButton.setDownStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DOWN));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DISABLE))
			dropButton.setDisableStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DISABLE));

		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON))
			dropButton.setIcon(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON));
	}

	private function initScrollBar() : Void
	{
		// UI Skin/Theme for ScrollBar
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL))
		{
			_scrollbar.upButton.setDefaultStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
			_scrollbar.downButton.setDefaultStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
		}

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER))
		{
			_scrollbar.upButton.setOverStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
			_scrollbar.downButton.setOverStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
		}

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN))
		{
			_scrollbar.upButton.setDownStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
			_scrollbar.downButton.setDownStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
		}

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))
		{
			_scrollbar.upButton.setDisableStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE));
			_scrollbar.downButton.setDisableStateImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE));
		}

		// Icons
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON))
			_scrollbar.upButton.setIcon(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON));

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON))
			_scrollbar.downButton.setIcon(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON));

		// Track
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK))
			_scrollbar.setTrackImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_TRACK));

		// Slider
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))
			_scrollbar.setSliderImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL));

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER))
			_scrollbar.setSliderOverImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER));

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN))
			_scrollbar.setSliderDownImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN));

		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE))
			_scrollbar.setSliderDisableImage(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE));
	}

	private function initComboBoxStyle() : Void
	{
		// Set Label Style
		if ( -1 != UIStyleManager.COMBO_TEXT_SIZE)
			_textFormat.size = UIStyleManager.COMBO_TEXT_SIZE;

		_textFormat.italic = UIStyleManager.COMBO_TEXT_ITALIC;
		_textFormat.bold = UIStyleManager.COMBO_TEXT_BOLD;

		if ("" != UIStyleManager.COMBO_TEXT_FONT)
			_textFormat.font = UIStyleManager.COMBO_TEXT_FONT;

		if ("" != UIStyleManager.COMBO_TEXT_ALIGN)
			_textFormat.align = UIStyleManager.COMBO_TEXT_ALIGN;

		if ( -1 != UIStyleManager.COMBO_TEXT_SIZE)
			_textFormat.size = UIStyleManager.COMBO_TEXT_SIZE;

		if (null != UIStyleManager.COMBO_TEXT_EMBED)
			_selectLabel.setEmbedFont(UIStyleManager.COMBO_TEXT_EMBED);

		if ("" != UIStyleManager.COMBO_DEFAULT_TEXT)
			_selectLabel.text = UIStyleManager.COMBO_DEFAULT_TEXT;

		// Set the Style for Over and Down states
		if ( -1 != UIStyleManager.COMBO_TEXT_OVER_COLOR)
			_textOverColor = UIStyleManager.COMBO_TEXT_OVER_COLOR;

		if ( -1 != UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR)
			_textOverBackground = UIStyleManager.COMBO_TEXT_OVER_BACKGROUND_COLOR;

		if ( -1 != UIStyleManager.COMBO_TEXT_DOWN_COLOR)
			_textOverColor = UIStyleManager.COMBO_TEXT_DOWN_COLOR;

		if ( -1 != UIStyleManager.COMBO_TEXT_DOWN_BACKGROUND_COLOR)
			_textDownBackground = UIStyleManager.COMBO_TEXT_DOWN_BACKGROUND_COLOR;

		// Drop Down Button
		if ( -1 != UIStyleManager.COMBO_BUTTON_NORMAL_COLOR)
			_dropButton.defaultColor = UIStyleManager.COMBO_BUTTON_NORMAL_COLOR;

		if ( -1 != UIStyleManager.COMBO_BUTTON_OVER_COLOR)
			_dropButton.overColor = UIStyleManager.COMBO_BUTTON_OVER_COLOR;

		if ( -1 != UIStyleManager.COMBO_BUTTON_DOWN_COLOR)
			_dropButton.downColor = UIStyleManager.COMBO_BUTTON_DOWN_COLOR;

		if ( -1 != UIStyleManager.COMBO_BUTTON_DISABLE_COLOR)
			_dropButton.disableColor = UIStyleManager.COMBO_BUTTON_DISABLE_COLOR;

		if ( -1 != UIStyleManager.COMBO_BUTTON_ICON_COLOR)
			_dropDownIcon.baseColor = UIStyleManager.COMBO_BUTTON_ICON_COLOR;

		if ( -1 != UIStyleManager.COMBO_BUTTON_ICON_BORDER_COLOR)
			_dropDownIcon.borderColor = UIStyleManager.COMBO_BUTTON_ICON_BORDER_COLOR;

		if ( -1 != UIStyleManager.COMBO_DROPDOWN_PADDING)
			_dropDownPadding = UIStyleManager.COMBO_DROPDOWN_PADDING;

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
		initBorder();
		initComboBoxStyle();
		initDropDownButton();
		initLabel();
		initScrollBar();
		
		super.reskin();

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
		draw();

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
		draw();

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
		draw();

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
		draw();

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
		draw();

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
		draw();

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
		draw();

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
		draw();

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
		super.enabled = _scrollbar.enabled = _dropButton.enabled = value;

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
	 * Appends an item to the end of the data provider.
	 *
	 * @param item Appends an item to the end of the data provider.
	 *
	 */ 
	
	public function addItem(item : ComboBoxObjectData) : Void
	{
		// Set the display if item is selected
		if (null != _selectLabel && item.selected)
			_selectLabel.text = item.text;

		_list.addItem(item);
	}

	/**
	* Removes the specified item from the
	*
	* @param item  Item to be removed.
	*
	*/

	public function removeItem(item : ComboBoxObjectData) : ComboBoxObjectData 
	{
		return _list.removeItem(item); 
		
	}

	/**
	* Removes the item at the specified index
	*
	* @param index  The index at which the item is to be added.
	*/

	public function removeItemAt(index : Int) : Array<ComboBoxObjectData>
	{
		return _list.removeItemAt(index); 
	}

	/**
	* Replaces an existing item with a new item
	*
	* @param newItem The item to be replaced.
	* @param oldItem The replacement item.
	*/

	public function replaceItem(newItem : ComboBoxObjectData, oldItem : ComboBoxObjectData) : Void
	{
		_list.replaceItem(newItem, oldItem); 
	}

	/**
	* Replaces the item at the specified index
	*
	* @param newItem The replacement item.
	* @param index The replacement item.
	*/

	public function replaceItemAt(newItem : ComboBoxObjectData, index : Int) : ComboBoxObjectData 
	{
		return _list.replaceItemAt(newItem, index); 
		
	}

	/**
	* Returns the item at the specified index.
	*
	* @param value Location of the item to be returned.
	* @return The item at the specified index.
	*
	*/

	public function getItemAt(value : Int) : ComboBoxObjectData 
	{
		return _list.getItemAt(value); 
		
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
	* Sorts the items that the data
	*
	* @param sortOpt The arguments to use for sorting.
	* @return The return value depends on whether the method receives any arguments.
	*
	*/

	public function sort(sortOpt : Dynamic) : Void
	{
		return _list.dataArray.sort(sortOpt);
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
			_dropDownHotspot.graphics.beginFill(_backgroundColor, 0);
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

		_selectLabel.backgroundColor = _backgroundColor;
		_selectLabel.textColor = _textColor;
		_selectLabel.width = (_width - _buttonWidth);
		_selectLabel.height = _height;
		_selectLabel.textField.setTextFormat(_textFormat);
		_dropButton.width = _buttonWidth;
		_dropButton.height = _height;
		_dropButton.x = (_width - _buttonWidth);
	}

	private function textOutEvent(event : MouseEvent) : Void
	{
		cast(event.currentTarget,Label).textColor = _textColor;
		cast(event.currentTarget,Label).backgroundColor = _backgroundColor;
		cast(event.currentTarget,Label).background = false;
	}

	private function textOverEvent(event : MouseEvent) : Void
	{
		// Stop Slider
		_scrollbar.stop();

		cast(event.currentTarget,Label).textColor = _textOverColor;
		cast(event.currentTarget,Label).backgroundColor = _textOverBackground;
		cast(event.currentTarget,Label).background = true;
	}

	private function textDownEvent(event : MouseEvent) : Void
	{
		// Set background and text color
		cast(event.currentTarget,Label).textColor = _textDownColor;
		cast(event.currentTarget,Label).backgroundColor = _textDownBackground;
		cast(event.currentTarget,Label).background = true;
	}

	private function textUpEvent(event : MouseEvent) : Void
	{

		var listDataObject:ComboBoxObjectData = null;
		var currentLabel:Label = cast(event.currentTarget, Label);

		for (i in 0..._list.length)
		{
			var listObj:ComboBoxObjectData = cast(_list.getItemAt(i), ComboBoxObjectData);

			if (currentLabel == listObj.label)
			{
				listDataObject = listObj;

				// Set text and selected index
				_selectLabel.text = listDataObject.text;
				_selectIndex = i;

				break;
			}

		}

		dispatchEvent(new ComboBoxEvent(ComboBoxEvent.CHANGE));

		// Set close flag
		_listOpen = false;
		removeComboList();

		// Clear all selected items
		clearSelected();

		// Get the selected item
		listDataObject.selected = true;

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
		{
			cast(_list.getItemAt(i), ComboBoxObjectData).selected = false;
		}
	}

	private function removeComboList() : Void
	{
		// Do try to clear list if nothing is in drop down
		if (_dropDownList.numChildren == 0)
			return

			// First remove everything out of list
			for (i in 0..._list.length - 1 + 1)
			{
				var tempLabel : DisplayObject = _dropDownList.removeChild(_list.getItemAt(i).label);
				tempLabel = null;
			}

		// Now remove drop down for display
		removeChild(_dropDownList);
		removeChild(_scrollbar);

		if (_showOutline)
			removeChild(_dropDownBorder);
	}

	private function createComboList() : Void
	{
		// Setup drop down area
		_dropDownList = new Sprite();
		_dropDownList.y = _height;

		for (i in 0..._list.length)
		{
			// Setup text field
			var comboLabel : Label = new Label();
			var comboDataObj : ComboBoxObjectData = cast(_list.getItemAt(i), ComboBoxObjectData);
			comboLabel.text = comboDataObj.text;
			comboLabel.textColor = _textColor;
			comboLabel.width = _width + SCROLLBAR_OFFSET + _scrollbar.width - _buttonWidth;
			comboLabel.height = _height + SCROLLBAR_OFFSET;
			comboLabel.background = true;
			comboLabel.name = Std.string(i);

			comboLabel.textField.setTextFormat(_textFormat);
			comboDataObj.id = i;

			if (null != _textFormat.size)
				comboLabel.size = _textFormat.size;

			if (null != _textFormat.align)
				comboLabel.align = _textFormat.align;

			if (_useEmbedFonts)
				comboLabel.setEmbedFont(_embedFont);

			// Set location of item
			comboLabel.y = (_height * i + 1) - SCROLLBAR_OFFSET;

			// Keep a ref object for later
			comboDataObj.label = comboLabel;

			// Events for text fields
			comboLabel.addEventListener(MouseEvent.MOUSE_OVER, textOverEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_OUT, textOutEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_DOWN, textDownEvent, false, 0, true);
			comboLabel.addEventListener(MouseEvent.MOUSE_UP, textUpEvent, false, 0, true);

			// Add to Drop down display
			_dropDownList.addChild(comboLabel);
		}

		if (_dropDownScrollContent != null)
			_dropDownScrollContent.unload();

		if (_rowCount >= _list.length - 1)
			_dropDownScrollContent = new ScrollContent(_dropDownList, _scrollbar, new Rectangle(0, _height, _width + SCROLLBAR_OFFSET + (_scrollbar.width - _buttonWidth), (_height + _dropDownPadding) * (_list.length) + SCROLLBAR_OFFSET));
		else
			_dropDownScrollContent = new ScrollContent(_dropDownList, _scrollbar, new Rectangle(0, _height, _width + SCROLLBAR_OFFSET + (_scrollbar.width - _buttonWidth), (_height + _dropDownPadding) * (_rowCount - 1) + SCROLLBAR_OFFSET));

		if (_rowCount >= _list.length - 1)
			_scrollbar.visible = false;

		// Setup scrollbar defaults
		_scrollbar.percent = 0;
		_scrollbar.draw();

		// Redraw outline
		_dropDownBorder.y = _dropDownList.y;
		_dropDownBorder.graphics.clear();
		_dropDownBorder.graphics.lineStyle(_thinkness, _outlineColor, _outlineAlpha);
		_dropDownBorder.graphics.lineTo(0, (((_height + _dropDownPadding) * (_list.length)) - _thinkness));
		_dropDownBorder.graphics.lineTo(_dropDownList.width, (((_height + _dropDownPadding) * (_list.length))  - _thinkness));
		_dropDownBorder.graphics.lineTo(_dropDownList.width, 0);
		_dropDownBorder.graphics.moveTo(0, 0);

		// Drop down background
		_dropDownList.graphics.clear();

		// Show display image
		if (_backgroundDropImage != null && _showImage)
			_dropDownList.graphics.beginBitmapFill(_backgroundDropImage, null, true, _smoothImage);
		else
			_dropDownList.graphics.beginFill(_backgroundColor, 1);

		if (_rowCount >= _list.length - 1)
			_dropDownList.graphics.drawRect(0, 0, _width + SCROLLBAR_OFFSET + _scrollbar.width - _buttonWidth, (_height + _dropDownPadding) * _list.length);
		else
			_dropDownList.graphics.drawRect(0, 0, _width + SCROLLBAR_OFFSET - _buttonWidth, (_height + _dropDownPadding) * _list.length);

		_dropDownList.graphics.endFill();

		addChildAt(_dropDownList, 0);
		addChildAt(_scrollbar, 1);

		// Show Outline
		if (_showOutline)
			addChild(_dropDownBorder);

	}



}