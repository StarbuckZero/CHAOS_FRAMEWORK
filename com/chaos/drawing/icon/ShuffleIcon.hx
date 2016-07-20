package com.chaos.drawing.icon;

import com.chaos.drawing.icon.UnshuffleIcon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


/**
 * Creates a Shuffle icon to be used for media players
 * @author Erick Feiling
 */

class ShuffleIcon extends UnshuffleIcon implements IBasicIcon implements IBaseUI
{
    private var _spacing : Int = 2;
    
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
        // This draw base shuffle icon
        super.draw();
        
        iconArea.graphics.moveTo(0, 0);
        
        // Draw circle
        if (showImage && null != displayImg.image) 
        {
            iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData, null, true);
        }
        else 
        {
            iconArea.graphics.beginFill(baseColor, 1);
        }
        
        iconArea.graphics.drawCircle(width >> 1, height >> 1, as3hx.Compat.parseInt(width / 8));
    }
}

