package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Create a previous icon on the fly
 *
 * @author Erick Feiling
 */

class PreviousIcon extends ArrowLeftIcon implements IBasicIcon implements IBaseUI
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
        
        _iconArea.graphics.moveTo(0, 0);
        _iconArea.graphics.lineTo(0, height);
    }
}

