package com.chaos.ui.data;


import com.chaos.data.DataProvider;
import com.chaos.ui.classInterface.IMenuItem;
import openfl.display.BitmapData;

/**
 * Data object for Menu class
 * @author Erick Feiling
 */

class MenuItemObjectData extends SelectObjectData
{
    public var icon(get, set) : BitmapData;
    public var menuItem(get, set) : IMenuItem;
    public var subMenuList(get, set) : DataProvider<MenuItemObjectData>;
    public var subMenuIcon(get, set) : BitmapData;
    public var hasSubMenu(get, never) : Bool;

    private var _menuItem : IMenuItem;
    
    private var _icon : BitmapData;
    private var _subMenuIcon : BitmapData;
    
    private var _subMenu : DataProvider<MenuItemObjectData> = new DataProvider<MenuItemObjectData>();
    
    /**
	 * An data object to be used for the menu system in the CHAOS framework
	 *
	 * @param	text The button text
	 * @param	value A value for selected button
	 * @param	subMenuList The custion icon for sub drop down menu
	 * @param	menuItem The parent menu item
	 * @param	icon The custom icon for the button
	 */
    
    public function new(id:Int = -1,text : String = "", value : String = "", subMenuList : DataProvider<MenuItemObjectData> = null, icon : BitmapData = null, subMenuIcon : BitmapData = null)
    {
		super(id, text, value);
		

        _menuItem = menuItem;
        _subMenu = subMenuList;
        
        _icon = icon;
        _subMenuIcon = subMenuIcon;
    }
    
  
    
    /**
	 * Set the menu icon
	 */
	
    private function set_icon(value : BitmapData) : BitmapData
    {
        _icon = value;
        return value;
    }
    
    /**
	 * Return a display image being used for icon
	 */
	
    private function get_icon() : BitmapData
    {
        return _icon;
    }
    
    private function set_menuItem(value : IMenuItem) : IMenuItem
    {
        _menuItem = value;
        return value;
    }
    
    /**
	 * Return the parent item
	 */
    private function get_menuItem() : IMenuItem
    {
        return _menuItem;
    }
    
    /**
	 * A DataProvider filled with items
	 */
	
    private function set_subMenuList(value : DataProvider<MenuItemObjectData>) : DataProvider<MenuItemObjectData>
    {
        _subMenu = value;
        return value;
    }
    
    /**
	 * Return DataProvider with MenuItemObjectData objects
	 */
	
    private function get_subMenuList() : DataProvider<MenuItemObjectData>
    {
        return _subMenu;
    }
    
    /**
	 * Set the sub menu drop down icon
	 */
	
    private function set_subMenuIcon(value : BitmapData) : BitmapData
    {
        _subMenuIcon = value;
        return value;
    }
    
    /**
	 * Return a display image being used for icon
	 */
    
    private function get_subMenuIcon() : BitmapData
    {
        return _subMenuIcon;
    }
    
    /**
	 * Check to see if there is a sub menu on button
	 */
    
    private function get_hasSubMenu() : Bool
    {
        return (subMenuList != null);
    }
}

