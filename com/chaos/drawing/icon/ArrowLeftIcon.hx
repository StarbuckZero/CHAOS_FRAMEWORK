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
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
    /**
	 * Update the UI class
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        _iconArea.graphics.clear();
        
        if (border) 
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        _iconArea.graphics.moveTo(0, height / 2);
        _iconArea.graphics.lineTo(width, 0);
        _iconArea.graphics.lineTo(width, height);
        _iconArea.graphics.lineTo(0, height / 2);
        
        _iconArea.graphics.endFill();
    }
}

