package com.chaos.mobile.ui.data;

import openfl.display.DisplayObject;
import openfl.display.BitmapData;
import com.chaos.ui.data.SelectObjectData;

/**
 * Base data class for any data objects
 * @author Erick Feiling
 */

class CarouselObjectData extends SelectObjectData
{
    /** 
    * The default icon that will be displayed
    **/

    public var defaultIcon(get, never) : BitmapData;

    /** 
    * The selected icon that will be displayed
    **/

    public var selectedIcon(get, never) : BitmapData;    

	/**
	 * Default state Color
     */
     
    public var defaultColor(get, never) : Int;

	/**
	 * Selected state Color
     */
     
    public var selectedColor(get, never) : Int;    


    /** 
    * The content that will be displayed in the Carouse
    **/

    public var content(get, never) : DisplayObject;

    private var _defaultIconImage : BitmapData;
    private var _selectedIconImage : BitmapData;

	private var _defaultColor : Int = 0xCCCCCC;
	private var _selectedColor : Int = 0x999999;    
    
    private var _content:DisplayObject;
   
	/**
     * Store text and string base value
     * @param   displayObj content that will be display
     * @param   defaultIcon default image 
     * @param   selectedIcon selected image
     * @param   defaultColor default color
     * @param   selectedColor selected color
	 * @param	newText Text that will be display as tool-tip
     * @param	newVal Sting that can be whatever you want
	 */
	
    public function new( displayObj : DisplayObject, defaultIcon : BitmapData = null, selectedIcon : BitmapData = null,  defaultColor : Int = 0, selectedColor = 0, newText : String = "", newVal : String = "", selected : Bool = false)
    {
        super(-1,newText, newVal, selected );

        _defaultIconImage = defaultIcon;
        _selectedIconImage = selectedIcon;

        _defaultColor = defaultColor;
        _selectedColor = selectedColor;
        
        _content = displayObj;
    }


	private function get_defaultColor() : Int {
		return _defaultColor;
	}

	private function get_selectedColor() : Int {
		return _selectedColor;
    }    
    
    public function get_defaultIcon() : BitmapData {
        return _defaultIconImage;
    }

    public function get_selectedIcon() : BitmapData {
        return _selectedIconImage;
    }    

    public function get_content() : DisplayObject {
        return _content;
    }

}