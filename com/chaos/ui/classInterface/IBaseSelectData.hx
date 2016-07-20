package com.chaos.ui.classInterface;



/**
 * ...
 * @author Erick Feiling
 */

import com.chaos.ui.Label;
import openfl.display.DisplayObject;

interface IBaseSelectData
{
    
    
    /**
	 * Set the name of the item
	 */
    
    
    
    /**
	 * Return the object name
	 */

    var name(get, set) : String;    
    
    /**
	 * Set the object id
	 */
    
    
    
    /**
	 * Return the object id
	 */
    
    var id(get, set) : Int;    
    
    /**
	 * The next that will be used
	 */
    
    
    
    /**
	 * Return the text being used
	 */
    
    var text(get, set) : String;    
    
    /**
	 * The value that will be used
	 */
    
    
    
    /**
	 * Return the value being used
	 */
    
    var value(get, set) : String;    
    
    /**
	 * Set if the object will be selected or not
	 */
    
    
    
    /**
	 * Return true if the object has been selected and false if not
	 */
    
    var selected(get, set) : Bool;    
    
    /**
	 * The DisplayObject you want to use as an icon
	 */
    
    
    
    /**
	 * Return the DisplayObject being used as an icon
	 */
    
    var icon(get, set) : DisplayObject;    
    
    /**
	 * Set the label that is being used
	 */
    
    
    
    /**
	 * Return the label being used
	 */
    
    var label(get, set) : Label;

}

