package com.chaos.mobile.ui;

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
    }
    
	/**
	 * Unload Component
	 */
	
    override public function destroy():Void 
    {
        super.destroy();        
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

            _content.removeChild(crumbHolder);
            _content.removeChild(separator);
        }
    } 

    private function get_labelSpacing():Int {

        return _labelSpacing;
    }
    
    private function set_labelSpacing(value:Int):Int {
    
        _labelSpacing = value;

        return _labelSpacing;
    }    

    /**
	 * Draw the container
	 */
    
    override public function draw() : Void
    {
        super.draw();        
    }       

}