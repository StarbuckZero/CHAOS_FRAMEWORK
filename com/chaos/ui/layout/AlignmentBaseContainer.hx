package com.chaos.ui.layout;

import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import openfl.errors.Error;


import com.chaos.utils.Debug;


import openfl.geom.Rectangle;

/**
 * The base layer the alignment container
 *
 * @author Erick Feiling
 */

class AlignmentBaseContainer extends BaseContainer implements IBaseUI implements IAlignmentContainer implements IBaseContainer
{
	
    /**
	 * For making it so the content can overlap or bleed outside the container
	 */
	
    public var clipping(get, set) : Bool;
	
    /**
	 * Return the total number of elements being stored
	 */
	
    public var length(get, never) : Int;
	
    /**
	 * Specifies the space between the cell wall and the cell content
	 */
	
    public var padding(get, set) : Int;
	
    /**
	 * Set the Horizontal or right to left margin between object
	 */
	
    public var spacingH(get, set) : Int;
	
    /**
	 * Set the Vertical or top to bottom spacing between object
	 */
	
    public var spacingV(get, set) : Int;
	
    /**
	 * Set the alignment mode
	 *
	 * @see com.chaos.ui.layout.ContainerAlignPolicy
	 */
	
    public var align(get, set) : String;

    
    private var _align : String = ContainerAlignPolicy.CENTER;
    private var _spacingH : Int = 0;
    private var _spacingV : Int = 0;
    private var _padding : Int = 0;
    
    private var _clipping : Bool = true;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		super.initialize();
		
	}
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
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
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
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
        return _content.numChildren;
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
	 * Adjust the location of all UI elements 
	 */	
	
	public function updateAlignment():Void
	{
		// align elemcts 
	}
    
    /**
	 * Update the UI class
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

