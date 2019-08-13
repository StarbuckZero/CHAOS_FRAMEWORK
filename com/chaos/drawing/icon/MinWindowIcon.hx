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
		
        ((showImage && null != _image)) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
		
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        _iconArea.graphics.drawRect(0, height / 2, width, height / 2);
        _iconArea.graphics.endFill();
    }
}

