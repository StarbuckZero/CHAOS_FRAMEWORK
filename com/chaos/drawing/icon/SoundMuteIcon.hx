package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Creates a sound on icon for media players
 *
 * @author Erick Feiling
 */

class SoundMuteIcon extends SoundIcon implements IBasicIcon implements IBaseUI
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
        
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        // Draw circle
        iconArea.graphics.drawCircle(width / 2, (height / 2) - (offset / 2), offset / 2);
        
        iconArea.graphics.moveTo(offset, height - offset);
        iconArea.graphics.lineTo(width - offset, 0);
    }
}

