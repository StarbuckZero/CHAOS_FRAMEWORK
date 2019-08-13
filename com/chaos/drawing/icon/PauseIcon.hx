package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


/**
 * Creates a Pause icon to be used for media players
 * @author Erick Feiling
 */
class PauseIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    
    public var space : Int = 4;
    
    /**
	 * @inheritDoc
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "space"))
			space = Reflect.field(data, "space");
	}
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create Icon
        _iconArea.graphics.clear();
        
        // Draw first block
        if (border) 
        _iconArea.graphics.lineStyle(borderThinkness, borderColor, borderAlpha);
		
		(showImage && null != _image) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        _iconArea.graphics.drawRect(0, 0, (width / 2) - space, height);  // First Block  
        _iconArea.graphics.drawRect((width / 2) + space, 0, (width / 2) - space, height);  // Second Block  
        
        _iconArea.graphics.endFill();
    }
}

