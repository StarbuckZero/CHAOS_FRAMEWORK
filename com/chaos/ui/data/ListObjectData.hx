package com.chaos.ui.data;


/**
 * Data object for List and Select classes
 * @author Erick Feiling
 */





import openfl.display.BitmapData;

class ListObjectData extends SelectObjectData
{
	public var icon(get, set) :BitmapData;
   
	private var _icon:BitmapData;
    
    /**
	 * The object being used for the List class
	 *
	 * @param	itemText The text you want to set the list object to
	 * @param	itemSelected If the select object is selected or not
	 * @param	itemIcon If there is an icon that need to be set beside the label
	 * @param	itemLabel The label that will be used. If empty one will be created.
	 */
    
    public function new(id:Int = -1, itemText : String, value : String = "", itemSelected : Bool = false, itemIcon : BitmapData = null)
    {
        super(id, itemText, value, itemSelected);
		
        
        _icon = itemIcon;
		
    }
	
	private function set_icon(value:BitmapData):BitmapData
	{
		_icon = value;
		
		return value;
	}
	
	private function get_icon():BitmapData
	{
		return _icon;
	}
    
}

