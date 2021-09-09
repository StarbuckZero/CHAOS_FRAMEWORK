package com.chaos.form.classInterface;


import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IGridCell;
import com.chaos.form.ui.classInterface.IFormUI;
import com.chaos.form.FormData;

/**
 * Interface for form objects
 * @author Erick Feiling
 */

interface IFormBuilder extends IBaseUI
{
    
    /**
	 * The default spacing used for added form elements
	 */
    
    
    
    /**
	 * Return value
	 */
    var vSpacing(get, set) : Int;    
    
    /**
	 * The default spacing used for added form elements
	 */
    
    
    
    /**
	 * Return value
	 */
    
    var hSpacing(get, set) : Int;    
    
    /**
	 * If true the border on added form item will have border
	 */
    
    
    
    /**
	 * Return true if border will be set by default and false if not
	 */
    
    var border(get, set) : Bool;    
    
    /**
	 * Set the default border thinkness of added item
	 */
    
    
    
    /**
	 * Return the border thinkness
	 */
    var borderThinkness(get, set) : Int;    
    
    /**
	 * Set the url the form data will be sent
	 */
    
    
    /**
	 * Get the url that is being used
	 */

    var url(get, set) : String;    
    
    /**
	 * Used for sending a "GET" or "POST" command to the server. Use the URLRequestMethod to set this.
	 */
    
    
    
    /**
	 * Return the mode the form is in
	 */
    
    var method(get, set) : String;

    
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
    
	 function addFormElement(labelName : String, elementName : String, elementClass : Class<Dynamic>, elementParams: Dynamic = null, layoutClass : Class<Dynamic> = null, layoutParams : Dynamic = null) : Void;
    
    /**
	 * Keeps track of a FormData object. The name and values will be sent to server when using the send method.
	 * @param	dataObj The form object
	 */
    
    function addFormData(dataObj : FormData) : Void;
    
    /**
	 * @copy com.chaos.ui.layout.GridContainer
	 */
    
    function getCell(row : Int, col : Int) : com.chaos.ui.layout.classInterface.IGridCell;
    
    /**
	 * Set the size of the form
	 * @param	newWidth The new width
	 * @param	newHeight The new height
	 */
    
    function setSize(newWidth : Int, newHeight : Int) : Void;
    
    /**
	 * Set the width of the form
	 * @param	value The new width
	 */
    
    function setWidth(value : Int) : Void;
    
    /**
	 * Set the height of the form
	 * @param	value The new height
	 */
    
    function setHeight(value : Int) : Void;
    
    /**
	 * Set the column width
	 *
	 * @param	index Which column
	 * @param	colWidth The new width
	 */
    
    function setColumnWidthAt(index : Int, colWidth : Int) : Void;
    
    /**
	 * Set all the cells width in the grid
	 * @param	colWidth The new cell width
	 */
    
    function setCellWidth(colWidth : Int) : Void;
    
    /**
	 * Set the column height
	 *
	 * @param	index Which column
	 * @param	colWidth The new height
	 */
    
    function setColumnHeightAt(index : Int, colHeight : Int) : Void;
    
    /**
	 * Clear all form values
	 */
    
    function reset() : Void;
    
    /**
	 * Does a POST or GET with all the values to a server-side script
	 *
	 * @eventType openfl.events.Event.COMPLETE
	 * @eventType openfl.events.IOErrorEvent.IO_ERROR
	 *
	 * @return The data object just in case values are written
	 */
    
    function send() : Dynamic;
}

