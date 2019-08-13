package com.chaos.drawing.icon;


import com.chaos.drawing.icon.interface.IBasicIcon;
import com.chaos.ui.interface.IBaseUI;

/**
 * Creates a Shuffle icon to be used for media players
 * @author Erick Feiling
 */
class UnshuffleIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    private var _spacing : Int = 6;
    
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
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
        
        _iconArea.graphics.curveTo(0, height, width, height);
        _iconArea.graphics.moveTo(width, 0);
        _iconArea.graphics.curveTo(width, height, 0, height);
    }
}

