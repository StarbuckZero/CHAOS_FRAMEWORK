package com.chaos.ui.layout;

import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IGridCell;
import com.chaos.ui.classInterface.IBorder;


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

class GridCell extends BaseUI implements IGridCell implements IBaseUI 
{

    public var container(get, never) : IAlignmentContainer;
    public var border(get, never) : IBorder;

    private var _border : IBorder;
    
    private var _layoutClass : Class<Dynamic> = GridCellLayout.FIT;
    private var _container : IAlignmentContainer;

    private var _params : Dynamic = {};
    private var _borderData : Dynamic = {};
    
    /**
	 * Creates a cell block for a grid
	 *
	 * @param	data The proprieties that you want to set on component.
	 *
	 * @see com.chaos.ui.layout.GridLayout
	 *
	 * @exampleText var cell = new GridCell({"width":100,"height":100,"border":{},"layout":GridLayout.FIT,"params":{'direction':FitContainerDirection.VERTICAL}});
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }

    override function setComponentData(data:Dynamic) {

        super.setComponentData(data);

		if (Reflect.hasField(data, "layout"))
			_layoutClass = Reflect.field(data, "layout");

		if (Reflect.hasField(data, "params"))
			_params = Reflect.field(data, "params");
    }

    override function initialize() {

        super.initialize();

        _border = new Border(_borderData);
        
        if (null != _layoutClass) 
            setLayout(_layoutClass, _params);

        addChild(_border.displayObject);

        _params = null;
        _borderData = null;
        _layoutClass = null;

    }
    
    /**
	 * Returns border 
	 */
    
    private function get_border() : IBorder
    {
        return _border;
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

        // Check to to see if right container 
        if (Std.isOfType(Type.createInstance(value, []), AlignmentBaseContainer)) 
        {
            _layoutClass = value;
            
            // Remove old layout
            if (null != _container && null != _container.displayObject.parent) 
                removeChild(_container.displayObject);
            
            // Add new layout
            _container = Type.createInstance(_layoutClass, [params]);
            _container.background = false;
            
            // Apply direction for FitContainer
            if (Std.isOfType(_container, FitContainer) && null != params && Reflect.hasField(params,"direction") && Std.isOfType( Reflect.field(params,"direction"), String)) 
                cast(_container, FitContainer).direction = params.direction;
            
            addChild(_border.displayObject);
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
        
        _container.width = _width;
        _container.height = _height;

        _border.width = _width;
        _border.height = _height;

        _container.draw();
        _border.draw();
    }
}

