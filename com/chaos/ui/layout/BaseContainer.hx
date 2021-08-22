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

class BaseContainer extends BaseUI implements IBaseContainer implements IBaseUI
{
	
    public var content(get, never) : DisplayObject;
    public var showImage(get, set) : Bool;
    public var background(get, set) : Bool;
    public var backgroundColor(get, set) : Int;
    public var backgroundAlpha(get, set) : Float;

    
    /** This could be used for holding other DisplayObjects */
    public var contentHolder : Sprite = new Sprite();
    
    /** The background shape */
    public var backgroundShape : Shape = new Shape();
    
    /** This is used for the content getting property */
    private var _content : Sprite = new Sprite();

	/**
	 * Toggle on and off border
	 */
     public var border(get, set):Bool;

     /**
      * The ScrollPane border color
      */
     public var borderColor(get, set):Int;
 
     /**
      * Specifies the border alpha. Set the alpha between 1 to 0.
      */
     public var borderAlpha(get, set):Float;

	/**
	 * Border thinkness
	 */
     public var borderThinkness(get, set):Float;     
    
    
    private var _imageBackground : BitmapData = null;
    private var _backgroundAlpha : Float = 1;
    private var _backgroundColor : Int = 0xCCCCCC;
    private var _background : Bool = true;

	private var _borderThinkness:Float = 1;    
	private var _border:Bool = false;
	private var _borderColor:Int = 0x000000;
	private var _borderAlpha:Float = 1;    
    
    private var _showImage : Bool = true;
    
	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    public function new(data:Dynamic = null)
    {
        super(data);
        
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

		if (Reflect.hasField(data, "border"))
			_border = Reflect.field(data, "border");		
	}
	
	/**
	 * Unload Component
	 */
	
	override public function destroy():Void 
	{
		super.destroy();
		
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
            if (null != list[i] && Std.isOfType(list[i], IBaseUI)) 
                _content.addChild(cast(list[i], IBaseUI).displayObject);
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
            return try cast(_content.getChildAt(value), IBaseUI) catch(e:Dynamic) null;
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
                currentObject = cast(_content.getChildAt(i), IBaseUI);
                _content.removeChild(currentObject.displayObject);
				
				currentObject.destroy();
				currentObject = null;
				
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
	 * Toggle on and off border
	 */
     private function set_border(value:Bool):Bool {
		_border = value;

		return value;
	}

	/**
	 * Returns true if the border is on and false if not
	 */
	private function get_border():Bool {
		return _border;
	}

	/**
	 * Border thinkness
	 */
     private function set_borderThinkness(value:Float):Float {
		_borderThinkness = value;

		return value;
	}

	/**
	 * Return the size of the border
	 */
	private function get_borderThinkness():Float {
		return _borderThinkness;
	}


	/**
	 * The ScrollPane border color
	 */
	private function set_borderColor(value:Int):Int {
		_borderColor = value;

		return value;
	}

	/**
	 * Returns the color
	 */
	private function get_borderColor():Int {
		return _borderColor;
	}

	/**
	 * Specifies the border alpha. Set the alpha between 1 to 0.
	 */
	private function set_borderAlpha(value:Float):Float {
		_borderAlpha = value;

		return value;
	}

	/**
	 * Returns the boarder alpha
	 */
	private function get_borderAlpha():Float {
		return _borderAlpha;
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
			backgroundShape.graphics.beginBitmapFill(_imageBackground, null, true, _smoothImage);
		else 
			backgroundShape.graphics.beginFill(_backgroundColor, _backgroundAlpha);
		
		backgroundShape.graphics.drawRect(0, 0, _width, _height);
		backgroundShape.graphics.endFill();
		
    }

}

