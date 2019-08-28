package com.chaos.ui.layout;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IGridCell;


import com.chaos.ui.layout.GridCellLayout;

import com.chaos.ui.layout.AlignmentBaseContainer;
import com.chaos.ui.layout.FitContainer;

import com.chaos.utils.Debug;
import openfl.display.Shape;

import com.chaos.ui.BaseUI;

/**
 * A cell block for the grid class
 * @author Erick Feiling
 */

class GridCell extends BaseUI implements IBaseUI implements IGridCell
{
    public var border(get, set) : Bool;
    public var borderColor(get, set) : Int;
    public var borderAlpha(get, set) : Float;
    public var borderThinkness(get, set) : Float;
    public var container(get, never) : IAlignmentContainer;

    public var outline : Shape;
    
    private var _layoutClass : Class<Dynamic> = GridCellLayout.FIT;
    private var _container : IAlignmentContainer;
    
    private var _border : Bool = true;
    
    private var _thinkness : Float = 1;
    private var _borderColor : Int = 0x000000;
    private var _borderAlpha : Float = 1;
    
    /**
	 * Creates a cell block for a grid
	 *
	 * @param	gridWidth The width of the cell block
	 * @param	gridHeight The height of the block
	 * @param	layout Set the alignments
	 * @param	params Set extra stuff to the layout
	 *
	 * @see com.chaos.ui.layout.GridLayout
	 *
	 * @exampleText var cell = new GridCell(100,100,GridLayout.FIT,{'direction':FitContainerDirection.VERTICAL});
	 */
    
    public function new(gridWidth : Float = -1, gridHeight : Float = -1, layout : Class<Dynamic> = null, params : Dynamic = null)
    {
        
        super();
        
        if (-1 != gridWidth) 
            _width = gridWidth;
        
        if (-1 != gridHeight) 
            _height = gridHeight;
        
        if (null != layout) 
            setLayout(layout, params);
        
        init();
    }
    
    private function init() : Void
    {
        _container = Type.createInstance(_layoutClass, []);
        outline = new Shape();
        
        _container.width = _width;
        _container.height = _height;
        
        addChild(_container.displayObject);
        addChild(outline);
        
        draw();
    }
    
    
    /**
	 * Toggle on and off border
	 */
    
    private function set_border(value : Bool) : Bool
    {
        _border = value;
        draw();
        return value;
    }
    
    /**
	 * Returns true if the border is on and false if not
	 */
    
    private function get_border() : Bool
    {
        return _border;
    }
    
    /**
	 * The ScrollPane border color
	 */
    
    private function set_borderColor(value : Int) : Int
    {
        _borderColor = value;
        draw();
        return value;
    }
    
    /**
	 * Returns the color
	 */
    
    private function get_borderColor() : Int
    {
        return _borderColor;
    }
    
    /**
	 * Specifies the border alpha. Set the alpha between 1 to 0.
	 */
    
    private function set_borderAlpha(value : Float) : Float
    {
        _borderAlpha = value;
        draw();
        return value;
    }
    
    /**
	 * Returns the boarder alpha
	 */
    
    private function get_borderAlpha() : Float
    {
        return _borderAlpha;
    }
    
    /**
	 * Border thinkness
	 */
    
    private function set_borderThinkness(value : Float) : Float
    {
        _thinkness = value;
        draw();
        return value;
    }
    
    /**
	 * Return the size of the border
	 */
    private function get_borderThinkness() : Float
    {
        return _thinkness;
    }
    
    /**
	 * Remove old layout container and add new one to cell block.
	 *
	 * @param	value The layout you want to use
	 * @param	params Set extra stuff to the layout being used.
	 *
	 * @see com.chaos.ui.layout.GridLayout
	 *
	 * @exampleText setLayout(GridCellLayout.VERTICAL);
	 */
    
    public function setLayout(value : Class<Dynamic>, params : Dynamic = null) : Void
    {
        
        if (Std.is(Type.createInstance(value, []), AlignmentBaseContainer)) 
        {
            _layoutClass = value;
            
            // Remove old layout
            if (null != _container && null != _container.displayObject.parent) 
                removeChild(_container.displayObject);
            
            
            // Add new layout
            _container = Type.createInstance(_layoutClass, []);
            _container.width = _width;
            _container.height = _height;
            
            _container.background = false;
            
            // Apply direction for FitContainer
            if (Std.is(_container, FitContainer) && null != params && params.exists("direction") && Std.is(params.direction, String)) 
                (try cast(_container, FitContainer) catch (e:Dynamic) null).direction = params.direction;
            
            
            // Toggle background 
            if (null != params && params.exists("background")) 
                _container.background = cast(params.background, Bool);
            
            if (null != params && params.exists("backgroundAlpha")) 
                _container.backgroundAlpha = Std.parseFloat(params.backgroundAlpha);
            
            if (null != params && params.exists("backgroundColor")) 
                _container.backgroundColor = Std.parseInt(params.backgroundColor);
            
            addChild(_container.displayObject);
        }
        else 
        {
            Debug.print("[GridCell::setLayout] Must be an based off the AlignmentBaseContainer class.");
        }
    }
    
    /**
	 * Grab the layout container
	 *
	 * @return The container being used
	 */
    
    private function get_container() : IAlignmentContainer
    {
        
        return _container;
    }
    
    /**
	 * Update the cell
	 */
	
    override public function draw() : Void
    {
        super.draw();
        
        if (null == outline) 
            return;
        
        if (null != _container) 
		{
            _container.width = _width;
            _container.height = _height;
		}
			
        outline.graphics.clear();
        
        // Setup for border if need be
        if (_border) 
        {
            outline.graphics.lineStyle(_thinkness, _borderColor, _borderAlpha);
            outline.graphics.drawRect(0, 0, _width, _height);
        }
    }
}

