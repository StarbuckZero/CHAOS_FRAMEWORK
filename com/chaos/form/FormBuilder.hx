package com.chaos.form;

import com.chaos.form.FormData;



import com.chaos.ui.BaseUI;
import com.chaos.ui.layout.GridContainer;
import com.chaos.ui.layout.AlignmentBaseContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IGridCell;
import com.chaos.ui.layout.classInterface.IGridContainer;
import com.chaos.form.ui.TextLabel;
import com.chaos.form.classInterface.IFormBuilder;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.classInterface.ILabel;
import com.chaos.utils.Debug;
import com.chaos.ui.layout.GridCellLayout;
import openfl.events.Event;


/**
 * This creates a form 
 * @author Erick Feiling
 */

class FormBuilder extends GridContainer implements IFormBuilder implements IBaseUI
{
    public static inline var TYPE : String = "FormBuilder";
	
    public var vSpacing(get, set) : Int;
    public var hSpacing(get, set) : Int;
    
    private var _vSpacing : Int = 4;
    private var _hSpacing : Int = 0;
        
    private var _defaultCellHeight : Int = 30;
    
    /**
	 * Creates a two colume form that return values in object
	 *
	 */
	
    public function new(data:Dynamic = null )
    {
        super(data);   
    }

    override function setComponentData(data:Dynamic) {

        // If going to update columns then have to be more than 2 else force it to be 2
		if (!Reflect.hasField(data, "column") || Reflect.hasField(data, "column") && Reflect.field(data, "column") < 2)
            Reflect.setField(data, "column", 2);
                
        super.setComponentData(data);

        // If not passed then set it to true
        //_border = (Reflect.hasField(data, "border")) ? Reflect.field(data,"border") : true;

        if(Reflect.hasField(data, "vSpacing"))
            _vSpacing = Reflect.field(data,"vSpacing");

        if(Reflect.hasField(data, "hSpacing"))
            _hSpacing = Reflect.field(data,"hSpacing");

        if(Reflect.hasField(data, "defaultCellHeight"))
            _defaultCellHeight = Reflect.field(data,"defaultCellHeight");
    }

    override function initialize() {

        super.initialize();

    }

    override function destroy() {

        // Remove all cells first
        for (row in 0 ... getRowCount())
		{
            for( col in 0 ... getColumnCount())  {

                if (getCell(row, col).container.length > 0 && null != getCell(row, col).container.getElementAtIndex(0) && Std.isOfType(getCell(row, col).container.getElementAtIndex(0), IBaseUI)) 
                    cast(getCell(row, col).container.getElementAtIndex(0), IBaseUI).destroy();
            }

        }        

        super.destroy();

    }
    
    
    /**
	 * The default spacing used for added form elements
	 */
    
    private function set_vSpacing(value : Int) : Int
    {
        _vSpacing = value;
        return value;
    }
    
    /**
	 * Return value
	 */
	
    private function get_vSpacing() : Int
    {
        return _vSpacing;
    }
    
    /**
	 * The default spacing used for added form elements
	 */
    
    private function set_hSpacing(value : Int) : Int
    {
        _hSpacing = value;
        return value;
    }
    
    /**
	 * Return value
	 */
    
    private function get_hSpacing() : Int
    {
        return _hSpacing;
    }
    
    /**
	 * Adds a new form element to the form
	 *
	 * @param	labelName The label of the form
	 * @param	elementName The name that will stored in an object
	 * @param	elementClass The ui class that will be used
     * @param	elementParams The ui class that will be used
	 * @param	layoutClass What layout that will be used
	 * @param	params Any extra values that will be passed for the layout
	 */
    
    public function addFormElement(labelName : String, elementName : String, elementClass : Class<Dynamic>, elementParams: Dynamic = null, layoutClass : Class<Dynamic> = null, layoutParams : Dynamic = null) : Void
    {
        addRow(getRowCount());

        var labelRow:IGridCell = getCell(getRowCount() - 1, 0);
        var inputRow:IGridCell = getCell(getRowCount() - 1, 1);
        
        // Set borders and everything first
        setColumnHeightAt(0, _defaultCellHeight);
        setColumnHeightAt(1, _defaultCellHeight);
        
        labelRow.setLayout(GridCellLayout.HORIZONTAL, layoutParams);
        inputRow.setLayout(((null != layoutClass && Std.isOfType(Type.createInstance(layoutClass, []), AlignmentBaseContainer))) ? Type.createInstance(layoutClass, []) : GridCellLayout.FIT, layoutParams);
        
        // Turn off clipping for combo boxes
        labelRow.container.clipping = inputRow.container.clipping = false;
        
        var newLabel : ILabel = new TextLabel({"text":labelName,"width":labelRow.width,"height":labelRow.height});
        labelRow.container.addElement(newLabel);
        
        // Check to see if item is a based UI
        var element:IFormUI = Type.createInstance(elementClass,[elementParams]);
        element.setName(elementName);
                
        if (Std.isOfType(element, IBaseUI)) 
        {
            var baseElement : IBaseUI = (try cast(element, IBaseUI) catch(e:Dynamic) null);
            
            inputRow.container.addElement(baseElement);            
        }
		
		// Adjust elements location  
        for (row in 0 ... getRowCount())
		{
            if (getCell(row, 0).container.length > 0) 
            {
                getCell(row, 0).container.getElementAtIndex(0).x = _vSpacing;
                
                // Only move if was adjusted
                if (_hSpacing > 0) 
                    getCell(row, 0).container.getElementAtIndex(0).y = _hSpacing;
            }
            
            if (getCell(row, 1).container.length > 0) 
            {
                getCell(row, 1).container.getElementAtIndex(0).x = _vSpacing;
                
                // Only move if was adjusted
                if (_hSpacing > 0) 
                    getCell(row, 1).container.getElementAtIndex(0).y = _hSpacing;
            }

        }

    }
        
    /**
	 * Set the column width
	 *
	 * @param	index Which column
	 * @param	colWidth The new width
	 */
    
    public function setColumnWidthAt(index : Int, colWidth : Int) : Void
    {
        
        for (row in 0 ... getRowCount())
		{
            if (validCell(row, index)) 
                setCellWidth(row, index, colWidth);
            else 
                Debug.print("[FormBuilder::setColumnWidthAt] Fail to update " + row + "x" + index + " width in grid to " + colWidth + ".");
        }
    }
    
    /**
	 * Set the column height
	 *
	 * @param	index Which column
	 * @param	colWidth The new height
	 */
    
    public function setColumnHeightAt(index : Int, colHeight : Int) : Void
    {

        for (row in 0 ... getRowCount())
		{
            
            if (validCell(row, index)) 
                setCellHeight(row, index, colHeight);
            else 
                Debug.print("[FormBuilder::setColumnHeight] Fail to update " + row + "x" + index + " height in grid to " + colHeight + ".");
        }
    }
    
    /**
	 * Clear all form values
	 */
    
    public function reset() : Void
    {
        // clear all input fields
        for (row in 0 ... getRowCount())
		{
            if (getCell(row, 1).container.length > 0 && null != getCell(row, 1).container.getElementAtIndex(0) && Std.isOfType(getCell(row, 1).container.getElementAtIndex(0), IFormUI)) 
                cast(getCell(row, 1).container.getElementAtIndex(0), IFormUI).clear();
        }

    }
    
    /**
	 * Take all input values and return them
	 * @return The object with values
	 */
    
    public function getFormData() : Dynamic
    {

        var formObj: Dynamic = {};

        for (row in 0 ... getRowCount())
        {
            if (getCell(row, 1).container.length > 0 && null != getCell(row, 1).container.getElementAtIndex(0) && Std.isOfType(getCell(row, 1).container.getElementAtIndex(0), IFormUI)) 
            {
                var itemFormUI : IFormUI = cast(getCell(row, 1).container.getElementAtIndex(0), IFormUI);                    
                Reflect.setField(formObj, itemFormUI.getName(), itemFormUI.getValue());
            }
        }
        
        return formObj;

    }
}

