package com.chaos.ui.data;




/**
 * Base data class for any data objects
 * @author Erick Feiling
 */

class BaseObjectData 
{
    /** Display label for this data item. */
    public var text(get, set) : String;
    /** Stored value for this data item. */
    public var value(get, set) : String;

    private var _text : String = "";
    private var _value : String = "";
    
	/**
	 * Store text and string base value
	 * @param	newText Text that will be displayed
	 * @param	newVal Sting that can be whatever you want
	 */
	
    public function new(newText : String = "", newVal : String = "")
    {
        _text = newText;
        _value = newVal;
        
    }
    
    private function set_text(value : String) : String
    {
        _text = value;
        return value;
    }
    
    private function get_text() : String
    {
        return _text;
    }
    
    private function set_value(value : String) : String
    {
        _value = value;
        return value;
    }
    
    private function get_value() : String
    {
        return _value;
    }
    
    

}

