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
    
    var vSpacing(get, set) : Int;    
    
    /**
	 * The default spacing used for added form elements
	 */
    
    
    var hSpacing(get, set) : Int;    
    
    
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
	 * @copy com.chaos.ui.layout.GridContainer
	 */
    
    function getCell(row : Int, col : Int) : IGridCell;
    
    /**
	 * Set the column width
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
	 * Clear all form values
	 */
    
    function reset() : Void;
    
    /**
	 * Take all input values and return them
	 * @return The object with values
	 */
    
	function getFormData() : Dynamic;
}

