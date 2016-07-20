package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseSelectData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IItemPane;
import com.chaos.ui.classInterface.IItemPaneObjectData;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IToggleButton;
import openfl.errors.Error;
import openfl.text.TextFieldAutoSize;


//import com.chaos.ui.interface.IBaseSelectData;
import openfl.display.Bitmap;

import openfl.events.Event;

import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

import openfl.display.Sprite;
import openfl.display.Shape;

import openfl.text.Font;

//import com.chaos.ui.interface.IToggleButton;
//import com.chaos.ui.interface.IItemPane;
//import com.chaos.ui.interface.IItemPaneObjectData;
//import com.chaos.ui.interface.IList;
//import com.chaos.ui.interface.IBaseUI;
//import com.chaos.ui.interface.IScrollPane;

import com.chaos.data.DataProvider;

import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;

import com.chaos.ui.data.ItemPaneObjectData;

import com.chaos.ui.event.ToggleEvent;

import com.chaos.ui.ScrollPane;
import com.chaos.ui.ItemPane;
import com.chaos.ui.Label;
import com.chaos.ui.ToggleButtonLite;

import com.chaos.media.DisplayImage;



/**
 * A list of display objects.
 *
 * @author Erick Feiling
 */

class ItemPane extends ScrollPane implements com.chaos.ui.classInterface.IItemPane implements com.chaos.ui.classInterface.IScrollPane implements com.chaos.ui.classInterface.IBaseUI
{
    public var itemWidth(get, set) : Int;
    public var itemHeight(get, set) : Int;
    public var showLabel(get, set) : Bool;
    public var itemNormalColor(get, set) : Int;
    public var itemOverColor(get, set) : Int;
    public var itemSelectedColor(get, set) : Int;
    public var itemDisableColor(get, set) : Int;
    public var allowMultipleSelection(get, set) : Bool;
    public var itemLocX(get, set) : Int;
    public var itemLocY(get, set) : Int;
    public var dataProvider(get, set) : DataProvider;

    /** The type of UI Element */
    public static inline var TYPE : String = "ItemPane";
    
    private var _list : DataProvider = new DataProvider();
    
    private var _selectedIndex : Int = -1;
    private var _itemHolder : Sprite;
    
    private var _itemTempItem : DisplayImage;
    
    private var _itemNormalState : DisplayImage;
    private var _itemOverState : DisplayImage;
    private var _itemSelectedState : DisplayImage;
    private var _itemDisableState : DisplayImage;
    
    private var _itemWidth : Int = UIStyleManager.ITEMPANE_DEFAULT_ITEM_WIDTH;
    private var _itemHeight : Int = UIStyleManager.ITEMPANE_DEFAULT_ITEM_HEIGHT;
    
    private var _itemNormalColor : Int = 0x5D5D5D;
    private var _itemOverColor : Int = 0x666666;
    private var _itemSelectedColor : Int = 0x999999;
    private var _itemDisableColor : Int = 0xCCCCCC;
    
    private var _labelNormalColor : Int = -1;
    private var _labelSelectedColor : Int = -1;
    
    private var _showLabel : Bool = true;
    
    //private var _border : Bool = false;
    
    //private var _thinkness : Float = 1;
    //private var _borderColor : Int = 0x000000;
    //private var _borderAlpha : Float = 1;
    
    private var _allowMultipleSelection : Bool = false;
    
    private var _itemLocX : Int = UIStyleManager.ITEMPANE_ITEM_LOC_X;
    private var _itemLocY : Int = UIStyleManager.ITEMPANE_ITEM_LOC_Y;
    
    private var _embed : Font = null;
    private var _font : String = "";
    
    private var _color : Int = -1;
    private var _bold : Bool = false;
    private var _italic : Bool = false;
    private var _size : Int = -1;
    
    /**
		 * A list of display objects
		 *
		 * @param	paneWidth The width of the pane
		 * @param	paneHeight The height of the pane
		 * @param	itemData A list of data
		 *
		 * @eventType openfl.events.Event.CHANGE
		 */
    public function new(paneWidth : Int = 200, paneHeight : Int = 300, itemData : DataProvider = null)
    {
        super();
        
        _itemNormalState = new DisplayImage();
        _itemOverState = new DisplayImage();
        _itemSelectedState = new DisplayImage();
        _itemDisableState = new DisplayImage();
        
        _itemHolder = new Sprite();
        
        // Init scroll pane
        super();
        
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
        
        source = _itemHolder;
        
        width = paneWidth;
        height = paneHeight;
        
        if (null != itemData) 
            _list = itemData;
        
        reskin();
    }
    
    override public function reskin() : Void
    {
        super.reskin();
        
        // init them
        initUISkin();
        initStyle();
        
        draw();
        refreshPane();
    }
    
    override private function onStageAdd(event : Event) : Void
    {
        UIBitmapManager.watchElement(TYPE, this);
    }
    
   override private function onStageRemove(event : Event) : Void
    {
        UIBitmapManager.stopWatchElement(TYPE, this);
    }
    
    override private function initUISkin() : Void
    {
		super.initUISkin();
		
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_BACKGROUND)) 
            setBackgroundBitmap(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_BACKGROUND));
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_NORMAL)) 
        {
            
            var tempNormal : DisplayImage = new DisplayImage();
            tempNormal.setImage(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_NORMAL));
            
            setNormalItem(tempNormal);
        }
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_OVER)) 
        {
            var tempOver : DisplayImage = new DisplayImage();
            tempOver.setImage(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_OVER));
            
            setOverItem(tempOver);
        }
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_SELECTED)) 
        {
            var tempSelected : DisplayImage = new DisplayImage();
            tempSelected.setImage(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_SELECTED));
            
            setSelectedItem(tempSelected);
        }
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_DISABLE)) 
        {
            var tempDisable : DisplayImage = new DisplayImage();
            tempDisable.setImage(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_DISABLE));
            
            setDisableItem(tempDisable);
        }
    }
    
    override private function initStyle() : Void
    {
		super.initStyle();
		
        // Scroll Pane Background
        if (-1 != UIStyleManager.ITEMPANE_BACKGROUND) 
            backgroundColor = UIStyleManager.ITEMPANE_BACKGROUND; 
			
		// Scroll Pane
        border = UIStyleManager.ITEMPANE_BORDER;
        
        if (-1 != UIStyleManager.ITEMPANE_BORDER_COLOR) 
            borderColor = UIStyleManager.ITEMPANE_BORDER_COLOR;
        
        if (-1 != UIStyleManager.ITEMPANE_BORDER_ALPHA) 
            borderAlpha = UIStyleManager.ITEMPANE_BORDER_ALPHA;  
        
        // Items Pane
        _border = UIStyleManager.ITEMPANE_ITEM_BORDER;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_BORDER_COLOR) 
            _borderColor = UIStyleManager.ITEMPANE_ITEM_BORDER_COLOR;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_BORDER_ALPHA) 
            _borderAlpha = UIStyleManager.ITEMPANE_ITEM_BORDER_ALPHA;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_BORDER_THINKNESS) 
            _thinkness = UIStyleManager.ITEMPANE_ITEM_BORDER_THINKNESS;  
        
        
        // Item Colors
        if (-1 != UIStyleManager.ITEMPANE_ITEM_NORMAL_COLOR) 
            _itemNormalColor = UIStyleManager.ITEMPANE_ITEM_NORMAL_COLOR;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_OVER_COLOR) 
            _itemOverColor = UIStyleManager.ITEMPANE_ITEM_OVER_COLOR;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_SELECTED_COLOR) 
            _itemSelectedColor = UIStyleManager.ITEMPANE_ITEM_SELECTED_COLOR;
        
        if (-1 != UIStyleManager.ITEMPANE_ITEM_DISABLE_COLOR) 
            _itemDisableColor = UIStyleManager.ITEMPANE_ITEM_DISABLE_COLOR; 
        
        
         // Label
        _embed = UIStyleManager.ITEMPANE_TEXT_EMBED;
        _font = UIStyleManager.ITEMPANE_TEXT_FONT;
        _color = UIStyleManager.ITEMPANE_TEXT_COLOR;
        _size = UIStyleManager.ITEMPANE_TEXT_SIZE;
        _bold = UIStyleManager.ITEMPANE_TEXT_BOLD;
        _italic = UIStyleManager.ITEMPANE_TEXT_ITALIC;
    }
    
    /**
	 * Set the width of the item block size
	 */
    
    private function set_itemWidth(value : Int) : Int
    {
        _itemWidth = value;
        draw();
        return value;
    }
    
    /**
	 * Return the size of the item block width
	 */
    
    private function get_itemWidth() : Int
    {
        return _itemWidth;
    }
    
    /**
	 * Set the height of the item block size
	 */
    
    private function set_itemHeight(value : Int) : Int
    {
        _itemHeight = value;
        draw();
        return value;
    }
    
    /**
	 * Return the size of the item block height
	 */

    private function get_itemHeight() : Int
    {
        return _itemHeight;
    }
    
    /**
	 * Show or hide the label on button
	 */
    
    private function set_showLabel(value : Bool) : Bool
    {
        _showLabel = value;
        draw();
        return value;
    }
    
    /**
	 * Return if the label is hidden or is being displayed
	 */
    
    private function get_showLabel() : Bool
    {
        return _showLabel;
    }
    
    /**
	 * The item normal state color
	 */
    
    private function set_itemNormalColor(value : Int) : Int
    {
        _itemNormalColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the item normal state color
	 */
    
    private function get_itemNormalColor() : Int
    {
        return _itemNormalColor;
    }
    
    /**
	 * The item over state color
	 */
    
    private function set_itemOverColor(value : Int) : Int
    {
        _itemOverColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the item over state color
	 */
    
    private function get_itemOverColor() : Int
    {
        return _itemOverColor;
    }
    
    /**
	 * The item selected state color
	 */
    
    private function set_itemSelectedColor(value : Int) : Int
    {
        _itemSelectedColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the item selected state color
	 */
    
    private function get_itemSelectedColor() : Int
    {
        return _itemSelectedColor;
    }
    
    /**
	 * The item disable state color
	 */
    
    private function set_itemDisableColor(value : Int) : Int
    {
        _itemDisableColor = value;
        draw();
        return value;
    }
    
    /**
	 * Return the item disable state color
	 */
    
    private function get_itemDisableColor() : Int
    {
        return _itemDisableColor;
    }
    
    /**
	 * The user can select more then one item on the item pane
	 */
    
    private function set_allowMultipleSelection(value : Bool) : Bool
    {
        _allowMultipleSelection = value;
        return value;
    }
    
    /**
	 * Returns if the user can select more then one at a time.
	 */
    
    private function get_allowMultipleSelection() : Bool
    {
        return _allowMultipleSelection;
    }
    
    /**
	 * Set the X location of the item
	 */
    
    private function set_itemLocX(value : Int) : Int
    {
        _itemLocX = value;
        return value;
    }
    
    /**
	 *  Return the X location of the item
	 */
    
    private function get_itemLocX() : Int
    {
        return _itemLocX;
    }
    
    /**
	 * Set the Y location of the item
	 */
    
    private function set_itemLocY(value : Int) : Int
    {
        _itemLocY = value;
        return value;
    }
    
    /**
	 *  Return the Y location of the item
	 */
    
    private function get_itemLocY() : Int
    {
        return _itemLocY;
    }
    
    /**
	 * Add a new item to the item pane
	 *
	 * @param	item The item you want to add
	 */
    
    public function addItem(item : Dynamic) : Void
    {
        _list.addItem(item);
        draw();
    }
    
    /**
	 * Remove an item out of the item pane
	 *
	 * @param	item The object you want to remove
	 *
	 * @return Return the removed object
	 */
    public function removeItem(item : Dynamic) : Dynamic
    {
        var oldData : Dynamic = _list.removeItem(item);
        draw();
        
        return oldData;
    }
    
    /**
	 * Replaces an existing item with a new item
	 *
	 * @param newItem The item to be replaced.
	 * @param oldItem The replacement item.
	 */
    
    public function replaceItem(newItem : Dynamic, oldItem : Dynamic) : Void
    {
        _list.replaceItem(newItem, oldItem);
        draw();
    }
    
    /**
	 * Remove all items out of the list
	 */
    
    public function removeAll() : Void
    {
        _list.removeAll();
        
        _selectedIndex = -1;
        draw();
    }
    
    /**
	 * Replaces the item at the specified index
	 *
	 * @param newItem The replacement item.
	 * @param index The replacement item.
	 */
    
    public function replaceItemAt(newItem : Dynamic, index : Int) : ItemPaneObjectData
    {
        var oldData : ItemPaneObjectData = _list.replaceItemAt(newItem, index);
        draw();
        
        return oldData;
    }
    
    /**
	 * Returns the item at the specified index.
	 *
	 * @param value Location of the item to be returned.
	 * @return The item at the specified index.
	 *
	 */
    
    public function getItemAt(value : Int) : ItemPaneObjectData
    {
        var oldData : ItemPaneObjectData = _list.getItemAt(value);
        draw();
        
        return oldData;
    }
    
    /**
	 * Replace the current data provider and rebuild the item pane
	 */
    
    private function set_dataProvider(value : DataProvider) : DataProvider
    {
        _list = value;
        draw();
        return value;
    }
    
    /**
	 * Returns the data provider being used
	 */
    
    private function get_dataProvider() : DataProvider
    {
        return _list;
    }
    
    /**
	 * Returns the item at the selected index.
	 *
	 * @return The item at the selected index.
	 *
	 */
    
    public function getSelected() : ItemPaneObjectData
    {
        return _list.getItemAt(_selectedIndex);
    }
    
    /**
	 * A list of selected items
	 * @return An array with selected list items
	 */
    
    public function getSelectedList() : Array<Dynamic>
    {
        var selectedList : Array<Dynamic> = new Array<Dynamic>();
        
        for (i in 0..._list.length - 1 + 1){
            var itemPaneData : com.chaos.ui.classInterface.IBaseSelectData = try cast(_list.getItemAt(i), com.chaos.ui.classInterface.IBaseSelectData) catch(e:Dynamic) null;
            
            if (itemPaneData.selected) 
                selectedList.push(itemPaneData);
        }
        
        return selectedList;
    }
    
    /**
	 * Return the index number of the item that was selected
	 */
    
    public function selectIndex() : Int
    {
        return _selectedIndex;
    }
    
    /**
	 * Returns the listed item in the list
	 */
    
    public function selectText() : String
    {
        return _list.getItemAt(_selectedIndex).text;
    }
    
    /**
	 *
	 * The nomral state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    public function setNormalItem(value : DisplayImage) : Void
    {
        _itemNormalState = value;
        draw();
    }
    
    /**
	 *
	 * The over state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    public function setOverItem(value : DisplayImage) : Void
    {
        _itemOverState = value;
        draw();
    }
    
    /**
	 *
	 * The down state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    public function setSelectedItem(value : DisplayImage) : Void
    {
        _itemSelectedState = value;
        draw();
    }
    
    /**
	 * The disable state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    public function setDisableItem(value : DisplayImage) : Void
    {
        _itemDisableState = value;
        draw();
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        buildDataList();
    }
    
    private function buildDataList() : Void
    {
        
        if (null == _list) 
            return;
			
		// Remove all old
        removeList();
        
        var _lastRowNum : Int = 0;
        
        for (i in 0..._list.length)
		{
            
            var itemLabel : Label = new Label();
            var itemButton : ToggleButtonLite = new ToggleButtonLite();
            var itemData : com.chaos.ui.classInterface.IItemPaneObjectData = try cast(_list.getItemAt(i), com.chaos.ui.classInterface.IItemPaneObjectData) catch(e:Dynamic) null;
            var oldData : com.chaos.ui.classInterface.IItemPaneObjectData = ((i == 0)) ? null : try cast(_list.getItemAt(i - 1), com.chaos.ui.classInterface.IItemPaneObjectData) catch(e:Dynamic) null;
            var textFormat : TextFormat = new TextFormat();
            
            // Attach a tool-tip
            if ("" != itemData.toolTipText) 
                ToolTip.attach(itemButton, itemData.toolTipText);
            
            itemLabel.textField.autoSize = TextFieldAutoSize.LEFT;
            itemLabel.width = _itemWidth;
            
            itemLabel.text = itemData.text;
            itemLabel.align = "center";
            
            itemLabel.visible = _showLabel;
            
            if (null != _embed) 
                itemLabel.setEmbedFont(_embed);
            
            if ("" != _font) 
                itemLabel.font = _font;
            
            if (-1 != _color) 
                itemLabel.textColor = _color;
            
            if (-1 != _size) 
                itemLabel.size = _size;
            
            itemLabel.textFormat.bold = _bold;
            itemLabel.textFormat.italic = _italic;
            
            //itemLabel.setTextFormat(textFormat);
            
            // Set color default color if was set
            if (!itemData.selected && -1 != _labelNormalColor) 
                itemLabel.textColor = _labelNormalColor;  
            
            // Set selected color if was set
            if (itemData.selected && -1 != _labelSelectedColor) 
                itemLabel.textColor = _labelSelectedColor;
            
            itemButton.name = Std.string(i);
            itemButton.setNormalState(createButtonState(_itemWidth, _itemHeight, _itemNormalColor, ((null != _itemNormalState.image)) ? _itemNormalState.image : null));
            itemButton.setOverState(createButtonState(_itemWidth, _itemHeight, _itemOverColor, ((null != _itemOverState.image)) ? _itemOverState.image : null));
            itemButton.setDownState(createButtonState(_itemWidth, _itemHeight, _itemSelectedColor, ((null != _itemSelectedState.image)) ? _itemSelectedState.image : null));
            itemButton.setDisableState(createButtonState(_itemWidth, _itemHeight, _itemDisableColor, ((null != _itemDisableState.image)) ? _itemDisableState.image : null));
            
            itemButton.addEventListener(ToggleEvent.DOWN_STATE, onItemDownPress);
            
            // Center the Item label at the bottom
            itemLabel.x = (itemLabel.width - _itemWidth / 2) + UIStyleManager.ITEMPANE_LABEL_OFFSET_X;
            itemLabel.y = (_itemHeight - itemLabel.height) + UIStyleManager.ITEMPANE_LABEL_OFFSET_Y;
            
            // Add in the item if it's there
            if (null != itemData.item) 
            {
                itemData.item.x = _itemLocX;
                itemData.item.y = _itemLocY;
                
                itemButton.addChild(itemData.item);
            }  
            
            // Add label to button  
            itemButton.addChild(itemLabel);
            
            // Shift items to where they need to be on the screen
            itemButton.x = (i - _lastRowNum) * itemButton.width;
            
            // Update to new row on y-axis
            if ((itemButton.x + itemButton.width) > width) 
            {
                _lastRowNum = i;
                
                itemButton.x = 0;
                itemButton.y = oldData.itemButton.y + _itemHeight;
            }
            else 
            {
                itemButton.y = ((null == oldData)) ? itemButton.y : oldData.itemButton.y;
            }  
            
            
            // Add icon if need be  
            if (null != itemData.icon) 
            {
                
                itemData.icon.x = UIStyleManager.ITEMPANE_ICON_LOC_X;
                itemData.icon.y = UIStyleManager.ITEMPANE_ICON_LOC_Y;
                
                itemButton.addChild(itemData.icon);
            }
			
			// Add to data object    
			//itemButton.x = (i - _lastRowNum) * itemButton.width; 
			//trace("new row: " + i);  
            
            
            itemData.label = itemLabel;
            itemData.itemButton = itemButton;
            
            _itemHolder.addChild(itemButton);
        }
        
        refreshPane();
    }
    
    private function removeList() : Void
    {
        
        // NOTE: Turn this into a class file later
        var i : Int = _itemHolder.numChildren;
        
        while (i < 0)
        {
            
            try
            {
                
                var tempObj : Sprite = cast(_itemHolder.removeChildAt(i), Sprite);
                ToolTip.remove(tempObj);
				
                tempObj.removeEventListener(ToggleEvent.DOWN_STATE, onItemDownPress);
                tempObj = null;
            }
            catch (error : Error)
            {
                
                
            }
			
			i--;
        }  
		
		//source = _itemHolder;
		//_itemHolder = new Sprite();  
        
        refreshPane();
    }
    
    private function createButtonState(shapeWidth : Int, shapeHeight : Int, shapeColor : Int = 0xFFFFFF, shapeBitmap : Bitmap = null) : Shape
    {
        var tempShape : Shape = new Shape();
        
        tempShape.graphics.clear();
        
        // Draw border if need be
        if (_border) 
            tempShape.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
        
        if (null == shapeBitmap) 
        {
            tempShape.graphics.beginFill(shapeColor);
        }
        else 
        {
            tempShape.graphics.beginBitmapFill(shapeBitmap.bitmapData, null, false, true);
        }
        
        tempShape.graphics.drawRect(0, 0, shapeWidth, shapeHeight);
        tempShape.graphics.endFill();
        
        return tempShape;
    }
    
    private function onItemDownPress(event : ToggleEvent) : Void
    {
        
        var toggleButton : IToggleButton = cast(event.currentTarget, IToggleButton);
        
        // If not allow more then one to be selected
        if (!_allowMultipleSelection) 
        {
            clearAllSelected();
            
            if (null != _list.getItemAt(_selectedIndex)) 
                _list.getItemAt(_selectedIndex).selected = toggleButton.selected = true;
        }
        else 
        {
            if (null != _list.getItemAt(_selectedIndex)) 
                _list.getItemAt(_selectedIndex).selected = toggleButton.selected;
        }
        
        _selectedIndex = Std.parseInt(toggleButton.name);
		
        dispatchEvent(new Event(Event.CHANGE));
		
    }
    
    private function clearAllSelected() : Void
    {
        for (i in 0..._list.length - 1 + 1)
		{
            var itemData : IItemPaneObjectData = cast(_list.getItemAt(i), IItemPaneObjectData);
            
            itemData.itemButton.selected = itemData.selected = false;
            
            // If color label was selected
            if (-1 != _labelNormalColor) 
                itemData.label.textColor = _labelNormalColor;
        }
    }
}

