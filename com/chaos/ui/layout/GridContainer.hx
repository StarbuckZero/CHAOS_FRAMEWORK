package com.chaos.ui.layout;

import openfl.display.DisplayObject;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.errors.Error;

import com.chaos.data.DataProvider;
import com.chaos.ui.BaseUI;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.GridCell;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IGridContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IGridCell;
import com.chaos.utils.Debug;

/**
 * Layout out items based on a grid layout
 * @author Erick Feiling
 */

class GridContainer extends BaseContainer implements IGridContainer implements IBaseContainer implements IBaseUI
{
    public var alwaysOnTop(get, set) : Bool;
    public var cellWidth(get, set) : Int;
    public var cellHeight(get, set) : Int;

    
    private var _list : DataProvider<DataProvider<IGridCell>>;
    
    private var rowCount : Int = 0;
    private var columnCount : Int = 0;
    
    private var _cellWidth : Int = -1;
    private var _cellHeight : Int = -1;
    
    private var _alwaysOnTop : Bool = true;
    
    /**
	 * Creates a grid layout to store
	 *
	 * @param	rows The amount of rows
	 * @param	column The amount of columns
	 */
    
    public function new(rows : Int, column : Int)
    {
        super();
        
        rowCount = rows;
        columnCount = column;
        
        background = false;
        init();
    }
    
    private function init() : Void
    {
        _list = new DataProvider<DataProvider<IGridCell>>();
        
        // Create data list
        for (row in 0...rowCount)
		{
            // Add new row
            var rowData : DataProvider<IGridCell> = new DataProvider<IGridCell>();
			
            _list.addItem(rowData);
            
            for (col in 0...columnCount)
			{
                // Create cell
                var cell : IGridCell = new GridCell(Std.int(_width / rowCount), Std.int(_height / columnCount));
                contentObject.addChild(cell.displayObject);
				
                cell.x = cell.width * col;
                cell.y = cell.height * row;
                
                rowData.addItem(cell);
            }
        }
    }
    
    /**
	 * Moves cell that user mouse over to the top of the display list.
	 */
    
    private function set_alwaysOnTop(value : Bool) : Bool
    {
        _alwaysOnTop = value;
        return value;
    }
    
    /**
	 * If true cell will be move to the top of the display list inside the grid container.
	 */
    
    private function get_alwaysOnTop() : Bool
    {
        return _alwaysOnTop;
    }
    
    /**
	 * The default width
	 */
    
    private function set_cellWidth(value : Int) : Int
    {
        _cellWidth = value;
        draw();
        return value;
    }
    
    /**
	 * Return the default cell width
	 */
    
    private function get_cellWidth() : Int
    {
        return _cellWidth;
    }
    
    /**
	 * The default height
	 */
	
    private function set_cellHeight(value : Int) : Int
    {
        _cellHeight = value;
        draw();
        return value;
    }
    
    /**
	 * Return the default cell height
	 */
    
    private function get_cellHeight() : Int
    {
        return _cellHeight;
    }
    
    /**
	 * Adjust the size of the cell width
	 *
	 * @param	row The index of the row
	 * @param	col The index of the column
	 * @param	widthNum The new width of the cell
	 */
    
    public function setCellWidth(row : Int, col : Int, widthNum : Int) : Void
    {
        if (!validCell(row, col)) 
            return;
        
        var rowData : DataProvider<IGridCell> = _list.getItemAt(row);
        var cell : IGridCell = rowData.getItemAt(col);
		
        cell.width = widthNum;
        
        // Move everything else x location
        for (i in col...columnCount)
		{
            var currentColumn : IGridCell = rowData.getItemAt(i);
            
            // If it's not the current cell and greater than 0
            if (cell != currentColumn && i > 0) 
            {
                var prevCell : IGridCell = rowData.getItemAt(i - 1);
                
                // Only move if on the same axis
                if (currentColumn.y == prevCell.y) 
                    currentColumn.x = prevCell.x + prevCell.width;
            }
        }
    }
    
    /**
	 * Adjust the size of the cell height
	 * @param	row The index of the row
	 * @param	col The index of the column
	 * @param	heightNum The new height of the cell
	 */
    
    public function setCellHeight(row : Int, col : Int, heightNum : Int) : Void
    {
        if (!validCell(row, col)) 
            return;
        
        var rowData : DataProvider<IGridCell> = _list.getItemAt(row);
        var cell : IGridCell = rowData.getItemAt(col);
        
        cell.height = heightNum;
        
        // Move everything else y location
        for (i in row ... rowCount)
		{
            // Get the next row in list
            rowData = _list.getItemAt(i);
            
            // Grab that column
            var currentColumn : IGridCell = rowData.getItemAt(col);
            
            // If it's not the current cell and not row length
            if ((i + 1) < rowCount) 
            {
                // Get next row
                var nextRow : DataProvider<IGridCell> = _list.getItemAt(i + 1);
                
                // Get column for that row
                var nextCell : IGridCell = nextRow.getItemAt(col);
                
                // Only move if on the same axis
                if (nextCell.x == currentColumn.x) 
                    nextCell.y = currentColumn.y + currentColumn.height;
            }
        }
    }
    
    /**
	 * Adds new row to grid
	 * @param	index Where you want to add the new row
	 */
    
    public function addRow(index : Int) : Void
    {
        var newRow : DataProvider<IGridCell> = new DataProvider<IGridCell>();
        
        // Create the columns for the row
        for (col in 0 ... columnCount)
		{
            var cell : IGridCell = new GridCell(Std.int(width / rowCount), Std.int(height / columnCount));
            
            contentObject.addChild(cell.displayObject);
            
            newRow.addItem(cell);
        }
        
        _list.addItemAt(newRow, index);
        
        rowCount++;
        
        draw();
    }
    
    /**
	 * Remove row from grid
	 * @param	index Which item to remove
	 */
    
    public function removeRow(index : Int) : Void
    {
        if (null == _list.getItemAt(index) || null == _list.getItemAt(index)) 
            return;
        
        
         // Get the rows
        var oldRow : DataProvider<IGridCell> = _list.getItemAt(index);
        
        // Remove columns out of the display
        for (col in 0...columnCount)
		{
            var cell : IGridCell = oldRow.getItemAt(col);
            contentObject.removeChild(cell.displayObject);
        }  
        
        // Remove the row  
        _list.removeItemAt(index);
        
        rowCount--;
        
        draw();
    }
    
    /**
	 * Adds new column to grid
	 * @param	index Where you want to add the new column
	 */
    
    public function addColumn(index : Int) : Void
    {
        
        if (null == _list.getItemAt(index) || null == _list.getItemAt(index)) 
            return;
        
        
         // Get each row and add a col  
        for (row in 0 ... rowCount)
		{
            // Get the row
            var rowData : DataProvider<IGridCell> = _list.getItemAt(row);
            
            // Create a new cell
            var cell : IGridCell = new GridCell(Std.int(width / rowCount), Std.int(height / columnCount));
            
            // Add to the display
            contentObject.addChild(cell.displayObject);
            
            // At column at the given index
            rowData.addItemAt(cell, index);
        }
        
        columnCount++;
        
        draw();
    }
    
    /**
	 * Removews column from grid
	 * @param	index Which item to remove
	 */
    
    public function removeColumn(index : Int) : Void
    {
        // Get each row and add a col
        for (row in 0...rowCount)
		{
            // Get the row
            var rowData : DataProvider<IGridCell> = _list.getItemAt(row);
            
            // Get cell at Column index
            var cell : IGridCell = rowData.getItemAt(index);
            
            // Remove event
            if (cell.hasEventListener(MouseEvent.MOUSE_OVER)) 
                cell.removeEventListener(MouseEvent.MOUSE_OVER, moveToFront);
            
            
            // Remove from the display  
            contentObject.removeChild(cell.displayObject);
            
            // Remove column at the given index
            rowData.removeItemAt(index);
        }
        
        columnCount--;
        
        draw();
    }
    
    /**
	 * Get a cell out of the grid
	 *
	 * @param	row The index of the row
	 * @param	col The index of the column
	 *
	 * @return A grid cell
	 */
    
    public function getCell(row : Int, col : Int) : IGridCell
    {
		
		if (_list.getItemAt(row) != null && _list.getItemAt(row).getItemAt(col) != null)
			return _list.getItemAt(row).getItemAt(col);
        
        return null;
    }
    
    /**
	 * Check to see if cell is in grid
	 *
	 * @param	row The row index
	 * @param	col The column index
	 * @return True if there is a cell there and false if not
	 */
    
    public function validCell(row : Int, col : Int) : Bool
    {
        
        if (_list.getItemAt(row) != null && _list.getItemAt(row).getItemAt(col) != null) 
            return true;
        
			Debug.print("[GridContainer::validCell] Couldn't find cell at " + row + "x" + col);
        
        return false;
    }
    
    /**
	 * Gets the number of rows.
	 * @return The total number of rows
	 */
    
    public function getRowCount() : Int
    {
        return rowCount;
    }
    
    /**
	 * Gets the number of columns
	 * @return The total number of columns
	 */
    
    public function getColumnCount() : Int
    {
        return columnCount;
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        if (null == _list) 
            return;
        
        
        // Create data list  
        for (row in 0...rowCount)
		{
            // Get row
            var rowData : DataProvider<IGridCell> = _list.getItemAt(row);
            
            // Start resizing col cell
            for (col in 0...columnCount)
			{
                // Get the cell
                var cell : IGridCell = rowData.getItemAt(col);
                cell.addEventListener(MouseEvent.MOUSE_OVER, moveToFront, false, 0, true);
                
                // Re add to the display for order
                contentObject.addChild(cell.displayObject);
                
                // Force resize based on with and height
                cell.width = ((_cellWidth >= -1)) ? Std.int(width / columnCount) : _cellWidth;
                cell.height = ((_cellHeight >= -1)) ? Std.int(height / rowCount) : _cellHeight;
                
                // Place items
                cell.x = cell.width * col;
                cell.y = cell.height * row;
            }
        }
        
        contentHolder.scrollRect = null;
        contentHolder.scrollRect = new Rectangle(0, 0, width, height);
    }
    
    private function moveToFront(event : MouseEvent) : Void
    {
        if (_alwaysOnTop) 
            contentObject.setChildIndex(cast(event.currentTarget, DisplayObject), contentObject.numChildren - 1);
    }
}

