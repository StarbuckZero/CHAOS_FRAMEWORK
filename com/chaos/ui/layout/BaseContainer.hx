package com.chaos.ui.layout;



/**
 * A very basic container.
 * @author Erick Feiling
 */


import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.utils.Debug;

import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.errors.Error;
import openfl.display.BitmapData;
import openfl.geom.Matrix;
import com.chaos.ui.UIStyleManager;
import com.chaos.ui.UIBitmapManager;
import com.chaos.ui.UIBitmapManager.UIBitmapType;
import openfl.events.Event;

class BaseContainer extends BaseUI implements IBaseContainer implements IBaseUI
{
	
    public var content(get, never) : DisplayObject;
    public var showImage(get, set) : Bool;
    public var background(get, set) : Bool;
    public var backgroundColor(get, set) : Int;
    public var backgroundAlpha(get, set) : Float;
    public var tileImage(get, set) : Bool;

    
    /** This could be used for holding other DisplayObjects */
    public var contentHolder : Sprite = new Sprite();
    
    /** The background shape */
    public var backgroundShape : Shape = new Shape();
    
    /** This is used for the content getting property */
    private var _content : Sprite = new Sprite();
    
    private var _imageBackground : BitmapData = null;
    private var _backgroundAlpha : Float = 1;
    private var _backgroundColor : Int = 0xCCCCCC;
    private var _background : Bool = true;
    private var _tileImage : Bool = false;

    
    private var _showImage : Bool = true;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    public function new(data:Dynamic = null)
    {
        super(data);

		addEventListener(Event.ADDED_TO_STAGE, onBaseContainerStageAdd, false, 0, true);
		addEventListener(Event.REMOVED_FROM_STAGE, onBaseContainerStageRemove, false, 0, true);
    }
	
	/**
	 * initialize all importain objects
	 */
	
	override public function initialize():Void 
	{
		super.initialize();
		
        addChild(backgroundShape);
        addChild(_content);
        
        addChild(contentHolder);
	}
	
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
	override public function setComponentData(data:Dynamic):Void 
	{
		super.setComponentData(data);
		
		if (Reflect.hasField(data, "backgroundAlpha"))
			_backgroundAlpha = Reflect.field(data, "backgroundAlpha");
			
		if (Reflect.hasField(data, "backgroundColor"))
			_backgroundColor = Reflect.field(data, "backgroundColor");
			
		if (Reflect.hasField(data, "background"))
			_background = Reflect.field(data, "background");
			
		if (Reflect.hasField(data, "content"))
			_content = Reflect.field(data, "content");
			
		if (Reflect.hasField(data, "backgroundImage"))
			_imageBackground = Reflect.field(data, "backgroundImage");

		if (Reflect.hasField(data, "tileImage"))
			_tileImage = Reflect.field(data, "tileImage");
		
	}

	override public function reskin() : Void
	{
		super.reskin();

		if (UIStyleManager.hasStyle(UIStyleManager.BASE_CONTAINER_BACKGROUND_COLOR))
			_backgroundColor = UIStyleManager.getStyle(UIStyleManager.BASE_CONTAINER_BACKGROUND_COLOR);

		if (UIStyleManager.hasStyle(UIStyleManager.BASE_CONTAINER_TILE_IMAGE))
			_tileImage = UIStyleManager.getStyle(UIStyleManager.BASE_CONTAINER_TILE_IMAGE);

		if (UIBitmapManager.hasUIElement(UIBitmapType.BaseContainer, UIBitmapManager.BASE_CONTAINER_BACKGROUND))
			setBackgroundImage(UIBitmapManager.getUIElement(UIBitmapType.BaseContainer, UIBitmapManager.BASE_CONTAINER_BACKGROUND));

		var componentSkin : Dynamic = getComponentBackgroundSkin();

		if (componentSkin != null && UIBitmapManager.hasUIElement(componentSkin.type, componentSkin.style))
			setBackgroundImage(UIBitmapManager.getUIElement(componentSkin.type, componentSkin.style));
	}

	private function getComponentBackgroundSkin() : Dynamic
	{
		return switch (Type.getClassName(Type.getClass(this)))
		{
			case "com.chaos.drawing.Canvas": {type:UIBitmapType.Canvas, style:UIBitmapManager.CANVAS_BACKGROUND};
			case "com.chaos.form.FormBuilder": {type:UIBitmapType.FormBuilder, style:UIBitmapManager.FORM_BUILDER_BACKGROUND};
			case "com.chaos.mobile.ui.Breadcrumb": {type:UIBitmapType.Breadcrumb, style:UIBitmapManager.BREADCRUMB_BACKGROUND};
			case "com.chaos.mobile.ui.Carousel": {type:UIBitmapType.Carousel, style:UIBitmapManager.CAROUSEL_BACKGROUND};
			case "com.chaos.mobile.ui.MobileButtonList": {type:UIBitmapType.MobileButtonList, style:UIBitmapManager.MOBILE_BUTTON_LIST_BACKGROUND};
			case "com.chaos.mobile.ui.NavigationMenu": {type:UIBitmapType.NavigationMenu, style:UIBitmapManager.NAVIGATION_MENU_BACKGROUND};
			case "com.chaos.mobile.ui.layout.DragContainer": {type:UIBitmapType.DragContainer, style:UIBitmapManager.DRAG_CONTAINER_BACKGROUND};
			case "com.chaos.ui.layout.AlignmentBaseContainer": {type:UIBitmapType.AlignmentBaseContainer, style:UIBitmapManager.ALIGNMENT_BASE_CONTAINER_BACKGROUND};
			case "com.chaos.ui.layout.FitContainer": {type:UIBitmapType.FitContainer, style:UIBitmapManager.FIT_CONTAINER_BACKGROUND};
			case "com.chaos.ui.layout.GridContainer": {type:UIBitmapType.GridContainer, style:UIBitmapManager.GRID_CONTAINER_BACKGROUND};
			case "com.chaos.ui.layout.HorizontalContainer": {type:UIBitmapType.HorizontalContainer, style:UIBitmapManager.HORIZONTAL_CONTAINER_BACKGROUND};
			case "com.chaos.ui.layout.VerticalContainer": {type:UIBitmapType.VerticalContainer, style:UIBitmapManager.VERTICAL_CONTAINER_BACKGROUND};
			default: null;
		}
	}

	private function onBaseContainerStageAdd(event : Event) : Void
	{
		UIBitmapManager.watchElement(UIBitmapType.BaseContainer, this);

		var componentSkin : Dynamic = getComponentBackgroundSkin();

		if (componentSkin != null)
			UIBitmapManager.watchElement(componentSkin.type, this);
	}

	private function onBaseContainerStageRemove(event : Event) : Void
	{
		UIBitmapManager.stopWatchElement(UIBitmapType.BaseContainer, this);

		var componentSkin : Dynamic = getComponentBackgroundSkin();

		if (componentSkin != null)
			UIBitmapManager.stopWatchElement(componentSkin.type, this);
	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();

		removeEventListener(Event.ADDED_TO_STAGE, onBaseContainerStageAdd);
		removeEventListener(Event.REMOVED_FROM_STAGE, onBaseContainerStageRemove);
		onBaseContainerStageRemove(null);
		
		backgroundShape.graphics.clear();
		
        removeChild(backgroundShape);
        removeChild(_content);
        
        removeChild(contentHolder);
		
		if (null != _imageBackground)
			_imageBackground.dispose();

		removeAll();
		
		backgroundShape = null;
		_content = null;
		contentHolder = null;
		
	}

    /**
	 * Adds more then one item to the object to the list
	 *
	 * @param	list A list of UI Elements
	 */
    
    public function addElementList(list : Array<Dynamic>) : Void
    {
        for (i in 0 ... list.length)
		{
            if (null != list[i] && Std.isOfType(list[i], IBaseUI))  {
                _content.addChild(cast(list[i], IBaseUI).displayObject);
            }
            else 
                Debug.print("[BaseContainer::addElementList] Fail to add item at index " + i);
        }
    }
    
    /**
	 * Add an UI element to the container
	 *
	 * @param	object The object you want to add
	 */
    
    public function addElement(object : IBaseUI) : Void
    {
        _content.addChild(object.displayObject);
    }
    
    /**
	 * Return the object inside the container
	 *
	 * @param	value The index of the object inside the container
	 * @return The object that is stored in the container
	 */
    
    public function getElementAtIndex(value : Int) : IBaseUI
    {
        try
        {
             if(Std.isOfType(_content.getChildAt(value), IBaseUI) ) {
                return try cast(_content.getChildAt(value), IBaseUI) catch(e:Dynamic) null;
            }
            
        } 
		catch (error : Error)
        {
            Debug.print("[BaseContainer::getElementAtIndex] Can't get item at index " + value + " returning null.");
        }
        
        return null;
    }
    
    /**
	 * Return the object inside the container based on the name passed
	 *
	 * @param	value The name of the object
	 * @return The object that is stored in the container
	 */
    
    public function getElementByName(value : String) : IBaseUI
    {
        try
        {
            return try cast(_content.getChildByName(value), IBaseUI) catch(e:Dynamic) null;
        }
        catch (error : Error)
        {
            Debug.print("[BaseContainer::getElementByName] Can't find item" + value + " returning null.");
        }
        
        return null;
	}
	
    /**
	 * Remove an UI element from the container
	 *
	 * @param	object The object you want to remove
	 */
    
    public function removeElement(object : IBaseUI) : Void
    {
        var temp : Array<Dynamic> = new Array<Dynamic>();
        
        // Remove all old items and add them back again
        for (i in 0..._content.numChildren)
		{
             if(Std.isOfType(_content.getChildAt(i), IBaseUI) ) {

                var currentObject : IBaseUI = null;
                
                try
                {
                    currentObject = cast(_content.getChildAt(i), IBaseUI);
                    _content.removeChild(currentObject.displayObject);
                }            
                catch (error : Error)
                {
                    trace("[BaseContainer] Couldn't remove item");
                }  

                // Only grab the items that are needed  
                if (object != currentObject) 
                    temp.push(currentObject);

             }
        }  
        
        
        // Add it back  
        for (a in 0...temp.length)
            _content.addChild(temp[a]);
    }	

    /**
	 * Remove all elements that are stored
	 */
    
    public function removeAll() : Void
    {
        var currentObject : IBaseUI;
        
        for (i in 0 ... _content.numChildren)
		{
            try
            {
                if(Std.isOfType(_content.getChildAt(i), IBaseUI) ) {

                    currentObject = cast(_content.getChildAt(i), IBaseUI);
                    _content.removeChild(currentObject.displayObject);
                    
                    currentObject.destroy();
                    currentObject = null;
                }
				
            } 
			catch (error : Error)
            {
                trace("[BaseContainer] Couldn't remove item");
            }
        }
    }	
	
	
    /**
	 * The content layer
	 */
    
    private function get_content() : DisplayObject
    {
        return _content;
    }
    
    /**
	 * Toggle on and off images, if false then will use default render
	 */
    
    private function set_showImage(value : Bool) : Bool
    {
        _showImage = value;
        return value;
    }
    
    /**
	 * Return true if showing images and false if not
	 */
    
    private function get_showImage() : Bool
    {
        return _showImage;
    }

    private function set_tileImage(value : Bool) : Bool
    {
        _tileImage = value;
        return value;
    }

    private function get_tileImage() : Bool
    {
        return _tileImage;
    }
    

    /**
	 * Hide or show the background
	 */
    
    private function set_background(value : Bool) : Bool
    {
        _background = value;
        
		
        return value;
    }
    
    /**
	 * Return true if the being displayed
	 */
    
    private function get_background() : Bool
    {
        return _background;
    }
    
    /**
	 * The background color
	 */
    
    private function set_backgroundColor(value : Int) : Int
    {
        _backgroundColor = value;
        
		
        return value;
    }
    
    /**
	 * Return the color
	 */
    
    private function get_backgroundColor() : Int
    {
        return _backgroundColor;
    }
    
    /**
	 * The background alpha
	 */
    
    private function set_backgroundAlpha(value : Float) : Float
    {
        _backgroundAlpha = value;
        
		
        return value;
    }
    
    /**
	 * Return background alpha
	 */
    
    private function get_backgroundAlpha() : Float
    {
        return _backgroundAlpha;
    }

 
    
    /**
	 * Set the background image
	 *
	 * @param	value The bitmap that will be used
	 */
    
    public function setBackgroundImage(value : BitmapData) : Void
    {
        _imageBackground = value;
		
    }
    
    
    /**
	 * Draw the container
	 */
    
    override public function draw() : Void
    {
        super.draw();
        
		// Don't show background
        backgroundShape.alpha = (_background) ? 1 : 0;
        
		
        backgroundShape.graphics.clear();
        
		if(null != _imageBackground)
		{
			var bitmapMatrix : Matrix = null;

			if (!_tileImage && _imageBackground.width > 0 && _imageBackground.height > 0 && _width > 0 && _height > 0)
			{
				bitmapMatrix = new Matrix();
				bitmapMatrix.scale(_width / _imageBackground.width, _height / _imageBackground.height);
			}

			backgroundShape.graphics.beginBitmapFill(_imageBackground, bitmapMatrix, _tileImage, _smoothImage);
		}
		else 
			backgroundShape.graphics.beginFill(_backgroundColor, _backgroundAlpha);
		
		backgroundShape.graphics.drawRect(0, 0, _width, _height);
		backgroundShape.graphics.endFill();
		
    }

}

