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
        
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
		
        if (border) 
           _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        _iconArea.graphics.lineTo(0, height);
        _iconArea.graphics.lineTo(width, height / 2);
        _iconArea.graphics.lineTo(0, 0);
        _iconArea.graphics.endFill();
    }
}

