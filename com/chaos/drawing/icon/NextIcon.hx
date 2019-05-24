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
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
        
        borderThinkness = 2;
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

