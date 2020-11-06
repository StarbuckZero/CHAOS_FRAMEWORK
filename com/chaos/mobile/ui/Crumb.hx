package com.chaos.mobile.ui;

import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.text.TextFieldAutoSize;
import openfl.display.BitmapData;

import com.chaos.ui.Label;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

class Crumb extends BaseUI implements IBaseUI
{
    private var _label:Label;
    private var _icon:BitmapData;
    private var _labelSpacing:Int = 0;

    private var _text:String;
    private var _iconShape:Shape;

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }

	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();

        // Remove label
        _label.destroy();
        removeChild(_label);
        
        if(_icon != null)
            _icon.dispose();

        if(_iconShape != null)
        {
            _iconShape.graphics.clear();
            removeChild(_iconShape);
        }
            
    }

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData(data:Dynamic):Void 
    {
        super.setComponentData(data);	

		if (Reflect.hasField(data, "icon"))
            _icon = Reflect.field(data, "icon");
        
		if (Reflect.hasField(data, "text"))
            _text = Reflect.field(data, "text");

		if (Reflect.hasField(data, "labelSpacing"))
            _labelSpacing = Reflect.field(data, "labelSpacing");
    }      

	/**
	 * initialize all importain objects
	 */

     override public function initialize() : Void
    {
        // Buttom Mode
        buttonMode = true;
        
        // Create label
        _label = new Label({"name":"label","text":_text,"height":_height});
        _label.align = "left";
        _label.textField.wordWrap = false;
        _label.textField.autoSize = TextFieldAutoSize.CENTER;
        
        // Now init and add everything 
        super.initialize();

        // Setup Icon if needed
        if(_icon != null)
        {
            _iconShape = new Shape();
            _iconShape.graphics.beginBitmapFill(_icon);
            _iconShape.graphics.drawRect(0,0, _icon.width, _icon.height);
            _iconShape.graphics.endFill();
            _iconShape.name = "icon";

            addChild(_iconShape);
        }        
        
        addChild(_label);
        
    }  

    override function draw() {
        super.draw();

        // Set width of everything
        _label.width = _width = _label.textField.textWidth + _labelSpacing;

        // Update width with icon size
        if(_icon != null)
        {
            // Shift label over and adjust left of 
            _label.x = _icon.width;
            _width += _icon.width;        
        }

        _label.draw();

    }

}