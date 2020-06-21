package com.chaos.ui.layout.classInterface;


import com.chaos.ui.classInterface.IBaseUI;

/**
* Interface for grid cell
* @author Erick Feiling
*/

interface IGridCell extends IBaseUI
{
    
    
    /**
	 * Grab the layout container
	 *
	 * @return The container being used
	 */
    
    var container(get, never) : IAlignmentContainer;    
    
    /**
	 * Toggle on and off border
	 */
    
    var border(get, set) : Bool;    
    
    /**
	 * The ScrollPane border color
	 */
    
    
    var borderColor(get, set) : Int;    
    
    /**
	 * Specifies the border alpha. Set the alpha between 1 to 0.
	 */
    
    
    
    var borderAlpha(get, set) : Float;    
    
    /**
	 * Border thinkness
	 */
    
    
    var borderThinkness(get, set) : Float;

    /**
	 * Remove old layout container and add new one to cell block.
	 *
	 * @param	value The layout you want to use
	 * @param	params Set extra stuff to the layout being used.
	 *
	 * @see com.chaos.ui.layout.GridLayout
	 *
	 * @exampleText setLayout(GridLayout.VERTICAL);
	 */
    
    function setLayout(value : Class<Dynamic>, params : Dynamic = null) : Void;
}

