package com.chaos.ui.data;
import openfl.display.DisplayObject;


/**
 * Data object for TabPane
 * @author Erick Feiling
 */

class TabPaneObjectData extends SelectObjectData 
{

	public var content(get, never) : DisplayObject;
	
	private var _content : DisplayObject;
	
	
	public function new(newContent:DisplayObject, newId:Int =-1,  newText:String = "", newVal:String = "", isSelected:Bool = false) 
	{
		super(newId, newText, newVal, isSelected);		
		
		_content = newContent;
	}
	
	private function get_content() : DisplayObject
	{
		return _content;
	}
	
}