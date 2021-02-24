package com.chaos.engine.plugin;

import openfl.display.BitmapData;
import com.chaos.engine.Global;
import com.chaos.engine.CommandDispatch;
import com.chaos.ui.classInterface.IBaseUI;
import com.chaos.ui.layout.classInterface.IBaseContainer;
import com.chaos.ui.classInterface.ILabel;
import openfl.display.DisplayObject;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import com.chaos.engine.CommandCentral;
import com.chaos.engine.EngineTypes;
import com.chaos.utils.Debug;

/**
* Just call commands that should already be loaded
* @author Erick Feiling
*/
class CoreCommandPlugin
{
    private static var unNameCount : Int = 0;
    
    
    public function new()
    {
        
    }
    
    
    
    /**
    * Adds object to layer if there is one set. If none is set then the display area passed in
    * @param	UIObject The UI object you want to add to the display
    * @param	displayArea The object that the UIObject will be added to if there isn't a layer set
    */
    
    public static function displayUpdate(UIObject : IBaseUI, data : Dynamic) : Void
    {
        if (Reflect.hasField(data,"displayArea") )
        {
            var displayArea : Sprite = getDisplayObject(data);
            displayArea.addChild(UIObject.displayObject);
        }
    }

    public static function getDisplayObject( data : Dynamic ) : Sprite 
    {
        if(Reflect.hasField(data,"displayArea"))
            return Reflect.field(data,"displayArea");
        else if (null != Global.currentLayer)
            return Global.currentLayer;
        else
            return Global.mainDisplyArea;
    }
    
    public static function setComponentData(data : Dynamic, UIObject : IBaseUI) : Void
    {
        UIObject.setComponentData(data);

        if(Reflect.hasField(data,"redraw") && Reflect.field(data,"redraw"))
            UIObject.draw();
    }
    
    
    public static function removeContainerEvents(baseContainer : IBaseContainer) : Void
    {
        
        var containerArea : Sprite = cast(baseContainer.content, Sprite);
        
        for (i in 0...containerArea.numChildren)
        {
            var subElement : DisplayObject = containerArea.getChildAt(i);
            
            if (Std.is(subElement, IBaseUI))
                CommandDispatch.removeAllEvents(cast(subElement, IBaseUI));
            
            if (Std.is(subElement, IBaseContainer))
                removeContainerEvents(try cast(subElement, IBaseContainer) catch(e:Dynamic) null);
        }
    }
    
    public static function getScreen(screenName : String) : DisplayObject
    {
        return try cast(CommandCentral.runCommand(EngineTypes.GET_SCREEN, {name : screenName}), DisplayObject);
    }
    
    public static function getElement(elementName : String) : DisplayObject
    {
        return cast(CommandCentral.runCommand(EngineTypes.GET_ELEMENT, {name : elementName}), DisplayObject);
    }
    
    public static function getImage(elementName : String) : BitmapData
    {
        return cast(CommandCentral.runCommand(EngineTypes.GET_IMAGE, {name : elementName}), BitmapData);
    }
    
    public static function getItem(elementName : String) : DisplayObject
    {
        return cast(CommandCentral.runCommand(EngineTypes.GET_ITEM, {name : elementName}), DisplayObject);
    }
    
    public static function setDataProvider(elementName : String, append : Bool = false, items : Array<Dynamic> = null) : DisplayObject
    {
        return cast(CommandCentral.runCommand(EngineTypes.DATA_UPDATE, {name : elementName,append : append,items : ((null != items)) ? items : []}), DisplayObject);
    }
}

