package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Create a next icon
 * @author Erick Feiling
 */

class NextIcon extends ArrowRightIcon implements IBasicIcon implements IBaseUI
{
    /**
	 * @inheritDoc
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Just draw a line down
        _iconArea.graphics.moveTo(width, 0);
        _iconArea.graphics.lineTo(width, height);
    }
}

