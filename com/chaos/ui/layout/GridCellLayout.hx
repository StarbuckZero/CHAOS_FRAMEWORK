package com.chaos.ui.layout;



import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.VerticalContainer;
import com.chaos.ui.layout.FitContainer;

/**
 * Used to set a layout for the GridCell class
 *
 * @author Erick Feiling
 */

class GridCellLayout
{
    /** Horizontal container class for a grid cell. */
    public static var HORIZONTAL : Class<Dynamic> = HorizontalContainer;
    /** Vertical container class for a grid cell. */
    public static var VERTICAL : Class<Dynamic> = VerticalContainer;
    /** Fitted container class for a grid cell. */
    public static var FIT : Class<Dynamic> = FitContainer;

    /** Creates a grid cell layout registry. */
    public function new()
    {
    }
}

