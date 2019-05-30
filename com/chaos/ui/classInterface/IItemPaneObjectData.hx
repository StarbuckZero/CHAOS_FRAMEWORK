package com.chaos.ui.classInterface;



/**
 * ...
 * @author Erick Feiling
 */

import openfl.display.DisplayObject;


interface IItemPaneObjectData extends IBaseSelectData
{
    
    
    /**
	 * Set the item
	 */

    
    var item(get, set) : DisplayObject;    
    
    /**
	 * Set the button being used
	 */
    
    
    var itemButton(get, set) : IToggleButton;
    
    /**
	 * Set the tool-tip
	 */
    
    
    var toolTipText(get, set) : String;

}

