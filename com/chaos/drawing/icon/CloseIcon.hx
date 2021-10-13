package com.chaos.drawing.icon;


import com.chaos.drawing.icon.classInterface.IBasicIcon;

/**
 * X icon 
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

        // Draw hotspot
        _iconArea.graphics.lineStyle(0,0,0);
        _iconArea.graphics.beginFill(0,0);
        _iconArea.graphics.drawRect(0,0,_width,_height);
        _iconArea.graphics.endFill();

        
    }
}

