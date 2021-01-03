package com.chaos.mobile.ui;

import com.chaos.mobile.ui.layout.DragContainer;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

class MobileButton extends DragContainer implements IBaseUI
{
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data : Dynamic = null)
    {
        super(data);

    }  

    override function initialize() {
        super.initialize();
    }

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);
    }
}