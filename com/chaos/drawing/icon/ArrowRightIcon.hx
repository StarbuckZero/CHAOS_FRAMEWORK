package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 *  Creates a right arrow icon
 *
 * @author Erick Feiling
 */
class ArrowRightIcon extends BaseIcon implements IBasicIcon implements IBaseUI
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
        iconArea.graphics.clear();
        
		(showImage && null != displayImg.image) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
		
        if (border) 
           iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        iconArea.graphics.lineTo(0, height);
        iconArea.graphics.lineTo(width, height / 2);
        iconArea.graphics.lineTo(0, 0);
        iconArea.graphics.endFill();
    }
}

