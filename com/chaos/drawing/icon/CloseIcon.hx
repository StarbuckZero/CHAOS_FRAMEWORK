package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;

/**
 * Stop icon used for media players
 *
 * @author Erick Feiling
 */

class CloseIcon extends BaseIcon implements IBasicIcon
{
    
    /**
	 * This will create a stop icon on the fly.
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
        
        ((showImage && null != _image)) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        if (border) 
            _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
			
		// Draw an X
        _iconArea.graphics.lineTo(width, height);
        _iconArea.graphics.moveTo(0, height);
        _iconArea.graphics.lineTo(width, 0);
    }
}

