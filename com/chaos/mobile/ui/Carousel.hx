package com.chaos.mobile.ui;

import com.chaos.ui.layout.HorizontalContainer;
import com.chaos.ui.layout.VerticalContainer;
import openfl.display.Sprite;
import com.chaos.mobile.ui.CarouselDot;
import com.chaos.ui.BaseUI;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.mobile.ui.data.CarouselObjectData;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.data.DataProvider;

class Carousel extends BaseContainer implements IBaseContainer implements IBaseUI
{

    public var dotContainer(get, never):VerticalContainer;
    private var _list : DataProvider<CarouselObjectData> = new DataProvider<CarouselObjectData>();

    private var _dotSize : Int = 6;
    private var _dotSpacing : Int = 10;

	private var _defaultColor : Int = 0xCCCCCCC;
    private var _selectedColor : Int = 0x999999;
    
    private var _carouselContentArea:Sprite = new Sprite();
    private var _dotArea:HorizontalContainer;
    private var _dotContainer:VerticalContainer;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }

    public function addItem( item:CarouselObjectData ):Void
    {
        // Add content to display
        var itemContent:DisplayObject = item.content;

        // Set size of content
        itemContent.width = _width;
        itemContent.height = _height;

        // If a BaseUI class then force redraw
        if(Std.is(itemContent, BaseUI) && !cast(itemContent, BaseUI).drawOnResize)
            cast(itemContent, BaseUI).draw();

        // Create Dot
        var dot:CarouselDot = new CarouselDot({"name":"doc_" + _carouselContentArea.numChildren,"dotSize":_dotSize,"defaultColor":item.defaultColor,"selectedColor":item.selectedColor,"defaultIcon":item.defaultIcon,"selectedIcon":item.selectedIcon});

        
        _dotArea.addElement(dot);
        _carouselContentArea.addChild(item.content);

        _dotArea.spacingH = _dotSpacing;
        _dotArea.width = ((dot.width + _dotSpacing) * _carouselContentArea.numChildren) + _dotSpacing;
        _dotArea.height = dot.height;

        if(_dotContainer.height < _dotArea.height)
            _dotContainer.height = _dotArea.height;

        _dotContainer.y = _height - dot.height;
        _dotContainer.updateAlignment();

        _dotArea.draw();
        

    }

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData(data:Dynamic):Void 
    {
        super.setComponentData(data);

        // Turn Dynamic object into CarouselObjectData
		if (Reflect.hasField(data, "data"))
			_list = addItemsFromList(Reflect.field(data, "data"));        
    }

    override function initialize() {

        super.initialize();

        _carouselContentArea.name = "contentArea";

        _dotContainer = new VerticalContainer({"name":"dotContainer","width":_width,"align":"center","background":false});
        _dotArea = new HorizontalContainer({"name":"dotArea","width":_width,"height": 20,"align":"center","background":false});

        _content.addChild(_carouselContentArea);
        _content.addChild(_dotContainer);
        _dotContainer.addElement(_dotArea);

        // Create items in Carousel now that everything has been initialized
        if(_list != null && _list.length > 0) {

            for(i in 0 ... _list.length)
                addItem(_list.getItemAt(i));                
        }
    }    

	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();
    }

    public function get_dotContainer() : VerticalContainer {
        return _dotContainer;
    }

    private function addItemsFromList( dataArray:Array<Dynamic> ):DataProvider<CarouselObjectData>
    {
        var newList:DataProvider<CarouselObjectData> = new DataProvider<CarouselObjectData>();

        for (i in 0 ... dataArray.length)
        {
            var data:Dynamic = dataArray[i];
            var content:DisplayObject = null;
            var defaultIcon:BitmapData = null;
            var selectedIcon:BitmapData = null;
            var defaultColor = 0;
            var selectedColor = 0;

            // Get content 
            if(Reflect.hasField(data,"content"))
                content = Reflect.field(data,"content");

            if(Reflect.hasField(data,"defaultIcon"))
                defaultIcon = Reflect.field(data,"defaultIcon");

            if(Reflect.hasField(data,"selectedIcon"))
                selectedIcon = Reflect.field(data,"selectedIcon");

            // Default color
            if (Reflect.hasField(data, "defaultColor"))
                defaultColor = Reflect.field(data, "defaultColor");
            else
                defaultColor = _defaultColor;

            // Selected color
            if (Reflect.hasField(data, "selectedColor"))
                selectedColor = Reflect.field(data, "selectedColor");
            else
                selectedColor = _selectedColor;
            
            newList.addItem( new CarouselObjectData(content, defaultIcon, selectedIcon, defaultColor, selectedColor, Reflect.field(data,"text"), Reflect.field(data, "value")));
        }

        return newList;
    } 
    
}