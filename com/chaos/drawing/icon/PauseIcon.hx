package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


/**
 * Creates a Pause icon to be used for media players
 * @author Erick Feiling
 */
class PauseIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    
    public var space : Int = 4;
    
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
        
        // Draw first block
        if (border) 
        iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != displayImg.image) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
        
        iconArea.graphics.drawRect(0, 0, (width / 2) - space, height);  // First Block  
        iconArea.graphics.drawRect((width / 2) + space, 0, (width / 2) - space, height);  // Second Block  
        
        iconArea.graphics.endFill();
    }
}

