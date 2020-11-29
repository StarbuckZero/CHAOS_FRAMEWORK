package com.chaos.mobile.ui.data;

import openfl.display.BitmapData;
import com.chaos.ui.data.BaseObjectData;
import com.chaos.data.DataProvider;

/**
 * Base data class for any data objects
 * @author Erick Feiling
 */

class NavigationMenuObjectData extends MobileMenuObjectData
{

    public var childObject(get, set):DataProvider<NavigationMenuObjectData>;
    
    private var _childObject:DataProvider<NavigationMenuObjectData>;
   
	/**
     * Store text and string base value
	 * @param	newText Text that will be displayed
     * @param	newVal Sting that can be whatever you want
     * @param   icon image being used for nav button
     * @param   childObj list of menu data objects
	 */
	
    public function new(newText : String = "", newVal : String = "", childObj : DataProvider<NavigationMenuObjectData> = null, icon : BitmapData = null)
    {
        super(newText, newVal, icon);

        _childObject = childObj;
    }

    private function get_childObject():DataProvider<NavigationMenuObjectData> {
        return _childObject;
    }
    
    private function set_childObject(value:DataProvider<NavigationMenuObjectData>):DataProvider<NavigationMenuObjectData> {
        _childObject = value;

        return _childObject;
    }

}

