package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


i

/**
 * Icon for window
 *
 * @author Erick Feiling
 */

class MinWindowIcon extends BaseIcon implements IBasicIcon implements IBaseUI
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
		
        ((showImage && null != displayImg.image)) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
		
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        iconArea.graphics.drawRect(0, height / 2, width, height / 2);
        iconArea.graphics.endFill();
    }
}

