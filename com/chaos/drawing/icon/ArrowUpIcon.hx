package com.chaos.drawing.icon;


import com.chaos.drawing.icon.BaseIcon;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;

/**
 * Creates a up arrow
 *
 * @author Erick Feiling
 */
class ArrowUpIcon extends BaseIcon implements IBaseUI implements IBasicIcon
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
		
		// Bitmap or not
		(showImage && null != displayImg.image) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
		
		
        
        // Draw first crossing block
        iconArea.graphics.moveTo((width / 2), 0);
        iconArea.graphics.lineTo(0, height);
        iconArea.graphics.lineTo(width, height);
        iconArea.graphics.lineTo((width / 2), 0);
        iconArea.graphics.endFill();
    }
}

