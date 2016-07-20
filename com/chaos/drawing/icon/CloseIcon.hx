package com.chaos.drawing.icon;


import com.chaos.drawing.icon.interface.IBasicIcon;

/**
 * Stop icon used for media players
 *
 * @author Erick Feiling
 */

class CloseIcon extends BaseIcon implements IBasicIcon
{
    
    /**
	 * This will create a stop icon on the fly.
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
        
        ((showImage && null != displayImg.image)) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
        
        if (border) 
            iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
			
		// Draw an X
        iconArea.graphics.lineTo(width, height);
        iconArea.graphics.moveTo(0, height);
        iconArea.graphics.lineTo(width, 0);
    }
}

