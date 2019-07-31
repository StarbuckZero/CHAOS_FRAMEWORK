package com.chaos.ui.layout;

import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.errors.Error;


import com.chaos.utils.Debug;


import flash.geom.Rectangle;

/**
 * The base layer the alignment container
 *
 * @author Erick Feiling
 */

class AlignmentBaseContainer extends BaseContainer implements IBaseUI implements IAlignmentContainer implements IBaseContainer
{
    public var clipping(get, set) : Bool;
    public var length(get, never) : Int;
    public var padding(get, set) : Int;
    public var spacingH(get, set) : Int;
    public var spacingV(get, set) : Int;
    public var align(get, set) : String;

    
    private var _align : String = ContainerAlignPolicy.CENTER;
    private var _spacingH : Int = 0;
    private var _spacingV : Int = 0;
    private var _padding : Int = 0;
    
    private var _clipping : Bool = true;
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	override public function initialize():Void 
	{
		super.initialize();
		
	}
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "align"))
			_align = Reflect.field(data, "align");
		
		if (Reflect.hasField(data, "spacingH"))
			_spacingH = Reflect.field(data, "spacingH");
			
		if (Reflect.hasField(data, "spacingV"))
			_spacingV = Reflect.field(data, "spacingV");
			
		if (Reflect.hasField(data, "padding"))
			_padding = Reflect.field(data, "padding");
			
		if (Reflect.hasField(data, "clipping"))
			_clipping = Reflect.field(data, "clipping");
			
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		
		removeAll();
		
		contentHolder.scrollRect = null;
	}
	
    
    /**
	 * For making it so the content can overlap or bleed outside the container
	 */
    
    private function set_clipping(value : Bool) : Bool
    {
        _clipping = value;
		
        return value;
    }
    
    /**
	 * If true content can overlap the container and false clips it
	 */
    
    private function get_clipping() : Bool
    {
        return _clipping;
    }
    
    
    /**
	 * Return the total number of elements being stored
	 */
    
    private function get_length() : Int
    {
        return contentObject.numChildren;
    }
    
    /**
	 * Specifies the space between the cell wall and the cell content
	 */
    
    private function set_padding(value : Int) : Int
    {
        _padding = value;
        return value;
    }
    
    /**
	 * Return the space in between the cell wall and the content
	 */
    
    private function get_padding() : Int
    {
        return _padding;
    }
    
    /**
	 * Set the Horizontal or right to left margin between object
	 */
    
    private function set_spacingH(value : Int) : Int
    {
        _spacingH = value;
        return value;
    }
    
    /**
	 * Return the margin
	 */
    
    private function get_spacingH() : Int
    {
        return _spacingH;
    }
    
    /**
	 * Set the Vertical or top to bottom spacing between object
	 *
	 */
    
    private function set_spacingV(value : Int) : Int
    {
        _spacingV = value;
        return value;
    }
    
    /**
	 * Return the margin
	 */
    
    private function get_spacingV() : Int
    {
        return _spacingV;
    }
    
    /**
	 * Set the alignment mode
	 *
	 * @see com.chaos.ui.layout.ContainerAlignPolicy
	 */
    
    private function set_align(value : String) : String
    {
        _align = value;
		
        return value;
    }
    
    /**
	 * Return the alignment mode
	 *
	 * @see com.chaos.ui.layout.ContainerAlignPolicy
	 */
    
    private function get_align() : String
    {
        return _align;
    }
    
    /**
	 * Adds more then one item to the object to the list
	 *
	 * @param	list A list of UI Elements
	 */
    
    public function addElementList(list : Array<Dynamic>) : Void
    {
        for (i in 0 ... list.length)
		{
            if (null != list[i] && Std.is(list[i], IBaseUI)) 
                contentObject.addChild(cast(list[i], IBaseUI).displayObject);
            else 
                Debug.print("[AlignmentBaseContainer::addElementList] Fail to add item at index " + i);
        }
    }
    
    /**
	 * Add an UI element to the container
	 *
	 * @param	object The object you want to add
	 */
    
    public function addElement(object : IBaseUI) : Void
    {
        contentObject.addChild(object.displayObject);
    }
    
    /**
	 * Return the object inside the container
	 *
	 * @param	value The index of the object inside the container
	 * @return The object that is stored in the container
	 */
    
    public function getElementAtIndex(value : Int) : IBaseUI
    {
        try
        {
            return try cast(contentObject.getChildAt(value), IBaseUI) catch(e:Dynamic) null;
        } 
		catch (error : Error)
        {
            Debug.print("[AlignmentBaseContainer::getElementAtIndex] Can't get item at index " + value + " returning null.");
        }
        
        return null;
    }
    
    /**
	 * Return the object inside the container based on the name passed
	 *
	 * @param	value The name of the object
	 * @return The object that is stored in the container
	 */
    
    public function getElementByName(value : String) : IBaseUI
    {
        try
        {
            return try cast(contentObject.getChildByName(value), IBaseUI) catch(e:Dynamic) null;
        }
        catch (error : Error)
        {
            Debug.print("[AlignmentBaseContainer::getElementByName] Can't find item" + value + " returning null.");
        }
        
        return null;
    }
	
    /**
	 * Adjust the location of all UI elements 
	 *
	 */	
	
	public function updateAlignment():Void
	{
		// align elemcts 
	}
    
    /**
	 * Remove an UI element from the container
	 *
	 * @param	object The object you want to remove
	 */
    
    public function removeElement(object : IBaseUI) : Void
    {
        var temp : Array<Dynamic> = new Array<Dynamic>();
        
        // Remove all old items and add them back again
        for (i in 0...contentObject.numChildren)
		{
            var currentObject : IBaseUI = null;
            
            try
            {
                currentObject = cast(contentObject.getChildAt(i), IBaseUI);
                contentObject.removeChild(currentObject.displayObject);
            }            
			catch (error : Error)
            {
                trace("[AlignmentBaseContainer] Couldn't remove item");
            }  
            
            
            // Only grab the items that are needed  
            if (object != currentObject) 
                temp.push(currentObject);
        }  
        
        
        // Add it back  
        for (a in 0...temp.length)
            contentObject.addChild(temp[a]);
    }
    
    /**
	 * Remove all elements that are stored
	 */
    
    public function removeAll() : Void
    {
        var currentObject : IBaseUI;
        
        for (i in 0 ... contentObject.numChildren)
		{
            try
            {
                currentObject = cast(contentObject.getChildAt(i), IBaseUI);
                contentObject.removeChild(currentObject.displayObject);
				
				currentObject.destroy();
				currentObject = null;
				
            } 
			catch (error : Error)
            {
                trace("[AlignmentBaseContainer] Couldn't remove item");
            }
        }
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        contentHolder.scrollRect = null;
        
		// So there is no clipping when it comes to objects
        if (_clipping) 
            contentHolder.scrollRect = new Rectangle(0, 0, width, height);
    }
}

