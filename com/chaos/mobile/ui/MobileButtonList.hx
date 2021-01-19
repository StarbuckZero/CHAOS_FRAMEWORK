package com.chaos.mobile.ui;


import com.chaos.ui.data.BaseObjectData;
import com.chaos.mobile.ui.event.MobileButtonListEvent;
import openfl.events.MouseEvent;
import com.chaos.mobile.ui.layout.DragContainer;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.data.DataProvider;

import openfl.events.EventDispatcher;

class MobileButtonList extends DragContainer implements IBaseUI
{

    public var selectedIndex(get, never):Int;
    public var buttonHeight(get, set):Int;

	/**
	 * Replace the current data provider
	 */
	
     public var dataProvider(get, set) : DataProvider<BaseObjectData>;    
    
    private var _buttonHeight : Int = 40;	
    private var _labelData : Dynamic = {};

    private var _selectedIndex : Int = -1;

    private var _list : DataProvider<BaseObjectData> = new DataProvider<BaseObjectData>();

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

    override function destroy() {
        super.destroy();


    }

    private function createDataList( dataArray : Array<Dynamic> ) : Void {

        for (i in 0 ... dataArray.length) {

            var button:MobileButton = new MobileButton({"name":"button_" + i ,"Label":_labelData,"width":_width,"height":_buttonHeight,"text": Reflect.hasField(dataArray[i],"text") ? Reflect.field(dataArray[i], "text") : ""});

            button.addEventListener(MouseEvent.CLICK, onButtonClick, false, 0, true);
            button.y = _buttonHeight * i;

            _list.addItem(new BaseObjectData(Reflect.hasField( dataArray[i],"text") ? Reflect.field(dataArray[i], "text") : "", Reflect.hasField(dataArray[i],"value") ? Reflect.field(dataArray[i], "value") : Std.string(i)) );

            _content.addChild(button);
        }
    }

	/**
	 * Replace the current data provider
	 */

	private function set_dataProvider(value : DataProvider<BaseObjectData>) : DataProvider<BaseObjectData>
	{
		_list = value;
		return value;
	}

	/**
	 * Returns the data provider being used
	 */

    private function get_dataProvider() : DataProvider<BaseObjectData> { return _list; }  
    
    private function get_selectedIndex():Int {
        
        return _selectedIndex;
    }

    private function get_buttonHeight() : Int {
        return _buttonHeight;   
    }
    
    private function set_buttonHeight(value : Int) : Int {
        _buttonHeight = value;
        
        return _buttonHeight;
    }    

    private function onButtonClick( event:MouseEvent ) : Void {
        
        var button:MobileButton = cast(event.currentTarget, MobileButton);
        button.name.substr(button.name.indexOf("_") + 1);

        _selectedIndex = Std.parseInt(button.name.substr(button.name.indexOf("_") + 1));

        dispatchEvent(new MobileButtonListEvent(MobileButtonListEvent.CHANGE));

    }
}