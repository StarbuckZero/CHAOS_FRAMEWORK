package com.chaos.ui.classInterface;

import com.chaos.data.DataProvider;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.form.ui.classInterface.IFormUI;
import openfl.display.BitmapData;
import openfl.utils.Object;

/**
 * Interface for Grid Pane
 * @author Erick Feiling
 */

interface IGridPane extends IScrollPane
{
    
    
    /**
	 * Set the selected row
	 */

    
    var selectedRow(get, set) : Int;    
    
    /**
	 * Set the selected column
	 */
    
    
    var selectedCol(get, set) : Int;    
    
    /**
	 * Set the button height
	 */
	
    var buttonSize(get, set) : Int;    
    
    /**
	 * Set the size of the icon
	 */

    var arrowSize(get, set) : Int;    
    
    /**
	 * Arrow color
	 */
    
    var arrowColor(get, set) : Int;    
    
    /**
	 * Turn on and off cell border
	 */
    
    
    var cellBorder(get, set) : Bool;    
    
    /**
	 * Set the cell border color
	 */
    
    
    var cellBorderColor(get, set) : Int;    
    
    /**
	 * Set the cell color
	 */
    
    
    var cellColor(get, set) : Int;    
    
    /**
	 * Show or Hide the cell background
	 */
    
    
    var cellBackground(get, set) : Bool;    
    
    /**
	 * Set the alpha of the border
	 */

    
    var cellBorderAlpha(get, set) : Float;    
    
    /**
	 * Cell border thinkness
	 */

    
    var cellBorderThinkness(get, set) : Float;    
    
    /**
	 * The button normal state color
	 */
    
    var columnButtonColor(get, set) : Int;    
    
    /**
	 * The button over state color
	 */
    
    var columnButtonOverColor(get, set) : Int;    
    
    /**
	 * The button down state color
	 */
    

    var columnButtonDownColor(get, set) : Int;    
    
    /**
	 * Set the data provider and object with values for the grid
	 */
    
    var dataProvider(get, set) : DataProvider<Object>;

    
    /**
	 * Set or update what values to look for in pasted in data objects.
	 *
	 * @param	index The index of the value you want to update
	 * @param	value A list of values as stings that will be on each data object
	 * @exampleText grid.setStore(0,"newName");
	 */
    
    function setStore(index : Int, value : String) : Void;
    
    /**
	 * Adds a new colume to the grid. The class must be have IFormUI and IBaseUI interfaces in order to be used.
	 *
	 * @param	colName The name of the column.
	 * @param	element The Form object class
	 * @param	dataRowName The name that is being used inside the store object.
	 * @param	gridLayout The layout you want to use. The default is the FitLayout or Fit
	 * @param	data The DataProvider that could be used for DropDownMenu or Select list
	 *
	 * @exampleText grid.addColumn("Family", DropDownMenu, "family", GridCellLayout.VERTICAL, dropDownData);
	 */
    
    function addColumn(colName : String, element : Class<Object>, dataRowName : String, gridLayout : Class<Object> = null, data : DataProvider<Object> = null) : Void;
    
    /**
	 * Remove an column using the index id
	 * @param	index The current item based on index value
	 */
    
    function removeColumnByIndex(index : Int) : Void;
    
    /**
	 * Remove all columns
	 */
    
    function removeAllColumns() : Void;
    
    /**
	 * Set all the cells width in the grid
	 * @param	colWidth The new cell width
	 */
    function setCellWidth(colWidth : Int) : Void;
    
    /**
	 * Set all the cells height in the grid
	 * @param	colHeight The new cell height
	 */
    function setCellHeight(colHeight : Int) : Void;
    
    /**
	 * Set the column width at given index
	 *
	 * @param	index Which column
	 * @param	colWidth The new width
	 */
    function setColumnWidthAt(index : Int, colWidth : Int) : Void;
    
    /**
	 * Set the column height
	 *
	 * @param	index Which column
	 * @param	colWidth The new height
	 */
    function setColumnHeightAt(index : Int, colHeight : Int) : Void;
    
    /**
	 * Return the selected object
	 * @return Data Object
	 */
    
    function getSelected() : Dynamic;
    /**
	 * Get selected UI Element
	 *
	 * @return Return a form interface
	 */
    
    function getSelectedElement() : IFormUI;
    
    /**
	 * Set which cell in the grid is active
	 * @param	row The row index
	 * @param	col The column index
	 */
    
    function selectCell(row : Int, col : Int) : Void;
    
    /**
	 * Return the button used in the grid
	 *
	 * @param The column index
	 * @return a button interface
	 */
    
    function getColumnButton(index : Int) : IButton;
    

    
    /**
	 * Set the image based on a pasted in bitmap
	 * @param	value The bitmap object that will be used
	 */
    
    function setColumnButtonImage(value : BitmapData) : Void;
    
    
    /**
	 * Set the image based on a pasted in bitmap
	 * @param	value The bitmap object that will be used
	 */
    
    function setColumnButtonOverImage(value : BitmapData) : Void;
    
    
    /**
	 * Set the image based on a pasted in bitmap
	 * @param	value The bitmap object that will be used
	 */
    
    function setColumnButtonDownImage(value : BitmapData) : Void;
    
    
    /**
	 * Set the cell background based on bitmap data being passed
	 * @param	value The bitmap object that will be used
	 */
    
    function setCellBackgroundImage(value : BitmapData) : Void;
    
    /**
	 * Gets the arrow used in column
	 * @param	index the column button index
	 * @return Return the icon
	 */
    
    function getColumnArrow(index : Int) : IBasicIcon;
    
    /**
	 * Set the grid container being used width
	 * @param	value The new width
	 */
    
    function setGridWidth(value : Int) : Void;
    
    /**
	 * Set the grid container being used height
	 * @param	value The new height
	 */
    
    function setGridHeight(value : Int) : Void;
    
    /**
	 * Set the width and height of the grid container being used
	 * @param	gridWidth The new width
	 * @param	gridHeight The new height
	 */
    function setGridSize(gridWidth : Int, gridHeight : Int) : Void;
}

