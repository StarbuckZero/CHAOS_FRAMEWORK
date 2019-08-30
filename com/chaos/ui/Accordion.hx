package com.chaos.ui;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.data.AccordionObjectData;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

/**
 * Menu for holding content that is displayed based on click on title area
 * 
 * @author Erick Feiling
 */
class Accordion extends BaseContainer implements IBaseContainer implements IBaseUI 
{
	public var selectedSectionName(get, never) : String;

	
	private var _buttonSize : Int = 20;

	private var _selectedSection:String = "";
	
	
	private var _section : Array<AccordionObjectData> = new Array<AccordionObjectData>();
	
	public function new(data:Dynamic = null) 
	{
		super(data);
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		
		super.setComponentData(data);
		
		//TODO: Add in section based on section data being passed
	}
	
	private function get_selectedSectionName():String
	{
		return _selectedSection;
	}

	
	public function addSection(sectionName:String, title:String, content:DisplayObject):Void
	{
		var container:BaseContainer = new BaseContainer({"name": sectionName + "_container", "content":content});
		var button:Button =  new Button({"name": sectionName + "_button", "text":title});
		
		button.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
		
		_section.push(new AccordionObjectData(sectionName, button, container, content));
		
		// Hide it will be shown if selected later
		container.visible = false;
	}
	
	/**
	 * Get section data object for adjusting button,container and content
	 * @param	value Name of the section
	 * @return data object 
	 */
	
	public function getSection( sectionName:String ) : AccordionObjectData
	{
		for (i in 0 ... _section.length)
		{
			if (_section[i].name == sectionName)
				return _section[i];
		}
		
		return null;
	}
	
	public function closeAll(): Void
	{
		for (i in 0 ... _section.length)
		{
			var button:IButton = _section[i].button;
			var container:IBaseContainer = _section[i].container;
			
			button.y = i * _buttonSize;
			container.y = button.y + button.height;
		}
		
	}
	
	public function open( sectionName:String ) : Void
	{
		closeAll();
		
		// Start off as -1 
		var index:Int = -1;
		
		
		// Figure out what button to open based on section passed in
		for (i in 0 ... _section.length)
		{
			if (_section[i].name == sectionName)
			{
				// Take the current 
				index = i;
				
				// Get the current section
				var section:AccordionObjectData = _section[i];
				
				// Resize container based on how many sections below
				section.container.height = _height - (_buttonSize * _section.length - index);
				section.container.visible = true; 
			}
			
			// If greater than index than start shifting buttons down
			if (i > index)
			{
				
				// Get current item
				var currentSection:AccordionObjectData = _section[i];
				
				// Check to see if buttons need to be shifted below contianer
				if ((i - 1) == index)
				{
					var selectedSection:AccordionObjectData = _section[index];
					currentSection.button.y = selectedSection.container.y + selectedSection.container.height;
				}
				else
				{
					var lastSection:AccordionObjectData = _section[i - 1];
					currentSection.button.y = lastSection.button.y + lastSection.button.height;
				}
			}
		}
		
	}
	
	
	
	
    /**
	 * Draw the container
	 */	
	
	override public function draw():Void 
	{
		super.draw();
		
		for (i in 0 ... _section.length)
		{
			var button:IButton = _section[i].button;
			var container:IBaseContainer = _section[i].container;
			
			button.width = _width;
			button.height = _buttonSize;
			button.y = i * _buttonSize;
			
			container.y = button.y + button.height;
			
			
			// Check to see if it's open or not
			button.draw();
			container.draw();
		}
		
	}
	
	
	
	
	private function onButtonClick(event:MouseEvent):Void 
	{
		//TODO: Adjust 
	}
	
	
	
	
	
	
}