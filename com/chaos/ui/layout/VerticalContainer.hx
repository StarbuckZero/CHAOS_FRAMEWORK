package com.chaos.ui.layout;




import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.event.ContainerEvent;
import com.chaos.ui.layout.ContainerAlignPolicy;
import com.chaos.ui.layout.classInterface.IAlignmentContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;


/**
 * Added UI Elements to the container and align them. Everything that will be added will be from top to bottom or the y-axis.
 *
 * @author Erick Feiling
 */

class VerticalContainer extends AlignmentBaseContainer implements IBaseContainer implements IAlignmentContainer implements IBaseUI
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
	 */
    
    override public function addElementList(list : Array<Dynamic>) : Void
    {
        super.addElementList(list);
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
    
    /**
	 * Add an UI element to the container
	 *
	 * @param	object The object you want to add
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
	 */
	
    override public function removeElement(object : IBaseUI) : Void
    {
        super.removeElement(object);
        
        updateAlignment();
        dispatchEvent(new ContainerEvent(ContainerEvent.UPDATE));
    }
    
    /**
	 * Update the UI class
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
        
        for (i in 0 ... contentObject.numChildren)
		{
            var alignObj : IBaseUI = try cast(contentObject.getChildAt(i), IBaseUI) catch(e:Dynamic) null;
            
			
            // Set y
            alignObj.y = (i == 0) ? padding : (contentObject.getChildAt(i - 1).y + contentObject.getChildAt(i - 1).height) + spacingV;
            
            // Set the x based on alignment
            if (align == ContainerAlignPolicy.CENTER) 
            {
                alignObj.x = (width / 2) - (alignObj.width / 2);
                
				// First center  
                if (i > 0 && alignObj.x != contentObject.getChildAt(i - 1).x) 
                    alignObj.x = contentObject.getChildAt(i - 1).x;
            }
            else if (align == ContainerAlignPolicy.LEFT) 
            {
                alignObj.x = padding;  // Move to left  
                
                if (i > 0 && alignObj.x != contentObject.getChildAt(i - 1).x) 
                    alignObj.x = contentObject.getChildAt(i - 1).x;
            }
            else if (align == ContainerAlignPolicy.RIGHT)  // If greather than height then move objects
            {
                alignObj.x = width - alignObj.width;
            }
            
            
            
            if ((alignObj.y + alignObj.height + spacingV) > height) 
            {
                alignObj.y = padding;
                
                if (align == ContainerAlignPolicy.LEFT) 
                {
                    alignObj.x += ((i == 0)) ? spacingH : alignObj.width + spacingH;
                }
                else if (align == ContainerAlignPolicy.CENTER) 
                {
                    // Now swift everything up based on width
                    var a : Int = contentObject.numChildren - 1;
                    while (a >= i){
                        // Move everything back
                        contentObject.getChildAt(a).x -= contentObject.getChildAt(a).width + spacingH;
                        --a;
                    }
                }
                else if (align == ContainerAlignPolicy.RIGHT) 
                {
                    // Now swift everything up based on width
                    for (j in 0...i)
					{
                        // Move everything back
                        contentObject.getChildAt(j).x -= contentObject.getChildAt(j).width + spacingH;
                    }
                }
            }
        }
    }
}

