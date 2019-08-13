package com.chaos.drawing.icon;


import com.chaos.drawing.icon.BaseIcon;
import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;

/**
 * Creates a down arrow icon
 *
 * @author Erick Feiling
 */
class ArrowDownIcon extends BaseIcon implements IBaseUI implements IBasicIcon
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
		
		// Bitmap or not
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);  
		
		
        // Draw first crossing block
        _iconArea.graphics.lineTo(width, 0);
        _iconArea.graphics.lineTo(width / 2, height);
        _iconArea.graphics.lineTo(0, 0);
        _iconArea.graphics.endFill();
    }
}

