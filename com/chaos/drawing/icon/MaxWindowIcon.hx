package com.chaos.drawing.icon;


import com.chaos.drawing.icon.NormalWindowIcon;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;

/**
 * Icon for window
 *
 * @author Erick Feiling
 */

class MaxWindowIcon extends NormalWindowIcon implements IBasicIcon implements IBaseUI
{
    
    /**
	 * @inheritDoc
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        _iconArea.graphics.drawRect(width / 2, height / 2, width / 2, height / 2);
        _iconArea.graphics.drawRect(0, 0, width, height);
    }
}

