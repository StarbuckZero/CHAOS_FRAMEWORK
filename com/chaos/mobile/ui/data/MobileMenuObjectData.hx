package com.chaos.mobile.ui.data;

import openfl.display.BitmapData;
import com.chaos.ui.data.BaseObjectData;

/**
 * Base data class for any data objects
 * @author Erick Feiling
 */

class MobileMenuObjectData extends BaseObjectData
{
    /** 
    * The icon that will be displayed on the menu
    **/

    public var icon(get, never):BitmapData;

    private var _icon:BitmapData;
    private var _data:MobileMenuObjectData;
   
	/**
     * Store text and string base value
	 * @param	newText Text that will be displayed
     * @param	newVal Sting that can be whatever you want
     * @param   icon The menu used for child objects
	 */
	
    public function new(newText : String = "", newVal : String = "", icon:BitmapData = null)
    {
        super(newText, newVal);

        _icon = icon;
    }

    
    function get_icon():BitmapData {
        return _icon;
    }

}

