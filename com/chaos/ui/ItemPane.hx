package com.chaos.ui;


import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IItemPane;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.classInterface.IToggleButton;

import com.chaos.data.DataProvider;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.data.ItemPaneObjectData;
import com.chaos.ui.event.ToggleEvent;
import com.chaos.ui.ScrollPane;

import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.text.Font;


/**
 * A list of elements that support different items being viewed as images. 
 *
 * @author Erick Feiling
 */

class ItemPane extends ScrollPane implements IItemPane implements IScrollPane implements IBaseUI
{
	
    /** The type of UI Element */
    public static inline var TYPE : String = "ItemPane";
	
    /**
	 * Set the width of the item block size
	 */
	
    public var itemWidth(get, set) : Int;
	
    /**
	 * Set the height of the item block size
	 */
	
    public var itemHeight(get, set) : Int;
	
    /**
	 * Show or hide the label on button
	 */
	
    public var showLabel(get, set) : Bool;
	
    /**
	 * The item normal state color
	 */
	
    public var itemNormalColor(get, set) : Int;
	
    /**
	 * The item over state color
	 */
	
    public var itemOverColor(get, set) : Int;
	
    /**
	 * The item selected state color
	 */
	
    public var itemSelectedColor(get, set) : Int;
	
    /**
	 * The item disable state color
	 */
	
    public var itemDisableColor(get, set) : Int;
	
    /**
	 * The user can select more than one item on the item pane
	 */
	
    public var allowMultipleSelection(get, set) : Bool;
	
    /**
	 * Set the X location of the item
	 */
	
    public var itemLocX(get, set) : Int;
	
    /**
	 * Set the Y location of the item
	 */
	
    public var itemLocY(get, set) : Int;
	
    /**
	 * Replace the current data provider and rebuild the item pane
	 */
	
    public var dataProvider(get, set) : DataProvider<ItemPaneObjectData>;
    
    private var _list : DataProvider<ItemPaneObjectData> = new DataProvider<ItemPaneObjectData>();
    
    private var _selectedIndex : Int = -1;
    private var _itemHolder : Sprite;
    
    private var _itemDefaultState : BitmapData;
    private var _itemOverState : BitmapData;
    private var _itemSelectedState : BitmapData;
    private var _itemDisableState : BitmapData;
    
    private var _itemWidth : Int = UIStyleManager.ITEMPANE_DEFAULT_ITEM_WIDTH;
    private var _itemHeight : Int = UIStyleManager.ITEMPANE_DEFAULT_ITEM_HEIGHT;
    
    private var _itemNormalColor : Int = 0x5D5D5D;
    private var _itemOverColor : Int = 0x666666;
    private var _itemSelectedColor : Int = 0x999999;
    private var _itemDisableColor : Int = 0xCCCCCC;
    
    private var _labelNormalColor : Int = -1;
    private var _labelSelectedColor : Int = -1;
    
    private var _showLabel : Bool = true;
    
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
	 * UI TabPane 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new(data:Dynamic = null)
    {
        
        super(data);
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override function setComponentData(data:Dynamic) 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "data"))
		{
			var data:Array<Dynamic> = Reflect.field(data, "data");
			
			for (i in 0 ... data.length)
			{
				var dataObj:Dynamic = data[i];
				
				if (Reflect.hasField(dataObj,"text") && Reflect.hasField(dataObj, "value"))
					_list.addItem(new ItemPaneObjectData(i, Reflect.field(dataObj, "text"), Reflect.field(dataObj, "value"), (Reflect.hasField(dataObj, "selected")) ? Reflect.field(dataObj, "selected") : false));
			}
		}
		
		
		if (Reflect.hasField(data, "itemWidth"))
			_itemWidth = Reflect.field(data, "itemWidth");
		
		if (Reflect.hasField(data, "itemHeight"))
			_itemHeight = Reflect.field(data, "itemHeight");
			
			
			
		if (Reflect.hasField(data, "itemNormalColor"))
			_itemNormalColor = Reflect.field(data, "itemNormalColor");
			
		if (Reflect.hasField(data, "itemOverColor"))
			_itemOverColor = Reflect.field(data, "itemOverColor");
			
		if (Reflect.hasField(data, "itemSelectedColor"))
			_itemSelectedColor = Reflect.field(data, "itemSelectedColor");
			
		if (Reflect.hasField(data, "itemDisableColor"))
			_itemDisableColor = Reflect.field(data, "itemDisableColor");
			
			
			
		if (Reflect.hasField(data, "labelNormalColor"))
			_labelNormalColor = Reflect.field(data, "labelNormalColor");
			
		if (Reflect.hasField(data, "labelSelectedColor"))
			_labelSelectedColor = Reflect.field(data, "labelSelectedColor");
			
		if (Reflect.hasField(data, "showLabel"))
			_showLabel = Reflect.field(data, "showLabel");
			
			
		if (Reflect.hasField(data, "allowMultipleSelection"))
			_allowMultipleSelection = Reflect.field(data, "allowMultipleSelection");
			
			
		if (Reflect.hasField(data, "selectedIndex"))
			_selectedIndex = Reflect.field(data, "selectedIndex");
			
			
		if (Reflect.hasField(data, "font"))
			_font = Reflect.field(data, "font");
			
		if (Reflect.hasField(data, "color"))
			_color = Reflect.field(data, "color");
			
			
		if (Reflect.hasField(data, "bold"))
			_bold = Reflect.field(data, "bold");
			

		if (Reflect.hasField(data, "italic"))
			_italic = Reflect.field(data, "italic");
			
		if (Reflect.hasField(data, "size"))
			_size = Reflect.field(data, "size");
			
	}
	
	/**
	 * @inheritDoc
	 */
	override public function initialize():Void 
	{
		_itemHolder = new Sprite();
		
		super.initialize();
		
        addEventListener(Event.ADDED_TO_STAGE, onStageAdd, false, 0, true);
        addEventListener(Event.REMOVED_FROM_STAGE, onStageRemove, false, 0, true);
        
        source = _itemHolder;
		
	}
    
	/**
	 * @inheritDoc
	 */
	
    override public function reskin() : Void
    {
        super.reskin();
        
        // init them
        initUISkin();
        initStyle();
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
            setBackgroundImage(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_BACKGROUND));
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_NORMAL)) 
            setNormalItem(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_NORMAL));
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_OVER)) 
            setOverItem(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_OVER));
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_SELECTED)) 
            setSelectedItem(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_SELECTED));
        
        if (null != UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_DISABLE)) 
            setDisableItem(UIBitmapManager.getUIElement(ItemPane.TYPE, UIBitmapManager.ITEMPANE_ITEM_DISABLE));
    }
    
    override private function initStyle() : Void
    {
		super.initStyle();
		
        // Scroll Pane Background
        if (-1 != UIStyleManager.ITEMPANE_BACKGROUND) 
            backgroundColor = UIStyleManager.ITEMPANE_BACKGROUND; 
			
        
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
	 * Replace the current data provider and rebuild the item pane
	 */
    
    private function set_dataProvider(value : DataProvider<ItemPaneObjectData>) : DataProvider<ItemPaneObjectData>
    {
        _list = value;
        
        return value;
    }
    
    /**
	 * Returns the data provider being used
	 */
    
    private function get_dataProvider() : DataProvider<ItemPaneObjectData>
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
    
    public function getSelectedList() : Array<ItemPaneObjectData>
    {
        var selectedList : Array<ItemPaneObjectData> = new Array<ItemPaneObjectData>();
        
        for (i in 0..._list.length - 1 + 1)
		{
            var itemPaneData : ItemPaneObjectData = _list.getItemAt(i);
            
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
	 * @param	value The image that will be used for the item background
	 */
    
    public function setNormalItem(value : BitmapData) : Void
    {
        _itemDefaultState = value;
        
    }
    
    /**
	 *
	 * The over state of an item block
	 *
	 * @param	value The image that will be used for the item background
	 */
    
    public function setOverItem(value : BitmapData) : Void
    {
        _itemOverState = value;
        
    }
    
    /**
	 *
	 * The down state of an item block
	 *
	 * @param	value The image that will be used for the item background
	 */
    
    public function setSelectedItem(value : BitmapData) : Void
    {
        _itemSelectedState = value;
        
    }
    
    /**
	 * The disable state of an item block
	 *
	 * @param	value The display object that will be used for the item background
	 */
    
    public function setDisableItem(value : BitmapData) : Void
    {
        _itemDisableState = value;
        
    }
    
	/**
	* Draw the TabPane and all the UI classes it's using
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
        
		
        for (i in 0... _list.length)
		{
           
            //var itemLabel : Label = new Label();
            var itemData : ItemPaneObjectData = _list.getItemAt(i);
            var lastButton : ItemPaneButton = (i == 0) ? null : cast(_itemHolder.getChildByName( Std.string( Std.int(i - 1) ) ), ItemPaneButton);
			var itemButton : ItemPaneButton = new ItemPaneButton({"width":_itemWidth, "height":_itemHeight, "ItemLocX": _itemLocX, "ItemLocY": _itemLocY, "Label":{"text":itemData.text, "align":"center"}} );
			
				
            itemButton.showLabel = _showLabel;
            
            if (null != _embed) 
				itemButton.label.setEmbedFont(_embed);
				
            if ("" != _font) 
                itemButton.label.font = _font;
            
            if (-1 != _color) 
                itemButton.label.textColor = _color;
            
            if (-1 != _size) 
                itemButton.label.size = _size;
             
            itemButton.label.textFormat.bold = _bold;
            itemButton.label.textFormat.italic = _italic;
            
            
            // Set color default color if was set
            if (!itemData.selected && -1 != _labelNormalColor) 
                itemButton.label.textColor = _labelNormalColor;  
            
            // Set selected color if was set
            if (itemData.selected && -1 != _labelSelectedColor) 
                itemButton.label.textColor = _labelSelectedColor;
            
            itemButton.name = Std.string(i);
			
			
			if ( null != _itemDefaultState)
				itemButton.setDefaultStateImage(_itemDefaultState);
			else
				itemButton.defaultColor = _itemNormalColor;
			
			if (null != _itemOverState)
				itemButton.setOverStateImage(_itemOverState);
			else
				itemButton.overColor = _itemOverColor;
				
			if (null != _itemSelectedState)
				itemButton.setDownStateImage(_itemSelectedState);
			else
				itemButton.downColor = _itemSelectedColor;
			
			if (null != _itemDisableState)
				itemButton.setDisableStateImage(_itemDisableState);
			else
				itemButton.disableColor = _itemDisableColor;
            
            itemButton.addEventListener(ToggleEvent.DOWN_STATE, onItemDownPress);
           

            // Add in the item if it's there
            if (null != itemData.item) 
                itemButton.setItem(itemData.item);
            
            // Shift items to where they need to be on the screen
            itemButton.x = (i - _lastRowNum) * itemButton.width;
            
            // Update to new row on y-axis
            if ((itemButton.x + itemButton.width) > width)
            {
                _lastRowNum = i;
                
                itemButton.x = 0;
                itemButton.y = (null == lastButton) ? itemButton.y : lastButton.y + _itemHeight;
            }
            else 
            {
                itemButton.y = ((null == lastButton)) ? itemButton.y : lastButton.y;
            }  
             
            
            // Add icon if need be  
            if (null != itemData.icon) 
                itemButton.setIcon(itemData.icon);
			
			itemButton.draw();
			
            _itemHolder.addChild(itemButton);
			
        }
        
        refreshPane();
    }
    
    private function removeList() : Void
    {
        
        // NOTE: Turn this into a class file later
        var i : Int = _itemHolder.numChildren - 1;
        
        while (i > 0)
        {
            
			var itemButton : ItemPaneButton = cast(_itemHolder.getChildByName(Std.string(i)), ItemPaneButton);
			
			itemButton.removeEventListener(ToggleEvent.DOWN_STATE, onItemDownPress);
			_itemHolder.removeChild(itemButton);
			
			itemButton.destroy();
			itemButton = null;
			
			//TODO: Add back in once support for tool-tips is fixed
			//ToolTip.remove(tempObj);
			
			
			
			itemButton = null;
			
			i--;
        }
		
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
		
		toggleButton.draw();
        dispatchEvent(new Event(Event.CHANGE));
		
    }
    
    private function clearAllSelected() : Void
    {
        for (i in 0 ... _list.length)
		{
			
            var itemData : ItemPaneObjectData = cast(_list.getItemAt(i), ItemPaneObjectData);
            var itemButton : ItemPaneButton = cast(_itemHolder.getChildByName(Std.string(i)), ItemPaneButton);
			
            itemData.selected = false;
            
            // If color label was selected
            if ( -1 != _labelNormalColor) 
			{
                itemButton.label.textColor = _labelNormalColor;
				itemButton.draw();
			}
        }
    }
}

