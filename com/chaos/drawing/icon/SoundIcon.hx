package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Create a sound icon
 *
 * @author Erick Feiling
 */
class SoundIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    public var offset : Int = 10;
    
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
        
        // Create offset values based on with and hight
        offset = as3hx.Compat.parseInt((width + height) / 8);
        
        if (offset < 0) 
            offset = 2;
        
        iconArea.graphics.clear();
        
        ((showImage && null != displayImg.image)) ? iconArea.graphics.beginBitmapFill(displayImg.image.bitmapData) : iconArea.graphics.beginFill(baseColor);
        
        iconArea.graphics.drawRect(0, offset, (width / 2) - offset, (height / 2) - offset);
        iconArea.graphics.moveTo((width / 2) - offset, offset);
        iconArea.graphics.lineTo(width - offset, 0);
        iconArea.graphics.lineTo(width - offset, height - offset);
        iconArea.graphics.lineTo((width / 2) - offset, (height / 2));
        iconArea.graphics.endFill();
    }
}

