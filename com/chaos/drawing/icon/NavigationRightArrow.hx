package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;


/**
 * Creates a arrow icon to be used for navigation bar
 * @author Erick Feiling
 */
class NavigationRightArrow extends BaseIcon implements IBasicIcon implements IBaseUI
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

        _iconArea.graphics.lineStyle(borderThinkness, baseColor, borderAlpha);
        
        _iconArea.graphics.moveTo(0, height);
        _iconArea.graphics.lineTo(width, height / 2);
        _iconArea.graphics.lineTo(0, 0);
        _iconArea.graphics.endFill();
    }
}

