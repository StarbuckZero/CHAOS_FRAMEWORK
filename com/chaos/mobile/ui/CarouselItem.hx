package com.chaos.mobile.ui;

import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.classInterface.IBaseUI;

class Carousel extends BaseContainer implements IBaseContainer implements IBaseUI
{
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new( data : Dynamic = null)
    {
        super(data);
    }

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData( data : Dynamic ) : Void 
    {
        super.setComponentData(data);

        // Get items out of list
        
    }

    override function initialize() {

        super.initialize();

        // TODO: Get a list
    }    
    
	/**
	 * Unload Component
	 */
	
    override public function destroy() : Void 
    {
        super.destroy();
    }     
}