package com.chaos.drawing.icon;

import com.chaos.drawing.icon.UnshuffleIcon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


/**
 * Creates a Shuffle icon to be used for media players
 * @author Erick Feiling
 */

class ShuffleIcon extends UnshuffleIcon implements IBasicIcon implements IBaseUI
{
    private var _spacing : Int = 2;
    
    /**
	 * @inheritDoc
	 */
    
    public function new(iconWidth : Float = -1, iconHeight : Float = -1)
    {
        super(iconWidth, iconHeight);
        
        borderColor = 0xFFFFFF;
        borderThinkness = 2;
    }
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        // This draw base shuffle icon
        super.draw();
        
        _iconArea.graphics.moveTo(0, 0);
        
        // Draw circle
        if (showImage && null != _image) 
            _iconArea.graphics.beginBitmapFill(_image, null, true);
        else 
            _iconArea.graphics.beginFill(baseColor, 1);
        
        _iconArea.graphics.drawCircle(width / 2, height / 2, as3hx.Compat.parseInt(width / 8));
    }
}

