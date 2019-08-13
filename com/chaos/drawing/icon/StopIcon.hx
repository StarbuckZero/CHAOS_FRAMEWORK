package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Stop icon used for media players
 *
 * @author Erick Feiling
 */

class StopIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    
    /**
	 * @inheritDoc
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        _iconArea.graphics.clear();
        
        if (border) 
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        _iconArea.graphics.drawRect(0, 0, width, height);
        _iconArea.graphics.endFill();
    }
}

