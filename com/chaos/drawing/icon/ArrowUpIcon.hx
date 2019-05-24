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
        _iconArea.graphics.clear();
        
        if (border) 
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		// Bitmap or not
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
		
		
        
        // Draw first crossing block
        _iconArea.graphics.moveTo((width / 2), 0);
        _iconArea.graphics.lineTo(0, height);
        _iconArea.graphics.lineTo(width, height);
        _iconArea.graphics.lineTo((width / 2), 0);
        _iconArea.graphics.endFill();
    }
}

