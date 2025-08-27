package com.chaos.mobile.ui;

import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.BitmapData;

import com.chaos.ui.Label;
import com.chaos.mobile.ui.classInterface.IBreadcrumb;
import com.chaos.mobile.ui.Crumb;
import com.chaos.ui.layout.BaseContainer;
import com.chaos.ui.BaseUI;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.mobile.ui.event.BreadcrumbEvent;

class Breadcrumb extends BaseContainer implements IBreadcrumb implements IBaseContainer implements IBaseUI
{

    /**
    * Space between next label and separator
    **/
    
    public var labelSpacing(get, set):Int;

    private var _level:Int = 0;
    private var _labelSpacing:Int = 10;
    private var _separatorSize:Int = 20;
    private var _separator:String = "/";

	/**
	 * UI Component 
	 * @param	data The proprieties that you want to set on component.
	 */
    
    public function new(data:Dynamic = null)
    {
        super(data);
    }
    
	/**
	 * Set properties based on object
	 * @param	data object with supported types
	 */
	
    override public function setComponentData(data:Dynamic):Void 
    {
        super.setComponentData(data);

        // Properties
        if (Reflect.hasField(data, "labelSpacing"))  {
            _labelSpacing = Reflect.field(data,"labelSpacing");
        }

        if (Reflect.hasField(data, "separatorSize"))  {
            _separatorSize = Reflect.field(data,"separatorSize");
        }

        if (Reflect.hasField(data, "separator"))  {
            _separator = Reflect.field(data,"separator");
        }
        
        
        // Methods
		if (Reflect.hasField(data, "addLevel")) 
        {
            var level : Dynamic = Reflect.field(data,"addLevel");

            var name : String = "";
            var icon : BitmapData = null;

            if(Reflect.hasField(level,"name")) {
                name = Reflect.field(data,"name");
            }

            if(Reflect.hasField(level,"icon")) {
                icon = Reflect.field(data,"icon");
            }
            
            // Add level if name was passed
            if(name != "")
                this.addLevel(name, icon);
        }


        if (Reflect.hasField(data, "jumpToLevel"))  {
            jumpToLevel( Std.parseInt(Reflect.field(data,"jumpToLevel")) );
        }
      
    }
    
	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();

        // Just remove all items
        jumpToLevel(0);
    }      

    /**
    * Add another level        
    * @param	levelName Name of level
    * @param	icon The image being used
    **/

    public function addLevel(levelName:String, icon:BitmapData = null):Void {
        
        // Crumb Holder
        var crumbHolder:Sprite = new Sprite();
        crumbHolder.name = "level_" + _level;

        var crumb:Crumb = new Crumb({"name":"crumb_" + _level,"text":levelName,"labelSpacing":_labelSpacing,"icon":icon,"height":_height});
        crumbHolder.addChild(crumb);

        crumb.addEventListener(MouseEvent.CLICK, onCrumbClicked, false, 0, true);

        // If higher than first level
        if(_level > 0)
        {
            // Get last crumb area setup holder
            var lastCrumbHolder:Sprite = cast(_content.getChildByName("level_" + (_level - 1)), Sprite);
            var separator:Label = new Label({"name":"separator_"+ _level,"text":_separator,"width":_separatorSize,"height":_height,"x":(lastCrumbHolder.x + lastCrumbHolder.width)});

            // Adjust the location of current holder
            crumbHolder.x = separator.x + separator.width;
            
            _content.addChild(separator);
        }

        _content.addChild(crumbHolder);

        _level++;
    }

    /**
    * Jump to level
    **/

    public function jumpToLevel( level:Int ):Void {
        
        // Make sure it's not above or below
        if(level > _level)
            level = _level;
        else if(level < 0)
            level = 0;

        // Remove every label and separator
        while(_level > level)
        {
            _level--;

            var crumbHolder:Sprite = cast(_content.getChildByName("level_" + _level), Sprite);
            var separator:Label = cast(_content.getChildByName("separator_" + _level), Label);
            var crumb:Crumb = cast(crumbHolder.getChildByName("crumb_" + _level), Crumb);

            crumb.removeEventListener(MouseEvent.CLICK, onCrumbClicked);
            
            // Do clean up
            if(separator != null)
            {
                separator.destroy();
                _content.removeChild(separator);
            }

            crumb.destroy();
            _content.removeChild(crumbHolder);
            
        }
    } 

    private function get_labelSpacing():Int {

        return _labelSpacing;
    }
    
    private function set_labelSpacing(value:Int):Int {
    
        _labelSpacing = value;

        return _labelSpacing;
    }   
    
    private function onCrumbClicked(event:MouseEvent) : Void {

        var crumb:Crumb = cast(event.currentTarget, Crumb);
        var crumbName:String = crumb.name;

        dispatchEvent(new BreadcrumbEvent(BreadcrumbEvent.SELECTED, crumb,Std.parseInt(crumbName.substr(crumbName.indexOf("_") + 1))));
    }

    /**
	 * Draw the container
	 */
    
    override public function draw() : Void
    {
        super.draw();        
    }       

}