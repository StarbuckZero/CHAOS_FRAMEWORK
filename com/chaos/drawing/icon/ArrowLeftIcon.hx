package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;

/**
 *  Creates a right arrow icon
 *
 * @author Erick Feiling
 */
class ArrowLeftIcon extends BaseIcon implements IBasicIcon implements IBaseUI
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
        
        if (border) 
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != displayImg.image) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
        
        iconArea.graphics.moveTo(0, height / 2);
        iconArea.graphics.lineTo(width, 0);
        iconArea.graphics.lineTo(width, height);
        iconArea.graphics.lineTo(0, height / 2);
        
        iconArea.graphics.endFill();
    }
}

