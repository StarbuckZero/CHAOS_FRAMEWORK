package com.chaos.mobile.ui;

class Carousel extends BaseContainer implements IBaseContainer implements IBaseUI
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
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData(data:Dynamic):Void 
    {
        super.setComponentData(data);
    }
    
	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();
    }     
}