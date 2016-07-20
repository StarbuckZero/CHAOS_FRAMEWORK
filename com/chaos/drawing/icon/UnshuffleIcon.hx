package com.chaos.drawing.icon;


import com.chaos.drawing.icon.interface.IBasicIcon;
import com.chaos.ui.interface.IBaseUI;

/**
 * Creates a Shuffle icon to be used for media players
 * @author Erick Feiling
 */
class UnshuffleIcon extends BaseIcon implements com.chaos.drawing.icon.interface.IBasicIcon implements com.chaos.ui.classInterface.IBaseUI
{
    private var _spacing : Int = 6;
    
    /**
	 * @inheritDoc
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
        
        borderColor = 0xFFFFFF;
        borderThinkness = 2;
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        iconArea.graphics.clear();
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        iconArea.graphics.curveTo(0, height, width, height);
        iconArea.graphics.moveTo(width, 0);
        iconArea.graphics.curveTo(width, height, 0, height);
    }
}

