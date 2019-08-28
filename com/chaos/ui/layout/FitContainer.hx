package com.chaos.ui.layout;



import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IFitContainer;
import com.chaos.utils.Debug;

import com.chaos.ui.layout.FitContainerDirection;
import com.chaos.ui.layout.AlignmentBaseContainer;


/**
	 * This takes class makes sure everything fits.
	 * @author Erick Feiling
	 */

class FitContainer extends AlignmentBaseContainer implements IFitContainer implements IBaseContainer implements IBaseUI
{
    public var direction(get, set) : String;

    
    private var _mode : String = "horizontal";
    
    /**
	 * Create a container that fits all UI elements inside
	 */
    
    public function new(data:Dynamic = null)
    {
        // direction : String = "horizontal"
        super(data);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data,"direction"))
			_mode = Reflect.field(data, "direction");
	}
    
    /**
	 * @inheritDoc
	 */
    
    override public function addElement(object : IBaseUI) : Void
    {
        
        super.addElement(object);
        resizeElements();
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function addElementList(list : Array<Dynamic>) : Void
    {
        
        super.addElementList(list);
        
        resizeElements();
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function removeElement(object : IBaseUI) : Void
    {
        
        super.removeElement(object);
        
        resizeElements();
    }
    
    /**
	 * Resize all UI Objects
	 */

    
    override public function draw() : Void
    {
        
        super.draw();
        
        resizeElements();
    }
    
    /**
	 * Set the mode using the FitContainerDirection
	 * @see com.chaos.ui.layout.FitContainerDirection
	 */
    
    private function set_direction(value : String) : String
    {
        _mode = value.toLowerCase();
        
		
        return value;
    }
    
    /**
	 * Return the direction
	 */
	
    private function get_direction() : String
    {
        return _mode;
    }
    
    /**
	 * Resize based on the width and set height to size of container
	 * @private
	 */
    
    private function resizeElements() : Void
    {
        
        if (_mode == FitContainerDirection.HORIZONTAL || _mode == FitContainerDirection.VERTICAL) 
        {
            for (i in 0...contentObject.numChildren)
			{
                var element : IBaseUI = try cast(contentObject.getChildAt(i), IBaseUI) catch(e:Dynamic) null;
                
                if (_mode == FitContainerDirection.HORIZONTAL) 
                {
                    element.width = Std.int(width / contentObject.numChildren);
                    element.height = height;
                    element.x = contentObject.getChildAt(i).width * i;
                    element.y = 0;
                }
                else if (_mode == FitContainerDirection.VERTICAL) 
                {
                    element.width = width;
                    element.height = Std.int(height / contentObject.numChildren);
                    element.y = contentObject.getChildAt(i).height * i;
                    element.x = 0;
                }
				
				element.draw();
            }
        }
        else 
        {
            Debug.print("[FitContainer::resizeElements] Was unable to resize items. Make sure HORIZONTAL or VERTICAL is being passed.");
        }
    }
}

