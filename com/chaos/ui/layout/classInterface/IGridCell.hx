package com.chaos.ui.layout.classInterface;


import com.chaos.ui.classInterface.IBorder;
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
    
    var border(get, never) : IBorder;    
    

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

