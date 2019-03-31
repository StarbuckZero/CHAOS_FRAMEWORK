package com.chaos.ui;

import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IComboBox;
import com.chaos.ui.classInterface.IScrollBar;
import openfl.display.DisplayObjectContainer;
import openfl.display.Shape;
import com.chaos.ui.data.ComboBoxObjectData;
import com.chaos.data.DataProvider;
import com.chaos.media.DisplayImage;
import com.chaos.ui.Button;
import com.chaos.ui.Label;
import com.chaos.ui.ScrollBar;
import com.chaos.ui.ScrollBarDirection;
import com.chaos.ui.ScrollContent;
import com.chaos.ui.event.ComboBoxEvent;
import openfl.display.DisplayObject;
import com.chaos.ui.UIDetailLevel;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import openfl.display.Bitmap;
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
    public var selectedIndex(get, never) : Int;
    public var trackSize(get, set) : Int;
    public var buttonWidth(get, set) : Int;
    public var buttonColor(get, set) : Int;
    public var buttonOverColor(get, set) : Int;
    public var buttonDownColor(get, set) : Int;
    public var buttonDisableColor(get, set) : Int;
    public var clickLabelArea(get, set) : Bool;
    public var dataProvider(get, set) : DataProvider;
    public var text(get, set) : String;
    public var label(get, never) : Label;
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
    public var showArrowButton(get, set) : Bool;
    public var scrollBarTrackColor(get, set) : Int;
	public var dropDownPadding(get, set) : Int;
	
  /** The type of UI Element */
  public static inline var TYPE : String = "ComboBox";
  
  /** The scrollbar offset */
  public static var SCROLLBAR_OFFSET : Int = 2;
  public static var DROPAREA_HEIGHT_PADDING : Int = 0;
  
  private var _selectLabel : Label;
  private var _selectIndex : Int = -1;
  private var _trackSize : Int = 15;
  private var _dropButton : Button;
  private var _qualityMode : String = UIDetailLevel.HIGH;
  private var _scrollbar : ScrollBar;
  private var _dropDownScrollContent : ScrollContent;
  private var _dropDownList : Sprite;
  private var _border : Sprite;
  private var _background : Sprite;
  private var _embedFont : Font;
  private var _dropDownBorder : Sprite;
  private var _thinkness : Float = 1;
  private var _rowCount : Int = 3;
  private var _buttonWidth : Int = 17;
  private var _list : DataProvider = new DataProvider();
  private var _listOpen : Bool = false;
  private var _outlineColor : Int = 0x000000;
  private var _backgroundColor : Int = 0xFFFFFF;
  private var _outlineAlpha : Float = 1;
  private var _showOutline : Bool = true;
  private var _buttonColor : Int = 0xCCCCCC;
  private var _useEmbedFonts : Bool = false;
  private var _textFormat : TextFormat;
  private var _textColor : Int = 0x000000;
  private var _textOverColor : Int = 0xFFFFFF;
  private var _textDownColor : Int = 0xCCCCCC;
  private var _textOverBackground : Int = 0x00FF00;
  private var _textDownBackground : Int = 0x999999;
  private var _backgroundImage : DisplayImage;
  private var _backgroundDropImage : DisplayImage;
  private var _displayImage : Bool = false;
  private var _displayDropDownImage : Bool = false;
  private var _showImage : Bool = true;
  private var _smoothImage : Bool = true;
  private var _clickLabelArea : Bool = true;
  private var _width : Float = 70;
  private var _height : Float = 15;
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
	
	public function new(comboWidth : Int = 70, comboHeight : Int = 15, comboList : DataProvider = null)
	{
		super();
		
		if (null != comboList)
		_list = comboList;
		
		if (comboWidth > 0) 
		_width = comboWidth;
		
		if (comboHeight > 0)
		_height = comboHeight;
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		init();
		draw();
		
	}
	
	private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); stage.addEventListener(MouseEvent.MOUSE_DOWN, stageClick); }
	
	private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); stage.removeEventListener(MouseEvent.MOUSE_DOWN, stageClick); }
	
	private function init() : Void 
	{
		// Background Image event
		_backgroundImage = new DisplayImage();
		_backgroundImage.onImageComplete = backgroundImageComplete;
		_backgroundDropImage = new DisplayImage();
		_backgroundDropImage.onImageComplete = backgroundDropDownImageComplete;
		
		// Create default text field and boarder
		_selectLabel = new Label();
		_selectLabel.width = _width;
		_selectLabel.height = _height;
		
		_textFormat = new TextFormat();
		
		// Draw outline
		_border = new Sprite();
		_background = new Sprite(); 
		
		// Setup drop down outline
		_dropDownBorder = new Sprite();
		
		// Scroll bars for drop down area
		_scrollbar = new ScrollBar();
		_dropButton = new Button();
		_dropDownHotspot = new Sprite(); 
		
		_dropDownIcon = new ArrowDownIcon(5, 5);
		_dropDownIcon.filterMode = false;
		setDropIcon(_dropDownIcon.displayObject);
		
		// Setup ScrollBar and DropDown Button
		reskin();
		
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
		_dropButton.label = "";
		
		_dropButton.x = _selectLabel.width;
		_dropButton.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);
		_dropDownHotspot.addEventListener(MouseEvent.CLICK, toggleList, false, 0, true);
		
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BACKGROUND))   
		setBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BACKGROUND));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND)) 
		setDropDownBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_DROPDOWN_BACKGROUND));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_NORMAL)) 
		setButtonBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_OVER))
		setButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DOWN)) 
		setButtonDownBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DISABLE)) 
		setButtonDisableBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DISABLE));
		
		if (null != UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON)) 
		setDropIconBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.COMBO_BUTTON_DROPDOWN_ICON));
    }
	
	private function initScrollBar() : Void
	{
		// UI Skin/Theme for ScrollBar 
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL)) 
		_scrollbar.setButtonBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER)) 
		_scrollbar.setButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN)) 
		_scrollbar.setButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE))     
        _scrollbar.setButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_BUTTON_DISABLE));
		
		// Icons
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON)) 
		_scrollbar.setUpIconBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_UP_ICON));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON)) 
		_scrollbar.setDownIconBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_DOWN_ICON)); 
		
		// Track  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_TRACK))
		_scrollbar.setTrackBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_TRACK));
		
		// Slider  
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL))   
		_scrollbar.setSliderBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER))       
		_scrollbar.setSliderOverBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN)) 
		_scrollbar.setSliderDownBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DOWN));
		
		if (null != UIBitmapManager.getUIElement(ScrollBar.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE)) 
		_scrollbar.setButtonDisableBackgroundBitmap(UIBitmapManager.getUIElement(ComboBox.TYPE, UIBitmapManager.SCROLLBAR_SLIDER_BUTTON_DISABLE));
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
			_dropButton.buttonColor = UIStyleManager.COMBO_BUTTON_NORMAL_COLOR;
			
		if ( -1 != UIStyleManager.COMBO_BUTTON_OVER_COLOR)
			_dropButton.buttonOverColor = UIStyleManager.COMBO_BUTTON_OVER_COLOR;
		
		if ( -1 != UIStyleManager.COMBO_BUTTON_DOWN_COLOR)
			_dropButton.buttonDownColor = UIStyleManager.COMBO_BUTTON_DOWN_COLOR;
		
		if ( -1 != UIStyleManager.COMBO_BUTTON_DISABLE_COLOR)
			_dropButton.buttonDisableColor = UIStyleManager.COMBO_BUTTON_DISABLE_COLOR;
		
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
		super.reskin();
		
		initBorder();
		initComboBoxStyle();
		initDropDownButton();
		initLabel();
		initScrollBar();
		
		draw();
		
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
	
	/**
	* Set the color of the button
	*/
	private function set_buttonColor(value : Int) : Int 
	{ 
		_dropButton.buttonColor = value; 
		
		return value; 
	} 
	
	/**
	*
	* Returns the color
	*/
	private function get_buttonColor() : Int { return _dropButton.buttonColor; }
	
	/**
	* Set the color of the button over state
	*/
	private function set_buttonOverColor(value : Int) : Int 
	{ 
		_dropButton.buttonOverColor = value; 
		
		return value; 
	} 
	
	/**
	*
	* Returns the color
	*/
	private function get_buttonOverColor() : Int { return _dropButton.buttonOverColor; }  
	
	/**
	* Set the color of the button down state
	*/
	
	private function set_buttonDownColor(value : Int) : Int 
	{ 
		_dropButton.buttonDownColor = value;
		
		return value; 
	} 
	
	/**
	* Returns the color
	*/
	private function get_buttonDownColor() : Int { return _dropButton.buttonDownColor; } 
	
	/**
	* Set the color of the button disabled state
	*/
	
	private function set_buttonDisableColor(value : Int) : Int 
	{ 
		_dropButton.buttonDisableColor = value;
		
		return value;
	}
	
	
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
	*
	* Returns the color
	*/
	
	private function get_buttonDisableColor() : Int { return _dropButton.buttonDisableColor; }  
	
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
	* This is for setting an image to the drop down button default state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a URL file path.
	*
	*/ 
	
	public function setButtonBackgroundImage(value : String) : Void { _dropButton.setBackgroundImage(value); } 
	
	/**
	* This is for setting an image to the drop down button default state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setButtonBackgroundBitmap(value : Bitmap) : Void { _dropButton.setBackgroundBitmap(value); } 
	
	/**
	* This is for setting an image to the drop down button roll over state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a URL file path.
	*
	*/
	
	public function setButtonOverBackgroundImage(value : String) : Void { _dropButton.setOverBackgroundImage(value); } 
	
	/**
	* This is for setting an image to the drop down button roll over state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setButtonOverBackgroundBitmap(value : Bitmap) : Void { _dropButton.setOverBackgroundBitmap(value); } 
	
	/**
	* This is for setting an image to the drop down button roll down state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a URL file path.
	*
	*/
	
	public function setButtonDownBackgroundImage(value : String) : Void { _dropButton.setDownBackgroundImage(value); } 
	
	/**
	* This is for setting an image to the drop down button roll down state. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setButtonDownBackgroundBitmap(value : Bitmap) : Void { _dropButton.setDownBackgroundBitmap(value); }
	
	/**
	* This is for setting an image to the drop down button disable state. It is best to set an image that can be tile.
	*
	* @param value Set the image based on a URL file path.
	*
	*/
	
	public function setButtonDisableBackgroundImage(value : String) : Void { _dropButton.setDisableBackgroundImage(value); } 
	
	/**
	* This is for setting an image to the drop down button disable state. It is best to set an image that can be tile.
	* 
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setButtonDisableBackgroundBitmap(value : Bitmap) : Void { _dropButton.setDisableBackgroundBitmap(value); } 
	
	/**
	 * Replace the current data provider
	 */
	
	private function set_dataProvider(value : DataProvider) : DataProvider 
	{
		_list = value;
		return value; 
	} 
	 
	/**
	 * Returns the data provider being used
	 */
	
	private function get_dataProvider() : DataProvider { return _list; }  
	 
	/**
	* Set the width of the combo box
	* 
	* @param value Set the width of the combo box
	* 
	*/
	#if flash @:setter(width)
	private function set_width(value : Float) : Void 
	{
		_width = value;
		draw();
	}
	#else
	override private function set_width(value : Float) : Float 
	{
		_width = value;
		draw();
		return value; 
	}	
	#end
	 
	/**
	*
	* @return Returns the width
	*/
	#if flash @:getter(width)
	private function get_width() : Float 
	{ 
		return _width; 
	}  
	#else 
	override private function get_width() : Float 
	{ 
		return _width; 
	}  
	#end
	 
	/**
	* Set the height of the combo box
	* 
	* @param value The font you want to use.
	* 
	*/ 
	#if flash @:setter(height)
	private function set_height(value : Float) : Void 
	{ 
		_height = value;
		draw();
	} 
	#else
	override private function set_height(value : Float) : Float 
	{ 
		_height = value;
		draw();
		
		return value;
	} 
	#end
	 
	/**
	*
	* @return Returns the height
	*/
	#if flash @:getter(height)
	private function get_height() : Float 
	{ 
		return _height; 
	}  
	#else
	override private function get_height() : Float 
	{ 
		return _height; 
	}  
	#end
	 
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
	
	private function get_text() : String { return _selectLabel.text; } 
	
	/**
	* Returns text label used on the combo box selected item area
	*/
	
	private function get_label() : Label { return _selectLabel; } 
	
	/**
	* Configure and setup the label to handle embedded fonts
	* 
	* @param value The font you want to use.
	* 
	*/
	
	public function setEmbedFont(value : Font) : Void { _embedFont = value; _useEmbedFonts = true; _selectLabel.setEmbedFont(value); }; 
	
	/**
	* Unload the font that was set by using the setEmbedFont
	* 
	*/
	
	public function unloadEmbedFont() : Void { _selectLabel.unloadEmbedFont(); _embedFont = null; _useEmbedFonts = false; } 
	
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
	
	private function get_textColor() : Int { return _textColor; } 
	
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
	private function get_textOverColor() : Int { return _textOverColor; } 
	
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
	
	private function get_textDownColor() : Int { return _textDownColor; } 
	
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
	
	private function get_backgroundColor() : Int { return _backgroundColor; } 
	
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
		super.enabled = _dropButton.enabled = value;
		
		return value; 
	}  
	
	/**
	* If you want to use the scrollbar arrow buttons or not, pass  ScrollBarDirection.HORIZONTAL or ScrollBarDirection.VERTICAL.
	*/
	
	private function set_showArrowButton(value : Bool) : Bool 
	{ 
		_scrollbar.showArrowButton = value;
		
		return value; 
	} 
	
	/**
	* Returns true if the scrollbar arrows are being displayed and false if not
	*/
	
	private function get_showArrowButton() : Bool { return _scrollbar.showArrowButton; }  
	
	/**
	* Applies the text formatting that the format parameter specifies to the specified text in a label.
	* 
	* @param format A TextFormat object that contains character and paragraph formatting information.
	*/

	public function setTextFormat(value : TextFormat) : Void { _textFormat = value; }  
	
	/**
	 * Set the icon being used on the button based on the DisplayObject passed in
	 * 
	 * @param	value A DisplayObject that will be used as an icon
	 */
	
	public function setDropIcon(value : DisplayObject) : Void { _dropButton.setIcon(value); } 
	 
	/**
	* Set the icon used on the button based on a URL location
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setDropIconImage(value : String) : Void { _dropButton.setIconImage(value); } 
	
	/**
	* Set the icon used on the drop down button
	*
	* @param value The icon you want to use for
	*
	*/
	
	public function setDropIconBitmap(value : Bitmap) : Void { _dropButton.setIconBitmap(value); } 
	
	/**
	* This is for setting an image to the combo box.
	*
	* @param value Set the image based on a URL file path.
	*
	*/
	
	public function setBackgroundImage(value : String) : Void { _backgroundImage.load(value); } 
	
	/**
	* This is for setting an image to the combox box. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setBackgroundBitmap(value : Bitmap) : Void { _backgroundImage.setImage(value); } 
	
	/**
	* This is for setting an image to the combo box once using click the drop down button.
	*
	* @param value Set the image based on a URL file path.
	*
	*/
	
	public function setDropDownBackgroundImage(value : String) : Void { _backgroundDropImage.load(value); }
	
	/**
	* This is for setting an image to the combox box once using click the drop down button. It is best to set an image that can be tile. 
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setDropDownBackgroundBitmap(value : Bitmap) : Void { _backgroundDropImage.setImage(value); _displayDropDownImage = true; } 
	
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
	
	public function removeItem(item : ComboBoxObjectData) : ComboBoxObjectData { return _list.removeItem(item); }
	
	/**
	* Removes the item at the specified index
	*
	* @param index  The index at which the item is to be added.
	*/
	
	public function removeItemAt(index : Int) : ComboBoxObjectData { return _list.removeItemAt(index); } 
	
	/**
	* Replaces an existing item with a new item
	*
	* @param newItem The item to be replaced.
	* @param oldItem The replacement item.
	*/
	
	public function replaceItem(newItem : ComboBoxObjectData, oldItem : ComboBoxObjectData) : Void { _list.replaceItem(newItem, oldItem); }  
	
	/**
	* Replaces the item at the specified index
	*
	* @param newItem The replacement item.
	* @param index The replacement item.
	*/
	
	public function replaceItemAt(newItem : ComboBoxObjectData, index : Int) : ComboBoxObjectData { return _list.replaceItemAt(newItem, index); } 
	
	/**
	* Returns the item at the specified index.
	*
	* @param value Location of the item to be returned.
	* @return The item at the specified index.
	*
	*/
	
	public function getItemAt(value : Int) : ComboBoxObjectData { return _list.getItemAt(value); }
	
	/**
	* Returns the item at the selected index.
	*
	* @return The item at the selected index. Returns null if nothing was selected
	*
	*/
	
	public function getSelected() : ComboBoxObjectData { return ((_selectIndex == -1)) ? null : _list.getItemAt(_selectIndex); } 
	
	/**
	* Sorts the items that the data
	*
	* @param sortOpt The arguments to use for sorting.
	* @return The return value depends on whether the method receives any arguments.
	*
	*/
	
	public function sort(sortOpt : Dynamic) : Void 
	{ return _list.dataArray.sort(sortOpt); } 
	
	/**
	* Set the color of the track
	*/  
	
	private function set_scrollBarTrackColor(value : Int) : Int 
	{ 
		_scrollbar.trackColor = value;
		
		return value; 
	} 
	
	/**
	* Returns the color of the scrollbar track
	*/
	
	private function get_scrollBarTrackColor() : Int { return _scrollbar.trackColor; }
	
	/**
	* Set the scrollbar up icon using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setScrollBarUpIconImage(value : String) : Void { _scrollbar.setUpIconImage(value); } 
	
	/**
	* Set a image to the scrollbar up icon.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollBarUpIconBitmap(value : Bitmap) : Void { _scrollbar.setUpIconBitmap(value); } 
	
	/**
	* Set the scrollbar down icon using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setScrollBarDownIconImage(value : String) : Void { _scrollbar.setDownIconImage(value); }  
	
	/**
	* Set a image to the scrollbar down icon.
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollBarDownIconBitmap(value : Bitmap) : Void { _scrollbar.setDownIconBitmap(value); } 
	
	/**
	* Set a image to the scrollbar buttons default state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/ 
	
	public function setScrollButtonBackgroundImage(value : String) : Void { _scrollbar.setButtonBackgroundImage(value); } 
	
	/**
	* Set a image to the scrollbar buttons default state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/ 
	
	public function setScrollButtonBackgroundBitmap(value : Bitmap) : Void { _scrollbar.setButtonBackgroundBitmap(value); } 
	
	/**
	* Set a image to the scrollbar buttons over state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setScrollButtonOverBackgroundImage(value : String) : Void { _scrollbar.setButtonOverBackgroundImage(value); } 
	
	/**
	* Set a image to the scrollbar buttons over state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollButtonOverBackgroundBitmap(value : Bitmap) : Void { _scrollbar.setButtonOverBackgroundBitmap(value); } 
	
	/**
	* Set a image to the scrollbar up button down state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setScrollButtonDownBackgroundImage(value : String) : Void { _scrollbar.setButtonDownBackgroundImage(value); } 
	
	/**
	* Set a image to the scrollbar up button down state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollButtonDownBackgroundBitmap(value : Bitmap) : Void { _scrollbar.setButtonDownBackgroundBitmap(value); }
	
	/**
	* Set a image to the scrollbar up button disable state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setScrollButtonDisableBackgroundImage(value : String) : Void { _scrollbar.setButtonDisableBackgroundImage(value); }
	
	/**
	* Set a image to the scrollbar up button disable state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollButtonDisableBackgroundBitmap(value : Bitmap) : Void 
	{
		_scrollbar.setButtonDisableBackgroundBitmap(value); 
	} 
	
	/**
	* Set the scrollbar slider default state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/  public function setSliderImage(value : String) : Void{_scrollbar.setSliderImage(value);
} 
	/**
	* Set a image to the scrollbar slider default state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setSliderBitmap(value : Bitmap) : Void { _scrollbar.setSliderBitmap(value); }  
	
	/**
	* Set the scrollbar slider over state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/
	
	public function setSliderOverImage(value : String) : Void { _scrollbar.setSliderOverImage(value); } 
	
	/**
	* Set a image to the scrollbar slider over state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setSliderOverBitmap(value : Bitmap) : Void { _scrollbar.setSliderOverBitmap(value); } 
	
	/**
	* Set the scrollbar slider down state using a file path
	*
	* @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	*
	*/ 
	
	public function setSliderDownImage(value : String) : Void { _scrollbar.setSliderDownImage(value); } 
	
	/**
	* Set a image to the scrollbar slider down state
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setSliderDownBitmap(value : Bitmap) : Void 
	{
		_scrollbar.setSliderDownBitmap(value); 
	}
	
	public function setScrollBarTrackImage(value : String) : Void 
	{
		_scrollbar.setTrackImage(value); 
	} 
	
	/**
	* Set a image to the scrollbar track
	*
	* @param value Set the image based on a Bitmap being pass
	*
	*/
	
	public function setScrollBarTrackBitmap(value : Bitmap) : Void
	{
		_scrollbar.setTrackBitmap(value); 
	}  
	
	/**
	 * Return the scrollbar used in combo box
	 * @return A scroll bar interface
	 */
	
	public function getScrollBar() : IScrollBar { return _scrollbar; }
	 
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
		
		// Redraw outline  
		_border.graphics.clear();
		
		// Draw hotspot box for main area
		_dropDownHotspot.graphics.clear();
		if (_clickLabelArea) 
		{
			_dropDownHotspot.graphics.beginFill(_backgroundColor, 0);
			_dropDownHotspot.graphics.drawRect(0, 0, (_width - _buttonWidth), _height);
			_dropDownHotspot.graphics.endFill();
		} 
		
		// Show display image
		if (_displayImage && _showImage) 
		{
			_background.graphics.beginBitmapFill(_backgroundImage.image.bitmapData, null, true, _smoothImage);
		}
		else 
		{
			_background.graphics.beginFill(_backgroundColor, 1);
		}
		
		_background.graphics.drawRect(0, 0, _width, _height);
		_background.graphics.endFill();
		
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
		
		// Show display image  
		if (_displayImage && _showImage) 
		{
			_background.graphics.beginBitmapFill(_backgroundImage.image.bitmapData, null, true, _smoothImage);
		}
		else
		{
			_background.graphics.beginFill(_backgroundColor, 1);
		}
		
		_background.graphics.drawRect(0, 0, _width, _height);
		_background.graphics.endFill();
		
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
	
	/**
	* Set the level of detail on the combo box. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	* Use the the UIDetailLevel class to change the settings.
	*
	* LOW - Remove all filters and bitmap images. 
	* MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	* HIGH - Enable and show all filters plus display bitmap images if set
	*
	* @param value Send the value "low","medium" or "high"
	* @see com.chaos.ui.UIDetailLevel
	*/ 
	
	override private function set_detail(value : String) : String
	{
		// Only turn off filter if medium and low  
		if (value.toLowerCase() == UIDetailLevel.HIGH) 
		{
			super.detail = value.toLowerCase();
			_showImage = true;
			_smoothImage = true;
		}
		else if (value.toLowerCase() == UIDetailLevel.MEDIUM) 
		{
			super.detail = value.toLowerCase();
			_showImage = true;
			_smoothImage = false;
		}
		// Setting other ui classes
		else if (value.toLowerCase() == UIDetailLevel.LOW) 
		{
			super.detail = value.toLowerCase();
			_showImage = false;
			_smoothImage = false;
		}
		else 
		{
			super.detail = UIDetailLevel.LOW;
			_showImage = false;
			_smoothImage = false;
		}
		
		super.detail = _dropButton.detail = value;
		
		if (_listOpen)
		_scrollbar.detail = value;
		
		draw();
		
		return value;
	}
	
	private function textOutEvent(event : MouseEvent) : Void
	{
		cast(event.currentTarget,Label).textColor = _textColor;
		cast(event.currentTarget,Label).backgroundColor = _backgroundColor;
		cast(event.currentTarget, Label).background = false;
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
		{
			_dropDownScrollContent = new ScrollContent(_dropDownList, _scrollbar, new Rectangle(0, _height, _width + SCROLLBAR_OFFSET + (_scrollbar.width - _buttonWidth), (_height + _dropDownPadding) * (_list.length) + SCROLLBAR_OFFSET));
        }
        else 
		{
			_dropDownScrollContent = new ScrollContent(_dropDownList, _scrollbar, new Rectangle(0, _height, _width + SCROLLBAR_OFFSET + (_scrollbar.width - _buttonWidth), (_height + _dropDownPadding) * (_rowCount - 1) + SCROLLBAR_OFFSET));
        }
		
		if (_rowCount >= _list.length - 1)   
		_scrollbar.visible = false;
		
		// Setup scrollbar defaults
		_scrollbar.detail = _qualityMode;
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
		_dropDownList.graphics.clear(); 
		
		// Show display image  
		if (_displayDropDownImage && _showImage) 
		{
			_dropDownList.graphics.beginBitmapFill(_backgroundImage.image.bitmapData, null, true, _smoothImage);
        }
        else 
		{
			_dropDownList.graphics.beginFill(_backgroundColor, 1);
        }
		
		if (_rowCount >= _list.length - 1) 
		{
			_dropDownList.graphics.drawRect(0, 0, _width + SCROLLBAR_OFFSET + _scrollbar.width - _buttonWidth, (_height + _dropDownPadding) * _list.length);
        }
        else 
		{
			_dropDownList.graphics.drawRect(0, 0, _width + SCROLLBAR_OFFSET - _buttonWidth, (_height + _dropDownPadding) * _list.length);
        }
		
		_dropDownList.graphics.endFill();
		addChildAt(_dropDownList, 0);
		addChildAt(_scrollbar, 1);
		
		// Show Outline
		if (_showOutline)
		addChild(_dropDownBorder);
		
    }
	
	private function backgroundImageComplete(event : Event) : Void
	{
		_displayImage = true;
		draw();
    }
	
	private function backgroundDropDownImageComplete(event : Event) : Void 
	{
		_displayDropDownImage = true;
		draw();
    }
	
}