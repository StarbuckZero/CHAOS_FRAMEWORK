package com.chaos.form;

import com.chaos.form.FormData;
import com.chaos.form.Layout;

import com.chaos.form.classInterface.IFormBuilder;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.ui.BaseUI;
import com.chaos.ui.interface.IBaseUI;
import com.chaos.ui.layout.AlignmentBaseContainer;
import com.chaos.ui.layout.GridContainer;
import com.chaos.ui.layout.Interface.IGridCell;
import com.chaos.ui.layout.Interface.IGridContainer;
import com.chaos.form.ui.TextLabel;
import com.chaos.ui.interface.ILabel;
import com.chaos.utils.Debug;
import com.chaos.ui.layout.GridCellLayout;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLVariables;
import openfl.net.URLRequestMethod;

/**
 * This creates a form that can submit data to a server in the form of a post or get
 * @author Erick Feiling
 */

class FormBuilder extends BaseUI implements IFormBuilder implements com.chaos.ui.classInterface.IBaseUI
{
    public static inline var TYPE : String = "FormBuilder";
	
    public var vSpacing(get, set) : Int;
    public var hSpacing(get, set) : Int;
    public var border(get, set) : Bool;
    public var borderThinkness(get, set) : Int;
    public var url(get, set) : String;
    public var method(get, set) : String;
    
    public var formObj : URLVariables = new URLVariables();
    
    public var hiddenObj : Dynamic = new Dynamic();
    
    private var _grid : com.chaos.ui.layout.classInterface.IGridContainer = new GridContainer(0, 2);
    
    private var _border : Bool = true;
    private var _borderThinkness : Int = 2;
    private var _vSpacing : Int = 4;
    private var _hSpacing : Int = 0;
    
    private var _url : String = "";
    private var _method : String = URLRequestMethod.POST;
    
    private var _defaultCellHeight : Int = 30;
    
    /**
	 * Creates a two colume form that sends command to a server.
	 *
	 * @eventType openfl.events.IOErrorEvent.IO_ERROR
	 * @eventType openfl.events.Event.COMPLETE
	 */
	
    public function new()
    {
        super();
        addChild(_grid.displayObject);
    }
    
    override private function get_Width() : Float
    {
        return _grid.width;
    }
    
    override private function set_Width(value : Float) : Float
    {
        _grid.width = value;
        return value;
    }
    
    override private function get_Height() : Float
    {
        return _grid.height;
    }
    
    override private function set_Height(value : Float) : Float
    {
        _grid.height = value;
        return value;
    }
    
    /**
	 * The default spacing used for added form elements
	 */
    
    private function set_VSpacing(value : Int) : Int
    {
        _vSpacing = value;
        return value;
    }
    
    /**
	 * Return value
	 */
	
    private function get_VSpacing() : Int
    {
        return _vSpacing;
    }
    
    /**
	 * The default spacing used for added form elements
	 */
    
    private function set_HSpacing(value : Int) : Int
    {
        _hSpacing = value;
        return value;
    }
    
    /**
	 * Return value
	 */
    
    private function get_HSpacing() : Int
    {
        return _hSpacing;
    }
    
    /**
	 * If true the border on added form item will have border
	 */
    
    private function set_Border(value : Bool) : Bool
    {
        _border = value;
        return value;
    }
    
    /**
	 * Return true if border will be set by default and false if not
	 */
    
    private function get_Border() : Bool
    {
        return _border;
    }
    
    /**
	 * Set the default border thinkness of added item
	 */
    
    private function set_BorderThinkness(value : Int) : Int
    {
        _borderThinkness = value;
        return value;
    }
    
    /**
	 * Return the border thinkness
	 */
	
    private function get_BorderThinkness() : Int
    {
        return _borderThinkness;
    }
    
    /**
	 * Set the url the form data will be sent
	 */
	
    private function set_Url(value : String) : String
    {
        _url = value;
        return value;
    }
    
    /**
	 * Get the url that is being used
	 */
    
    private function get_Url() : String
    {
        return _url;
    }
    
    /**
	 * Used for sending a "GET" or "POST" command to the server. Use the URLRequestMethod to set this.
	 */
    
    private function set_Method(value : String) : String
    {
        _method = value;
        return value;
    }
    
    /**
	 * Return the mode the form is in
	 */
    
    private function get_Method() : String
    {
        return _method;
    }
    
    /**
	 * Adds a new form element to the form
	 *
	 * @param	labelName The label of the form
	 * @param	elementName The name that will be used once sent to server
	 * @param	element The ui class that will be used
	 * @param	layout What layout that will be used
	 * @param	params Any extra values that will be passed for the layout
	 */
    
    public function addFormElement(labelName : String, elementName : String, element : IFormUI, layout : Class<Dynamic> = null, params : Dynamic = null) : Void
    {
        _grid.addRow(0);
        
        // Set borders and everything first
        setColumnHeightAt(0, _defaultCellHeight);
        setColumnHeightAt(1, _defaultCellHeight);
        
        _grid.getCell(0, 0).setLayout(GridCellLayout.HORIZONTAL, params);
        _grid.getCell(0, 1).setLayout(((null != layout && Std.is(Type.createInstance(layout, []), AlignmentBaseContainer))) ? Type.createInstance(layout, []) : GridCellLayout.HORIZONTAL, params);
        
        // Turn off clipping for combo boxes
        _grid.getCell(0, 0).container.clipping = _grid.getCell(0, 1).container.clipping = false;
        
        var newLabel : com.chaos.ui.classInterface.ILabel = new TextLabel(labelName);
        _grid.getCell(0, 0).container.addElement(newLabel);
        
        element.setName(elementName);
        
        _grid.getCell(0, 0).border = _border;
        _grid.getCell(0, 0).borderThinkness = _borderThinkness;
        
        // Check to see ifitem is a based UI
        if (Std.is(element, com.chaos.ui.classInterface.IBaseUI)) 
        {
            var baseElement : com.chaos.ui.classInterface.IBaseUI = (try cast(element, com.chaos.ui.classInterface.IBaseUI) catch(e:Dynamic) null);
            
            _grid.getCell(0, 1).container.addElement(baseElement);
            
            _grid.getCell(0, 1).border = _border;
            _grid.getCell(0, 1).borderThinkness = _borderThinkness;
        }  
		
		// Adjust elements location  
        for (row in 0..._grid.getRowCount())
		{
            if (_grid.getCell(row, 0).container.length > 0) 
            {
                _grid.getCell(row, 0).container.getElementAtIndex(0).x = _vSpacing;
                
                // Only move if was adjusted
                if (_hSpacing > 0) 
                    _grid.getCell(row, 0).container.getElementAtIndex(0).y = _hSpacing;
            }
            
            if (_grid.getCell(row, 1).container.length > 0) 
            {
                _grid.getCell(row, 1).container.getElementAtIndex(0).x = _vSpacing;
                
                // Only move if was adjusted
                if (_hSpacing > 0) 
                    _grid.getCell(row, 1).container.getElementAtIndex(0).y = _hSpacing;
            }
        }
    }
    
    /**
	 * Keeps track of a FormData object. The name and values will be sent to server when using the send method.
	 * @param	dataObj The form object
	 */
    
    public function addFormData(dataObj : FormData) : Void
    {
        hiddenObj[dataObj.getName()] = dataObj;
    }
    
    /**
	 * @copy com.chaos.ui.layout.GridContainer
	 */
    
    public function getCell(row : Int, col : Int) : com.chaos.ui.layout.classInterface.IGridCell
    {
        return _grid.getCell(row, col);
    }
    
    /**
	 * Set the size of the form
	 * @param	newWidth The new width
	 * @param	newHeight The new height
	 */
    
    public function setSize(newWidth : Int, newHeight : Int) : Void
    {
        _grid.width = newWidth;
        _grid.height = newHeight;
    }
    
    /**
	 * Set the width of the form
	 * @param	value The new width
	 */
    
    public function setWidth(value : Int) : Void
    {
        _grid.width = value;
    }
    
    /**
	 * Set the height of the form
	 * @param	value The new height
	 */
    
    public function setHeight(value : Int) : Void
    {
        _grid.height = value;
    }
    
    /**
	 * Set the column width
	 *
	 * @param	index Which column
	 * @param	colWidth The new width
	 */
    
    public function setColumnWidthAt(index : Int, colWidth : Int) : Void
    {
        
        for (row in 0..._grid.getRowCount()){
            
            if (_grid.validCell(row, index)) 
            {
                _grid.setCellWidth(row, index, colWidth);
            }
            else 
            {
                Debug.print("[FormBuilder::setColumnWidthAt] Fail to update " + row + "x" + index + " width in grid to " + colWidth + ".");
            }
        }
    }
    
    /**
	 * Set all the cells width in the grid
	 * @param	colWidth The new cell width
	 */
    
    public function setCellWidth(colWidth : Int) : Void
    {
        for (row in 0..._grid.getRowCount()){
            for (col in 0..._grid.getColumnCount()){
                if (_grid.validCell(row, col)) 
                {
                    _grid.setCellWidth(row, col, colWidth);
                }
                else 
                {
                    Debug.print("[FormBuilder::setColumnWidth] Fail to update " + row + "x" + col + " width in grid to " + colWidth + ".");
                }
            }
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
        if (null == _grid) 
            return;
        
        for (row in 0..._grid.getRowCount()){
            
            if (_grid.validCell(row, index)) 
            {
                _grid.setCellHeight(row, index, colHeight);
            }
            else 
            {
                Debug.print("[FormBuilder::setColumnHeight] Fail to update " + row + "x" + index + " height in grid to " + colHeight + ".");
            }
        }
    }
    
    /**
	 * Clear all form values
	 */
    
    public function reset() : Void
    {
        // Get all data from form objects
        for (row in 0..._grid.getRowCount()){
            
            if (_grid.getCell(row, 1).container.length > 0 && null != _grid.getCell(row, 1).container.getElementAtIndex(0) && Std.is(_grid.getCell(row, 1).container.getElementAtIndex(0), IFormUI)) 
            {
                var itemFormUI : IFormUI = try cast(_grid.getCell(row, 1).container.getElementAtIndex(0), IFormUI) catch(e:Dynamic) null;
                itemFormUI.clear();
                
                formObj[itemFormUI.getName()] = itemFormUI.getValue();
            }
        }
    }
    
    /**
	 * Does a POST or GET with all the values to a server-side script
	 *
	 * @eventType openfl.events.Event.COMPLETE
	 * @eventType openfl.events.IOErrorEvent.IO_ERROR
	 *
	 * @return The data object just in case values are written
	 */
    
    public function send() : Dynamic
    {
        // Do nothing if URL wasn't set
        if (_url == "") 
        {
            Debug.print("[FormBuilder::send] URL wasn't sent");
            return;
        }  // Get all data from form objects  
        
        
        
        for (row in 0..._grid.getRowCount()){
            
            if (_grid.getCell(row, 1).container.length > 0 && null != _grid.getCell(row, 1).container.getElementAtIndex(0) && Std.is(_grid.getCell(row, 1).container.getElementAtIndex(0), IFormUI)) 
            {
                var itemFormUI : IFormUI = try cast(_grid.getCell(row, 1).container.getElementAtIndex(0), IFormUI) catch(e:Dynamic) null;
                formObj[itemFormUI.getName()] = itemFormUI.getValue();
            }
        }  // Add hidden data object to formObj  
        
        
        
        for (index in Reflect.fields(hiddenObj))
        {
            Reflect.setField(formObj, index, (try cast(Reflect.field(hiddenObj, index), FormData) catch(e:Dynamic) null).getValue());
        }
        
        var request : URLRequest = new URLRequest();
        request.data = formObj;
        request.url = _url;
        request.method = _method;
        
        // Send data to server
        var loader : URLLoader = new URLLoader();
        loader.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 0, true);
        loader.load(request);
        
        return loader.data;
    }
    
    private function onComplete(event : Event) : Void
    {
        dispatchEvent(event);
    }
    
    private function onError(event : IOErrorEvent) : Void
    {
        Debug.print("[FormBuilder::onError] Fail to send infomation.");
        
        dispatchEvent(event);
    }
}

