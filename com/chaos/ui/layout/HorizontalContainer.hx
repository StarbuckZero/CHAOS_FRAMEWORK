package com.chaos.ui.layout;




import com.chaos.ui.event.ContainerEvent;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.ContainerAlignPolicy;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;


/**
 * Added UI Elements to the container and align them. Everything that will be added will be from left to right or the x-axis.
 *
 * @author Erick Feiling
 */

class HorizontalContainer extends AlignmentBaseContainer implements IBaseContainer implements IAlignmentContainer implements IBaseUI
{
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */	
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
	
    /**
	 * Adds more then one item to the object to the list
	 *
	 * @param	list A list of UI Elements
	 * 
	 * @eventType ContainerEvent.UPDATE
	 */	 
    
    override public function addElementList(list : Array<IBaseUI>) : Void
    {
        super.addElementList(list);
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
    
	
    /**
	 * Remove an UI element from the container
	 *
	 * @param	object The object you want to remove
	 * 
	 * @eventType ContainerEvent.UPDATE
	 */	 
    
    override public function addElement(object : IBaseUI) : Void
    {
        super.addElement(object);
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
    
	
    /**
	 * Remove an UI element from the container
	 *
	 * @param	object The object you want to remove
	 * 
	 * @eventType ContainerEvent.UPDATE
	 */	 
    
    override public function removeElement(object : IBaseUI) : Void
    {
        super.removeElement(object);
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
    
    /**
	 * Update layout
	 *
	 * @eventType ContainerEvent.UPDATE
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
	
    /**
	 * Adjust the location of all UI elements 
	 */	
	
    override public function updateAlignment() : Void
    {
        
        for (i in 0 ... _content.numChildren)
		{
            var alignObj : BaseUI = try cast(_content.getChildAt(i), BaseUI) catch(e:Dynamic) null;
            
			
            // Set x
            alignObj.x = ((i == 0)) ? spacingH + padding : (_content.getChildAt(i - 1).x + _content.getChildAt(i - 1).width) + spacingH;
            
            // Set the y based on alignment
            if (align == ContainerAlignPolicy.CENTER) 
            {
                alignObj.y = (height / 2) - (alignObj.height / 2);
				
				// First center  
                if (i > 0 && alignObj.y != _content.getChildAt(i - 1).y) 
                    alignObj.y = _content.getChildAt(i - 1).y;
            }
            else if (align == ContainerAlignPolicy.TOP) 
            {
                alignObj.y = padding; 
				
				// Move to top  
                if (i > 0 && alignObj.y != _content.getChildAt(i - 1).y) 
                    alignObj.y = _content.getChildAt(i - 1).y;
            }
            else if (align == ContainerAlignPolicy.BOTTOM) // If greather than width then move objects
            {
                alignObj.y = height - alignObj.height - padding;
            }
            
            
            
            if ((alignObj.x + alignObj.width + spacingH) > width) 
            {
                alignObj.x = padding;
                
                if (align == ContainerAlignPolicy.CENTER || align == ContainerAlignPolicy.TOP) 
                {
                    alignObj.y += ((i == 0)) ? spacingV : alignObj.height + spacingV;
                }
                else if (align == ContainerAlignPolicy.BOTTOM) 
                {
                    // Now swift everything up based on height
                    for (a in 0 ... i)
					{
                        // Shift everything up
                        _content.getChildAt(a).y -= (_content.getChildAt(a).height + spacingV);
                    }
                }
            }
			
			
        }
    }
}

