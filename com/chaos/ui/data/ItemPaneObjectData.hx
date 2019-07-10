package com.chaos.ui.data;



/**
 * Data Object for Item Pane
 * @author Erick Feiling
 */


import openfl.display.BitmapData;


class ItemPaneObjectData extends SelectObjectData
{
    public var item(get, set) : BitmapData;
    public var icon(get, set) : BitmapData;
    
    private var _item : BitmapData = null;
    private var _icon : BitmapData = null;
    
    /**
	 * The ItemPanel DisplayObject
	 * @param	id The id for the item
	 * @param	itemText The object text if the labels is being displayed
	 * @param	toolTipText The tool-tip text. If nothing is set then no tool-tip will be displayed.
	 * @param	itemSelected If the object is already selected or not
	 * @param	item The DisplayObject that you want to display
	 * @param	itemIcon An icon that can be displayed
	 */
    
    public function new( id:Int = -1, itemText : String = "", value : String = "", itemSelected : Bool = false, item : BitmapData = null, itemIcon : BitmapData = null)
    {
		super(id, itemText, value, itemSelected);
		
        _selected = itemSelected;
        _item = item;
        _icon = itemIcon;
    }
    
    /**
	 * Set the item
	 */
    
    private function set_item(value : BitmapData) : BitmapData
    {
        _item = value;
        return value;
    }
    
    /**
	 * Return the DisplayObject being used
	 */
    
    private function get_item() : BitmapData
    {
        return _item;
    }
    
  
    
    /**
	 * Set the icon being used
	 */
    
    private function set_icon(value : BitmapData) : BitmapData
    {
        _icon = value;
        return value;
    }
    
    /**
	 * Return the icon
	 */
    
    private function get_icon() : BitmapData
    {
        return _icon;
    }

}

