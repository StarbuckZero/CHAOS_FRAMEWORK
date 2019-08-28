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
    public static var HORIZONTAL : Class<Dynamic> = HorizontalContainer;
    public static var VERTICAL : Class<Dynamic> = VerticalContainer;
    public static var FIT : Class<Dynamic> = FitContainer;

    public function new()
    {
    }
}

