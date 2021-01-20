package com.chaos.ui.layout.classInterface;

import com.chaos.ui.classInterface.IBaseUI;



/**
 * Interface for both Horizontal and Vertical container
 *
 * @author Erick Feiling
 */

interface IAlignmentContainer extends IBaseContainer
{
    
    
    /**
	 * For making it so the content can overlap or bleed outside the container
	 */

    
    var clipping(get, set) : Bool;    
    
    /**
	 * Return the total number of elements being stored
	 */
    
    var length(get, never) : Int;    
    
    /**
	 * Specifies the space between the cell wall and the cell content
	 */

    
    var padding(get, set) : Int;    
    
    /**
	 * Set the Horizontal or right to left margin between object
	 */
    
    
    var spacingH(get, set) : Int;
    
    /**
	 * Set the Vertical or top to bottom spacing between object
	 */

    var spacingV(get, set) : Int;    
	
    /**
	 * Set the alignment mode
	 *
	 * @see com.chaos.ui.layout.ContainerAlignPolicy
	 */
    
    var align(get, set) : String;

    /**
	 * Adjust the location of all UI elements 
	 *
	 */
    
	
	function updateAlignment():Void;
    
}

