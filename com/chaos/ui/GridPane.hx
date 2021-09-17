package com.chaos.ui;

import openfl.geom.Matrix;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.ScrollPane;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.classInterface.IButton;
import com.chaos.ui.classInterface.IGridPane;
import com.chaos.ui.classInterface.IScrollPane;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIStyleManager;
import com.chaos.data.DataProvider;

import com.chaos.form.ui.TextLabel;
import com.chaos.media.DisplayImage;
import com.chaos.ui.layout.FitContainer;
import com.chaos.ui.layout.GridContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IGridCell;
import com.chaos.ui.layout.classInterface.IGridContainer;
import com.chaos.ui.Button;
import com.chaos.utils.Debug;
import com.chaos.utils.Utils;
import com.chaos.drawing.icon.ArrowDownIcon;
import com.chaos.ui.event.GridPaneEvent;
import com.chaos.utils.Validator;

import openfl.events.Event;
import openfl.display.BitmapData;
import openfl.errors.Error;
import openfl.utils.Dictionary;
import openfl.utils.Object;
import openfl.events.MouseEvent;
import openfl.events.FocusEvent;
import openfl.display.Sprite;

/**
 * Creates a grid that use Form UI Elements. The grid use basic Objects that is displayed
 * in the grid based on the value when the column is created.
 */

class GridPane extends ScrollPane implements IGridPane implements IScrollPane implements IBaseContainer implements IBaseUI
{
	
    public var selectedRow(get, set) : Int;
    public var selectedCol(get, set) : Int;
    public var buttonSize(get, set) : Int;
    public var arrowSize(get, set) : Int;
    public var arrowColor(get, set) : Int;
    public var cellBorder(get, set) : Bool;
    public var cellBorderColor(get, set) : Int;
    public var cellColor(get, set) : Int;
    public var cellBackground(get, set) : Bool;
    public var cellBorderAlpha(get, set) : Float;
    public var cellBorderThinkness(get, set) : Float;
    public var columnButtonColor(get, set) : Int;
    public var columnButtonOverColor(get, set) : Int;
    public var columnButtonDownColor(get, set) : Int;
    public var dataProvider(get, set) : DataProvider<Object>;

    
    public static var ARROW_OFFSET : Int = 13;
    
    public var columnDefaultHeight : Int = 25;
    
    private var column : DataProvider<GridObjectData> = new DataProvider<GridObjectData>();
    
    private var buttonHolder : Sprite = new Sprite();
    private var gridHolder : Sprite = new Sprite();
    
    private var _gridData : DataProvider<Dynamic> = new DataProvider<Dynamic>();
    
    private var _grid : IGridContainer = new GridContainer({"row":1,"column": 0});
    
    private var _selectedRow : Int = 0;
    private var _selectedCol : Int = 0;
    
    private var _colButtonSize : Int = 20;
    
    private var _columnButtonImage : BitmapData;
    private var _columnButtonOverImage : BitmapData;
    private var _columnButtonDownImage : BitmapData;
    
    private var _cellBackgroundImage : BitmapData;
    
    private var storeList : Array<String> = new Array<String>();
    
    private var _arrowSize : Int = 7;
    private var _arrowColor : Int = 0xFFFFFF;
    
    private var _cellBorder : Bool = true;
    private var _cellColor : Int = 0xFFFFFF;
    private var _cellBorderColor : Int = 0x000000;
    private var _cellBorderAlpha : Float = 1;
    private var _cellBackground : Bool = true;
    private var _cellBorderThinkness : Float = 1;
    
    private var _columnButtonColor : Int = 0xCCCCCC;
    private var _columnButtonOverColor : Int = 0x666666;
    private var _columnButtonDownColor : Int = 0x333333;
    
	/**
	 * UI Grid 
	 * @param	data The proprieties that you want to set on component.
	 */
	
    public function new(data:Dynamic = null)
    {
        super(data);
        
    }
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "data")) {

            // If an array then place in grid data else just replace
            if( Std.isOfType(Reflect.field(data, "data"), Array) ) {

                var gridDataArray:Array<Dynamic> = Reflect.field(data, "data");

                for( i in 0 ... gridDataArray.length)
                    _gridData.addItem(gridDataArray[i]);
            }
            else if(Std.isOfType(Reflect.field(data, "data"), DataProvider))
            {
                _gridData = Reflect.field(data, "data");
            }
            else
            {
                Debug.print("[GridPane::setComponentData] Couldn't covert or set data, must be an Array<Dynamic> or DataProvider<Dynamic> class type.");
            }
                
        }
			
	}
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		super.initialize();
		
		mouseChildren = true;
        mouseEnabled = false;
        
        _grid.width = _width;
        _grid.height = _height;
        
        addChild(buttonHolder);
        
        source = _grid.displayObject;
	}
    
	
	/**
	 * Reload all bitmap images and UI Styles
	 */
    
    override public function reskin() : Void
    {
        super.reskin();
        
        initSkin();
        initStyle();
    }
    
    private function initSkin() : Void
    {
        // Background
        if (UIBitmapManager.hasUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BACKGROUND)) 
            setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BACKGROUND));
        
          // Buttons
        if (UIBitmapManager.hasUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_NORMAL)) 
            setColumnButtonImage(UIBitmapManager.getUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_NORMAL));
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_OVER)) 
            setColumnButtonOverImage(UIBitmapManager.getUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_OVER));
        
        if (UIBitmapManager.hasUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_DOWN)) 
            setColumnButtonDownImage(UIBitmapManager.getUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_BUTTON_DOWN));
        
          // Cell
        if (UIBitmapManager.hasUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_CELL_BACKGROUND)) 
            setCellBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.GridPane, UIBitmapManager.GRIDPANE_CELL_BACKGROUND));
    }
    
	 
    override function initStyle() : Void
    {
		super.initStyle();
		
        // Border
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_BACKGROUND_COLOR))
            _backgroundColor = UIStyleManager.getStyle(UIStyleManager.GRID_BACKGROUND_COLOR);
        
        // if (UIStyleManager.hasStyle(UIStyleManager.GRID_BORDER_COLOR)) 
        //     _borderColor = UIStyleManager.getStyle(UIStyleManager.GRID_BORDER_COLOR);
        
        // if (UIStyleManager.hasStyle( UIStyleManager.GRID_BORDER_ALPHA))
        //     _borderAlpha = UIStyleManager.getStyle(UIStyleManager.GRID_BORDER_ALPHA);
        
        // if (UIStyleManager.hasStyle(UIStyleManager.GRID_BORDER_THINKNESS))
        //     _borderThinkness = UIStyleManager.getStyle(UIStyleManager.GRID_BORDER_THINKNESS);
        
        // if (UIStyleManager.hasStyle(UIStyleManager.GRID_BORDER))
        //     _border = UIStyleManager.getStyle(UIStyleManager.GRID_BORDER);

        if (UIStyleManager.hasStyle(UIStyleManager.GRID_BACKGROUND))
            _background = UIStyleManager.getStyle(UIStyleManager.GRID_BACKGROUND);
        
        // Column Buttons
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_COLUMN_BUTTON_NORMAL_COLOR)) 
            _columnButtonColor = UIStyleManager.getStyle(UIStyleManager.GRID_COLUMN_BUTTON_NORMAL_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_COLUMN_BUTTON_OVER_COLOR))
            _columnButtonOverColor = UIStyleManager.getStyle(UIStyleManager.GRID_COLUMN_BUTTON_OVER_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_COLUMN_BUTTON_DOWN_COLOR))
            _columnButtonDownColor = UIStyleManager.getStyle(UIStyleManager.GRID_COLUMN_BUTTON_DOWN_COLOR);
        
        
        // Cell
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_CELL_BACKGROUND_COLOR))
            _cellColor = UIStyleManager.getStyle(UIStyleManager.GRID_CELL_BACKGROUND_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_CELL_BORDER_ALPHA))
            _cellBorderAlpha = UIStyleManager.getStyle(UIStyleManager.GRID_CELL_BORDER_ALPHA);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_CELL_BORDER_COLOR))
            _cellBorderColor = UIStyleManager.getStyle(UIStyleManager.GRID_CELL_BORDER_COLOR);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_BORDER_THINKNESS))
            _cellBorderThinkness = UIStyleManager.getStyle(UIStyleManager.GRID_BORDER_THINKNESS);
        
        if (UIStyleManager.hasStyle(UIStyleManager.GRID_CELL_BACKGROUND))
            _cellBackground = UIStyleManager.getStyle(UIStyleManager.GRID_CELL_BACKGROUND);
    }
    
    /**
	 * Set the selected row
	 */
    
    private function set_selectedRow(value : Int) : Int
    {
        if (_grid.validCell(value, _selectedCol)) 
            _selectedRow = value;
        else 
            Debug.print("[GridPane::selectedRow] The cell that your looking for at " + value + "x" + _selectedCol + " was not found.");
		
        return value;
    }
    
    /**
	 * Return selected row
	 */
    
    private function get_selectedRow() : Int
    {
        return _selectedRow;
    }
    
    /**
	 * Set the selected column
	 */
    
    private function set_selectedCol(value : Int) : Int
    {
        if (_grid.validCell(_selectedRow, value)) 
            _selectedCol = value;
        else 
            Debug.print("[GridPane::selectedRow] The cell that your looking for at " + _selectedRow + "x" + value + " was not found.");
		
		
        return value;
    }
    
    private function get_selectedCol() : Int
    {
        return _selectedCol;
    }
    
    /**
	 * Set the button height
	 */
    
    private function set_buttonSize(value : Int) : Int
    {
        _colButtonSize = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Return the button height
	 */
    private function get_buttonSize() : Int
    {
        return _colButtonSize;
    }
    
    /**
	 * Set the size of the icon
	 */
    
    private function set_arrowSize(value : Int) : Int
    {
        _arrowSize = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Return the arrow size
	 */
    
    private function get_arrowSize() : Int
    {
        return _arrowSize;
    }
    
    /**
	 * Arrow color
	 */
    
    private function set_arrowColor(value : Int) : Int
    {
        _arrowColor = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Get arrow color
	 */
    
    private function get_arrowColor() : Int
    {
        return _arrowColor;
    }
    
    /**
	 * Turn on and off cell border
	 */
    private function set_cellBorder(value : Bool) : Bool
    {
        _cellBorder = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return true if border is on and false if not
	 */
    
    private function get_cellBorder() : Bool
    {
        return _cellBorder;
    }
    
    /**
	 * Set the cell border color
	 */
    
    private function set_cellBorderColor(value : Int) : Int
    {
        _cellBorderColor = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_cellBorderColor() : Int
    {
        return _cellBorderColor;
    }
    
    /**
	 * Set the cell color
	 */
    
    private function set_cellColor(value : Int) : Int
    {
        _cellColor = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_cellColor() : Int
    {
        return _cellColor;
    }
    
    /**
	 * Show or Hide the cell background
	 */
    
    private function set_cellBackground(value : Bool) : Bool
    {
        _cellBackground = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return true of the background is being shown and false if not
	 */
    
    private function get_cellBackground() : Bool
    {
        return _cellBackground;
    }
    
    /**
	 * Set the alpha of the border
	 */
    
    private function set_cellBorderAlpha(value : Float) : Float
    {
        _cellBorderAlpha = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return the border alpha from 0 to 1
	 */
    
    private function get_cellBorderAlpha() : Float
    {
        return _cellBorderAlpha;
    }
    
    /**
	 * Cell border thinkness
	 */
    
    private function set_cellBorderThinkness(value : Float) : Float
    {
        _cellBorderThinkness = value;
        updateCellColor();
		
        return value;
    }
    
    /**
	 * Return the size of the border
	 */
    
    private function get_cellBorderThinkness() : Float
    {
        return _cellBorderThinkness;
    }
    
    /**
	 * The button normal state color
	 */
    
    private function set_columnButtonColor(value : Int) : Int
    {
        _columnButtonColor = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Return the normal state button color
	 */
    
    private function get_columnButtonColor() : Int
    {
        return _columnButtonColor;
    }
    
    /**
	 * The button over state color
	 */
    
    private function set_columnButtonOverColor(value : Int) : Int
    {
        _columnButtonOverColor = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Return the button over state color
	 */
    
    private function get_columnButtonOverColor() : Int
    {
        return _columnButtonOverColor;
    }
    
    /**
	 * The button down state color
	 */
    
    private function set_columnButtonDownColor(value : Int) : Int
    {
        _columnButtonDownColor = value;
        updateColumnArea();
		
        return value;
    }
    
    /**
	 * Return the button down state color
	 */
    
    private function get_columnButtonDownColor() : Int
    {
        return _columnButtonDownColor;
    }
    
    /**
	 * Set the data provider and object with values for the grid
	 */
    
    private function set_dataProvider(value : DataProvider<Object>) : DataProvider<Object>
    {
        _gridData = value;
		
        return value;
    }
    
    /**
	 * Get the data object that is being used for the grid
	 */
    
    private function get_dataProvider() : DataProvider<Object>
    {
        return _gridData;
    }
    
    /**
	 * Set or update what values to look for in pasted in data objects.
	 *
	 * @param	index The index of the value you want to update
	 * @param	value A list of values as stings that will be on each data object
	 * @exampleText grid.setStore(0,"newName");
	 */
    
    public function setStore(index : Int, value : String) : Void
    {
        if (storeList[index] != null) 
        {
            storeList[index] = value;
			
            updateGridData();
        }
        else 
        {
            Debug.print("[Grid::setStore] Current column value is null.");
        }
    }
    
    /**
	 * Adds a new colume to the grid. The class must be have IFormUI and IBaseUI interfaces in order to be used.
	 *
	 * @param	colName The name of the column.
	 * @param	element The Form object class
	 * @param	dataRowName The name that is being used inside the store object.
	 * @param	gridLayout The layout you want to use. The default is the FitLayout or Fit
	 * @param	data Passed in when creating the element
	 *
	 * @see com.chaos.ui.layout.GridCellLayout
	 * @exampleText grid.addColumn("Family", DropDownMenu, "family", GridCellLayout.VERTICAL, dropDownData);
	 */
    
    public function addColumn(colName : String, element : Class<Object>, dataRowName : String, gridLayout : Class<Object> = null, data : Dynamic = null) : Void
    {
        
        if (!(Std.isOfType(Type.createInstance(element, []), IFormUI)) || !(Std.isOfType(Type.createInstance(element, []), IBaseUI))) 
        {
            Debug.print("[GridPane::addColumn] Didn't add column because class doesn't support both the IFormUI and IBaseUI interfaces.");
            return;
        }  
        
        // Add a new column  
        _grid.addColumn(0);
        
        // Add store data value
        storeList.push(dataRowName);
        
        // Setup what's needed for col
        var colInfoHolder : BaseUI = new BaseUI({"name":"col" + _grid.getColumnCount()});
        var buttonArea : IAlignmentContainer = new FitContainer({"name":"buttonArea"});
        var button : IButton = new Button({"name":"button","text":colName});
        var arrow : IBasicIcon = new ArrowDownIcon({"name":"arrow","width":10,"height":10});        

        var gridColObj:GridObjectData = new GridObjectData(colInfoHolder, buttonArea, element, button, colName,arrow, dataRowName, gridLayout, data);
                
        button.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
        
        // Get the first cell and get the width
        buttonArea.height = _colButtonSize;
        
        // Name holder
        colInfoHolder.name = colName;
        
        // Put button in the fit container
        buttonArea.addElement(button);
        
        // Add fit container to holder
        colInfoHolder.addChild(buttonArea.displayObject);
        colInfoHolder.addChild(arrow.displayObject);
        
        // Keep track of clip
        column.addItem(gridColObj);
        
        buttonHolder.addChild(colInfoHolder);
        
        var currentCell : IGridCell = _grid.getCell(0, 0);
        
        buttonArea.width = currentCell.width;
        
        draw();
    }
    
    /**
	 * Remove an column using the index id
	 * @param	index The current item based on index value
	 */
    
    public function removeColumnByIndex(index : Int) : Void
    {
        var columnObj : GridObjectData = column.getItemAt(index);
        var colInfoHolder : IBaseUI = columnObj.col;
        var button : IButton = columnObj.button;
        var dataRowName : String = columnObj.dataRowName;
        
        // Remove name used for data row because data list is in same order as column
        storeList.splice(index, 1);
        
        button.removeEventListener(MouseEvent.CLICK, onButtonClick);
        buttonHolder.removeChild(colInfoHolder.displayObject);
        column.removeItem(columnObj);

        _grid.removeColumn(index);
        
        draw();
    }
    
    /**
	 * Remove all columns
	 */
    
    public function removeAllColumns() : Void
    {
        var columnCount : Int = column.length;

        for (i in 0...columnCount){
            removeColumnByIndex(0);
        }
    }
    
    /**
	 * Gets the arrow used in column
	 * @param	index the column button index
	 * @return Return the icon
	 */
    
    public function getColumnArrow(index : Int) : IBasicIcon
    {
        try
        {
            return column.getItemAt(index).arrow;
        }
        catch (error : Error)
        {
            Debug.print("[GridPane::getColumnArrow] Can't find item at index " + index);
        }
        
        return null;
    }
    
    /**
	 * Set the column width
	 *
	 * @param	index Which column
	 * @param	colWidth The new width
	 */
    public function setColumnWidthAt(index : Int, colWidth : Int) : Void
    {
        
        for (row in 0 ... _grid.getRowCount())
		{
            
            if (_grid.validCell(row, index)) 
            {
                _grid.setCellWidth(row, index, colWidth);
            }
            else 
            {
                Debug.print("[GridPane::setColumnWidthAt] Fail to update " + row + "x" + index + " width in grid to " + colWidth + ".");
            }
        }
        
        updateColumnArea();
    }
    
    /**
	 * Set all the cells width in the grid
	 * @param	colWidth The new cell width
	 */
    public function setCellWidth(colWidth : Int) : Void
    {
        for (row in 0 ... _grid.getRowCount())
		{
            for (col in 0 ... _grid.getColumnCount())
			{
                if (_grid.validCell(row, col)) 
                {
                    _grid.setCellWidth(row, col, colWidth);
                }
                else 
                {
                    Debug.print("[GridPane::setColumnWidth] Fail to update " + row + "x" + col + " width in grid to " + colWidth + ".");
                }
            }
        }
        
        updateColumnArea();
    }
    
    /**
	 * Set the column height
	 *
	 * @param	index Which column
	 * @param	colWidth The new height
	 */
    public function setColumnHeightAt(index : Int, colHeight : Int) : Void
    {
        if (null == _grid) 
            return;
        
        for (row in 0 ... _grid.getRowCount()){
            
            if (_grid.validCell(row, index)) 
            {
                _grid.setCellHeight(row, index, colHeight);
            }
            else 
            {
                Debug.print("[GridPane::setColumnHeight] Fail to update " + row + "x" + index + " height in grid to " + colHeight + ".");
            }
        }
        
        updateColumnArea();
    }
    
    /**
	 * Set all the cells height in the grid
	 * @param	colHeight The new cell height
	 */
    public function setCellHeight(colHeight : Int) : Void
    {
        
        for (row in 0 ... _grid.getRowCount())
        {
            for (col in 0 ... _grid.getColumnCount()) 
            {
                if (_grid.validCell(row, col)) 
                    _grid.setCellHeight(row, col, colHeight);
                else 
                    Debug.print("[GridPane::setCellHeight] Fail to update " + row + "x" + col + " height in grid to " + colHeight + ".");
            }
        }
        
        updateColumnArea();
    }
    
    /**
	 * Return the selected object
	 */
    public function getSelected() : Dynamic
    {
        // Make valid cell first, then return the hold object
        if (_grid.validCell(_selectedRow, _selectedCol)) 
            return _gridData.getItemAt(_selectedRow);
        
        return null;
    }
    
    /**
	 * Get selected UI Element
	 *
	 * @return Return a form interface
	 */
    
    public function getSelectedElement() : IFormUI
    {
        try
        {
            return cast(_grid.getCell(_selectedRow, _selectedCol).container.getElementAtIndex(0).displayObject, IFormUI);
        }        
        catch (error : Error)
        {
            Debug.print("[GridPane::getSelectedElement] Couldn't or convert item");
        }
        
        return null;
    }
    
    /**
	 * Return the button used in the grid
	
	 * @return a button interface
	 */
    
    public function getColumnButton(index : Int) : IButton
    {
        try
        {
            // Get holder and button area
            return cast(column.getItemAt(index).button, IButton);
        }        
		catch (error : Error)
        {
            Debug.print("[GridPane::getColumnButton] Couldn't find button at index " + index);
        }
        
        return null;
    }
    
    
    /**
	 * Set the image based on a pasted in bitmap
	 * @param	value
	 */
    
    public function setColumnButtonImage(value : BitmapData) : Void
    {
        _columnButtonImage = value;
        updateColumnArea();
    }

    
    /**
	 * Set the image based on a pasted in image
	 * @param	value The bitmap object that will be used
	 */
    
    public function setColumnButtonOverImage(value : BitmapData) : Void
    {
        _columnButtonOverImage = value;
        updateColumnArea();
    }
    

    
    /**
	 * Set the image based on a pasted in image
	 * @param	value The bitmap object that will be used
	 */
    
    public function setColumnButtonDownImage(value : BitmapData) : Void
    {
        _columnButtonDownImage = value;
        updateColumnArea();
    }

    
    /**
	 * Set the cell background based on bitmap data being passed
	 * @param	value The bitmap object that will be used
	 */
    
    public function setCellBackgroundImage(value : BitmapData) : Void
    {
        _cellBackgroundImage = value;
        updateColumnArea();
    }
    
    /**
	 * Set which cell in the grid is active
	 * @param	row The row index
	 * @param	col The column index
	 */
    
    public function selectCell(row : Int, col : Int) : Void
    {
        // If it's in the list then set selected
        if (_grid.validCell(row, col)) 
        {
            _selectedRow = row;
            _selectedCol = col;
        }
        else 
        {
            Debug.print("[GridPane::selectCell] Not a valid of cell at " + row + "x" + col + ".");
        }
    }
    
    /**
	 * Set the grid container being used width
	 * @param	value The new width
	 */
    
    public function setGridWidth(value : Int) : Void
    {
        _grid.width = value;
        updateColumnArea();
    }
    
    /**
	 * Set the grid container being used height
	 * @param	value The new height
	 */
    
    public function setGridHeight(value : Int) : Void
    {
        _grid.height = value;
        updateColumnArea();
    }
    
    /**
	 * Set the width and height of the grid container being used
	 * @param	gridWidth The new width
	 * @param	gridHeight The new height
	 */
	
    public function setGridSize(gridWidth : Float, gridHeight : Float) : Void
    {
        _grid.width = gridWidth;
        _grid.height = gridHeight;
        
        updateGridData();
        updateColumnArea();
        
        refreshPane();
    }
    
    /**
	 * Update the UI Grid
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        if (null == column && null == _grid || column.length == 0) 
            return;
        
        _grid.width = width;
        
        
        for (i in 0 ... column.length)
		{
            // Get holder and button area
            var colInfoHolder : IBaseUI = column.getItemAt(i).col;
            var buttonArea : IAlignmentContainer = column.getItemAt(i).buttonHolder;
            var button : IButton = column.getItemAt(i).button;
            var cell : IGridCell = _grid.getCell(0, i);
            
            buttonArea.width = cell.width;
            buttonArea.draw();

            _grid.y = buttonArea.height;
            
            // Match button size with cell
            if (_grid.validCell(0, i)) 
                colInfoHolder.x = _grid.getCell(0, i).displayObject.width * i;
        } 
        
        
        // Set the default size of cells  
        setCellHeight(columnDefaultHeight);
        
        _grid.height = _grid.getRowCount() * columnDefaultHeight;
        contentHolder.y = buttonHolder.height;
        
        // NOTE: Done this way so devs can override them and call them one at a time later on
        updateColumnArea();  // Update the top button area  
        
        // For updating data in grid
        if (null != _gridData && _gridData.length > 0) 
        {
            updateRowCount();  // Add or remove rows  
            updateCellName();  // Cell names  
            updateGridData();  // Update the values being display  
            updateCellColor();
        }
        
        refreshPane();
    }
    
    /**
	 * Update the cell background and border colors
	 */
    public function updateCellColor() : Void
    {
        // Create data list
        for (row in 0..._grid.getRowCount())
		{
            // All update all cells
            for (col in 0..._grid.getColumnCount())
			{
                // Get the cell
                var currentCell : IGridCell = _grid.getCell(row, col);
                currentCell.border.visible = _cellBorder;
                currentCell.border.lineColor = _cellBorderColor;
                currentCell.border.lineAlpha = _cellBorderAlpha;
                currentCell.border.lineThinkness = _cellBorderThinkness;
                currentCell.container.background = _cellBackground;
                currentCell.container.backgroundColor = _cellColor;
                currentCell.draw();
                
                // Make sure image is loaded and set background image
                if (null != _cellBackgroundImage && null != currentCell.container) 
                    currentCell.container.setBackgroundImage(_cellBackgroundImage);
            }
        }
    }
    
    /**
	 * Update the buttons and column area
	 */
    
    public function updateColumnArea() : Void
    {
        for (i in 0 ... column.length)
		{
            var colInfoHolder : IBaseUI = column.getItemAt(i).col;
			
            var arrow : IBasicIcon = column.getItemAt(i).arrow;
            var buttonArea : IAlignmentContainer = column.getItemAt(i).buttonHolder;
            var button : IButton = column.getItemAt(i).button;
            
            button.defaultColor = _columnButtonColor;
            button.overColor = _columnButtonOverColor;
            button.downColor = _columnButtonDownColor;
            
            buttonArea.height = _colButtonSize;
            buttonArea.width = _grid.getCell(0, i).width;
            
            arrow.width = arrow.height = _arrowSize;
            arrow.baseColor = arrow.borderColor = _arrowColor;
            
            arrow.x = button.width - arrow.width - ARROW_OFFSET;
            arrow.y = (button.height / 2) - (arrow.height / 2);
            
            // If image was set the use
            if (null != _columnButtonImage) 
                button.setDefaultStateImage(_columnButtonImage);
            
            
            // If image was set the use
            if (null != _columnButtonOverImage) 
                button.setOverStateImage(_columnButtonOverImage);
            
            // If image was set the use 
            if (null != _columnButtonDownImage) 
                button.setDownStateImage(_columnButtonDownImage);
            
            if (i > 0)
            {
                var oldInfoHolder : IBaseUI = column.getItemAt(i - 1).col;
                colInfoHolder.x = oldInfoHolder.x + _grid.getCell(0, i - 1).width;
            }
            else 
            {
                colInfoHolder.x = 0;
            }
        }
    }
    
    /**
	 * Update all the grid form values
	 */
    
    public function updateGridData() : Void
    {
        if (null == _grid) 
            return;
			
		var row:Int = 0;
		var col:Int = 0;
        
        // Create data list
        while (row != _gridData.length)
		{

            // Start resizing col cell
            while (col != storeList.length)
			{
                
                // Make sure cell is there
                if (_grid.validCell(row, col)) 
                {
                    // If value is not there then move on
                    if (!Reflect.hasField(_gridData.getItemAt(row),storeList[col])) 
                    {
						col++;
						continue;
                    }  
                    
                    
                    // Check to see if cell was added 
                    if (_grid.getCell(row, col).container.length == 0) 
                    {
                        // Create element from stored class
                        var formClass : Class<Dynamic> = column.getItemAt(col).element;
                        var element : Dynamic = Type.createInstance(formClass, [column.getItemAt(col).data]);
                        var cell : IGridCell = _grid.getCell(row, col);
                        
                        // If there is a layout set it before adding in content
                        if (null != column.getItemAt(col).layout) 
                            cell.setLayout(column.getItemAt(col).layout);
                        
                        
                        // Make it so there is some form of overlay for drop down menus
                        cell.container.clipping = false;
                        
                        // Attach events /w weak link so it will be removed
                        cell.addEventListener(MouseEvent.CLICK, onUserSelection, false, 0, true);
                        cell.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, onCellCheck, false, 0, true);
                        cell.addEventListener(MouseEvent.MOUSE_OUT, onCellCheck, false, 0, true);
                        
                        // Add element
                        if (Std.isOfType(element, IBaseUI)) 
                        {
                            cell.container.addElement(cast(element, IBaseUI));
                        }
                        else 
                        {
                            Debug.print("[GridPane::updateGridData] Couldn't add element to " + row + "x" + col + " because element doesn't use IBaseUI Interface.");
                        }
                        
                        // Set value  
                        if (Std.isOfType(element, IFormUI)) 
                        {
                            cast(element, IFormUI).setValue(Std.string(Reflect.field(_gridData.getItemAt( row  ), storeList[ col ] )));
                            cast(element, IBaseUI).draw();
                        }
                        else 
                        {
                            Debug.print("[GridPane::updateGridData] Couldn't set element in " + row + "x" + col + " because element doesn't use IFormUI Interface.");
                        }
                    }
                    else if (_grid.getCell(row, col).container.length == 1) // Update the value inside
                    {
                        var uiFormElement : IBaseUI = _grid.getCell(row, col).container.getElementAtIndex(0);
                        
                        if (Std.isOfType(uiFormElement, IFormUI)) 
                        {
                            cast(uiFormElement, IFormUI).setValue( Reflect.field(_gridData.getItemAt(row),storeList[col]) );
                            uiFormElement.draw();
                        }
                        else 
                        {
                            Debug.print("[GridPane::updateGridData] Fail to update element at " + row + "x" + col + " because element doesn't use IFormUI Interface.");
                        }
                    }
                    else 
                    {
                        Debug.print("[GridPane::updateGridData] Didn't add or update element at " + row + "x" + col + " because there is more than one object in the cell.");
                    }
                }
				
				col++;
            }
			
			row++;
        }
    }
    
    /**
	 * This updates the row count
	 */
    
    public function updateRowCount(useFailsafe : Bool = false, maxCount : Int = 10000) : Void
    {
        if (_grid == null) 
            return;
        
        var breakOut : Int = 0;
        
        while (_grid.getRowCount() != _gridData.length)
        {
            
            if (_grid.getRowCount() < _gridData.length) 
                _grid.addRow(0);
            else if (_grid.getRowCount() > _gridData.length) 
                _grid.removeRow(0);
            
            breakOut++;
            
            // Force to break out of loop
            if (breakOut == maxCount && useFailsafe) 
                break;
        }
    }
    
    private function updateCellName() : Void
    {
        if (null == _grid)
            return;
        
        // Create data list
        for (row in 0 ... _grid.getRowCount())
		{
            // Start resizing col cell
            for (col in 0 ... _grid.getColumnCount())
			{
                // Get the cell
                _grid.getCell(row, col).name = row + "_" + col;
            }
        }
    }
    
    private function onButtonClick(event : MouseEvent) : Void
    {
        
        for (i in 0 ... column.length)
		{
            var button : IButton = cast(column.getItemAt(i).button, IButton);
            
            if (cast(event.currentTarget,IButton) == button) 
            {
                var arrow : IBasicIcon = cast(column.getItemAt(i).arrow, IBasicIcon);
                
                if (column.getItemAt(i).sort) 
                {
                    arrow.displayObject.transform.matrix = column.getItemAt(i).arrowDefault;
                    _gridData.dataArray.sort(sortAlphabeticallyDescending);
                    
                    updateColumnArea();
                }
                else 
                {
                    Utils.flipVertical(arrow.displayObject);
                    _gridData.dataArray.sort(sortAlphabeticallyAscending);
                    
                    updateColumnArea();
                    arrow.displayObject.y += arrow.displayObject.height / 2;
                }
                
                column.getItemAt(i).sort = !column.getItemAt(i).sort;
            }
        }
        
        updateGridData();
    }
	
	private function sortAlphabeticallyDescending( a:String, b:String):Int
	{
		a = a.toUpperCase();
		b = b.toUpperCase();
		
		if (a < b)
			return -1;
		else if (a > b)
			return 1;
		else
			return 0;
	}
	
	private function sortAlphabeticallyAscending( a:String, b:String):Int
	{
		a = a.toUpperCase();
		b = b.toUpperCase();
		
		if (a > b)
			return -1;
		else if (a < b)
			return 1;
		else
			return 0;
	}	
    
    private function onUserSelection(event : MouseEvent) : Void
    {
        try
        {
            var cellSelectArray : Array<String> = cast(event.currentTarget, IBaseUI).name.split("_");
            _selectedRow = Std.parseInt(cellSelectArray[0]);
            _selectedCol = Std.parseInt(cellSelectArray[1]);
            
            dispatchEvent(new GridPaneEvent(GridPaneEvent.SELECT, false, false, _selectedRow, _selectedCol));
        }    
		catch (error : Error)
        {
            Debug.print("[GridPane::onUserSelection] Fail to get cell name.");
        }
    }
    
    private function onCellCheck(event : Event) : Void
    {
        
        try
        {
            var cellSelectArray : Array<String> = cast(event.currentTarget, IBaseUI).name.split("_");
            var currentGridData : String = Std.string( Reflect.field(_gridData.getItemAt( Std.parseInt(cellSelectArray[0]) ), storeList[ Std.parseInt(cellSelectArray[1]) ] ));
            var currentFormObj : IFormUI = null;
            
            // Make sure there is an item in the cell and use the IForm interface
            if (_grid.getCell( Std.parseInt(cellSelectArray[0]), Std.parseInt(cellSelectArray[1]) ).container.length == 1 && Std.isOfType(_grid.getCell( Std.parseInt(cellSelectArray[0]), Std.parseInt(cellSelectArray[1]) ).container.getElementAtIndex(0), IFormUI)) 
                currentFormObj = cast(_grid.getCell( Std.parseInt(cellSelectArray[0]), Std.parseInt(cellSelectArray[1])).container.getElementAtIndex(0), IFormUI);
            
            if (null != currentFormObj) 
            {
                if (currentFormObj.getValue() != currentGridData) 
                {
                    // Update value and dispatch event
                    Reflect.setField(_gridData.getItemAt( Std.parseInt(cellSelectArray[0]) ), storeList[ Std.parseInt(cellSelectArray[1]) ], ( (Validator.isValidNumber(currentGridData) && Std.isOfType( Reflect.field( _gridData.getItemAt( Std.parseInt(cellSelectArray[0]) ), storeList[ Std.parseInt(cellSelectArray[1]) ]) , Int))) ? Std.parseInt(currentGridData) : currentFormObj.getValue());
                    dispatchEvent(new GridPaneEvent(GridPaneEvent.CHANGE, false, false, _selectedRow, _selectedCol));
                }
            }
        } 
		catch (error : Error)
        {
            Debug.print("[GridPane::onCellCheck] Fail to get cell name and check value");
        }
    }
    

}


/**
 * Grid Data Object
 * @author Erick Feiling
 */

 class GridObjectData 
 {

    public var col : IBaseUI;
    public var buttonHolder : IAlignmentContainer;
    public var element : Class<Object>;
    public var button : IButton;
    public var name : String;
    public var arrow : IBasicIcon;
    public var arrowDefault : Matrix;
    public var dataRowName : String;
    public var data : Dynamic;
    public var sort : Bool = false;
    public var layout : Class<Object>;

	/**
	 * Store grid values to use later
	 * @param	colInfoHolder Hold button and arrow
	 * @param	buttonHolder Fit container for button
	 * @param	element UI Class used in this column
	 * @param	button button being used
	 * @param	colName The name of the button
	 * @param	arrow The arrow on top of the button
	 * @param	dataRowName The name being used
	 * @param	gridLayout What layout the cell will used
	 * @param	data Used for drop downs and list buttons
	 */
	
    public function new(colInfoHolder : IBaseUI , buttonHolder : IAlignmentContainer, element : Class<Object>, button : IButton, colName : String, arrow : IBasicIcon, dataRowName : String, gridLayout : Class<Object> = null, data:Dynamic = null )
    {
        this.col = colInfoHolder;
        this.buttonHolder = buttonHolder;
        this.element = element;
        this.button = button;
        this.name = colName;
        this.arrow = arrow;
        this.arrowDefault = arrow.displayObject.transform.matrix.clone();
        this.dataRowName = dataRowName;
        this.data = data;
        this.layout = gridLayout;
    }
    
 }

