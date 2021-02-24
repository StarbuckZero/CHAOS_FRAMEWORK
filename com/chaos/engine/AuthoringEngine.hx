package com.chaos.engine;

import com.adobe.serialization.json.JSON;
import com.chaos.drawing.Draw;
import com.chaos.engine.event.CoreEngineEvent;
import com.chaos.engine.event.EngineDispatchEvent;
import com.chaos.engine.Global;
import com.chaos.engine.plugin.CoreCommandPlugin;
import com.chaos.utils.Utils;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.MouseEvent;
// import com.eclecticdesignstudio.motion.Actuate;
// import com.eclecticdesignstudio.motion.actuators.GenericActuator;
// import com.eclecticdesignstudio.motion.easing.*;
import openfl.display.DisplayObject;
import openfl.external.ExternalInterface;

/**
* This is used to connect to the IDE that is being used for development.
* @author Erick Feiling
*/
class AuthoringEngine extends CoreEngine
{
    private var _defaultImageName : String = "chaos_temp_image";
    private var _displayObj : DisplayObject;
    private var _editLayer : Sprite;
    private var _authoringDisplayArea : Sprite;
    private var _editBlockColor : Int = 0x999999;
    
    public function new()
    {
        super();
        
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        
        _editLayer = new Sprite();
        _authoringDisplayArea = new Sprite();
        
        
        _editLayer.alpha = 0;
        displayArea = _authoringDisplayArea;
        
        addChild(_authoringDisplayArea);
        addChild(_editLayer);
        
        if (ExternalInterface.available)
        
        // Methods{
            
            ExternalInterface.addCallback("chaos_setData", setData);
            ExternalInterface.addCallback("chaos_updateItem", updateItem);
            ExternalInterface.addCallback("chaos_removeItem", removeItem);
            ExternalInterface.addCallback("chaos_setDefaultImageName", setDefaultImageName);
            ExternalInterface.addCallback("chaos_swapLayer", swapLayer);
            ExternalInterface.addCallback("chaos_swapLayerItem", swapLayerItem);
            
            // Events
            ExternalInterface.call("onEngineReady");
            
            stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        }
    }
    
    
    public function setData(data : String) : Void
    {
        reader.setData(data);
    }
    
    public function updateItem(name : String, data : String) : Void
    {
        if (Global.status != CoreEngineEvent.LOADING && Global.status != CoreEngineEvent.READING)
        {
            reader.setData({
                        UpdateItem : {
                            name : name,
                            data : haxe.Json.decode(data)
                        }
                    });
        }
    }
    
    public function removeItem(name : String) : Void
    {
        if (Global.status != CoreEngineEvent.LOADING && Global.status != CoreEngineEvent.READING)
        {
            reader.setData({
                        RemoveItem : {
                            name : name
                        }
                    });
        }
    }
    
    override public function onEngineEvent(event : EngineDispatchEvent) : Void
    {
        super.onEngineEvent(event);
        
        
        // Create new item
        if (CoreEngineEvent.ITEM_CREATED == event.eventType && Std.is(event.eventData.item, DisplayObject))
        
        // Create a block that covers the item{
            
            createEditorObject(event.eventData.type, event.eventData.item);
        }
        /*
			// Remove old
			if (null != _displayObj)
			removeGlow(_displayObj);
			
			// Get Item
			_displayObj = CoreCommandPlugin.getItem(event.elementName);
			
			// Set glow
			if (null != _displayObj)
			setGlow(_displayObj);
			*/
        // Send what was selected to JavaScript
        if (ExternalInterface.available)
        {
            if (null != _displayObj)
            {
                ExternalInterface.call("onItemSelected", _displayObj.name);
            }
            
            for (index in Reflect.fields(event.eventData))
            
            //TODO: Send what type of class if it's a flash object{
                
                if (Std.is(!event.eventData[index], DisplayObject))
                {
                    ExternalInterface.call("onEngineEvent", event.eventType, event.elementName, index, event.eventData[index]);
                }
            }
        }
    }
    
    
    private function swapLayerItem(layerName : String, itemName1 : String, itemName2 : String) : Void
    {
        var layer : Sprite = try cast(Utils.getNestedChild(Global.mainDisplyArea, layerName), Sprite) catch(e:Dynamic) null;
        
        if (null != layer)
        {
            var item1 : DisplayObject = Utils.getNestedChild(layer, itemName1);
            var item2 : DisplayObject = Utils.getNestedChild(layer, itemName2);
            
            if (null != item1 && null != item2)
            {
                layer.swapChildren(item1, item2);
            }
        }
    }
    
    
    private function swapLayer(layerName1 : String, layerName2 : String) : Void
    {
        var item1 : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, layerName1);
        var item2 : DisplayObject = Utils.getNestedChild(Global.mainDisplyArea, layerName2);
        
        if (null != item1 && null != item2)
        {
            displayArea.swapChildren(item1, item2);
        }
    }
    
    private function setDefaultImageName(name : String) : Void
    {
        _defaultImageName = name;
    }
    
    private function setGlow(displayObj : DisplayObject) : Void
    {
        // Actuate.transform(displayObj, .8).color(0xFFFFFF, 1, 0).ease(Linear.easeNone).repeat().reflect();
    }
    
    private function removeGlow(displayObj : DisplayObject) : Void
    {
        // Actuate.stop(displayObj);
    }
    
    private function onMouseDown(event : MouseEvent) : Void
    {
        if (ExternalInterface.available)
        {
            ExternalInterface.call("onEngineMouseDown", stage.mouseX, stage.mouseY);
        }
    }
    
    private function createEditorObject(type : String, item : DisplayObject) : Void
    {
        // Draw Object and place in edit layer
        
        var blockHolder : Sprite = new Sprite();
        
        blockHolder.name = "editor_" + item.name;
        blockHolder.x = item.x;
        blockHolder.y = item.y;
        blockHolder.addChild(Draw.Square(item.width, item.height, _editBlockColor, 1, false, false));
        
        _editLayer.addChild(blockHolder);
        
        blockHolder.addEventListener(MouseEvent.MOUSE_DOWN, onEditorObjectMouseDown, false, 0, true);
        blockHolder.addEventListener(MouseEvent.MOUSE_UP, onEditorObjectMouseUp, false, 0, true);
        blockHolder.addEventListener(MouseEvent.MOUSE_MOVE, onEditorObjectMove, false, 0, true);
    }
    
    
    private function onEditorObjectMouseDown(event : MouseEvent) : Void
    {
        if (Std.is(event.currentTarget, Sprite))
        {
            (try cast(event.currentTarget, Sprite) catch(e:Dynamic) null).startDrag();
        }
    }
    
    private function onEditorObjectMouseUp(event : MouseEvent) : Void
    {
        if (Std.is(event.currentTarget, Sprite))
        {
            (try cast(event.currentTarget, Sprite) catch(e:Dynamic) null).stopDrag();
        }
        
        // Pass to set object in final place
        onEditorObjectMove(event);
        
        if (ExternalInterface.available)
        {
            ExternalInterface.call("onItemLocationUpdate", event.currentTarget.name.substr(event.currentTarget.name.indexOf("_") + 1), event.currentTarget.x, event.currentTarget.y);
        }
    }
    
    
    private function onEditorObjectMove(event : MouseEvent) : Void
    {
        var currentName : String = event.currentTarget.name;
        var displayObj : DisplayObject = Utils.getNestedChild(displayArea, currentName.substr(currentName.indexOf("_") + 1));
        
        displayObj.x = event.currentTarget.x;
        displayObj.y = event.currentTarget.y;
    }
}

