package com.chaos.ui.data;


import com.chaos.ui.data.BaseObjectData;

/**
 * Select Data Object
 * @author Erick Feiling
 */
class SelectObjectData extends BaseObjectData
{
	
    public var selected(get, set) : Bool;
    public var id(get, set) : Int;
	
    private var _selected : Bool = false;
	private var _id:Int = -1;

	public function new(newId : Int = -1, newText:String = "", newVal:String = "", isSelected:Bool = false) 
	{
		super(newText, newVal);
		
		_id = newId;
		_selected = isSelected;
	}
	
    private function set_selected(value : Bool) : Bool
    {
        _selected = value;
        return value;
    }
    
    private function get_selected() : Bool
    {
        return _selected;
    }
	
	private function set_id(value : Int ) : Int
	{
		_id = value;
		return value;
	}
	
	private function get_id():Int
	{
		return _id;
	}
	

	
}