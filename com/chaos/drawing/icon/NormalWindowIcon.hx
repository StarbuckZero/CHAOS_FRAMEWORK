package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Icon for window
 *
 * @author Erick Feiling
 */

class NormalWindowIcon extends BaseIcon implements IBasicIcon implements IBaseUI
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
        
        // Create Icon
        _iconArea.graphics.clear();
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        _iconArea.graphics.drawRect(0, 0, width, height);
    }
}

