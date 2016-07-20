package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.ITabPane;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.DisplayObject;
import openfl.display.Bitmap;
import openfl.events.*;
import com.chaos.data.DataProvider;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.Button;
import com.chaos.ui.UIDetailLevel;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.media.DisplayImage;
import openfl.utils.Object;


/**
 *  A list of containers for loading in swf and images plus displaying content based on what button is pressed
 *
 *  @author Erick Feiling
 *  @date 11-19-09
 */

class TabPane extends ScrollPane implements ITabPane implements IScrollPane implements IBaseUI
{
    public var tabButtonTextColor(get, set) : Int;
    public var tabButtonTextSelectedColor(get, set) : Int;
    public var selectedIndex(get, set) : Int;
    public var tabButtonColor(get, set) : Int;
    public var tabButtonOverColor(get, set) : Int;
    public var tabButtonSelectedColor(get, set) : Int;
    public var tabButtonDisableColor(get, set) : Int;
	
  /** The type of UI Element */
  public static inline var TYPE : String = "TabPane";
  private var _contentList : DataProvider;
  private var _qualityMode : String = UIDetailLevel.HIGH;
  private var _tabButtonHeight : Int = 20;
  private var _tabButtonNormalColor : Int = 0xCCCCCC;
  private var _tabButtonOverColor : Int = 0x666666;
  private var _tabButtonSelectedColor : Int = 0x333333;
  private var _tabButtonDisableColor : Int = 0x999999;
  private var _tabButtonTextColor : Int = 0xFFFFFF;
  private var _tabButtonTextSelectedColor : Int = 0xFFFFFF;
  private var _tabButtonNormalImage : DisplayImage;
  private var _tabButtonOverImage : DisplayImage;
  private var _tabButtonDisableImage : DisplayImage;
  private var _tabButtonDownImage : DisplayImage;
  private var _scrollButtonNormalColor : Int = 0xCCCCCC;
  private var _scrollButtonOverColor : Int = 0x666666;
  private var _scrollButtonDownColor : Int = 0x333333;
  private var _scrollButtonDisableColor : Int = 0x999999;
  private var _selectedIndex : Int = 0;
  
  private function new(paneWidth : Int = 400, paneHeight : Int = 300)
    {
		super(paneWidth, paneHeight);
		
		addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
		
		border = true;
		
		//init();
		draw();
    }
	
	override private function onStageAdd(event : Event) : Void { UIBitmapManager.watchElement(TYPE, this); }	
	override private function onStageRemove(event : Event) : Void { UIBitmapManager.stopWatchElement(TYPE, this); }
	
	override function init() : Void
	{
		super.init();
		
		// setup list
		_contentList = new DataProvider();
		
		_tabButtonNormalImage = new DisplayImage();
		_tabButtonOverImage = new DisplayImage();
		_tabButtonDownImage = new DisplayImage();
		_tabButtonDisableImage = new DisplayImage();
		
		_tabButtonNormalImage.onImageComplete = tabBtnImageLoadComplete;
		_tabButtonOverImage.onImageComplete = tabBtnImageLoadComplete;
		_tabButtonDownImage.onImageComplete = tabBtnImageLoadComplete;
		_tabButtonDisableImage.onImageComplete = tabBtnImageLoadComplete;
    }
	
	private function initSkin() : Void 
	{
		// Background
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BACKGROUND))  
		setBackgroundBitmap(UIBitmapManager.getUIElement(ScrollPane.TYPE, UIBitmapManager.TABPANE_BACKGROUND)); 
		
		// Buttons  
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_NORMAL))       
		setTabButtonBackgroundBitmap(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_NORMAL));
		
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_OVER))     
        setTabButtonOverBackgroundBitmap(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_OVER));
		
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_SELECTED))       
		setTabButtonDownBackgroundBitmap(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_SELECTED));
		
		if (null != UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_DISABLE)) 
		setTabButtonDisableBackgroundBitmap(UIBitmapManager.getUIElement(TabPane.TYPE, UIBitmapManager.TABPANE_BUTTON_DISABLE));
    }
	
	override private function initStyle() : Void
	{  
		super.initStyle();
		
		// Border
		if ( -1 != UIStyleManager.TABPANE_BACKGROUND)   
		backgroundColor = UIStyleManager.TABPANE_BACKGROUND;
		
		border = UIStyleManager.TABPANE_BORDER;
		
		if ( -1 != UIStyleManager.TABPANE_BORDER_COLOR)  
		borderColor = UIStyleManager.TABPANE_BORDER_COLOR;
		
		if ( -1 != UIStyleManager.TABPANE_BORDER_ALPHA)      
		borderAlpha = UIStyleManager.TABPANE_BORDER_ALPHA;
		
		if ( -1 != UIStyleManager.TABPANE_BORDER_THINKNESS)  
		borderThinkness = UIStyleManager.TABPANE_BORDER_THINKNESS;
		
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
	
	/**
	 * @inheritDoc
	 */
	override public function reskin() : Void 
	{
		super.reskin();
		
		initSkin();
		initStyle();
    }
	
	/**
	 * Set the color of the TabPane button text field color
	 */
	
	private function set_tabButtonTextColor(value : Int) : Int
	{
		_tabButtonTextColor = value;draw();
        return value;
    } 
	
	/**
	 *
	 * @return Returns the color
	 */
	
	private function get_tabButtonTextColor() : Int{return _tabButtonTextColor;
    }
	
	/**
	 * Set the color of the TabPane button text field color in it's selected state
	 */
	private function set_tabButtonTextSelectedColor(value : Int) : Int
	{
		_tabButtonTextSelectedColor = value;draw();
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
		for (i in 0..._contentList.length - 1 + 1)
		{
			_contentList.getItemAt(i).button.enabled = value;
        }
		
		_contentList.getItemAt(_selectedIndex).button.enabled = (super.enabled) ? false : true;
		
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
		var tempObject : Object = new Object();
		tabButton.label = value;
		tabButton.addEventListener(MouseEvent.CLICK, tabPress);
		
		// Content
		tempObject.label = value;
		tempObject.content = content;
		tempObject.button = tabButton;
		
		if (Std.is(content, DisplayObject)) 
		{
			tempObject.content_width = content.width;
			tempObject.content_height = content.height;
        }
		
		addChild(tabButton);
		
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
		for (i in 0..._contentList.length - 1 + 1)
		{
			if (_contentList.getItemAt(i).label.toLowerCase() == value.toLowerCase()) 
			{
				return removeItemAt(i);
            }
        }
		
		return null;
    } 
	
	/**
	 * Removes the item at the specified index
	 *
	 * @param index  The index at which the item is to be added.
	 */  
	public function removeItemAt(value : Int) : Dynamic 
	{
		if (value < 0 || value > _contentList.length - 1)    
		return null;
		
		var tempObj : Dynamic = _contentList.removeItemAt(value); 
		
		// Remove button from display  
		removeChild(tempObj.button);
		
		tempObj.button.addEventListener(MouseEvent.CLICK, tabPress);
		
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
			_selectedIndex = value;contentLoad(_contentList.getItemAt(value).content);
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
		_tabButtonNormalColor = value;draw();
        return value;
    }
	
	/**
	 * Returns the color
	 */
	
	private function get_tabButtonColor() : Int{return _tabButtonNormalColor;
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
	 * Set a image to the tab buttons default state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */ 
	public function setTabButtonBackgroundImage(value : String) : Void 
	{
		_tabButtonNormalImage.load(value);
    }
	
	/**
	 * Set a image to the tab buttons default state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */
	public function setTabButtonBackgroundBitmap(value : Bitmap) : Void
	{
		_tabButtonNormalImage.setImage(value);
    }
	
	/**
	 * Set a image to the tab buttons over state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setTabButtonOverBackgroundImage(value : String) : Void
	{
		_tabButtonOverImage.load(value);
    }
	
	/**
	 * Set a image to the tab buttons over state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */  
	public function setTabButtonOverBackgroundBitmap(value : Bitmap) : Void
	{
		_tabButtonOverImage.setImage(value);
    }  
	
	/**
	 * Set a image to the tab up button down state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setTabButtonDownBackgroundImage(value : String) : Void
	{
		_tabButtonDownImage.load(value);
    }
	/**
	 * Set a image to the tab up button down state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	public function setTabButtonDownBackgroundBitmap(value : Bitmap) : Void
	{
		_tabButtonDownImage.setImage(value);
    }
	
	/**
	 * Set a image to the tab up button disable state using a file path
	 *
	 * @param value A URL path as a string to the image. Make sure this is one of the formats the version of the Flash player your using supports.
	 *
	 */
	public function setTabButtonDisableBackgroundImage(value : String) : Void 
	{
		_tabButtonDisableImage.load(value);
    }
	
	/**
	 * Set a image to the tab up button disable state
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 */ 
	
	public function setTabButtonDisableBackgroundBitmap(value : Bitmap) : Void
	{
		_tabButtonDisableImage.setImage(value);
    } 
	
	/**
	 * Return the TabPane buton being used.
	 *
	 * @param value Set the image based on a Bitmap being pass
	 *
	 * @return Return button being on TabPane
	 */  
	public function getTabButton(value : Int = -1) : Button
	{  
		// Return value passed if not found or incorrect return the current selected index
		if (value <= _contentList.length - 1 && value >= 0) 
		{
			return _contentList.getItemAt(value).button;
        }
        else 
		{
			return _contentList.getItemAt(_selectedIndex).button;
        }
		
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
		for (i in 0..._contentList.length - 1 + 1)
		{ 
			// Setting up buttons
			_contentList.getItemAt(i).button.name = i;
			_contentList.getItemAt(i).button.width = Std.int(width / _contentList.length);
			_contentList.getItemAt(i).button.height = _tabButtonHeight;
			_contentList.getItemAt(i).button.x = _contentList.getItemAt(i).button.width * i;
			_contentList.getItemAt(i).button.textColor = _tabButtonTextColor;
			_contentList.getItemAt(i).button.buttonColor = _tabButtonNormalColor;
			_contentList.getItemAt(i).button.buttonOverColor = _tabButtonOverColor;
			_contentList.getItemAt(i).button.buttonDownColor = _tabButtonSelectedColor;
			_contentList.getItemAt(i).button.buttonDisableColor = _tabButtonDisableColor;
			
			if (null != _tabButtonNormalImage.image)          
			_contentList.getItemAt(i).button.setBackgroundBitmap(_tabButtonNormalImage);
			
			if (null != _tabButtonOverImage.image)  
			_contentList.getItemAt(i).button.setOverBackgroundBitmap(_tabButtonOverImage);
			
			if (null != _tabButtonDownImage.image) 
			_contentList.getItemAt(i).button.setOverBackgroundBitmap(_tabButtonDownImage);
			
			if (null != _tabButtonDisableImage.image)    
			_contentList.getItemAt(i).button.setDisableBackgroundBitmap(_tabButtonDisableImage);
			
			// Set TextFormat based on UIStyleManager  
			_contentList.getItemAt(i).button.textBold = UIStyleManager.TABPANE_BUTTON_TEXT_BOLD;
			_contentList.getItemAt(i).button.textItalic = UIStyleManager.TABPANE_BUTTON_TEXT_ITALIC;
			
			if ( -1 != UIStyleManager.TABPANE_BUTTON_TEXT_SIZE)   
			_contentList.getItemAt(i).button.textSize = UIStyleManager.TABPANE_BUTTON_TEXT_SIZE;
			
			if ("" != UIStyleManager.TABPANE_BUTTON_TEXT_FONT)  
			_contentList.getItemAt(i).button.textFont = UIStyleManager.TABPANE_BUTTON_TEXT_FONT;
			
			if (null != UIStyleManager.TABPANE_BUTTON_TEXT_EMBED)   
			_contentList.getItemAt(i).button.textLabel.setEmbedFont(UIStyleManager.TABPANE_BUTTON_TEXT_EMBED);
			
			if ( -1 != UIStyleManager.TABPANE_BUTTON_TINT_ALPHA) 
			_contentList.getItemAt(i).button.textLabel.bitmapAlpha(UIStyleManager.TABPANE_BUTTON_TINT_ALPHA);
			
        }  
		
		// Set location of scroll pane 
		contentHolder.height = height;
		contentHolder.y = _tabButtonHeight;
		
		// Load in content
		if (_contentList.length > 0 && _contentList.getItemAt(_selectedIndex).content != null)
		{
			_contentList.getItemAt(_selectedIndex).button.enabled = false;
			contentLoad(_contentList.getItemAt(_selectedIndex).content);
        }
		
		update();
    }
	
	/**
	 * Set the level of detail on the TabPane. This degrade the combo box with LOW, MEDIUM and HIGH settings.
	 * Use the the UIDetailLevel class to change the settings.
	 *
	 * LOW - Remove all filters and bitmap images.
	 * MEDIUM - Remove all filters but leaves bitmap images with image smoothing off.
	 * HIGH - Enable and show all filters plus display bitmap images if set
	 *
	 * @param value Send the value "low","medium" or "high"
	 * @see com.chaos.ui.UIDetailLevel
	 */  
	
	override  function set_detail(value : String) : String
	{
		super.detail = value;
		
		// Set detail level for all buttons  
		for (i in 0..._contentList.length - 1 + 1)
		{
			_contentList.getItemAt(i).button.detail = value;
        }
		
        return value;
    }
	
	private function contentLoad(value : DisplayObject) : Void 
	{
		// Selected Index
		source = value;
    }
	
	private function tabPress(event : MouseEvent) : Void
	{
		if (_selectedIndex != Std.parseInt(event.currentTarget.name)) 
		{ 
			// Current Button
			_contentList.getItemAt(Std.parseInt(event.currentTarget.name)).button.enabled = false;
			_contentList.getItemAt(Std.parseInt(event.currentTarget.name)).button.textColor = _tabButtonSelectedColor;
			
			// Disable old one
			_contentList.getItemAt(_selectedIndex).button.enabled = true;
			_contentList.getItemAt(_selectedIndex).button.textColor = _tabButtonTextColor;
			
			// Update selected index and grab new content 
			_selectedIndex = Std.parseInt(event.currentTarget.name);
			contentLoad(_contentList.getItemAt(Std.parseInt(event.currentTarget.name)).content);
			dispatchEvent(new Event(Event.CHANGE));
        }
    }
	
	private function tabBtnImageLoadComplete(event : Event) : Void
	{
		draw();
    }
}