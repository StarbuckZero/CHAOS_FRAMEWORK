package com.chaos.ui.classInterface;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;

import com.chaos.ui.Label;

import com.chaos.ui.ToggleButtonLite;

interface IItemPaneObjectData extends IBaseSelectData
{
    
    
    /**
	 * Set the item
	 */

    
    var item(get, set) : DisplayObject;    
    
    /**
	 * Set the button being used
	 */
    
    
    var itemButton(get, set) : ToggleButtonLite;    
    
    /**
	 * Set the tool-tip
	 */
    
    
    var toolTipText(get, set) : String;

}

