package com.chaos.ui.layout.classInterface;


/**
 * Interface for Grid class
 * @author Erick Feiling
 */

interface IGridContainer extends IBaseContainer
{
    
    /**
	 * Moves cell that user mouse over to the top of the display list.
	 */
    
    var alwaysOnTop(get, set) : Bool;    
    
    /**
	 * The default width
	 */
    
    var cellWidth(get, set) : Int;    
    
    /**
	 * The default height
	 */
    
    var cellHeight(get, set) : Int;

    
    /**
	 * Adjust the size of the cell width
	 *
	 * @param	row The index of the row
	 * @param	col The index of the column
	 * @param	widthNum The new width of the cell
	 */
    
    function setCellWidth(row : Int, col : Int, widthNum : Int) : Void;
	
    /**
	 * Adjust the size of the cell height
	 *
	 * @param	row The index of the row
	 * @param	col The index of the column
	 * @param	heightNum The new height of the cell
	 */
    
    function setCellHeight(row : Int, col : Int, heightNum : Int) : Void;
	
    /**
	 * Adds new row to grid
	 * @param	index Where you want to add the new row
	 */
    
    function addRow(index : Int) : Void;
    
    /**
	 * Removews row from grid
	 * @param	index Which item to remove
	 */
    
    function removeRow(index : Int) : Void;
    
    /**
	 * Adds new column to grid
	 * @param	index Where you want to add the new column
	 */
    
    function addColumn(index : Int) : Void;
    
    /**
	 * Removews column from grid
	 * @param	index Which item to remove
	 */
    
    function removeColumn(index : Int) : Void;
    
    /**
	 * Get a cell out of the grid
	 *
	 * @param	row The index of the row
	 * @param	col The index of the column
	 *
	 * @return A grid cell
	 */
    
    function getCell(row : Int, col : Int) : IGridCell;
    
    /**
	 * Check to see if cell is in grid
	 *
	 * @param	row The row index
	 * @param	col The column index
	 * @return True if there is a cell there and false if not
	 */
    
    function validCell(row : Int, col : Int) : Bool;
    
    /**
	 * Gets the number of rows.
	 * @return The total number of rows
	 */
    
    function getRowCount() : Int;
    
    /**
	 * Gets the number of columns
	 * @return The total number of columns
	 */
    
    function getColumnCount() : Int;
}

