package com.chaos.mobile.ui;

import com.chaos.mobile.ui.layout.DragContainer;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;

class MobileButtonList extends DragContainer implements IBaseUI
{
    private var _buttonHeight : Int = 40;	
    private var _labelData:Dynamic = {};

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data : Dynamic = null)
    {
        super(data);

    }  

    override function initialize() {
        super.initialize();
    }

    override function setComponentData(data:Dynamic) {
        super.setComponentData(data);

		if (Reflect.hasField(data, "buttonHeight"))
            _buttonHeight = Reflect.field(data, "buttonHeight");      
        
		if (Reflect.hasField(data, "Label"))
            _labelData = Reflect.field(data, "Label");
		else
            _labelData = {"width":_width,"height":_height};        

		if (Reflect.hasField(data, "data"))
        {
            var dataMenu:Array<Dynamic> = Reflect.field(data, "data");
            createDataList(dataMenu);
        }        
    }

    private function createDataList( dataArray : Array<Dynamic> ) : Void {

        for (i in 0 ... dataArray.length) {

            var button:MobileButton = new MobileButton({"Label":_labelData,"width":_width,"height":_buttonHeight,"text": Reflect.hasField(dataArray[i],"text") ? Reflect.field(dataArray[i], "text") : ""});

            button.y = _buttonHeight * i;
            _content.addChild(button);
        }
    }
}