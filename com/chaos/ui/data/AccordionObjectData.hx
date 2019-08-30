package com.chaos.ui.data;
import com.chaos.ui.Button;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.DisplayObject;

/**
 * Keeps track of accordion button and content
 * @author Erick Feiling
 */
class AccordionObjectData 
{
	/**
	 * Name of section
	 */
	public var name(get, never) : String;
	
	/**
	 * Section Button
	 */
	public var button(get, never) : IButton;
	
	/**
	 * Section Contect
	 */
	public var content(get, never) : DisplayObject;
	
	/**
	 * Where content is stored
	 */
	
	public var container(get, never) : IBaseContainer;
	
	private var _name : String;
	private var _button : Button;
	private var _content : DisplayObject;
	private var _container : BaseContainer;

	public function new(sectionName:String, button:Button, container:BaseContainer, content:DisplayObject = null) 
	{
		_name = sectionName;
		_button = button;
		_content = content;
		_container = container;
	}
	
	
	private function get_name() : String
	{
		return _name;
	}
	
	private function get_button() : IButton
	{
		return _button;
	}
	
	private function get_content() : DisplayObject
	{
		return _content;
	}
	
	private function get_container() : BaseContainer
	{
		return _container;
	}
	
}