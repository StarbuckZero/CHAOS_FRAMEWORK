package com.chaos.ui.data;


import com.chaos.ui.Label;
import com.chaos.ui.classInterface.ILabel;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;



/**
 * The data object used for ComboBox
 *
 * @author Erick Feiling
 */

class ComboBoxObjectData extends SelectObjectData
{
    public var icon(get, set) : BitmapData;
	
	private var _icon:BitmapData;
    
    /**
	 * The combo box data object
	 *
	 * @param	text The text that will be set
	 * @param	value The value that will be used
	 * @param	selected If the object is selected or not
	 * @param	icon The icon that will be displayed
	 */
    
    public function new( id : Int = -1, text : String, value : String = "", selected : Bool = false, icon:BitmapData = null )
    {
		super(id, text, value, selected);
    }
    
    private function set_icon(value : BitmapData) : BitmapData
    {
		_icon = value;
        return value;
    }
    
    private function get_icon() : BitmapData
    {
        return _icon;
    }
}

