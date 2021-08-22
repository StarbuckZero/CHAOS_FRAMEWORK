package com.chaos.mobile.ui;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.display.Shape;
import openfl.events.MouseEvent;
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

    public var dotContainer(get, never) : VerticalContainer;
    public var animationSpeed(get, set) : Float;
    public var selectedIndex(get, never) : Int;

 	/**
	 * Adjust the line thickness used to draw the dot
     */ 

    public var dotLineThickness(get, set) : Float;

    private var _list : DataProvider<CarouselObjectData> = new DataProvider<CarouselObjectData>();

    private var _dotSize : Int = 6;
    private var _dotSpacing : Int = 10;

	private var _defaultColor : Int = 0xCCCCCCC;
    private var _selectedColor : Int = 0x999999;

    private var _selectedIndex : Int = -1;
    
    private var _carouselContentArea : BaseUI;
    private var _dotArea : HorizontalContainer;
    private var _dotContainer : VerticalContainer;
    private var _selectFirstItemByDefault : Bool = true;
    private var _dotLineThickness : Float = 1;

    private var _unselectedDotFill : Bool = false;

    private var _animationSpeed : Float = .2;

    private var _mask : Sprite = new Sprite();
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data : Dynamic = null)
    {
        super(data);
    }

	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();

        _carouselContentArea.destroy();
        _dotContainer.destroy();
        _dotArea.destroy();
        
        _mask.graphics.clear();
        removeChild(_mask);
    }    


    public function addItem( item : CarouselObjectData ):Void
    {
        // Add content to display
        var itemContent:DisplayObject = item.content;

        // If first item then force to be selected by default
        if(_selectFirstItemByDefault && _carouselContentArea.numChildren == 0)
            item.selected = true;

        // Set size of content
        itemContent.width = _width;
        itemContent.height = _height;

        // If a BaseUI class then force redraw
        if(Std.isOfType(itemContent, BaseUI) && !cast(itemContent, BaseUI).drawOnResize)
            cast(itemContent, BaseUI).draw();

        // Create Dot
        var dot:CarouselDot = new CarouselDot({"name":"doc_" + _carouselContentArea.numChildren, "selected": item.selected, 
        "dotSize": _dotSize, "defaultColor": item.defaultColor, "selectedColor": item.selectedColor, 
        "defaultIcon": item.defaultIcon,"selectedIcon": item.selectedIcon, "unselectedDotFill":_unselectedDotFill,"dotLineThickness":_dotLineThickness});

        // Set the current index
        if(item.selected)
           _selectedIndex = _carouselContentArea.numChildren;

        // Make it so content is lined up to the to the right and adjust the size of the content area
        _carouselContentArea.width = itemContent.x = _width * _carouselContentArea.numChildren;

        // Add event to dot
        dot.addEventListener(MouseEvent.MOUSE_DOWN, onDotClickEvent, false, 0, true);

        // Add event to content
        itemContent.addEventListener(MouseEvent.MOUSE_DOWN, onContentMouseDownEvent, false, 0, true);
        itemContent.addEventListener(MouseEvent.MOUSE_UP,onContentMouseUpEvent, false, 0, true);
        itemContent.addEventListener(MouseEvent.RELEASE_OUTSIDE,onContentMouseUpEvent, false, 0, true);

        _dotArea.addElement(dot);
        _carouselContentArea.addChild(itemContent);

        _dotArea.spacingH = _dotSpacing;
        _dotArea.width = ((dot.width + _dotSpacing) * _carouselContentArea.numChildren) + _dotSpacing;
        _dotArea.height = dot.height;

        if(_dotContainer.height < _dotArea.height)
            _dotContainer.height = _dotArea.height;

        _dotContainer.y = _height - dot.height;
        _dotContainer.updateAlignment();

        _carouselContentArea.draw();
        _dotArea.draw();
    }

    /**'
    * Force the carousel to move to item
    * @param index the item you want to jump to
    **/
    public function jumpToItem( index : Int ) {
        
        if(index > _list.length -1 || index < 0)
            return;

        // Remove unselect last dot and select current one
        var currentDot : CarouselDot = cast(_dotArea.getElementAtIndex(index), CarouselDot);
        var lastDot : CarouselDot = cast(_dotArea.getElementAtIndex(_selectedIndex), CarouselDot);

        lastDot.selected = false;
        lastDot.draw();

        currentDot.selected = true;
        currentDot.draw();

        // Shift or animate items
        if(_animationSpeed > 0)
            _carouselContentArea.animateTo({"x": -(_width * index), "duration":_animationSpeed});
        else
            _carouselContentArea.x = -(_width * index);

        _selectedIndex = index;

    }
    
    
    private function get_selectedIndex() : Int {
        return _selectedIndex;
    }

    private function get_unselectedDotFill() : Bool {
        return _unselectedDotFill;
    }
    
    private function set_unselectedDotFill(value : Bool) : Bool {
        _unselectedDotFill = value;
        return value;
    }    
    
    private function get_dotLineThickness() : Float {
        return _dotLineThickness;
    }
    
    private function set_dotLineThickness(value : Float) : Float {
        
        _dotLineThickness = value;
        return value;
    }       

	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData(data : Dynamic):Void 
    {
        super.setComponentData(data);

        // Dot Thickness
		if (Reflect.hasField(data, "dotLineThickness"))
            _dotLineThickness = Reflect.field(data, "dotLineThickness");        

		if (Reflect.hasField(data, "unselectedDotFill"))
            _unselectedDotFill = Reflect.field(data, "unselectedDotFill");        

        // Turn Dynamic object into CarouselObjectData
		if (Reflect.hasField(data, "data"))
			_list = addItemsFromList(Reflect.field(data, "data"));
    }

    override function initialize() {

        super.initialize();

        mask = _mask;
        addChild(_mask);

        _carouselContentArea = new BaseUI({"name":"contentArea","width":_width,"height":_height});

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

    private function get_dotContainer() : VerticalContainer {
        return _dotContainer;
    }

    private function set_animationSpeed( value : Float ) : Float {

        _animationSpeed = value;

        return _animationSpeed;
    }

    private function get_animationSpeed() : Float {
        return _animationSpeed;
    }

    override function draw() {
        super.draw();

        _mask.graphics.clear();
        _mask.graphics.beginFill(0);
        _mask.graphics.drawRect(0,0,_width,_height);
        _mask.graphics.endFill();

    }

    private function addItemsFromList( dataArray : Array<Dynamic> ): DataProvider<CarouselObjectData>
    {
        var newList : DataProvider<CarouselObjectData> = new DataProvider<CarouselObjectData>();

        for (i in 0 ... dataArray.length)
        {
            var data : Dynamic = dataArray[i];
            var content : DisplayObject = null;
            var defaultIcon : BitmapData = null;
            var selectedIcon : BitmapData = null;
            var defaultColor : Int = 0;
            var selectedColor : Int = 0;
            var selected : Bool = false;
            var text : String = "";
            var value : String = "";

            // Get content 
            if(Reflect.hasField(data,"content"))
                content = Reflect.field(data,"content");

            // Default Icon Image
            if(Reflect.hasField(data,"defaultIcon"))
                defaultIcon = Reflect.field(data,"defaultIcon");

            // Selected Icon Image
            if(Reflect.hasField(data,"selectedIcon"))
                selectedIcon = Reflect.field(data,"selectedIcon");

            // Default Color
            if (Reflect.hasField(data, "defaultColor"))
                defaultColor = Reflect.field(data, "defaultColor");
            else
                defaultColor = _defaultColor;

            // Selected
            if(Reflect.hasField(data, "selected"))
                selected = Reflect.field(data, "selected");

            // Text
            if(Reflect.hasField(data, "text"))
                text = Reflect.field(data, "text");

            // Value
            if(Reflect.hasField(data, "value"))
                value = Reflect.field(data, "value");

            // Selected color
            if (Reflect.hasField(data, "selectedColor"))
                selectedColor = Reflect.field(data, "selectedColor");
            else
                selectedColor = _selectedColor;

            // If item in data object is selected then turn off first default selected
            if(selected && _selectFirstItemByDefault)
                _selectFirstItemByDefault = false;
            
            newList.addItem( new CarouselObjectData(content, defaultIcon, selectedIcon, defaultColor, selectedColor,  text, value , selected));
        }

        return newList;
    } 

    private function onDotClickEvent( event : MouseEvent ) : Void {

        var currentDot : CarouselDot = cast(event.currentTarget, CarouselDot);
        var dotName : String = currentDot.name;
        var index : Int = Std.parseInt(dotName.substring(dotName.indexOf("_") + 1));
        var lastDot : CarouselDot = cast(_dotArea.getElementAtIndex(_selectedIndex), CarouselDot);

        jumpToItem(index);

        // Unselect last dot and select current one
        lastDot.selected = false;
        currentDot.selected = true;

        lastDot.draw();
        currentDot.draw();

        // Update selected index
        _selectedIndex = index;
    }

    private function onContentMouseDownEvent( event : MouseEvent) : Void {
        
        var content:Sprite = cast(event.currentTarget,Sprite);

        // If first item then can't move left and last item can't move right
        if(_selectedIndex >= _list.length - 1) {
            _carouselContentArea.startDrag(false, new Rectangle(0,0,-_width * (_selectedIndex),0));
        }
        else {
            _carouselContentArea.startDrag(false, new Rectangle(0,0,-_width * (_selectedIndex + 1),0));
        }
            
    }

    private function onContentMouseUpEvent( event : MouseEvent) : Void {
        
        var content:Sprite = cast(event.currentTarget,Sprite);
        _carouselContentArea.stopDrag();

        // For last item
        if(_selectedIndex >= _list.length - 1) {

            // Finish moving the item to the left or right then update the index
            if( (_width - _carouselContentArea.x - (_width * _selectedIndex)) <= (_width / 4) ) {
                jumpToItem(_selectedIndex - 1);
            }
            else {
                jumpToItem(_selectedIndex);
            }
                
        } else if(_selectedIndex == 0) { /// For first Item

            
            if( (_width + _carouselContentArea.x + (_width * _selectedIndex)) >= (_width / 4) ) {
                jumpToItem(_selectedIndex);
            }
            else {
                jumpToItem(_selectedIndex + 1);
            }
        } 
        else  { // For items in the middle

            
            if((_width - _carouselContentArea.x - (_width * _selectedIndex)) <= (_width / 4)) {
                jumpToItem(_selectedIndex - 1);
            }
            else if( (_width + _carouselContentArea.x + (_width * _selectedIndex)) <= (_width / 4) ) {
                jumpToItem(_selectedIndex + 1);
            }
            else {
                jumpToItem(_selectedIndex);
            }    
        }
            
    }
    
}