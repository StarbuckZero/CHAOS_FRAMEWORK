package com.chaos.drawing.icon;

import com.chaos.drawing.icon.classInterface.IBasicIcon;
import com.chaos.ui.classInterface.IBaseUI;



/**
 * Create a sound icon
 *
 * @author Erick Feiling
 */

class SoundIcon extends BaseIcon implements IBasicIcon implements IBaseUI
{
    public var offset : Int = 10;
    
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
		
		if (Reflect.hasField(data, "offset"))
			offset = Reflect.field(data, "offset");
	}
    
    /**
	 * @inheritDoc
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
        // Create offset values based on with and hight
        offset = Std.int((width + height) / 8);
        
        if (offset < 0) 
            offset = 2;
        
        _iconArea.graphics.clear();
        
        ((showImage && null != _image)) ? _iconArea.graphics.beginBitmapFill(_image) : _iconArea.graphics.beginFill(baseColor);
        
        _iconArea.graphics.drawRect(0, offset, (width / 2) - offset, (height / 2) - offset);
        _iconArea.graphics.moveTo((width / 2) - offset, offset);
        _iconArea.graphics.lineTo(width - offset, 0);
        _iconArea.graphics.lineTo(width - offset, height - offset);
        _iconArea.graphics.lineTo((width / 2) - offset, (height / 2));
        _iconArea.graphics.endFill();
    }
}

