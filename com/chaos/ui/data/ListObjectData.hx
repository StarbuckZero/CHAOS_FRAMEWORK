package com.chaos.ui.data;


//TODO: Update to use BaseSelectData class later

/**
 * Data object for List and Select classes
 * @author Erick Feiling
 */





import openfl.display.DisplayObject;
import com.chaos.ui.data.BaseObjectData;

class ListObjectData extends BaseObjectData
{
   
    
    /**
	 * The object being used for the List class
	 *
	 * @param	itemText The text you want to set the list object to
	 * @param	itemSelected If the select object is selected or not
	 * @param	itemIcon If there is an icon that need to be set beside the label
	 * @param	itemLabel The label that will be used. If empty one will be created.
	 */
    
    public function new(itemText : String, value : String = "", itemSelected : Bool = false, itemIcon : DisplayObject = null)
    {
        super();
		
        _text = itemText;
        _value = value;
        //_selected = itemSelected;
        //_icon = itemIcon;
		
    }
    
}

